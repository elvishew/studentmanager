import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'states.dart';
import '../database/album_repository.dart';

part 'student_provider.g.dart';

/// ============================================
/// Database Provider（依赖注入）
/// ============================================

@Riverpod(keepAlive: true)
Database database(DatabaseRef ref) {
  throw UnimplementedError('Database must be provided in main()');
}

/// ============================================
/// Student Notifier
/// ============================================

@Riverpod(keepAlive: true)
class StudentNotifier extends _$StudentNotifier {
  late final Database _database;

  @override
  StudentState build() {
    _database = ref.watch(databaseProvider);
    return const StudentState.initial();
  }

  /// ============================================
  /// 查询所有学员
  /// ============================================

  Future<void> fetchAll() async {
    state = const StudentState.loading();

    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        'students',
        orderBy: 'created_at DESC',
      );

      final students = maps.map((map) => Student.fromMap(map)).toList();

      state = StudentState.data(
        students: students,
        filteredStudents: students,
        searchQuery: '',
      );
    } catch (e, stackTrace) {
      state = StudentState.error(e, stackTrace);
    }
  }

  /// ============================================
  /// 搜索学员
  /// ============================================

  void search(String query) {
    state.when(
      initial: () => state = const StudentState.initial(),
      loading: () => state = const StudentState.loading(),
      error: (error, stackTrace) => state = StudentState.error(error, stackTrace),
      data: (students, filteredStudents, searchQuery) {
        final newSearchQuery = query.toLowerCase();
        final filtered = students.where((student) {
          return student.name.toLowerCase().contains(newSearchQuery) ||
              (student.contact?.toLowerCase().contains(newSearchQuery) ?? false) ||
              (student.notes?.toLowerCase().contains(newSearchQuery) ?? false);
        }).toList();

        state = StudentState.data(
          students: students,
          filteredStudents: filtered,
          searchQuery: query,
        );
      },
    );
  }

  /// ============================================
  /// 创建学员
  /// ============================================

  Future<int?> create({
    required String name,
    String? gender,
    required String contact,
    String? notes,
  }) async {
    try {
      final now = DateTime.now().toIso8601String();

      final id = await _database.insert(
        'students',
        {
          'name': name,
          'gender': gender,
          'contact': contact,
          'notes': notes,
          'created_at': now,
          'updated_at': now,
        },
      );

      // 重新加载数据
      await fetchAll();

      return id;
    } catch (e, stackTrace) {
      state = StudentState.error(e, stackTrace);
      return null;
    }
  }

  /// ============================================
  /// 更新学员
  /// ============================================

  Future<bool> update({
    required int id,
    required String name,
    String? gender,
    required String contact,
    String? notes,
  }) async {
    try {
      final count = await _database.update(
        'students',
        {
          'name': name,
          'gender': gender,
          'contact': contact,
          'notes': notes,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );

      if (count > 0) {
        await fetchAll();
        return true;
      }

      return false;
    } catch (e, stackTrace) {
      state = StudentState.error(e, stackTrace);
      return false;
    }
  }

  /// ============================================
  /// 删除学员
  /// ============================================

  Future<bool> delete(int id) async {
    try {
      // 先清理该学员所有相册的照片文件
      try {
        final albumRepo = AlbumRepository(database: _database);
        await albumRepo.cleanupByStudentId(id);
      } catch (_) {
        // 文件清理失败不影响学员删除
      }

      final count = await _database.delete(
        'students',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (count > 0) {
        // 从状态中移除（乐观更新）
        state.when(
          initial: () => state = const StudentState.initial(),
          loading: () => state = const StudentState.loading(),
          error: (error, stackTrace) => state = StudentState.error(error, stackTrace),
          data: (students, filteredStudents, searchQuery) {
            final updatedStudents = students.where((s) => s.id != id).toList();
            final updatedFiltered = filteredStudents.where((s) => s.id != id).toList();

            state = StudentState.data(
              students: updatedStudents,
              filteredStudents: updatedFiltered,
              searchQuery: searchQuery,
            );
          },
        );
        return true;
      }

      return false;
    } catch (e, stackTrace) {
      state = StudentState.error(e, stackTrace);
      return false;
    }
  }

  /// ============================================
  /// 根据 ID 获取学员
  /// ============================================

  Future<Student?> getById(int id) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        'students',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isNotEmpty) {
        return Student.fromMap(maps.first);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// ============================================
  /// 重置状态
  /// ============================================

  void reset() {
    state = const StudentState.initial();
  }
}

/// ============================================
/// Student 计算属性 Provider
/// ============================================

/// 学员总数
@riverpod
int studentCount(StudentCountRef ref) {
  final studentState = ref.watch(studentNotifierProvider);
  return studentState.maybeWhen(
    data: (students, filteredStudents, searchQuery) => students.length,
    orElse: () => 0,
  );
}

/// 过滤后的学员列表
@riverpod
List<Student> filteredStudents(FilteredStudentsRef ref) {
  final studentState = ref.watch(studentNotifierProvider);
  return studentState.maybeWhen(
    data: (_, filtered, __) => filtered,
    orElse: () => [],
  );
}
