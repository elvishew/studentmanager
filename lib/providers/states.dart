import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

/// ============================================
/// 字段类型枚举
/// ============================================

enum FieldType { select, number, text, multiline }

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
    required int goalId,
    String? goalName,
    String? blueprint,
    @Default(60) int? defaultDuration,
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
      goalId: map['goal_id'] as int? ?? 0,
      goalName: map['goal_name'] as String?,
      blueprint: map['blueprint'] as String?,
      defaultDuration: map['default_duration'] as int? ?? 60,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// 转换为数据库 Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'goal_id': goalId,
      'blueprint': blueprint,
      'default_duration': defaultDuration,
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
    int? durationOverride,
    required SessionStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<ContentBlock>? contentBlocks, // 关联的内容块列表
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
      durationOverride: map['duration_override'] as int?,
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
      'duration_override': durationOverride,
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
/// 内容字段定义
/// ============================================

@freezed
class ContentField with _$ContentField {
  const ContentField._();

  const factory ContentField({
    required int id,
    required String name,
    required FieldType fieldType,
    @Default(false) bool isRequired,
    required int sortOrder,
    @Default(false) bool isDeprecated,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<FieldOption>? options, // 关联的选项列表
  }) = _ContentField;

  factory ContentField.fromMap(Map<String, dynamic> map) {
    return ContentField(
      id: map['id'] as int,
      name: map['name'] as String,
      fieldType: _parseFieldType(map['field_type'] as String),
      isRequired: (map['is_required'] ?? 0) == 1,
      sortOrder: map['sort_order'] as int? ?? 0,
      isDeprecated: (map['is_deprecated'] ?? 0) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  static FieldType _parseFieldType(String type) {
    switch (type) {
      case 'select':
        return FieldType.select;
      case 'number':
        return FieldType.number;
      case 'text':
        return FieldType.text;
      case 'multiline':
        return FieldType.multiline;
      default:
        return FieldType.text;
    }
  }
}

/// ============================================
/// 字段选项
/// ============================================

@freezed
class FieldOption with _$FieldOption {
  const FieldOption._();

  const factory FieldOption({
    required int id,
    required int contentFieldId,
    required String value,
    @Default(false) bool isDeprecated,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FieldOption;

  factory FieldOption.fromMap(Map<String, dynamic> map) {
    return FieldOption(
      id: map['id'] as int,
      contentFieldId: map['content_field_id'] as int,
      value: map['value'] as String,
      isDeprecated: (map['is_deprecated'] ?? 0) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}

/// ============================================
/// 内容块
/// ============================================

@freezed
class ContentBlock with _$ContentBlock {
  const ContentBlock._();

  const factory ContentBlock({
    required int id,
    required int sessionId,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default({}) Map<int, String> values, // contentFieldId -> value
  }) = _ContentBlock;

  factory ContentBlock.fromMap(Map<String, dynamic> map) {
    return ContentBlock(
      id: map['id'] as int,
      sessionId: map['session_id'] as int,
      sortOrder: map['sort_order'] as int? ?? 0,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}

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
    required int goalId,
    String? goalName,
    String? blueprint,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<GoalConfigSession>? sessions,
    @Default(0) int sessionCount,
  }) = _GoalConfig;

  factory GoalConfig.fromMap(Map<String, dynamic> map) {
    return GoalConfig(
      id: map['id'] as int,
      goalId: map['goal_id'] as int? ?? 0,
      goalName: map['goal_name'] as String?,
      blueprint: map['blueprint'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      sessionCount: map['session_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goal_id': goalId,
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
    List<GoalConfigContentBlock>? contentBlocks,
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

/// 默认配置内容块
@freezed
class GoalConfigContentBlock with _$GoalConfigContentBlock {
  const GoalConfigContentBlock._();

  const factory GoalConfigContentBlock({
    required int id,
    required int goalConfigSessionId,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default({}) Map<int, String> values, // contentFieldId -> value
  }) = _GoalConfigContentBlock;

  factory GoalConfigContentBlock.fromMap(Map<String, dynamic> map) {
    return GoalConfigContentBlock(
      id: map['id'] as int,
      goalConfigSessionId: map['goal_config_session_id'] as int,
      sortOrder: map['sort_order'] as int? ?? 0,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}

/// ============================================
/// 相册状态
/// ============================================

@freezed
class AlbumState with _$AlbumState {
  const factory AlbumState.initial() = _AlbumInitial;
  const factory AlbumState.loading() = _AlbumLoading;
  const factory AlbumState.data({
    required List<Album> albums,
    @Default(null) int? selectedStudentId,
  }) = _AlbumData;
  const factory AlbumState.error(Object error, StackTrace stackTrace) = _AlbumError;
}

/// 相册数据模型
@freezed
class Album with _$Album {
  const Album._();

  const factory Album({
    required int id,
    required int studentId,
    required String name,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int photoCount,
  }) = _Album;

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'] as int,
      studentId: map['student_id'] as int,
      name: map['name'] as String,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      photoCount: map['photo_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'name': name,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// 相册照片数据模型
@freezed
class AlbumPhoto with _$AlbumPhoto {
  const AlbumPhoto._();

  const factory AlbumPhoto({
    required int id,
    required int albumId,
    required String filePath,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AlbumPhoto;

  factory AlbumPhoto.fromMap(Map<String, dynamic> map) {
    return AlbumPhoto(
      id: map['id'] as int,
      albumId: map['album_id'] as int,
      filePath: map['file_path'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'album_id': albumId,
      'file_path': filePath,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
