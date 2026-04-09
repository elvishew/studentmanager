import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

/// ============================================
/// 学员状态
/// ============================================

@freezed
class StudentState with _$StudentState {
  const factory StudentState.initial() = _StudentInitial;
  const factory StudentState.loading() = _StudentLoading;
  const factory StudentState.data({
    required List<Student> students,
    required List<Student> filteredStudents, // 搜索过滤后的结果
    @Default('') String searchQuery,
  }) = _StudentData;
  const factory StudentState.error(Object error, StackTrace stackTrace) = _StudentError;
}

/// 学员数据模型
@freezed
class Student with _$Student {
  const factory Student({
    required int id,
    required String name,
    String? gender,
    required String contact,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Student;

  /// 从数据库 Map 转换
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int,
      name: map['name'] as String,
      gender: map['gender'] as String?,
      contact: map['contact'] as String,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// 转换为数据库 Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'contact': contact,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// ============================================
/// 课程规划状态
/// ============================================

@freezed
class CoursePlanState with _$CoursePlanState {
  const factory CoursePlanState.initial() = _CoursePlanInitial;
  const factory CoursePlanState.loading() = _CoursePlanLoading;
  const factory CoursePlanState.data({
    required List<CoursePlan> coursePlans,
    CoursePlan? selectedCoursePlan, // 当前选中的课程规划
    @Default(null) int? selectedStudentId, // 当前筛选的学员ID
  }) = _CoursePlanData;
  const factory CoursePlanState.error(Object error, StackTrace stackTrace) = _CoursePlanError;
}

/// 课程规划数据模型
@freezed
class CoursePlan with _$CoursePlan {
  const factory CoursePlan({
    required int id,
    required int studentId,
    required String goal,
    String? blueprint,
    required DateTime createdAt,
    required DateTime updatedAt,
    Student? student, // 关联的学员信息
    List<Session>? sessions, // 关联的课时列表
    int? totalSessions, // 总课时数
    int? completedSessions, // 已完成课时数
  }) = _CoursePlan;

  /// 从数据库 Map 转换
  factory CoursePlan.fromMap(Map<String, dynamic> map) {
    return CoursePlan(
      id: map['id'] as int,
      studentId: map['student_id'] as int,
      goal: map['goal'] as String,
      blueprint: map['blueprint'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// 转换为数据库 Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'goal': goal,
      'blueprint': blueprint,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// 计算完成率
  double get completionRate {
    if (totalSessions == null || totalSessions == 0) return 0.0;
    return (completedSessions ?? 0) / totalSessions!;
  }
}

/// ============================================
/// 课时状态
/// ============================================

@freezed
class SessionState with _$SessionState {
  const factory SessionState.initial() = _SessionInitial;
  const factory SessionState.loading() = _SessionLoading;
  const factory SessionState.data({
    required List<Session> sessions,
    Session? selectedSession, // 当前选中的课时
    @Default(null) int? coursePlanId, // 所属的课程规划ID
  }) = _SessionData;
  const factory SessionState.error(Object error, StackTrace stackTrace) = _SessionError;
}

/// 课时数据模型
@freezed
class Session with _$Session {
  const factory Session({
    required int id,
    required int coursePlanId,
    required int sessionNumber,
    DateTime? scheduledTime,
    required SessionStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<TrainingBlock>? trainingBlocks, // 关联的训练块列表
  }) = _Session;

  /// 从数据库 Map 转换
  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'] as int,
      coursePlanId: map['course_plan_id'] as int,
      sessionNumber: map['session_number'] as int,
      scheduledTime: map['scheduled_time'] != null
          ? DateTime.parse(map['scheduled_time'] as String)
          : null,
      status: _parseSessionStatus(map['status'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// 转换为数据库 Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course_plan_id': coursePlanId,
      'session_number': sessionNumber,
      'scheduled_time': scheduledTime?.toIso8601String(),
      'status': status.value,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static SessionStatus _parseSessionStatus(String status) {
    switch (status) {
      case 'pending':
        return SessionStatus.pending;
      case 'completed':
        return SessionStatus.completed;
      case 'skipped':
        return SessionStatus.skipped;
      default:
        return SessionStatus.pending;
    }
  }
}

/// 课时状态枚举
enum SessionStatus {
  pending('未开始', 'pending'),
  completed('已完成', 'completed'),
  skipped('已跳过', 'skipped');

  final String label;
  final String value;

  const SessionStatus(this.label, this.value);
}

/// ============================================
/// 训练块数据模型
/// ============================================

@freezed
class TrainingBlock with _$TrainingBlock {
  const factory TrainingBlock({
    required int id,
    required int sessionId,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
    required bool isCustom,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    Action? action, // 关联的动作
    Equipment? equipment, // 关联的器械
    Tool? tool, // 关联的工具
  }) = _TrainingBlock;

  /// 从数据库 Map 转换
  factory TrainingBlock.fromMap(Map<String, dynamic> map) {
    return TrainingBlock(
      id: map['id'] as int,
      sessionId: map['session_id'] as int,
      actionId: map['action_id'] as int?,
      equipmentId: map['equipment_id'] as int?,
      toolId: map['tool_id'] as int?,
      reps: map['reps'] as String?,
      sets: map['sets'] as String?,
      duration: map['duration'] as String?,
      intensity: map['intensity'] as String?,
      notes: map['notes'] as String?,
      isCustom: (map['is_custom'] as int) == 1,
      sortOrder: map['sort_order'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// 转换为数据库 Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'session_id': sessionId,
      'action_id': actionId,
      'equipment_id': equipmentId,
      'tool_id': toolId,
      'reps': reps,
      'sets': sets,
      'duration': duration,
      'intensity': intensity,
      'notes': notes,
      'is_custom': isCustom ? 1 : 0,
      'sort_order': sortOrder,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// ============================================
/// 基础数据模型
/// ============================================

/// 动作
@freezed
class Action with _$Action {
  const factory Action({
    required int id,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Action;

  factory Action.fromMap(Map<String, dynamic> map) {
    return Action(
      id: map['id'] as int,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// 器械
@freezed
class Equipment with _$Equipment {
  const factory Equipment({
    required int id,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Equipment;

  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
      id: map['id'] as int,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// 工具
@freezed
class Tool with _$Tool {
  const factory Tool({
    required int id,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Tool;

  factory Tool.fromMap(Map<String, dynamic> map) {
    return Tool(
      id: map['id'] as int,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// ============================================
/// 课程目标枚举
/// ============================================

enum CourseGoal {
  postpartum('产后修复'),
  neckShoulder('肩颈理疗'),
  backShoulder('肩背打造'),
  backPain('腰酸治疗'),
  waistAbs('腰腹塑形'),
  fullBody('全身塑形'),
  gluteLeg('臀腿打造'),
  kneePain('膝盖疼痛'),
  custom('自定义');

  final String label;

  const CourseGoal(this.label);

  /// 获取数据库存储的值
  String get value {
    switch (this) {
      case CourseGoal.postpartum:
        return '产后修复';
      case CourseGoal.neckShoulder:
        return '肩颈理疗';
      case CourseGoal.backShoulder:
        return '肩背打造';
      case CourseGoal.backPain:
        return '腰酸治疗';
      case CourseGoal.waistAbs:
        return '腰腹塑形';
      case CourseGoal.fullBody:
        return '全身塑形';
      case CourseGoal.gluteLeg:
        return '臀腿打造';
      case CourseGoal.kneePain:
        return '膝盖疼痛';
      case CourseGoal.custom:
        return '自定义';
    }
  }

  /// 从字符串解析
  static CourseGoal? fromValue(String value) {
    switch (value) {
      case '产后修复':
        return CourseGoal.postpartum;
      case '肩颈理疗':
        return CourseGoal.neckShoulder;
      case '肩背打造':
        return CourseGoal.backShoulder;
      case '腰酸治疗':
        return CourseGoal.backPain;
      case '腰腹塑形':
        return CourseGoal.waistAbs;
      case '全身塑形':
        return CourseGoal.fullBody;
      case '臀腿打造':
        return CourseGoal.gluteLeg;
      case '膝盖疼痛':
        return CourseGoal.kneePain;
      case '自定义':
        return CourseGoal.custom;
      default:
        return null;
    }
  }

  /// 所有选项列表
  static List<CourseGoal> get values => CourseGoal.values;
}
