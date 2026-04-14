import 'package:sqflite/sqflite.dart';

/// 目标模板信息
class GoalTemplateInfo {
  final String? blueprint;
  final int availableSessionCount;

  const GoalTemplateInfo({
    this.blueprint,
    required this.availableSessionCount,
  });
}

/// 课程规划仓库
class CoursePlanRepository {
  final Database database;

  CoursePlanRepository({required this.database});

  /// 检测目标是否有模板数据
  Future<GoalTemplateInfo?> checkGoalTemplate(int goalId) async {
    final List<Map<String, dynamic>> goalConfigs = await database.query(
      'goal_configs',
      where: 'goal_id = ?',
      whereArgs: [goalId],
    );

    if (goalConfigs.isEmpty) return null;

    final goalConfig = goalConfigs.first;
    final goalConfigId = goalConfig['id'] as int;

    final List<Map<String, dynamic>> sessions = await database.query(
      'goal_config_sessions',
      where: 'goal_config_id = ?',
      whereArgs: [goalConfigId],
      columns: ['session_number'],
      orderBy: 'session_number DESC',
      limit: 1,
    );

    final maxSessions = sessions.isEmpty ? 0 : sessions.first['session_number'] as int;

    return GoalTemplateInfo(
      blueprint: goalConfig['blueprint'] as String?,
      availableSessionCount: maxSessions,
    );
  }

