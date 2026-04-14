import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'states.dart';
import 'student_provider.dart';
import '../database/course_type_repository.dart';

part 'course_type_provider.g.dart';

/// ============================================
/// CourseTypeRepository Provider
/// ============================================

@riverpod
CourseTypeRepository courseTypeRepository(CourseTypeRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return CourseTypeRepository(database: database);
}

/// ============================================
/// CourseTypeNotifier
/// ============================================

@riverpod
class CourseTypeNotifier extends _$CourseTypeNotifier {
  late final CourseTypeRepository _repository;

  @override
  CourseTypeState build() {
    _repository = ref.watch(courseTypeRepositoryProvider);
    return const CourseTypeState.initial();
  }

  /// 加载所有课程类型
  Future<void> fetchAll() async {
    state = const CourseTypeState.loading();
    try {
      final maps = await _repository.getAll();
      final courseTypes = maps.map((m) => CourseType.fromMap(m)).toList();
      state = CourseTypeState.data(courseTypes: courseTypes);
    } catch (e, st) {
      state = CourseTypeState.error(e, st);
    }
  }

  /// 创建课程类型
  Future<int?> create({
    required String name,
    String? icon,
    String? color,
    int defaultDuration = 60,
    bool isGroup = false,
    int? maxStudents,
    double defaultStudentPrice = 0,
    double defaultSessionFee = 0,
    CommissionType defaultCommissionType = CommissionType.none,
    double defaultCommissionValue = 0,
  }) async {
    try {
      if (await _repository.checkNameExists(name)) return null;

      final maxOrder = await _repository.getMaxSortOrder();
      final id = await _repository.create(
        name: name,
        icon: icon,
        color: color,
        defaultDuration: defaultDuration,
        isGroup: isGroup,
        maxStudents: maxStudents,
        defaultStudentPrice: defaultStudentPrice,
        defaultSessionFee: defaultSessionFee,
        defaultCommissionType: defaultCommissionType.value,
        defaultCommissionValue: defaultCommissionValue,
        sortOrder: maxOrder + 1,
      );

      await fetchAll();
      return id;
    } catch (e, st) {
      state = CourseTypeState.error(e, st);
      return null;
    }
  }

  /// 更新课程类型
  Future<bool> updateType({
    required int id,
    String? name,
    String? icon,
    String? color,
    int? defaultDuration,
    bool? isGroup,
    int? maxStudents,
    double? defaultStudentPrice,
    double? defaultSessionFee,
    CommissionType? defaultCommissionType,
    double? defaultCommissionValue,
  }) async {
    try {
      if (name != null && await _repository.checkNameExists(name, excludeId: id)) {
        return false;
      }

      final success = await _repository.update(
        id: id,
        name: name,
        icon: icon,
        color: color,
        defaultDuration: defaultDuration,
        isGroup: isGroup,
        maxStudents: maxStudents,
        defaultStudentPrice: defaultStudentPrice,
        defaultSessionFee: defaultSessionFee,
        defaultCommissionType: defaultCommissionType?.value,
        defaultCommissionValue: defaultCommissionValue,
      );

      if (success) await fetchAll();
      return success;
    } catch (e, st) {
      state = CourseTypeState.error(e, st);
      return false;
    }
  }

  /// 弃用/恢复课程类型
  Future<bool> toggleDeprecated(int id, bool isDeprecated) async {
    try {
      final success = await _repository.toggleDeprecated(id, isDeprecated);
      if (success) await fetchAll();
      return success;
    } catch (e, st) {
      state = CourseTypeState.error(e, st);
      return false;
    }
  }

  /// 删除课程类型
  Future<bool> delete(int id) async {
    try {
      final success = await _repository.delete(id);
      if (success) await fetchAll();
      return success;
    } catch (e, st) {
      state = CourseTypeState.error(e, st);
      return false;
    }
  }
}

/// ============================================
/// 课程类型计算属性
/// ============================================

/// 未弃用的课程类型列表
@riverpod
List<CourseType> activeCourseTypes(ActiveCourseTypesRef ref) {
  final ctState = ref.watch(courseTypeNotifierProvider);
  return ctState.maybeWhen(
    data: (types) => types.where((t) => !t.isDeprecated).toList(),
    orElse: () => [],
  );
}

/// 非团课类型列表
@riverpod
List<CourseType> privateCourseTypes(PrivateCourseTypesRef ref) {
  final types = ref.watch(activeCourseTypesProvider);
  return types.where((t) => !t.isGroup).toList();
}

/// 团课类型列表
@riverpod
List<CourseType> groupCourseTypes(GroupCourseTypesRef ref) {
  final types = ref.watch(activeCourseTypesProvider);
  return types.where((t) => t.isGroup).toList();
}
