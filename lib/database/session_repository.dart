import 'package:sqflite/sqflite.dart';

/// 课时仓库（纯教学内容，不再含排期字段）
class SessionRepository {
  final Database database;

  SessionRepository({required this.database});

  /// 添加课时
  Future<int> addSession({
    required int planId,
  }) async {
    return await database.transaction((txn) async {
      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COALESCE(MAX(session_number), 0) as max_number
        FROM sessions
        WHERE course_plan_id = ?
      ''', [planId]);

      int maxSessionNumber = result.first['max_number'] as int;
      int newSessionNumber = maxSessionNumber + 1;

      int sessionId = await txn.insert(
        'sessions',
        {
          'course_plan_id': planId,
          'session_number': newSessionNumber,
          'status': 'pending',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      return sessionId;
    });
  }

  /// 更新课时状态
  Future<int> updateSessionStatus({
    required int sessionId,
    required String status,
  }) async {
    if (!['pending', 'completed', 'skipped'].contains(status)) {
      throw ArgumentError(
        'Invalid status: $status. Must be one of: pending, completed, skipped',
      );
    }

    return await database.update(
      'sessions',
      {
        'status': status,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [sessionId],
    );
  }

  /// 删除课时（带重新编号）
  Future<int> deleteSession({
    required int sessionId,
  }) async {
    return await database.transaction((txn) async {
      List<Map<String, dynamic>> sessions = await txn.query(
        'sessions',
        where: 'id = ?',
        whereArgs: [sessionId],
      );

      if (sessions.isEmpty) {
        throw ArgumentError('Session not found: $sessionId');
      }

      Map<String, dynamic> session = sessions.first;
      int coursePlanId = session['course_plan_id'] as int;
      int deletedSessionNumber = session['session_number'] as int;

      int deletedCount = await txn.delete(
        'sessions',
        where: 'id = ?',
        whereArgs: [sessionId],
      );

      if (deletedCount == 0) {
        throw StateError('Failed to delete session: $sessionId');
      }

      await txn.rawQuery('''
        UPDATE sessions
        SET session_number = session_number - 1,
            updated_at = ?
        WHERE course_plan_id = ?
          AND session_number > ?
      ''', [
        DateTime.now().toIso8601String(),
        coursePlanId,
        deletedSessionNumber,
      ]);

      return deletedSessionNumber;
    });
  }

  /// 批量添加课时
  Future<List<int>> addSessionsBatch({
    required int planId,
    required int count,
  }) async {
    return await database.transaction((txn) async {
      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COALESCE(MAX(session_number), 0) as max_number
        FROM sessions
        WHERE course_plan_id = ?
      ''', [planId]);

      int maxSessionNumber = result.first['max_number'] as int;
      List<int> sessionIds = [];

      for (int i = 1; i <= count; i++) {
        int sessionNumber = maxSessionNumber + i;
        int sessionId = await txn.insert(
          'sessions',
          {
            'course_plan_id': planId,
            'session_number': sessionNumber,
            'status': 'pending',
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          },
        );
        sessionIds.add(sessionId);
      }

      return sessionIds;
    });
  }

  /// 插入指定位置的课时
  Future<int> insertSessionAt({
    required int planId,
    required int position,
  }) async {
    return await database.transaction((txn) async {
      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COUNT(*) as total_count
        FROM sessions
        WHERE course_plan_id = ?
      ''', [planId]);

      int totalCount = result.first['total_count'] as int;

      if (position < 1 || position > totalCount + 1) {
        throw ArgumentError(
          'Invalid position: $position. Must be between 1 and ${totalCount + 1}',
        );
      }

      if (position <= totalCount) {
        await txn.rawQuery('''
          UPDATE sessions
          SET session_number = session_number + 1,
              updated_at = ?
          WHERE course_plan_id = ?
            AND session_number >= ?
        ''', [
          DateTime.now().toIso8601String(),
          planId,
          position,
        ]);
      }

      int sessionId = await txn.insert(
        'sessions',
        {
          'course_plan_id': planId,
          'session_number': position,
          'status': 'pending',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      return sessionId;
    });
  }

  /// 移动课时位置
  Future<int> moveSession({
    required int sessionId,
    required int newPosition,
  }) async {
    return await database.transaction((txn) async {
      List<Map<String, dynamic>> sessions = await txn.query(
        'sessions',
        where: 'id = ?',
        whereArgs: [sessionId],
      );

      if (sessions.isEmpty) {
        throw ArgumentError('Session not found: $sessionId');
      }

      Map<String, dynamic> session = sessions.first;
      int coursePlanId = session['course_plan_id'] as int;
      int currentPosition = session['session_number'] as int;

      if (currentPosition == newPosition) {
        return sessionId;
      }

      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COUNT(*) as total_count
        FROM sessions
        WHERE course_plan_id = ?
      ''', [coursePlanId]);

      int totalCount = result.first['total_count'] as int;

      if (newPosition < 1 || newPosition > totalCount) {
        throw ArgumentError(
          'Invalid new position: $newPosition. Must be between 1 and $totalCount',
        );
      }

      if (currentPosition < newPosition) {
        await txn.rawQuery('''
          UPDATE sessions
          SET session_number = session_number - 1,
              updated_at = ?
          WHERE course_plan_id = ?
            AND session_number > ?
            AND session_number <= ?
        ''', [
          DateTime.now().toIso8601String(),
          coursePlanId,
          currentPosition,
          newPosition,
        ]);
      } else {
        await txn.rawQuery('''
          UPDATE sessions
          SET session_number = session_number + 1,
              updated_at = ?
          WHERE course_plan_id = ?
            AND session_number >= ?
            AND session_number < ?
        ''', [
          DateTime.now().toIso8601String(),
          coursePlanId,
          newPosition,
          currentPosition,
        ]);
      }

      await txn.update(
        'sessions',
        {
          'session_number': newPosition,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [sessionId],
      );

      return sessionId;
    });
  }

  /// 查询课程规划的所有课时
  Future<List<Map<String, dynamic>>> getSessionsByPlanId({
    required int planId,
  }) async {
    return await database.query(
      'sessions',
      where: 'course_plan_id = ?',
      whereArgs: [planId],
      orderBy: 'session_number ASC',
    );
  }

  /// 通过排课完成来标记 session 完成
  Future<void> completeFromScheduledClass(int sessionId) async {
    await database.update(
      'sessions',
      {
        'status': 'completed',
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [sessionId],
    );
  }
}