  /// 创建课程规划
  Future<int> createCoursePlan({
    required int studentId,
    required int goalId,
    int sessionCount = 12,
    String? customBlueprint,
    bool useTemplate = true,
  }) async {
    return await database.transaction((txn) async {
      int coursePlanId = await txn.insert(
        'course_plans',
        {
          'student_id': studentId,
          'goal_id': goalId,
          'blueprint': customBlueprint,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      // 查询默认配置
      int? goalConfigId;
      String? templateBlueprint;

      List<Map<String, dynamic>> goalConfigs = await txn.query(
        'goal_configs',
        where: 'goal_id = ?',
        whereArgs: [goalId],
      );

      if (goalConfigs.isNotEmpty) {
        Map<String, dynamic> goalConfig = goalConfigs.first;
        templateBlueprint = goalConfig['blueprint'] as String?;
        goalConfigId = goalConfig['id'] as int;

        if (customBlueprint == null && templateBlueprint != null) {
          await txn.update(
            'course_plans',
            {
              'blueprint': templateBlueprint,
              'updated_at': DateTime.now().toIso8601String(),
            },
            where: 'id = ?',
            whereArgs: [coursePlanId],
          );
        }
      }

      // 查询默认配置课时模板
      List<Map<String, dynamic>> goalConfigSessions = [];

      if (useTemplate && goalConfigId != null) {
        goalConfigSessions = await txn.query(
          'goal_config_sessions',
          where: 'goal_config_id = ? AND session_number <= ?',
          whereArgs: [goalConfigId, sessionCount],
          orderBy: 'session_number ASC',
        );
      }

      final now = DateTime.now().toIso8601String();

      // 从模板创建有内容的课时
      for (Map<String, dynamic> goalConfigSession in goalConfigSessions) {
        int sessionNumber = goalConfigSession['session_number'] as int;
        int goalConfigSessionId = goalConfigSession['id'] as int;

        int sessionId = await txn.insert(
          'sessions',
          {
            'course_plan_id': coursePlanId,
            'session_number': sessionNumber,
            'status': 'pending',
            'created_at': now,
            'updated_at': now,
          },
        );

        // 查询模板内容块
        List<Map<String, dynamic>> goalConfigBlocks = await txn.query(
          'goal_config_content_blocks',
          where: 'goal_config_session_id = ?',
          whereArgs: [goalConfigSessionId],
          orderBy: 'sort_order ASC',
        );

        // 复制内容块
        for (Map<String, dynamic> goalConfigBlock in goalConfigBlocks) {
          int blockId = await txn.insert(
            'content_blocks',
            {
              'session_id': sessionId,
              'sort_order': goalConfigBlock['sort_order'] ?? 0,
              'created_at': now,
              'updated_at': now,
            },
          );

          // 复制内容块字段值
          List<Map<String, dynamic>> blockValues = await txn.query(
            'goal_config_content_block_values',
            where: 'content_block_id = ?',
            whereArgs: [goalConfigBlock['id']],
          );

          for (Map<String, dynamic> blockValue in blockValues) {
            await txn.insert(
              'content_block_values',
              {
                'content_block_id': blockId,
                'content_field_id': blockValue['content_field_id'],
                'value': blockValue['value'],
                'created_at': now,
                'updated_at': now,
              },
            );
          }
        }
      }

      // 创建剩余的空课时
      int templateSessionCount = goalConfigSessions.length;
      for (int i = templateSessionCount + 1; i <= sessionCount; i++) {
        await txn.insert(
          'sessions',
          {
            'course_plan_id': coursePlanId,
            'session_number': i,
            'status': 'pending',
            'created_at': now,
            'updated_at': now,
          },
        );
      }

      return coursePlanId;
    });
  }

  /// 批量创建课程规划
  Future<List<int>> createCoursePlansBatch({
    required List<Map<String, dynamic>> plans,
  }) async {
    List<int> coursePlanIds = [];

    await database.transaction((txn) async {
      for (var plan in plans) {
        int coursePlanId = await _createCoursePlanInTransaction(
          txn: txn,
          studentId: plan['student_id'] as int,
          goalId: plan['goal_id'] as int,
          sessionCount: plan['session_count'] as int? ?? 12,
          customBlueprint: plan['blueprint'] as String?,
          useTemplate: plan['use_template'] as bool? ?? true,
        );
        coursePlanIds.add(coursePlanId);
      }
    });

    return coursePlanIds;
  }

  Future<int> _createCoursePlanInTransaction({
    required dynamic txn,
    required int studentId,
    required int goalId,
    int sessionCount = 12,
    String? customBlueprint,
    bool useTemplate = true,
  }) async {
    final now = DateTime.now().toIso8601String();

    int coursePlanId = await txn.insert(
      'course_plans',
      {
        'student_id': studentId,
        'goal_id': goalId,
        'blueprint': customBlueprint,
        'created_at': now,
        'updated_at': now,
      },
    );

    int? goalConfigId;
    String? templateBlueprint;

    List<Map<String, dynamic>> goalConfigs = await txn.query(
      'goal_configs',
      where: 'goal_id = ?',
      whereArgs: [goalId],
    );

    if (goalConfigs.isNotEmpty) {
      Map<String, dynamic> goalConfig = goalConfigs.first;
      templateBlueprint = goalConfig['blueprint'] as String?;
      goalConfigId = goalConfig['id'] as int;

      if (customBlueprint == null && templateBlueprint != null) {
        await txn.update(
          'course_plans',
          {'blueprint': templateBlueprint, 'updated_at': now},
          where: 'id = ?',
          whereArgs: [coursePlanId],
        );
      }
    }

    List<Map<String, dynamic>> goalConfigSessions = [];

    if (useTemplate && goalConfigId != null) {
      goalConfigSessions = await txn.query(
        'goal_config_sessions',
        where: 'goal_config_id = ? AND session_number <= ?',
        whereArgs: [goalConfigId, sessionCount],
        orderBy: 'session_number ASC',
      );
    }

    for (Map<String, dynamic> goalConfigSession in goalConfigSessions) {
      int sessionNumber = goalConfigSession['session_number'] as int;
      int goalConfigSessionId = goalConfigSession['id'] as int;

      int sessionId = await txn.insert(
        'sessions',
        {
          'course_plan_id': coursePlanId,
          'session_number': sessionNumber,
          'status': 'pending',
          'created_at': now,
          'updated_at': now,
        },
      );

      List<Map<String, dynamic>> goalConfigBlocks = await txn.query(
        'goal_config_content_blocks',
        where: 'goal_config_session_id = ?',
        whereArgs: [goalConfigSessionId],
        orderBy: 'sort_order ASC',
      );

      for (Map<String, dynamic> goalConfigBlock in goalConfigBlocks) {
        int blockId = await txn.insert(
          'content_blocks',
          {
            'session_id': sessionId,
            'sort_order': goalConfigBlock['sort_order'] ?? 0,
            'created_at': now,
            'updated_at': now,
          },
        );

        List<Map<String, dynamic>> blockValues = await txn.query(
          'goal_config_content_block_values',
          where: 'content_block_id = ?',
          whereArgs: [goalConfigBlock['id']],
        );

        for (Map<String, dynamic> blockValue in blockValues) {
          await txn.insert(
            'content_block_values',
            {
              'content_block_id': blockId,
              'content_field_id': blockValue['content_field_id'],
              'value': blockValue['value'],
              'created_at': now,
              'updated_at': now,
            },
          );
        }
      }
    }

    int templateSessionCount = goalConfigSessions.length;
    for (int i = templateSessionCount + 1; i <= sessionCount; i++) {
      await txn.insert(
        'sessions',
        {
          'course_plan_id': coursePlanId,
          'session_number': i,
          'status': 'pending',
          'created_at': now,
          'updated_at': now,
        },
      );
    }

    return coursePlanId;
  }

  /// ============================================
  /// 课程目标默认配置 CRUD
  /// ============================================

  Future<List<Map<String, dynamic>>> fetchAllGoalConfigs() async {
    return await database.rawQuery('''
      SELECT gc.*, cg.name as goal_name, COUNT(gcs.id) as session_count
      FROM goal_configs gc
      LEFT JOIN course_goals cg ON gc.goal_id = cg.id
      LEFT JOIN goal_config_sessions gcs ON gc.id = gcs.goal_config_id
      WHERE gc.goal_id IS NOT NULL
      GROUP BY gc.id
      ORDER BY gc.id ASC
    ''');
  }

  Future<Map<String, dynamic>?> fetchGoalConfigDetail(int id) async {
    final configs = await database.query(
      'goal_configs',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (configs.isEmpty) return null;

    final config = Map<String, dynamic>.from(configs.first);

    final sessions = await database.query(
      'goal_config_sessions',
      where: 'goal_config_id = ?',
      whereArgs: [id],
      orderBy: 'session_number ASC',
    );

    config['sessions'] = await Future.wait(sessions.map((session) async {
      final s = Map<String, dynamic>.from(session);

      // 查询内容块（含字段值）
      final blocks = await database.query(
        'goal_config_content_blocks',
        where: 'goal_config_session_id = ?',
        whereArgs: [s['id']],
        orderBy: 'sort_order ASC',
      );

      final mutableBlocks = <Map<String, dynamic>>[];
      for (final rawBlock in blocks) {
        final block = Map<String, dynamic>.from(rawBlock);
        final values = await database.rawQuery('''
          SELECT gcbv.content_field_id, gcbv.value, cf.name as field_name, cf.field_type
          FROM goal_config_content_block_values gcbv
          JOIN content_fields cf ON gcbv.content_field_id = cf.id
          WHERE gcbv.content_block_id = ?
        ''', [block['id']]);

        block['values'] = values;
        mutableBlocks.add(block);
      }

      s['content_blocks'] = mutableBlocks;
      return s;
    }));

    return config;
  }

  Future<int> upsertGoalConfig(int goalId, String? blueprint) async {
    final now = DateTime.now().toIso8601String();

    final existing = await database.query(
      'goal_configs',
      where: 'goal_id = ?',
      whereArgs: [goalId],
      limit: 1,
    );

    if (existing.isNotEmpty) {
      await database.update(
        'goal_configs',
        {'blueprint': blueprint, 'updated_at': now},
        where: 'goal_id = ?',
        whereArgs: [goalId],
      );
      return existing.first['id'] as int;
    } else {
      return await database.insert(
        'goal_configs',
        {
          'goal_id': goalId,
          'blueprint': blueprint,
          'created_at': now,
          'updated_at': now,
        },
      );
    }
  }

  Future<void> deleteGoalConfig(int id) async {
    await database.delete(
      'goal_configs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> addGoalConfigSession(int goalConfigId, int sessionNumber) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert(
      'goal_config_sessions',
      {
        'goal_config_id': goalConfigId,
        'session_number': sessionNumber,
        'created_at': now,
        'updated_at': now,
      },
    );
  }

  Future<void> deleteGoalConfigSession(int id) async {
    await database.delete(
      'goal_config_sessions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 新增默认配置内容块
  Future<int> addGoalConfigContentBlock({
    required int goalConfigSessionId,
    required Map<int, String> values,
  }) async {
    final now = DateTime.now().toIso8601String();

    // 获取最大排序号
    final results = await database.rawQuery(
      'SELECT COALESCE(MAX(sort_order), -1) as max_order FROM goal_config_content_blocks WHERE goal_config_session_id = ?',
      [goalConfigSessionId],
    );
    final maxOrder = (results.first['max_order'] as int?) ?? -1;

    final blockId = await database.insert(
      'goal_config_content_blocks',
      {
        'goal_config_session_id': goalConfigSessionId,
        'sort_order': maxOrder + 1,
        'created_at': now,
        'updated_at': now,
      },
    );

    // 插入字段值
    for (final entry in values.entries) {
      if (entry.value.isNotEmpty) {
        await database.insert(
          'goal_config_content_block_values',
          {
            'content_block_id': blockId,
            'content_field_id': entry.key,
            'value': entry.value,
            'created_at': now,
            'updated_at': now,
          },
        );
      }
    }

    return blockId;
  }

  /// 更新默认配置内容块
  Future<void> updateGoalConfigContentBlock({
    required int id,
    required Map<int, String> values,
  }) async {
    final now = DateTime.now().toIso8601String();

    // 删除旧值
    await database.delete(
      'goal_config_content_block_values',
      where: 'content_block_id = ?',
      whereArgs: [id],
    );

    // 插入新值
    for (final entry in values.entries) {
      if (entry.value.isNotEmpty) {
        await database.insert(
          'goal_config_content_block_values',
          {
            'content_block_id': id,
            'content_field_id': entry.key,
            'value': entry.value,
            'created_at': now,
            'updated_at': now,
          },
        );
      }
    }

    await database.update(
      'goal_config_content_blocks',
      {'updated_at': now},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 删除默认配置内容块
  Future<void> deleteGoalConfigContentBlock(int id) async {
    await database.delete(
      'goal_config_content_blocks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 调整默认配置内容块排序
  Future<void> reorderGoalConfigContentBlock({
    required int blockId,
    required int newSortOrder,
  }) async {
    await database.update(
      'goal_config_content_blocks',
      {
        'sort_order': newSortOrder,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [blockId],
    );
  }

  /// 获取指定 session 的最大排序号
  Future<int> getMaxSortOrder(int goalConfigSessionId) async {
    final results = await database.rawQuery(
      'SELECT MAX(sort_order) as max_order FROM goal_config_content_blocks WHERE goal_config_session_id = ?',
      [goalConfigSessionId],
    );
    return (results.first['max_order'] as int?) ?? -1;
  }
}
