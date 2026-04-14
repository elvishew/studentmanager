import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'states.dart';
import 'student_provider.dart';
import '../database/scheduled_class_repository.dart';

part 'scheduled_class_provider.g.dart';

/// ============================================
/// ScheduledClassRepository Provider
/// ============================================

@Riverpod(keepAlive: true)
ScheduledClassRepository scheduledClassRepository(ScheduledClassRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return ScheduledClassRepository(database: database);
}

/// ============================================
/// ScheduledClassNotifier
/// ============================================

@Riverpod(keepAlive: true)
class ScheduledClassNotifier extends _$ScheduledClassNotifier {
  late final ScheduledClassRepository _repository;

  @override
  ScheduledClassState build() {
    _repository = ref.watch(scheduledClassRepositoryProvider);
    return const ScheduledClassState.initial();
  }

  /// 按日期范围查询排课
  Future<void> fetchByDateRange(DateTime startDate, DateTime endDate) async {
    state = const ScheduledClassState.loading();
    try {
      final maps = await _repository.getByDateRange(
        startDate: startDate.toIso8601String(),
        endDate: endDate.toIso8601String(),
      );
      final classes = maps.map((m) => ScheduledClass.fromMap(m)).toList();
      state = ScheduledClassState.data(scheduledClasses: classes);
    } catch (e, st) {
      state = ScheduledClassState.error(e, st);
    }
  }

  /// 按日期查询排课
  Future<void> fetchByDate(DateTime date) async {
    state = const ScheduledClassState.loading();
    try {
      final dateStr = date.toIso8601String().substring(0, 10);
      final nextDay = date.add(const Duration(days: 1));
      final maps = await _repository.getByDateRange(
        startDate: '${dateStr}T00:00:00',
        endDate: '${nextDay.toIso8601String().substring(0, 10)}T00:00:00',
      );
      final classes = maps.map((m) => ScheduledClass.fromMap(m)).toList();
      state = ScheduledClassState.data(scheduledClasses: classes);
    } catch (e, st) {
      state = ScheduledClassState.error(e, st);
    }
  }

  /// 创建排课
  Future<int?> createScheduledClass({
    required int courseTypeId,
    String? title,
    required DateTime startTime,
    required DateTime endTime,
    int? sessionId,
    String? location,
    String? notes,
    double teacherSessionFee = 0,
    List<Map<String, dynamic>> participants = const [],
  }) async {
    try {
      final id = await _repository.createWithParticipants(
        courseTypeId: courseTypeId,
        title: title,
        startTime: startTime.toIso8601String(),
        endTime: endTime.toIso8601String(),
        sessionId: sessionId,
        location: location,
        notes: notes,
        teacherSessionFee: teacherSessionFee,
        participants: participants,
      );
      return id;
    } catch (e, st) {
      state = ScheduledClassState.error(e, st);
      return null;
    }
  }

  /// 消课
  Future<bool> completeClass(int id) async {
    try {
      return await _repository.completeClass(id);
    } catch (e, st) {
      state = ScheduledClassState.error(e, st);
      return false;
    }
  }

  /// 取消排课
  Future<bool> cancelClass(int id) async {
    try {
      return await _repository.cancelClass(id);
    } catch (e, st) {
      state = ScheduledClassState.error(e, st);
      return false;
    }
  }

  /// 标记未到
  Future<bool> markNoShow(int id) async {
    try {
      return await _repository.markNoShow(id);
    } catch (e, st) {
      state = ScheduledClassState.error(e, st);
      return false;
    }
  }

  /// 删除排课
  Future<bool> deleteClass(int id) async {
    try {
      return await _repository.delete(id);
    } catch (e, st) {
      state = ScheduledClassState.error(e, st);
      return false;
    }
  }

  /// 更新参与人出勤
  Future<bool> updateParticipantAttendance({
    required int participantId,
    required AttendanceStatus attendance,
  }) async {
    try {
      return await _repository.updateParticipantAttendance(
        participantId: participantId,
        attendance: attendance.value,
      );
    } catch (e, st) {
      return false;
    }
  }

  /// 添加参与人
  Future<int?> addParticipant({
    required int scheduledClassId,
    int? studentId,
    String? guestName,
  }) async {
    try {
      return await _repository.addParticipant(
        scheduledClassId: scheduledClassId,
        studentId: studentId,
        guestName: guestName,
      );
    } catch (e, st) {
      return null;
    }
  }

  /// 移除参与人
  Future<bool> removeParticipant(int participantId) async {
    try {
      return await _repository.removeParticipant(participantId);
    } catch (e, st) {
      return false;
    }
  }

  /// 获取排课详情
  Future<Map<String, dynamic>?> getDetail(int id) async {
    try {
      return await _repository.getDetail(id);
    } catch (e) {
      return null;
    }
  }

  /// 获取未排课的 session 列表
  Future<List<Map<String, dynamic>>> getUnscheduledSessions(int coursePlanId) async {
    try {
      return await _repository.getUnscheduledSessions(coursePlanId);
    } catch (e) {
      return [];
    }
  }
}

/// ============================================
/// 计算属性
/// ============================================

/// 选中日期
@Riverpod(keepAlive: true)
class SelectedDate extends _$SelectedDate {
  @override
  DateTime build() => DateTime.now();

  void setDate(DateTime date) {
    state = date;
  }
}

/// 当前视图模式
enum ScheduleViewMode { day, week, month }

@Riverpod(keepAlive: true)
class ScheduleView extends _$ScheduleView {
  @override
  ScheduleViewMode build() => ScheduleViewMode.day;

  void setMode(ScheduleViewMode mode) {
    state = mode;
  }
}
