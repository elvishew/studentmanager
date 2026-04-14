import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

/// ============================================
/// 字段类型枚举
/// ============================================

enum FieldType { select, number, text, multiline }

/// ============================================
/// 课时状态枚举
/// ============================================

enum SessionStatus {
  pending('未开始', 'pending'),
  completed('已完成', 'completed'),
  skipped('已跳过', 'skipped');

  final String label;
  final String value;

  const SessionStatus(this.label, this.value);
}

/// ============================================
/// 排课状态枚举
/// ============================================

enum ScheduledClassStatus {
  scheduled('待上课', 'scheduled'),
  completed('已完成', 'completed'),
  cancelled('已取消', 'cancelled'),
  noShow('未到', 'no_show');

  final String label;
  final String value;

  const ScheduledClassStatus(this.label, this.value);
}

/// ============================================
/// 出勤状态枚举
/// ============================================

enum AttendanceStatus {
  pending('待记录', 'pending'),
  present('出勤', 'present'),
  absent('缺勤', 'absent'),
  late('迟到', 'late');

  final String label;
  final String value;

  const AttendanceStatus(this.label, this.value);
}

/// ============================================
/// 提成类型枚举
/// ============================================

enum CommissionType {
  none('无', 'none'),
  fixed('固定金额', 'fixed'),
  percent('百分比', 'percent');

  final String label;
  final String value;

  const CommissionType(this.label, this.value);
}

/// ============================================
/// 学员状态
/// ============================================

