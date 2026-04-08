import 'package:sqflite/sqflite.dart';

/// 课程规划仓库
class CoursePlanRepository {
  final Database database;

  CoursePlanRepository({required this.database});

  /// 创建课程规划
  ///
  /// [studentId] 学员ID
  /// [goal] 课程目标（如 "产后修复"、"肩颈理疗" 等）
  ///
  /// 返回新创建的课程规划ID
  Future<int> createCoursePlan({
    required int studentId,
    required String goal,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：创建课程规划（初始 blueprint 为空）
      // ============================================
      int coursePlanId = await txn.insert(
        'course_plans',
        {
          'student_id': studentId,
          'goal': goal,
          'blueprint': null, // 初始为空，后续从默认配置复制
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      // ============================================
      // 第二步：如果是自定义目标，直接返回（不使用默认配置）
      // ============================================
      if (goal == '自定义') {
        return coursePlanId;
      }

      // ============================================
      // 第三步：查询该课程目标的默认配置
      // ============================================
      List<Map<String, dynamic>> goalConfigs = await txn.query(
        'goal_configs',
        where: 'goal = ?',
        whereArgs: [goal],
      );

      // 如果没有找到默认配置，直接返回（不报错，允许没有配置的目标）
      if (goalConfigs.isEmpty) {
        return coursePlanId;
      }

      Map<String, dynamic> goalConfig = goalConfigs.first;
      String? blueprint = goalConfig['blueprint'] as String?;
      int goalConfigId = goalConfig['id'] as int;

      // ============================================
      // 第四步：更新课程规划的 blueprint 字段
      // ============================================
      await txn.update(
        'course_plans',
        {
          'blueprint': blueprint,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [coursePlanId],
      );

      // ============================================
      // 第五步：查询默认配置的前12节课模板
      // ============================================
      List<Map<String, dynamic>> goalConfigSessions = await txn.query(
        'goal_config_sessions',
        where: 'goal_config_id = ? AND session_number <= 12',
        whereArgs: [goalConfigId],
        orderBy: 'session_number ASC',
      );

      // ============================================
      // 第六步：为每一节课创建 session 和 training_blocks
      // ============================================
      for (Map<String, dynamic> goalConfigSession in goalConfigSessions) {
        int sessionNumber = goalConfigSession['session_number'] as int;
        int goalConfigSessionId = goalConfigSession['id'] as int;

        // ----------------------------------------
        // 6.1 创建课时
        // ----------------------------------------
        int sessionId = await txn.insert(
          'sessions',
          {
            'course_plan_id': coursePlanId,
            'session_number': sessionNumber,
            'scheduled_time': null, // 初始未排课
            'status': 'pending', // 初始状态为未开始
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          },
        );

        // ----------------------------------------
        // 6.2 查询该节课模板的所有训练块
        // ----------------------------------------
        List<Map<String, dynamic>> goalConfigBlocks = await txn.query(
          'goal_config_training_blocks',
          where: 'goal_config_session_id = ?',
          whereArgs: [goalConfigSessionId],
          orderBy: 'sort_order ASC',
        );

        // ----------------------------------------
        // 6.3 复制训练块到新课时
        // ----------------------------------------
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
  }) async {
    // 创建课程规划
    int coursePlanId = await txn.insert(
      'course_plans',
      {
        'student_id': studentId,
        'goal': goal,
        'blueprint': null,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
    );

    // 自定义目标直接返回
    if (goal == '自定义') {
      return coursePlanId;
    }

    // 查询默认配置
    List<Map<String, dynamic>> goalConfigs = await txn.query(
      'goal_configs',
      where: 'goal = ?',
      whereArgs: [goal],
    );

    if (goalConfigs.isEmpty) {
      return coursePlanId;
    }

    Map<String, dynamic> goalConfig = goalConfigs.first;
    String? blueprint = goalConfig['blueprint'] as String?;
    int goalConfigId = goalConfig['id'] as int;

    // 更新蓝图
    await txn.update(
      'course_plans',
      {
        'blueprint': blueprint,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [coursePlanId],
    );

    // 查询前12节课模板
    List<Map<String, dynamic>> goalConfigSessions = await txn.query(
      'goal_config_sessions',
      where: 'goal_config_id = ? AND session_number <= 12',
      whereArgs: [goalConfigId],
      orderBy: 'session_number ASC',
    );

    // 创建课时和训练块
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

    return coursePlanId;
  }
}
