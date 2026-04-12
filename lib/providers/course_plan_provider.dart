import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'states.dart';
import 'student_provider.dart';
import '../database/course_plan_repository.dart';

part 'course_plan_provider.g.dart';

/// ============================================
/// CoursePlanRepository Provider
/// ============================================

@riverpod
CoursePlanRepository coursePlanRepository(CoursePlanRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return CoursePlanRepository(database: database);
}

/// ============================================
/// CoursePlan Notifier
/// ============================================

@riverpod
class CoursePlanNotifier extends _$CoursePlanNotifier {
  late final Database _database;
  late final CoursePlanRepository _repository;

  @override
  CoursePlanState build() {
    _database = ref.watch(databaseProvider);
    _repository = ref.watch(coursePlanRepositoryProvider);
    return const CoursePlanState.initial();
  }

  /// ============================================
  /// 查询指定学员的所有课程规划
  /// ============================================

  Future<void> fetchByStudentId(int studentId) async {
    state = CoursePlanState.loading();

    try {
      final List<Map<String, dynamic>> maps = await _database.rawQuery('''
        SELECT cp.*, cg.name as goal_name
        FROM course_plans cp
        LEFT JOIN course_goals cg ON cp.goal_id = cg.id
        WHERE cp.student_id = ?
        ORDER BY cp.created_at DESC
      ''', [studentId]);

      final coursePlans = await Future.wait(
        maps.map((map) async {
          final coursePlan = CoursePlan.fromMap(map);
          return await _enrichCoursePlan(coursePlan);
        }),
      );

      state = CoursePlanState.data(
        coursePlans: coursePlans,
        selectedCoursePlan: null,
        selectedStudentId: studentId,
      );
    } catch (e, stackTrace) {
      state = CoursePlanState.error(e, stackTrace);
    }
  }

  /// ============================================
  /// 查询所有课程规划
  /// ============================================

  Future<void> fetchAll() async {
    state = const CoursePlanState.loading();

    try {
      final List<Map<String, dynamic>> maps = await _database.rawQuery('''
        SELECT cp.*, cg.name as goal_name
        FROM course_plans cp
        LEFT JOIN course_goals cg ON cp.goal_id = cg.id
        ORDER BY cp.created_at DESC
      ''');

      final coursePlans = await Future.wait(
        maps.map((map) async {
          final coursePlan = CoursePlan.fromMap(map);
          return await _enrichCoursePlan(coursePlan);
        }),
      );

      state = CoursePlanState.data(
        coursePlans: coursePlans,
        selectedCoursePlan: null,
        selectedStudentId: null,
      );
    } catch (e, stackTrace) {
      state = CoursePlanState.error(e, stackTrace);
    }
  }

  /// ============================================
  /// 创建课程规划（带默认配置）
  /// ============================================

  Future<int?> create({
    required int studentId,
    required int goalId,
    int sessionCount = 12,
    String? customBlueprint,
    bool useTemplate = true,
  }) async {
    try {
      final coursePlanId = await _repository.createCoursePlan(
        studentId: studentId,
        goalId: goalId,
        sessionCount: sessionCount,
        customBlueprint: customBlueprint,
        useTemplate: useTemplate,
      );

      // 重新加载当前学员的课程规划
      await fetchByStudentId(studentId);

      return coursePlanId;
    } catch (e, stackTrace) {
      state = CoursePlanState.error(e, stackTrace);
      return null;
    }
  }

  /// ============================================
  /// 更新课程规划
  /// ============================================

