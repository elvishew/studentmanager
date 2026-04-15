import 'package:sqflite/sqflite.dart';

/// 排课仓库
class ScheduledClassRepository {
  final Database database;

  ScheduledClassRepository({required this.database});

  /// 创建排课记录
  Future<int> create({
    required int courseTypeId,
    String? title,
    required String startTime,
    required String endTime,
    String status = 'scheduled',
    int? sessionId,
    String? location,
    String? notes,
    double teacherSessionFee = 0,
  }) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert('scheduled_classes', {
      'course_type_id': courseTypeId,
      'title': title,
      'start_time': startTime,
      'end_time': endTime,
      'status': status,
      'session_id': sessionId,
      'location': location,
      'notes': notes,
      'teacher_session_fee': teacherSessionFee,
      'created_at': now,
      'updated_at': now,
    });
  }

  /// 创建排课记录（含参与人）— 事务
  Future<int> createWithParticipants({
    required int courseTypeId,
    String? title,
    required String startTime,
    required String endTime,
    String status = 'scheduled',
    int? sessionId,
    String? location,
    String? notes,
    double teacherSessionFee = 0,
    required List<Map<String, dynamic>> participants,
  }) async {
    return await database.transaction((txn) async {
      final now = DateTime.now().toIso8601String();

      final classId = await txn.insert('scheduled_classes', {
        'course_type_id': courseTypeId,
        'title': title,
        'start_time': startTime,
        'end_time': endTime,
        'status': status,
        'session_id': sessionId,
        'location': location,
        'notes': notes,
        'teacher_session_fee': teacherSessionFee,
        'created_at': now,
        'updated_at': now,
      });

      for (final p in participants) {
        await txn.insert('class_participants', {
          'scheduled_class_id': classId,
          'student_id': p['student_id'],
          'guest_name': p['guest_name'],
          'attendance': 'pending',
          'notes': p['notes'],
          'created_at': now,
          'updated_at': now,
        });
      }

      return classId;
    });
  }

  /// 更新排课记录
  Future<bool> update({
    required int id,
    int? courseTypeId,
    String? title,
    String? startTime,
    String? endTime,
    String? status,
    int? sessionId,
    bool clearSessionId = false,
    String? location,
    String? notes,
    double? teacherSessionFee,
  }) async {
    final data = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (courseTypeId != null) data['course_type_id'] = courseTypeId;
    if (title != null) data['title'] = title;
    if (startTime != null) data['start_time'] = startTime;
    if (endTime != null) data['end_time'] = endTime;
    if (status != null) data['status'] = status;
    if (sessionId != null) {
      data['session_id'] = sessionId;
    } else if (clearSessionId) {
      data['session_id'] = null;
    }
    if (location != null) data['location'] = location;
    if (notes != null) data['notes'] = notes;
    if (teacherSessionFee != null) data['teacher_session_fee'] = teacherSessionFee;

    final count = await database.update(
      'scheduled_classes',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 消课（标记完成 + 自动完成关联 session）
  Future<bool> completeClass(int id) async {
    return await database.transaction((txn) async {
      final now = DateTime.now().toIso8601String();

      // 获取排课信息
      final results = await txn.query(
        'scheduled_classes',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (results.isEmpty) return false;

      final scheduledClass = results.first;

      // 更新排课状态为已完成
      await txn.update(
        'scheduled_classes',
        {'status': 'completed', 'updated_at': now},
        where: 'id = ?',
        whereArgs: [id],
      );

      // 如果关联了 session，自动标记 session 为已完成
      final sessionId = scheduledClass['session_id'] as int?;
      if (sessionId != null) {
        await txn.update(
          'sessions',
          {'status': 'completed', 'updated_at': now},
          where: 'id = ?',
          whereArgs: [sessionId],
        );
      }

      return true;
    });
  }

  /// 取消排课
  Future<bool> cancelClass(int id) async {
    final count = await database.update(
      'scheduled_classes',
      {
        'status': 'cancelled',
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 恢复排课（回到 scheduled 状态）
  Future<bool> restoreClass(int id) async {
    final count = await database.update(
      'scheduled_classes',
      {
        'status': 'scheduled',
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ? AND status IN (?, ?)',
      whereArgs: [id, 'cancelled', 'no_show'],
    );
    return count > 0;
  }

  /// 标记未到
  Future<bool> markNoShow(int id) async {
    final count = await database.update(
      'scheduled_classes',
      {
        'status': 'no_show',
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 删除排课记录
  Future<bool> delete(int id) async {
    final count = await database.delete(
      'scheduled_classes',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// ============================================
  /// 查询方法
  /// ============================================

  /// 按日期范围查询排课（含课程类型信息）
  Future<List<Map<String, dynamic>>> getByDateRange({
    required String startDate,
    required String endDate,
  }) async {
    return await database.rawQuery('''
      SELECT sc.*, ct.name as course_type_name, ct.color as course_type_color,
             ct.icon as course_type_icon, ct.is_group as course_type_is_group
      FROM scheduled_classes sc
      LEFT JOIN course_types ct ON sc.course_type_id = ct.id
      WHERE sc.start_time >= ? AND sc.start_time < ?
      ORDER BY sc.start_time ASC
    ''', [startDate, endDate]);
  }

  /// 按日期查询排课
  Future<List<Map<String, dynamic>>> getByDate(String date) async {
    final nextDay = DateTime.parse(date).add(const Duration(days: 1));
    return await getByDateRange(
      startDate: '${date}T00:00:00',
      endDate: '${nextDay.toIso8601String().substring(0, 10)}T00:00:00',
    );
  }

  /// 获取排课详情（含参与人）
  Future<Map<String, dynamic>?> getDetail(int id) async {
    // 查询排课信息
    final results = await database.rawQuery('''
      SELECT sc.*, ct.name as course_type_name, ct.color as course_type_color,
             ct.icon as course_type_icon, ct.is_group as course_type_is_group,
             ct.default_duration as course_type_default_duration
      FROM scheduled_classes sc
      LEFT JOIN course_types ct ON sc.course_type_id = ct.id
      WHERE sc.id = ?
    ''', [id]);

    if (results.isEmpty) return null;

    final data = Map<String, dynamic>.from(results.first);

    // 查询参与人
    final participants = await database.rawQuery('''
      SELECT cp.*, s.name as student_name
      FROM class_participants cp
      LEFT JOIN students s ON cp.student_id = s.id
      WHERE cp.scheduled_class_id = ?
      ORDER BY cp.id ASC
    ''', [id]);

    data['participants'] = participants;

    // 如果关联了 session，查询 session 信息
    final sessionId = data['session_id'] as int?;
    if (sessionId != null) {
      final sessionResults = await database.query(
        'sessions',
        where: 'id = ?',
        whereArgs: [sessionId],
        limit: 1,
      );
      if (sessionResults.isNotEmpty) {
        data['session'] = sessionResults.first;

        // 查询课程规划信息
        final coursePlanId = sessionResults.first['course_plan_id'] as int;
        final planResults = await database.rawQuery('''
          SELECT cp.*, cg.name as goal_name, s.name as student_name
          FROM course_plans cp
          LEFT JOIN course_goals cg ON cp.goal_id = cg.id
          LEFT JOIN students s ON cp.student_id = s.id
          WHERE cp.id = ?
        ''', [coursePlanId]);
        if (planResults.isNotEmpty) {
          data['course_plan'] = planResults.first;
        }
      }
    }

    return data;
  }

  /// 按学员查询排课记录
  Future<List<Map<String, dynamic>>> getByStudentId(int studentId, {int? limit}) async {
    return await database.rawQuery('''
      SELECT sc.*, ct.name as course_type_name, ct.color as course_type_color,
             cp_att.attendance as my_attendance
      FROM scheduled_classes sc
      INNER JOIN class_participants cp_att ON sc.id = cp_att.scheduled_class_id AND cp_att.student_id = ?
      LEFT JOIN course_types ct ON sc.course_type_id = ct.id
      ORDER BY sc.start_time DESC
      ${limit != null ? 'LIMIT $limit' : ''}
    ''', [studentId]);
  }

  /// 按状态查询排课
  Future<List<Map<String, dynamic>>> getByStatus(String status) async {
    return await database.rawQuery('''
      SELECT sc.*, ct.name as course_type_name, ct.color as course_type_color
      FROM scheduled_classes sc
      LEFT JOIN course_types ct ON sc.course_type_id = ct.id
      WHERE sc.status = ?
      ORDER BY sc.start_time ASC
    ''', [status]);
  }

  /// 按 session 查询排课
  Future<Map<String, dynamic>?> getBySessionId(int sessionId) async {
    final results = await database.query(
      'scheduled_classes',
      where: 'session_id = ?',
      whereArgs: [sessionId],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// 获取未关联排课的 session 列表（给定学员的课程规划）
  Future<List<Map<String, dynamic>>> getUnscheduledSessions(int coursePlanId) async {
    return await database.rawQuery('''
      SELECT s.* FROM sessions s
      WHERE s.course_plan_id = ?
        AND s.status = 'pending'
        AND s.id NOT IN (SELECT session_id FROM scheduled_classes WHERE session_id IS NOT NULL AND status != 'cancelled')
      ORDER BY s.session_number ASC
    ''', [coursePlanId]);
  }

  /// ============================================
  /// 参与人操作
  /// ============================================

  /// 添加参与人
  Future<int> addParticipant({
    required int scheduledClassId,
    int? studentId,
    String? guestName,
    String notes = '',
  }) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert('class_participants', {
      'scheduled_class_id': scheduledClassId,
      'student_id': studentId,
      'guest_name': guestName,
      'attendance': 'pending',
      'notes': notes,
      'created_at': now,
      'updated_at': now,
    });
  }

  /// 更新参与人出勤状态
  Future<bool> updateParticipantAttendance({
    required int participantId,
    required String attendance,
  }) async {
    final count = await database.update(
      'class_participants',
      {
        'attendance': attendance,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [participantId],
    );
    return count > 0;
  }

  /// 移除参与人
  Future<bool> removeParticipant(int participantId) async {
    final count = await database.delete(
      'class_participants',
      where: 'id = ?',
      whereArgs: [participantId],
    );
    return count > 0;
  }

  /// 查询排课的所有参与人
  Future<List<Map<String, dynamic>>> getParticipants(int scheduledClassId) async {
    return await database.rawQuery('''
      SELECT cp.*, s.name as student_name
      FROM class_participants cp
      LEFT JOIN students s ON cp.student_id = s.id
      WHERE cp.scheduled_class_id = ?
      ORDER BY cp.id ASC
    ''', [scheduledClassId]);
  }

  /// 批量查询多个排课的参与人
  Future<List<Map<String, dynamic>>> getParticipantsBatch(List<int> scheduledClassIds) async {
    if (scheduledClassIds.isEmpty) return [];
    final placeholders = List.filled(scheduledClassIds.length, '?').join(',');
    return await database.rawQuery('''
      SELECT cp.*, s.name as student_name
      FROM class_participants cp
      LEFT JOIN students s ON cp.student_id = s.id
      WHERE cp.scheduled_class_id IN ($placeholders)
      ORDER BY cp.id ASC
    ''', scheduledClassIds);
  }

  /// ============================================
  /// 统计查询
  /// ============================================

  /// 按日期范围统计已完成课时数
  Future<int> getCompletedClassCount(String startDate, String endDate) async {
    final results = await database.rawQuery('''
      SELECT COUNT(*) as count FROM scheduled_classes
      WHERE status = 'completed' AND start_time >= ? AND start_time < ?
    ''', [startDate, endDate]);
    return (results.first['count'] as int?) ?? 0;
  }

  /// 按日期范围统计课时费总收入
  Future<double> getTotalSessionFee(String startDate, String endDate) async {
    final results = await database.rawQuery('''
      SELECT COALESCE(SUM(teacher_session_fee), 0) as total FROM scheduled_classes
      WHERE status = 'completed' AND start_time >= ? AND start_time < ?
    ''', [startDate, endDate]);
    return (results.first['total'] as num?)?.toDouble() ?? 0;
  }

  /// 按日期范围统计出勤率
  Future<double> getAttendanceRate(String startDate, String endDate) async {
    final results = await database.rawQuery('''
      SELECT
        COUNT(*) as total,
        SUM(CASE WHEN attendance = 'present' OR attendance = 'late' THEN 1 ELSE 0 END) as attended
      FROM class_participants cp
      INNER JOIN scheduled_classes sc ON cp.scheduled_class_id = sc.id
      WHERE sc.status = 'completed' AND sc.start_time >= ? AND sc.start_time < ?
    ''', [startDate, endDate]);

    final total = (results.first['total'] as int?) ?? 0;
    final attended = (results.first['attended'] as int?) ?? 0;
    return total > 0 ? attended / total : 0;
  }

  /// 按课程类型统计分布
  Future<List<Map<String, dynamic>>> getCourseTypeDistribution(String startDate, String endDate) async {
    return await database.rawQuery('''
      SELECT ct.name, ct.color, COUNT(sc.id) as count
      FROM scheduled_classes sc
      LEFT JOIN course_types ct ON sc.course_type_id = ct.id
      WHERE sc.status = 'completed' AND sc.start_time >= ? AND sc.start_time < ?
      GROUP BY sc.course_type_id
      ORDER BY count DESC
    ''', [startDate, endDate]);
  }

  /// 学员消费排行
  Future<List<Map<String, dynamic>>> getStudentRankings(String startDate, String endDate, {int limit = 5}) async {
    return await database.rawQuery('''
      SELECT sp.student_id, s.name as student_name,
             SUM(sp.amount) as total_amount,
             COUNT(DISTINCT cp_att.scheduled_class_id) as class_count
      FROM student_payments sp
      LEFT JOIN students s ON sp.student_id = s.id
      LEFT JOIN class_participants cp_att ON sp.student_id = cp_att.student_id
      LEFT JOIN scheduled_classes sc ON cp_att.scheduled_class_id = sc.id AND sc.status = 'completed'
        AND sc.start_time >= ? AND sc.start_time < ?
      WHERE sp.paid_at >= ? AND sp.paid_at < ?
      GROUP BY sp.student_id
      ORDER BY total_amount DESC
      LIMIT ?
    ''', [startDate, endDate, startDate, endDate, limit]);
  }
}
