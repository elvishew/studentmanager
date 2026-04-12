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
  ///
  /// [goalId] 课程目标ID
  ///
  /// 返回模板信息，如果未找到模板则返回 null
  Future<GoalTemplateInfo?> checkGoalTemplate(int goalId) async {
    final List<Map<String, dynamic>> goalConfigs = await database.query(
      'goal_configs',
      where: 'goal_id = ?',
      whereArgs: [goalId],
    );

    if (goalConfigs.isEmpty) return null;

    final goalConfig = goalConfigs.first;
    final goalConfigId = goalConfig['id'] as int;

    // 查询最大课时数
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
  ///
  /// [studentId] 学员ID
  /// [goalId] 课程目标ID
  /// [sessionCount] 课时数量（默认12节）
  /// [customBlueprint] 自定义蓝图描述（可选）
  /// [useTemplate] 是否使用模板数据（默认true）
  ///
  /// 返回新创建的课程规划ID
  Future<int> createCoursePlan({
    required int studentId,
    required int goalId,
    int sessionCount = 12,
    String? customBlueprint,
    bool useTemplate = true,
    int? defaultDuration,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：创建课程规划（使用传入的蓝图或初始为空）
      // ============================================
      int coursePlanId = await txn.insert(
        'course_plans',
        {
          'student_id': studentId,
          'goal_id': goalId,
          'blueprint': customBlueprint, // 使用传入的蓝图
          'default_duration': defaultDuration ?? 60,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      // ============================================
      // 第二步：查询该课程目标的默认配置
      // ============================================
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

        // 更新课程规划的 blueprint 字段（如果未提供自定义蓝图且模板有蓝图）
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

      // ============================================
      // 第三步：查询默认配置的课时模板（使用动态课时数）
      // ============================================
      List<Map<String, dynamic>> goalConfigSessions = [];

      if (useTemplate && goalConfigId != null) {
        goalConfigSessions = await txn.query(
          'goal_config_sessions',
          where: 'goal_config_id = ? AND session_number <= ?',
          whereArgs: [goalConfigId, sessionCount],
          orderBy: 'session_number ASC',
        );
      }

      // ============================================
      // 第四步：创建课时
      // ============================================

      // 4.1 从模板创建有内容的课时
      for (Map<String, dynamic> goalConfigSession in goalConfigSessions) {
        int sessionNumber = goalConfigSession['session_number'] as int;
        int goalConfigSessionId = goalConfigSession['id'] as int;

        // 创建课时
        int sessionId = await txn.insert(
          'sessions',
          {
            'course_plan_id': coursePlanId,
            'session_number': sessionNumber,
            'scheduled_time': null,
            'status': 'pending',
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          },
        );

        // 查询该节课模板的所有训练块
        List<Map<String, dynamic>> goalConfigBlocks = await txn.query(
          'goal_config_training_blocks',
          where: 'goal_config_session_id = ?',
          whereArgs: [goalConfigSessionId],
          orderBy: 'sort_order ASC',
        );

        // 复制训练块到新课时
        for (Map<String, dynamic> goalConfigBlock in goalConfigBlocks) {
          await txn.insert(
            'training_blocks',
            {
              'session_id': sessionId,
              'action_id': goalConfigBlock['action_id'],
              'equipment_id': goalConfigBlock['equipment_id'],
              'tool_id': goalConfigBlock['tool_id'],
              'reps': goalConfigBlock['reps'],
              'sets': goalConfigBlock['sets'],
              'duration': goalConfigBlock['duration'],
              'intensity': goalConfigBlock['intensity'],
              'notes': goalConfigBlock['notes'],
              'sort_order': goalConfigBlock['sort_order'] ?? 0,
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            },
          );
        }
      }

      // 4.2 创建剩余的空课时（如果模板课时数少于请求的课时数）
      int templateSessionCount = goalConfigSessions.length;
      for (int i = templateSessionCount + 1; i <= sessionCount; i++) {
        await txn.insert(
          'sessions',
          {
            'course_plan_id': coursePlanId,
            'session_number': i,
            'scheduled_time': null,
            'status': 'pending',
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          },
        );
      }

      // ============================================
      // 完成：返回新创建的课程规划ID
      // ============================================
      return coursePlanId;
    });
  }

  /// （扩展）批量创建课程规划
  ///
  /// 用于需要一次创建多个课程规划的场景
  Future<List<int>> createCoursePlansBatch({
    required List<Map<String, dynamic>> plans,
  }) async {
    List<int> coursePlanIds = [];

    await database.transaction((txn) async {
      for (var plan in plans) {
        int studentId = plan['student_id'] as int;
        int goalId = plan['goal_id'] as int;

        int coursePlanId = await _createCoursePlanInTransaction(
          txn: txn,
          studentId: studentId,
          goalId: goalId,
          sessionCount: plan['session_count'] as int? ?? 12,
          customBlueprint: plan['blueprint'] as String?,
          useTemplate: plan['use_template'] as bool? ?? true,
        );

        coursePlanIds.add(coursePlanId);
      }
    });

    return coursePlanIds;
  }

  /// 内部方法：在事务中创建单个课程规划
  Future<int> _createCoursePlanInTransaction({
    required Transaction txn,
    required int studentId,
    required int goalId,
    int sessionCount = 12,
    String? customBlueprint,
    bool useTemplate = true,
    int? defaultDuration,
  }) async {
    // 创建课程规划
    int coursePlanId = await txn.insert(
      'course_plans',
      {
        'student_id': studentId,
        'goal_id': goalId,
        'blueprint': customBlueprint,
        'default_duration': defaultDuration ?? 60,
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

      // 更新蓝图（如果未提供自定义蓝图）
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

    // 查询课时模板（使用动态课时数）
    List<Map<String, dynamic>> goalConfigSessions = [];

    if (useTemplate && goalConfigId != null) {
      goalConfigSessions = await txn.query(
        'goal_config_sessions',
        where: 'goal_config_id = ? AND session_number <= ?',
        whereArgs: [goalConfigId, sessionCount],
        orderBy: 'session_number ASC',
      );
    }

    // 从模板创建有内容的课时
    for (Map<String, dynamic> goalConfigSession in goalConfigSessions) {
      int sessionNumber = goalConfigSession['session_number'] as int;
      int goalConfigSessionId = goalConfigSession['id'] as int;

      // 创建课时
      int sessionId = await txn.insert(
        'sessions',
        {
          'course_plan_id': coursePlanId,
          'session_number': sessionNumber,
          'scheduled_time': null,
          'status': 'pending',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      // 查询训练块模板
      List<Map<String, dynamic>> goalConfigBlocks = await txn.query(
        'goal_config_training_blocks',
        where: 'goal_config_session_id = ?',
        whereArgs: [goalConfigSessionId],
        orderBy: 'sort_order ASC',
      );

      // 复制训练块
      for (Map<String, dynamic> goalConfigBlock in goalConfigBlocks) {
        await txn.insert(
          'training_blocks',
          {
            'session_id': sessionId,
            'action_id': goalConfigBlock['action_id'],
            'equipment_id': goalConfigBlock['equipment_id'],
            'tool_id': goalConfigBlock['tool_id'],
            'reps': goalConfigBlock['reps'],
            'sets': goalConfigBlock['sets'],
            'duration': goalConfigBlock['duration'],
            'intensity': goalConfigBlock['intensity'],
            'notes': goalConfigBlock['notes'],
            'sort_order': goalConfigBlock['sort_order'] ?? 0,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          },
        );
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
          'scheduled_time': null,
          'status': 'pending',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );
    }

    return coursePlanId;
  }

  /// ============================================
  /// 课程目标默认配置 CRUD
  /// ============================================

  /// 获取所有课程目标配置（含课时模板数量）
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

  /// 获取课程目标配置详情（含 sessions + training blocks）
  Future<Map<String, dynamic>?> fetchGoalConfigDetail(int id) async {
    final configs = await database.query(
      'goal_configs',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (configs.isEmpty) return null;

    final config = Map<String, dynamic>.from(configs.first);

    // 查询 sessions
    final sessions = await database.query(
      'goal_config_sessions',
      where: 'goal_config_id = ?',
      whereArgs: [id],
      orderBy: 'session_number ASC',
    );

    config['sessions'] = await Future.wait(sessions.map((session) async {
      final s = Map<String, dynamic>.from(session);

      // 查询 training blocks（含关联的动作/器械/工具名称）
      final blocks = await database.rawQuery('''
        SELECT
          tb.*,
          a.name as action_name,
          a.is_deprecated as action_deprecated,
          e.name as equipment_name,
          e.is_deprecated as equipment_deprecated,
          t.name as tool_name,
          t.is_deprecated as tool_deprecated
        FROM goal_config_training_blocks tb
        LEFT JOIN actions a ON tb.action_id = a.id
        LEFT JOIN equipments e ON tb.equipment_id = e.id
        LEFT JOIN tools t ON tb.tool_id = t.id
        WHERE tb.goal_config_session_id = ?
        ORDER BY tb.sort_order ASC
      ''', [s['id']]);

      s['training_blocks'] = blocks;
      return s;
    }));

    return config;
  }

  /// 新增或更新课程目标配置
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
        {
          'blueprint': blueprint,
          'updated_at': now,
        },
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

  /// 删除课程目标配置（CASCADE 删除 sessions + blocks）
  Future<void> deleteGoalConfig(int id) async {
    await database.delete(
      'goal_configs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 新增课时模板
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

  /// 删除课时模板（CASCADE 删除 blocks）
  Future<void> deleteGoalConfigSession(int id) async {
    await database.delete(
      'goal_config_sessions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 新增训练块模板
  Future<int> addGoalConfigTrainingBlock({
    required int goalConfigSessionId,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
    int sortOrder = 0,
  }) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert(
      'goal_config_training_blocks',
      {
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
        'created_at': now,
        'updated_at': now,
      },
    );
  }

  /// 更新训练块模板
  Future<void> updateGoalConfigTrainingBlock({
    required int id,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
  }) async {
    final values = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };
    if (actionId != null) values['action_id'] = actionId;
    if (equipmentId != null) values['equipment_id'] = equipmentId;
    if (toolId != null) values['tool_id'] = toolId;
    if (reps != null) values['reps'] = reps;
    if (sets != null) values['sets'] = sets;
    if (duration != null) values['duration'] = duration;
    if (intensity != null) values['intensity'] = intensity;
    if (notes != null) values['notes'] = notes;

    await database.update(
      'goal_config_training_blocks',
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 删除训练块模板
  Future<void> deleteGoalConfigTrainingBlock(int id) async {
    await database.delete(
      'goal_config_training_blocks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 调整训练块模板排序
  Future<void> reorderGoalConfigTrainingBlock({
    required int blockId,
    required int newSortOrder,
  }) async {
    await database.update(
      'goal_config_training_blocks',
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
      'SELECT MAX(sort_order) as max_order FROM goal_config_training_blocks WHERE goal_config_session_id = ?',
      [goalConfigSessionId],
    );
    return (results.first['max_order'] as int?) ?? -1;
  }
}
