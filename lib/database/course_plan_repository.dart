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
  /// [goal] 课程目标
  ///
  /// 返回模板信息，如果未找到模板则返回 null
  Future<GoalTemplateInfo?> checkGoalTemplate(String goal) async {
    final List<Map<String, dynamic>> goalConfigs = await database.query(
      'goal_configs',
      where: 'goal = ?',
      whereArgs: [goal],
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
  /// [goal] 课程目标（如 "产后修复"、"肩颈理疗" 等）
  /// [sessionCount] 课时数量（默认12节）
  /// [customBlueprint] 自定义蓝图描述（可选）
  /// [useTemplate] 是否使用模板数据（默认true）
  ///
  /// 返回新创建的课程规划ID
  Future<int> createCoursePlan({
    required int studentId,
    required String goal,
    int sessionCount = 12,
    String? customBlueprint,
    bool useTemplate = true,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：创建课程规划（使用传入的蓝图或初始为空）
      // ============================================
      int coursePlanId = await txn.insert(
        'course_plans',
        {
          'student_id': studentId,
          'goal': goal,
          'blueprint': customBlueprint, // 使用传入的蓝图
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      // ============================================
      // 第二步：查询该课程目标的默认配置
      // ============================================
      int? goalConfigId;
      String? templateBlueprint;

      if (goal != '自定义') {
        List<Map<String, dynamic>> goalConfigs = await txn.query(
          'goal_configs',
          where: 'goal = ?',
          whereArgs: [goal],
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
              'is_custom': goalConfigBlock['is_custom'] ?? 0,
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
        String goal = plan['goal'] as String;

        int coursePlanId = await _createCoursePlanInTransaction(
          txn: txn,
          studentId: studentId,
          goal: goal,
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
    required String goal,
    int sessionCount = 12,
    String? customBlueprint,
    bool useTemplate = true,
  }) async {
    // 创建课程规划
    int coursePlanId = await txn.insert(
      'course_plans',
      {
        'student_id': studentId,
        'goal': goal,
        'blueprint': customBlueprint,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
    );

    // 查询默认配置
    int? goalConfigId;
    String? templateBlueprint;

    if (goal != '自定义') {
      List<Map<String, dynamic>> goalConfigs = await txn.query(
        'goal_configs',
        where: 'goal = ?',
        whereArgs: [goal],
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
            'is_custom': goalConfigBlock['is_custom'] ?? 0,
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
}