@freezed
class StudentState with _$StudentState {
  const factory StudentState.initial() = _StudentInitial;
  const factory StudentState.loading() = _StudentLoading;
  const factory StudentState.data({
    required List<Student> students,
    required List<Student> filteredStudents,
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
/// 课程类型状态
/// ============================================

@freezed
class CourseTypeState with _$CourseTypeState {
  const factory CourseTypeState.initial() = _CourseTypeInitial;
  const factory CourseTypeState.loading() = _CourseTypeLoading;
  const factory CourseTypeState.data({
    required List<CourseType> courseTypes,
  }) = _CourseTypeData;
  const factory CourseTypeState.error(Object error, StackTrace stackTrace) = _CourseTypeError;
}

/// 课程类型数据模型
@freezed
class CourseType with _$CourseType {
  const CourseType._();

  const factory CourseType({
    required int id,
    required String name,
    String? icon,
    String? color,
    @Default(60) int defaultDuration,
    @Default(false) bool isGroup,
    int? maxStudents,
    @Default(0) double defaultStudentPrice,
    @Default(0) double defaultSessionFee,
    @Default(CommissionType.none) CommissionType defaultCommissionType,
    @Default(0) double defaultCommissionValue,
    @Default(0) int sortOrder,
    @Default(false) bool isDeprecated,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CourseType;

  factory CourseType.fromMap(Map<String, dynamic> map) {
    return CourseType(
      id: map['id'] as int,
      name: map['name'] as String,
      icon: map['icon'] as String?,
      color: map['color'] as String?,
      defaultDuration: map['default_duration'] as int? ?? 60,
      isGroup: (map['is_group'] as int? ?? 0) == 1,
      maxStudents: map['max_students'] as int?,
      defaultStudentPrice: (map['default_student_price'] as num?)?.toDouble() ?? 0,
      defaultSessionFee: (map['default_session_fee'] as num?)?.toDouble() ?? 0,
      defaultCommissionType: _parseCommissionType(map['default_commission_type'] as String?),
      defaultCommissionValue: (map['default_commission_value'] as num?)?.toDouble() ?? 0,
      sortOrder: map['sort_order'] as int? ?? 0,
      isDeprecated: (map['is_deprecated'] as int? ?? 0) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
      'default_duration': defaultDuration,
      'is_group': isGroup ? 1 : 0,
      'max_students': maxStudents,
      'default_student_price': defaultStudentPrice,
      'default_session_fee': defaultSessionFee,
      'default_commission_type': defaultCommissionType.value,
      'default_commission_value': defaultCommissionValue,
      'sort_order': sortOrder,
      'is_deprecated': isDeprecated ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static CommissionType _parseCommissionType(String? value) {
    switch (value) {
      case 'fixed':
        return CommissionType.fixed;
      case 'percent':
        return CommissionType.percent;
      default:
        return CommissionType.none;
    }
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
    CoursePlan? selectedCoursePlan,
    @Default(null) int? selectedStudentId,
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
    required DateTime createdAt,
    required DateTime updatedAt,
    Student? student,
    List<Session>? sessions,
    int? totalSessions,
    int? completedSessions,
  }) = _CoursePlan;

  factory CoursePlan.fromMap(Map<String, dynamic> map) {
    return CoursePlan(
      id: map['id'] as int,
      studentId: map['student_id'] as int,
      goalId: map['goal_id'] as int? ?? 0,
      goalName: map['goal_name'] as String?,
      blueprint: map['blueprint'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'goal_id': goalId,
      'blueprint': blueprint,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

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
    Session? selectedSession,
    @Default(null) int? coursePlanId,
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
    required SessionStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<ContentBlock>? contentBlocks,
  }) = _Session;

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'] as int,
      coursePlanId: map['course_plan_id'] as int,
      sessionNumber: map['session_number'] as int,
      status: _parseSessionStatus(map['status'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course_plan_id': coursePlanId,
      'session_number': sessionNumber,
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

/// ============================================
/// 排课状态
/// ============================================

@freezed
class ScheduledClassState with _$ScheduledClassState {
  const factory ScheduledClassState.initial() = _ScheduledClassInitial;
  const factory ScheduledClassState.loading() = _ScheduledClassLoading;
  const factory ScheduledClassState.data({
    required List<ScheduledClass> scheduledClasses,
    ScheduledClass? selectedClass,
  }) = _ScheduledClassData;
  const factory ScheduledClassState.error(Object error, StackTrace stackTrace) = _ScheduledClassError;
}

/// 排课数据模型
@freezed
class ScheduledClass with _$ScheduledClass {
  const ScheduledClass._();

  const factory ScheduledClass({
    required int id,
    required int courseTypeId,
    String? courseTypeName,
    String? courseTypeColor,
    String? title,
    required DateTime startTime,
    required DateTime endTime,
    @Default(ScheduledClassStatus.scheduled) ScheduledClassStatus status,
    int? sessionId,
    String? location,
    String? notes,
    @Default(0) double teacherSessionFee,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<ClassParticipant>? participants,
    CourseType? courseType,
  }) = _ScheduledClass;

  factory ScheduledClass.fromMap(Map<String, dynamic> map) {
    return ScheduledClass(
      id: map['id'] as int,
      courseTypeId: map['course_type_id'] as int,
      courseTypeName: map['course_type_name'] as String?,
      courseTypeColor: map['course_type_color'] as String?,
      title: map['title'] as String?,
      startTime: DateTime.parse(map['start_time'] as String),
      endTime: DateTime.parse(map['end_time'] as String),
      status: _parseScheduledClassStatus(map['status'] as String? ?? 'scheduled'),
      sessionId: map['session_id'] as int?,
      location: map['location'] as String?,
      notes: map['notes'] as String?,
      teacherSessionFee: (map['teacher_session_fee'] as num?)?.toDouble() ?? 0,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course_type_id': courseTypeId,
      'title': title,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'status': status.value,
      'session_id': sessionId,
      'location': location,
      'notes': notes,
      'teacher_session_fee': teacherSessionFee,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// 时长（分钟）
  int get durationInMinutes {
    return endTime.difference(startTime).inMinutes;
  }

  static ScheduledClassStatus _parseScheduledClassStatus(String value) {
    switch (value) {
      case 'completed':
        return ScheduledClassStatus.completed;
      case 'cancelled':
        return ScheduledClassStatus.cancelled;
      case 'no_show':
        return ScheduledClassStatus.noShow;
      default:
        return ScheduledClassStatus.scheduled;
    }
  }
}

/// ============================================
/// 参与人数据模型
/// ============================================

@freezed
class ClassParticipant with _$ClassParticipant {
  const ClassParticipant._();

  const factory ClassParticipant({
    required int id,
    required int scheduledClassId,
    int? studentId,
    String? guestName,
    @Default(AttendanceStatus.pending) AttendanceStatus attendance,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? studentName, // 关联查询时的学员姓名
  }) = _ClassParticipant;

  factory ClassParticipant.fromMap(Map<String, dynamic> map) {
    return ClassParticipant(
      id: map['id'] as int,
      scheduledClassId: map['scheduled_class_id'] as int,
      studentId: map['student_id'] as int?,
      guestName: map['guest_name'] as String?,
      attendance: _parseAttendanceStatus(map['attendance'] as String? ?? 'pending'),
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      studentName: map['student_name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'scheduled_class_id': scheduledClassId,
      'student_id': studentId,
      'guest_name': guestName,
      'attendance': attendance.value,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// 显示名称
  String get displayName {
    if (studentName != null) return studentName!;
    if (guestName != null) return guestName!;
    return '未知';
  }

  /// 是否是临时人员
  bool get isGuest => studentId == null && guestName != null;

  static AttendanceStatus _parseAttendanceStatus(String value) {
    switch (value) {
      case 'present':
        return AttendanceStatus.present;
      case 'absent':
        return AttendanceStatus.absent;
      case 'late':
        return AttendanceStatus.late;
      default:
        return AttendanceStatus.pending;
    }
  }
}

/// ============================================
/// 学员付费状态
/// ============================================

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _PaymentInitial;
  const factory PaymentState.loading() = _PaymentLoading;
  const factory PaymentState.data({
    required List<StudentPayment> payments,
  }) = _PaymentData;
  const factory PaymentState.error(Object error, StackTrace stackTrace) = _PaymentError;
}

/// 学员付费数据模型
@freezed
class StudentPayment with _$StudentPayment {
  const StudentPayment._();

  const factory StudentPayment({
    required int id,
    required int studentId,
    int? courseTypeId,
    int? coursePlanId,
    @Default(0) double amount,
    String? description,
    @Default(CommissionType.none) CommissionType commissionType,
    @Default(0) double commissionValue,
    @Default(0) double commissionEarned,
    required DateTime paidAt,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? studentName,
    String? courseTypeName,
  }) = _StudentPayment;

  factory StudentPayment.fromMap(Map<String, dynamic> map) {
    return StudentPayment(
      id: map['id'] as int,
      studentId: map['student_id'] as int,
      courseTypeId: map['course_type_id'] as int?,
      coursePlanId: map['course_plan_id'] as int?,
      amount: (map['amount'] as num?)?.toDouble() ?? 0,
      description: map['description'] as String?,
      commissionType: _parseCommissionType(map['commission_type'] as String?),
      commissionValue: (map['commission_value'] as num?)?.toDouble() ?? 0,
      commissionEarned: (map['commission_earned'] as num?)?.toDouble() ?? 0,
      paidAt: DateTime.parse(map['paid_at'] as String),
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      studentName: map['student_name'] as String?,
      courseTypeName: map['course_type_name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'course_type_id': courseTypeId,
      'course_plan_id': coursePlanId,
      'amount': amount,
      'description': description,
      'commission_type': commissionType.value,
      'commission_value': commissionValue,
      'commission_earned': commissionEarned,
      'paid_at': paidAt.toIso8601String(),
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static CommissionType _parseCommissionType(String? value) {
    switch (value) {
      case 'fixed':
        return CommissionType.fixed;
      case 'percent':
        return CommissionType.percent;
      default:
        return CommissionType.none;
    }
  }
}

/// ============================================
/// 统计数据
/// ============================================

class StatisticsData {
  final int totalClasses;
  final double totalStudentPayment;
  final double totalTeacherIncome;
  final double attendanceRate;
  final List<CourseTypeDistribution> courseTypeDistribution;
  final List<StudentRanking> studentRankings;
  final List<IncomeTrend> incomeTrends;

  const StatisticsData({
    this.totalClasses = 0,
    this.totalStudentPayment = 0,
    this.totalTeacherIncome = 0,
    this.attendanceRate = 0,
    this.courseTypeDistribution = const [],
    this.studentRankings = const [],
    this.incomeTrends = const [],
  });
}

class CourseTypeDistribution {
  final String name;
  final String? color;
  final int count;
  final double percentage;

  const CourseTypeDistribution({
    required this.name,
    this.color,
    required this.count,
    required this.percentage,
  });
}

class StudentRanking {
  final int studentId;
  final String studentName;
  final double totalAmount;
  final int classCount;

  const StudentRanking({
    required this.studentId,
    required this.studentName,
    required this.totalAmount,
    required this.classCount,
  });
}

class IncomeTrend {
  final String label; // week/month label
  final double commissionIncome;
  final double sessionFeeIncome;

  const IncomeTrend({
    required this.label,
    required this.commissionIncome,
    required this.sessionFeeIncome,
  });

  double get total => commissionIncome + sessionFeeIncome;
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
    List<FieldOption>? options,
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
    @Default({}) Map<int, String> values,
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

@freezed
class GoalConfigState with _$GoalConfigState {
  const factory GoalConfigState.initial() = _GoalConfigInitial;
  const factory GoalConfigState.loading() = _GoalConfigLoading;
  const factory GoalConfigState.data({
    required List<GoalConfig> goalConfigs,
  }) = _GoalConfigData;
  const factory GoalConfigState.error(Object error, StackTrace stackTrace) = _GoalConfigError;
}

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

@freezed
class GoalConfigContentBlock with _$GoalConfigContentBlock {
  const GoalConfigContentBlock._();

  const factory GoalConfigContentBlock({
    required int id,
    required int goalConfigSessionId,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default({}) Map<int, String> values,
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