  Future<bool> update({
    required int id,
    int? goalId,
    String? blueprint,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (goalId != null) {
        updateData['goal_id'] = goalId;
      }

      if (blueprint != null) {
        updateData['blueprint'] = blueprint;
      }

      final count = await _database.update(
        'course_plans',
        updateData,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (count > 0) {
        // 更新状态中的数据
        state.when(
          initial: () => state = const CoursePlanState.initial(),
          loading: () => state = const CoursePlanState.loading(),
          error: (error, stackTrace) => state = CoursePlanState.error(error, stackTrace),
          data: (coursePlans, selectedCoursePlan, selectedStudentId) {
            // 如果目标改了，需要查新目标名
            final updatedPlans = coursePlans.map((plan) {
              if (plan.id == id) {
                return plan.copyWith(
                  goalId: goalId ?? plan.goalId,
                  blueprint: blueprint ?? plan.blueprint,
                  updatedAt: DateTime.now(),
                );
              }
              return plan;
            }).toList();

            state = CoursePlanState.data(
              coursePlans: updatedPlans,
              selectedCoursePlan: selectedCoursePlan,
              selectedStudentId: selectedStudentId,
            );
          },
        );

        return true;
      }

      return false;
    } catch (e, stackTrace) {
      state = CoursePlanState.error(e, stackTrace);
      return false;
    }
  }

  /// ============================================
  /// 删除课程规划
  /// ============================================

  Future<bool> delete(int id) async {
    try {
      final count = await _database.delete(
        'course_plans',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (count > 0) {
        // 从状态中移除
        state.when(
          initial: () => state = const CoursePlanState.initial(),
          loading: () => state = const CoursePlanState.loading(),
          error: (error, stackTrace) => state = CoursePlanState.error(error, stackTrace),
          data: (coursePlans, selectedCoursePlan, selectedStudentId) {
            final updatedPlans = coursePlans.where((p) => p.id != id).toList();

            state = CoursePlanState.data(
              coursePlans: updatedPlans,
              selectedCoursePlan: selectedCoursePlan?.id == id
                  ? null
                  : selectedCoursePlan,
              selectedStudentId: selectedStudentId,
            );
          },
        );

        return true;
      }

      return false;
    } catch (e, stackTrace) {
      state = CoursePlanState.error(e, stackTrace);
      return false;
    }
  }

  /// ============================================
  /// 选择课程规划
  /// ============================================

  void selectCoursePlan(int? id) {
    state.when(
      initial: () => state = const CoursePlanState.initial(),
      loading: () => state = const CoursePlanState.loading(),
      error: (error, stackTrace) => state = CoursePlanState.error(error, stackTrace),
      data: (coursePlans, selectedCoursePlan, selectedStudentId) {
        if (id == null) {
          state = CoursePlanState.data(
            coursePlans: coursePlans,
            selectedCoursePlan: null,
            selectedStudentId: selectedStudentId,
          );
          return;
        }

        final selected = coursePlans.firstWhere(
          (plan) => plan.id == id,
          orElse: () => throw ArgumentError('Course plan not found: $id'),
        );

        state = CoursePlanState.data(
          coursePlans: coursePlans,
          selectedCoursePlan: selected,
          selectedStudentId: selectedStudentId,
        );
      },
    );
  }

  /// ============================================
  /// 根据 ID 获取课程规划详情（含课时）
  /// ============================================

  Future<CoursePlan?> getDetailById(int id) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.rawQuery('''
        SELECT cp.*, cg.name as goal_name
        FROM course_plans cp
        LEFT JOIN course_goals cg ON cp.goal_id = cg.id
        WHERE cp.id = ?
      ''', [id]);

      if (maps.isEmpty) return null;

      final coursePlan = CoursePlan.fromMap(maps.first);
      return await _enrichCoursePlan(coursePlan, includeSessions: true);
    } catch (e) {
      return null;
    }
  }

  /// ============================================
  /// 丰富课程规划数据（关联查询）
  /// ============================================

  Future<CoursePlan> _enrichCoursePlan(
    CoursePlan coursePlan, {
    bool includeSessions = false,
  }) async {
    // 查询学员信息
    final List<Map<String, dynamic>> studentMaps = await _database.query(
      'students',
      where: 'id = ?',
      whereArgs: [coursePlan.studentId],
      limit: 1,
    );

    Student? student;
    if (studentMaps.isNotEmpty) {
      student = Student.fromMap(studentMaps.first);
    }

    List<Session>? sessions;
    int? totalSessions;
    int? completedSessions;

    if (includeSessions) {
      // 查询课时列表
      final List<Map<String, dynamic>> sessionMaps = await _database.query(
        'sessions',
        where: 'course_plan_id = ?',
        whereArgs: [coursePlan.id],
        orderBy: 'session_number ASC',
      );

      sessions = sessionMaps.map((map) => Session.fromMap(map)).toList();
      totalSessions = sessions.length;
      completedSessions = sessions.where((s) => s.status == SessionStatus.completed).length;
    } else {
      // 只统计数量
      final result = await _database.rawQuery('''
        SELECT
          COUNT(*) as total,
          SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed
        FROM sessions
        WHERE course_plan_id = ?
      ''', [coursePlan.id]);

      if (result.isNotEmpty) {
        totalSessions = result.first['total'] as int?;
        completedSessions = result.first['completed'] as int?;
      }
    }

    return coursePlan.copyWith(
      student: student,
      sessions: sessions,
      totalSessions: totalSessions,
      completedSessions: completedSessions,
    );
  }

  /// ============================================
  /// 重置状态
  /// ============================================

  void reset() {
    state = const CoursePlanState.initial();
  }
}

/// ============================================
/// CoursePlan 计算属性 Provider
/// ============================================

/// 当前选中的课程规划
@riverpod
CoursePlan? selectedCoursePlan(SelectedCoursePlanRef ref) {
  final coursePlanState = ref.watch(coursePlanNotifierProvider);
  return coursePlanState.maybeWhen(
    data: (_, selected, __) => selected,
    orElse: () => null,
  );
}

/// 课程规划总数
@riverpod
int coursePlanCount(CoursePlanCountRef ref) {
  final coursePlanState = ref.watch(coursePlanNotifierProvider);
  return coursePlanState.maybeWhen(
    data: (plans, _, __) => plans.length,
    orElse: () => 0,
  );
}

/// 当前筛选的学员ID
@riverpod
int? filteredStudentId(FilteredStudentIdRef ref) {
  final coursePlanState = ref.watch(coursePlanNotifierProvider);
  return coursePlanState.maybeWhen(
    data: (_, __, studentId) => studentId,
    orElse: () => null,
  );
}
