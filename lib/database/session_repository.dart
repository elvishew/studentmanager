import 'package:sqflite/sqflite.dart';

/// 课时仓库
class SessionRepository {
  final Database database;

  SessionRepository({required this.database});

  /// ============================================
  /// 1. 添加课时
  /// ============================================
  ///
  /// 为指定课程规划添加一节新课时
  ///
  /// [planId] 课程规划ID
  ///
  /// 返回新创建的课时ID
  Future<int> addSession({
    required int planId,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：查询该课程规划当前的最大课时序号
      // ============================================
      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COALESCE(MAX(session_number), 0) as max_number
        FROM sessions
        WHERE course_plan_id = ?
      ''', [planId]);

      int maxSessionNumber = result.first['max_number'] as int;
      int newSessionNumber = maxSessionNumber + 1;

      // ============================================
      // 第二步：创建新课时
      // ============================================
      int sessionId = await txn.insert(
        'sessions',
        {
          'course_plan_id': planId,
          'session_number': newSessionNumber,
          'scheduled_time': null, // 初始未排课
          'status': 'pending', // 初始状态
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      return sessionId;
    });
  }

  /// ============================================
  /// 2. 更新课时
  /// ============================================
  ///
  /// 更新课时信息
  ///
  /// [sessionId] 课时ID
  /// [scheduledTime] 上课时间（可选）
  /// [status] 课时状态（可选：pending/completed/skipped）
  ///
  /// 返回影响的行数（1表示成功，0表示失败）
  Future<int> updateSession({
    required int sessionId,
    String? scheduledTime,
    String? status,
    int? durationOverride,
    bool clearDurationOverride = false,
  }) async {
    // ============================================
    // 第一步：构建更新数据（只更新非空字段）
    // ============================================
    Map<String, dynamic> updateData = {
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (scheduledTime != null) {
      updateData['scheduled_time'] = scheduledTime;
    }

    if (status != null) {
      // 验证状态值
      if (!['pending', 'completed', 'skipped'].contains(status)) {
        throw ArgumentError(
          'Invalid status: $status. Must be one of: pending, completed, skipped',
        );
      }
      updateData['status'] = status;
    }

    if (durationOverride != null) {
      updateData['duration_override'] = durationOverride;
    } else if (clearDurationOverride) {
      updateData['duration_override'] = null;
    }

    // 如果没有需要更新的字段，返回0
    if (updateData.length == 1) {
      // 只有 updated_at，说明没有实质更新
      return 0;
    }

    // ============================================
    // 第二步：执行更新
    // ============================================
    int count = await database.update(
      'sessions',
      updateData,
      where: 'id = ?',
      whereArgs: [sessionId],
    );

    return count;
  }

  /// ============================================
  /// 3. 删除课时（带重新编号）
  /// ============================================
  ///
  /// 删除指定课时，并重新编号后续课时
  ///
  /// [sessionId] 课时ID
  ///
  /// 返回删除的课时序号
  Future<int> deleteSession({
    required int sessionId,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：查询要删除的课时信息
      // ============================================
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

      // ============================================
      // 第二步：删除课时（级联删除训练块）
      // ============================================
      int deletedCount = await txn.delete(
        'sessions',
        where: 'id = ?',
        whereArgs: [sessionId],
      );

      if (deletedCount == 0) {
        throw StateError('Failed to delete session: $sessionId');
      }

      // ============================================
      // 第三步：重新编号后续课时
      // ============================================
      // 将所有序号大于被删除课时的记录，序号减1
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

      // ============================================
      // 第四步：返回被删除的课时序号
      // ============================================
      return deletedSessionNumber;
    });
  }

  /// ============================================
  /// 扩展：批量添加课时
  /// ============================================
  ///
  /// 为指定课程规划批量添加多节课时
  ///
  /// [planId] 课程规划ID
  /// [count] 要添加的课时数量
  ///
  /// 返回新创建的课时ID列表
  Future<List<int>> addSessionsBatch({
    required int planId,
    required int count,
  }) async {
    return await database.transaction((txn) async {
      // 查询当前最大课时序号
      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COALESCE(MAX(session_number), 0) as max_number
        FROM sessions
        WHERE course_plan_id = ?
      ''', [planId]);

      int maxSessionNumber = result.first['max_number'] as int;
      List<int> sessionIds = [];

      // 批量创建课时
      for (int i = 1; i <= count; i++) {
        int sessionNumber = maxSessionNumber + i;
        int sessionId = await txn.insert(
          'sessions',
          {
            'course_plan_id': planId,
            'session_number': sessionNumber,
            'scheduled_time': null,
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

  /// ============================================
  /// 扩展：插入指定位置的课时
  /// ============================================
  ///
  /// 在指定位置插入新课时，后续课时自动后移
  ///
  /// [planId] 课程规划ID
  /// [position] 插入位置（从1开始）
  ///
  /// 返回新创建的课时ID
  Future<int> insertSessionAt({
    required int planId,
    required int position,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：查询当前总课时数
      // ============================================
      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COUNT(*) as total_count
        FROM sessions
        WHERE course_plan_id = ?
      ''', [planId]);

      int totalCount = result.first['total_count'] as int;

      // 验证位置合法性
      if (position < 1 || position > totalCount + 1) {
        throw ArgumentError(
          'Invalid position: $position. Must be between 1 and ${totalCount + 1}',
        );
      }

      // ============================================
      // 第二步：将位置 >= position 的课时序号 +1（腾出位置）
      // ============================================
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

      // ============================================
      // 第三步：在腾出的位置插入新课时
      // ============================================
      int sessionId = await txn.insert(
        'sessions',
        {
          'course_plan_id': planId,
          'session_number': position,
          'scheduled_time': null,
          'status': 'pending',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      return sessionId;
    });
  }

  /// ============================================
  /// 扩展：移动课时位置
  /// ============================================
  ///
  /// 将课时从一个位置移动到另一个位置
  ///
  /// [sessionId] 课时ID
  /// [newPosition] 新位置（从1开始）
  ///
  /// 返回移动成功后的课时ID
  Future<int> moveSession({
    required int sessionId,
    required int newPosition,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：查询要移动的课时信息
      // ============================================
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

      // 如果位置没变，直接返回
      if (currentPosition == newPosition) {
        return sessionId;
      }

      // ============================================
      // 第二步：查询总课时数
      // ============================================
      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COUNT(*) as total_count
        FROM sessions
        WHERE course_plan_id = ?
      ''', [coursePlanId]);

      int totalCount = result.first['total_count'] as int;

      // 验证位置合法性
      if (newPosition < 1 || newPosition > totalCount) {
        throw ArgumentError(
          'Invalid new position: $newPosition. Must be between 1 and $totalCount',
        );
      }

      // ============================================
      // 第三步：调整其他课时的序号
      // ============================================
      if (currentPosition < newPosition) {
        // 向后移动：将 [currentPosition+1, newPosition] 的课时序号 -1
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
        // 向前移动：将 [newPosition, currentPosition-1] 的课时序号 +1
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

      // ============================================
      // 第四步：更新目标课时到新位置
      // ============================================
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

  /// ============================================
  /// 扩展：查询课程规划的所有课时
  /// ============================================
  ///
  /// 查询指定课程规划的所有课时（按序号排序）
  ///
  /// [planId] 课程规划ID
  ///
  /// 返回课时列表
  Future<List<Map<String, dynamic>>> getSessionsByPlanId({
    required int planId,
  }) async {
    List<Map<String, dynamic>> sessions = await database.query(
      'sessions',
      where: 'course_plan_id = ?',
      whereArgs: [planId],
      orderBy: 'session_number ASC',
    );

    return sessions;
  }

  /// ============================================
  /// 扩展：查询单个课时详情
  /// ============================================
  ///
  /// [sessionId] 课时ID
  ///
  /// 返回课时详情（含训练块）
  Future<Map<String, dynamic>?> getSessionDetail({
    required int sessionId,
  }) async {
    // 查询课时基本信息
    List<Map<String, dynamic>> sessions = await database.query(
      'sessions',
      where: 'id = ?',
      whereArgs: [sessionId],
    );

    if (sessions.isEmpty) {
      return null;
    }

    Map<String, dynamic> session = sessions.first;

    // 查询训练块
    List<Map<String, dynamic>> trainingBlocks = await database.rawQuery('''
      SELECT
        tb.*,
        a.name as action_name,
        e.name as equipment_name,
        t.name as tool_name
      FROM training_blocks tb
      LEFT JOIN actions a ON tb.action_id = a.id
      LEFT JOIN equipments e ON tb.equipment_id = e.id
      LEFT JOIN tools t ON tb.tool_id = t.id
      WHERE tb.session_id = ?
      ORDER BY tb.sort_order ASC
    ''', [sessionId]);

    session['training_blocks'] = trainingBlocks;

    return session;
  }

  /// ============================================
  /// 扩展：更新课时的完整信息
  /// ============================================
  ///
  /// [sessionId] 课时ID
  /// [scheduledTime] 上课时间
  /// [status] 课时状态
  ///
  /// 返回影响的行数
  Future<int> updateSessionFull({
    required int sessionId,
    String? scheduledTime,
    String? status,
    int? durationOverride,
    bool clearDurationOverride = false,
  }) async {
    Map<String, dynamic> updateData = {
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (scheduledTime != null) {
      updateData['scheduled_time'] = scheduledTime;
    } else {
      updateData['scheduled_time'] = null; // 允许清空时间
    }

    if (status != null) {
      if (!['pending', 'completed', 'skipped'].contains(status)) {
        throw ArgumentError(
          'Invalid status: $status. Must be one of: pending, completed, skipped',
        );
      }
      updateData['status'] = status;
    }

    if (durationOverride != null) {
      updateData['duration_override'] = durationOverride;
    } else if (clearDurationOverride) {
      updateData['duration_override'] = null;
    }

    int count = await database.update(
      'sessions',
      updateData,
      where: 'id = ?',
      whereArgs: [sessionId],
    );

    return count;
  }
}
