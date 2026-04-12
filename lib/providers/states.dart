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
  const Student._();

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
  const CoursePlan._();

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
  const Session._();

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
  const TrainingBlock._();

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
  const Action._();

  const factory Action({
    required int id,
    required String name,
    required bool isDeprecated,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Action;

  factory Action.fromMap(Map<String, dynamic> map) {
    return Action(
      id: map['id'] as int,
      name: map['name'] as String,
      isDeprecated: (map['is_deprecated'] ?? 0) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_deprecated': isDeprecated ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// 器械
@freezed
class Equipment with _$Equipment {
  const Equipment._();

  const factory Equipment({
    required int id,
    required String name,
    required bool isDeprecated,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Equipment;

  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
      id: map['id'] as int,
      name: map['name'] as String,
      isDeprecated: (map['is_deprecated'] ?? 0) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_deprecated': isDeprecated ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// 工具
@freezed
class Tool with _$Tool {
  const Tool._();

  const factory Tool({
    required int id,
    required String name,
    required bool isDeprecated,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Tool;

  factory Tool.fromMap(Map<String, dynamic> map) {
    return Tool(
      id: map['id'] as int,
      name: map['name'] as String,
      isDeprecated: (map['is_deprecated'] ?? 0) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_deprecated': isDeprecated ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// ============================================
/// 课程目标常量
/// ============================================

/// "自定义"目标的固定名称，用于判断特殊逻辑
const kCustomGoalName = '自定义';

/// ============================================
/// 课程目标默认配置
/// ============================================

/// 课程目标配置状态
@freezed
class GoalConfigState with _$GoalConfigState {
  const factory GoalConfigState.initial() = _GoalConfigInitial;
  const factory GoalConfigState.loading() = _GoalConfigLoading;
  const factory GoalConfigState.data({
    required List<GoalConfig> goalConfigs,
  }) = _GoalConfigData;
  const factory GoalConfigState.error(Object error, StackTrace stackTrace) = _GoalConfigError;
}

/// 课程目标配置
@freezed
class GoalConfig with _$GoalConfig {
  const GoalConfig._();

  const factory GoalConfig({
    required int id,
    required String goal,
    String? blueprint,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<GoalConfigSession>? sessions,
    @Default(0) int sessionCount,
  }) = _GoalConfig;

  factory GoalConfig.fromMap(Map<String, dynamic> map) {
    return GoalConfig(
      id: map['id'] as int,
      goal: map['goal'] as String,
      blueprint: map['blueprint'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      sessionCount: map['session_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goal': goal,
      'blueprint': blueprint,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// 课程目标配置课时模板
@freezed
class GoalConfigSession with _$GoalConfigSession {
  const GoalConfigSession._();

  const factory GoalConfigSession({
    required int id,
    required int goalConfigId,
    required int sessionNumber,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<GoalConfigTrainingBlock>? trainingBlocks,
  }) = _GoalConfigSession;

  factory GoalConfigSession.fromMap(Map<String, dynamic> map) {
    return GoalConfigSession(
      id: map['id'] as int,
      goalConfigId: map['goal_config_id'] as int,
      sessionNumber: map['session_number'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goal_config_id': goalConfigId,
      'session_number': sessionNumber,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// 课程目标配置训练块模板
@freezed
class GoalConfigTrainingBlock with _$GoalConfigTrainingBlock {
  const GoalConfigTrainingBlock._();

  const factory GoalConfigTrainingBlock({
    required int id,
    required int goalConfigSessionId,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    Action? action,
    Equipment? equipment,
    Tool? tool,
  }) = _GoalConfigTrainingBlock;

  factory GoalConfigTrainingBlock.fromMap(Map<String, dynamic> map) {
    return GoalConfigTrainingBlock(
      id: map['id'] as int,
      goalConfigSessionId: map['goal_config_session_id'] as int,
      actionId: map['action_id'] as int?,
      equipmentId: map['equipment_id'] as int?,
      toolId: map['tool_id'] as int?,
      reps: map['reps'] as String?,
      sets: map['sets'] as String?,
      duration: map['duration'] as String?,
      intensity: map['intensity'] as String?,
      notes: map['notes'] as String?,
      sortOrder: map['sort_order'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goal_config_session_id': goalConfigSessionId,
      'action_id': actionId,
      'equipment_id': equipmentId,
      'tool_id': toolId,
      'reps': reps,
      'sets': sets,
      'duration': duration,
      'intensity': intensity,
      'notes': notes,
      'sort_order': sortOrder,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
