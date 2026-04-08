import 'package:sqflite/sqflite.dart';
import 'session_repository.dart';

/// SessionRepository 使用示例
class SessionRepositoryExample {
  final SessionRepository repository;

  SessionRepositoryExample({required this.repository});

  /// ============================================
  /// 示例1：添加课时
  /// ============================================
  Future<void> example1_addSession() async {
    print('\n=== 示例1：添加课时 ===');

    // 假设课程规划ID为1
    int planId = 1;

    // 添加一节课时
    int sessionId = await repository.addSession(planId: planId);

    print('✅ 添加课时成功，ID: $sessionId');

    // 验证：查询该课程规划的所有课时
    List<Map<String, dynamic>> sessions = await repository.getSessionsByPlanId(
      planId: planId,
    );

    print('📊 当前课时列表:');
    for (var session in sessions) {
      print('  - 课时${session['session_number']}: ${session['status']} (${session['id']})');
    }
  }

  /// ============================================
  /// 示例2：批量添加课时
  /// ============================================
  Future<void> example2_addSessionsBatch() async {
    print('\n=== 示例2：批量添加课时 ===');

    int planId = 1;

    // 批量添加3节课时
    List<int> sessionIds = await repository.addSessionsBatch(
      planId: planId,
      count: 3,
    );

    print('✅ 批量添加${sessionIds.length}节课时成功');
    print('📋 新增课时IDs: $sessionIds');

    // 验证：查询总课时数
    List<Map<String, dynamic>> sessions = await repository.getSessionsByPlanId(
      planId: planId,
    );

    print('📊 当前总课时数: ${sessions.length}');
  }

  /// ============================================
  /// 示例3：更新课时（设置上课时间和状态）
  /// ============================================
  Future<void> example3_updateSession() async {
    print('\n=== 示例3：更新课时 ===');

    int sessionId = 1;

    // 更新上课时间
    await repository.updateSession(
      sessionId: sessionId,
      scheduledTime: '2025-01-15T10:00:00Z',
    );

    print('✅ 已设置上课时间: 2025-01-15 10:00');

    // 标记为已完成（消课）
    await repository.updateSession(
      sessionId: sessionId,
      status: 'completed',
    );

    print('✅ 已标记为已完成');

    // 验证：查询课时详情
    Map<String, dynamic>? session = await repository.getSessionDetail(
      sessionId: sessionId,
    );

    if (session != null) {
      print('📊 课时详情:');
      print('  - 序号: ${session['session_number']}');
      print('  - 上课时间: ${session['scheduled_time']}');
      print('  - 状态: ${session['status']}');
      print('  - 训练块数量: ${session['training_blocks'].length}');
    }
  }

  /// ============================================
  /// 示例4：在指定位置插入课时
  /// ============================================
  Future<void> example4_insertSessionAt() async {
    print('\n=== 示例4：在指定位置插入课时 ===');

    int planId = 1;
    int position = 3; // 在第3个位置插入

    // 在第3个位置插入新课时
    int sessionId = await repository.insertSessionAt(
      planId: planId,
      position: position,
    );

    print('✅ 在位置$position插入课时成功，ID: $sessionId');

    // 验证：查看课时顺序
    List<Map<String, dynamic>> sessions = await repository.getSessionsByPlanId(
      planId: planId,
    );

    print('📊 插入后的课时顺序:');
    for (var session in sessions) {
      print('  - 位置${session['session_number']}: ID=${session['id']}');
    }
  }

  /// ============================================
  /// 示例5：移动课时位置
  /// ============================================
  Future<void> example5_moveSession() async {
    print('\n=== 示例5：移动课时位置 ===');

    int sessionId = 5; // 要移动的课时ID
    int newPosition = 2; // 移动到第2个位置

    print('📋 将课时$sessionId移动到位置$newPosition');

    // 执行移动
    await repository.moveSession(
      sessionId: sessionId,
      newPosition: newPosition,
    );

    print('✅ 移动完成');

    // 验证：查看新的课时顺序
    // 假设我们知道该课时所属的课程规划ID
    // 这里仅作示例
    print('📊 移动后的课时顺序已更新');
  }

  /// ============================================
  /// 示例6：删除课时
  /// ============================================
  Future<void> example6_deleteSession() async {
    print('\n=== 示例6：删除课时 ===');

    int sessionId = 7; // 要删除的课时ID

    print('📋 准备删除课时: $sessionId');

    // 查询删除前的课时列表
    // 假设我们知道课程规划ID
    int planId = 1;
    List<Map<String, dynamic>> beforeDelete = await repository.getSessionsByPlanId(
      planId: planId,
    );

    print('📊 删除前的课时:');
    for (var session in beforeDelete) {
      print('  - 课时${session['session_number']}: ID=${session['id']}');
    }

    // 执行删除
    int deletedNumber = await repository.deleteSession(
      sessionId: sessionId,
    );

    print('✅ 已删除课时序号: $deletedNumber');

    // 查询删除后的课时列表
    List<Map<String, dynamic>> afterDelete = await repository.getSessionsByPlanId(
      planId: planId,
    );

    print('📊 删除后的课时（自动重新编号）:');
    for (var session in afterDelete) {
      print('  - 课时${session['session_number']}: ID=${session['id']}');
    }
  }

  /// ============================================
  /// 示例7：清空上课时间
  /// ============================================
  Future<void> example7_clearScheduledTime() async {
    print('\n=== 示例7：清空上课时间 ===');

    int sessionId = 1;

    // 使用 updateSessionFull 清空时间
    await repository.updateSessionFull(
      sessionId: sessionId,
      scheduledTime: '', // 传空字符串或 null 都可以
    );

    print('✅ 已清空课时$sessionId的上课时间');

    // 验证
    Map<String, dynamic>? session = await repository.getSessionDetail(
      sessionId: sessionId,
    );

    if (session != null) {
      print('📊 上课时间: ${session['scheduled_time'] ?? "（空）"}');
    }
  }

  /// ============================================
  /// 示例8：完整的排课流程
  /// ============================================
  Future<void> example8_fullSchedulingFlow() async {
    print('\n=== 示例8：完整的排课流程 ===');

    int planId = 1;

    // 步骤1：查询当前所有课时
    List<Map<String, dynamic>> sessions = await repository.getSessionsByPlanId(
      planId: planId,
    );

    print('📊 共有${sessions.length}节课时待排课');

    // 步骤2：为前3节课安排时间
    int count = 0;
    for (var session in sessions) {
      if (count >= 3) break;

      int sessionId = session['id'];
      int sessionNumber = session['session_number'];

      // 计算上课时间（假设每节课间隔一周）
      DateTime scheduledTime = DateTime(2025, 1, 15 + (count * 7), 10, 0);

      await repository.updateSession(
        sessionId: sessionId,
        scheduledTime: scheduledTime.toIso8601String(),
      );

      print('✅ 课时${sessionNumber}: 已安排时间 ${scheduledTime.toIso8601String()}');
      count++;
    }

    // 步骤3：查询已排课的课时
    List<Map<String, dynamic>> scheduledSessions = await repository.getSessionsByPlanId(
      planId: planId,
    );

    print('\n📋 排课结果:');
    for (var session in scheduledSessions) {
      String timeStr = session['scheduled_time'] ?? '未排课';
      print('  - 课时${session['session_number']}: $timeStr');
    }
  }

  /// ============================================
  /// 示例9：查询课时进度
  /// ============================================
  Future<void> example9_getProgress() async {
    print('\n=== 示例9：查询课程进度 ===');

    int planId = 1;

    // 查询所有课时
    List<Map<String, dynamic>> sessions = await repository.getSessionsByPlanId(
      planId: planId,
    );

    // 统计各状态课时数
    int total = sessions.length;
    int completed = sessions.where((s) => s['status'] == 'completed').length;
    int pending = sessions.where((s) => s['status'] == 'pending').length;
    int skipped = sessions.where((s) => s['status'] == 'skipped').length;

    print('📊 课程进度统计:');
    print('  - 总课时数: $total');
    print('  - 已完成: $completed');
    print('  - 未开始: $pending');
    print('  - 已跳过: $skipped');
    print('  - 完成率: ${(total > 0 ? (completed / total * 100).toStringAsFixed(1) : 0)}%');
  }

  /// ============================================
  /// 示例10：错误处理
  /// ============================================
  Future<void> example10_errorHandling() async {
    print('\n=== 示例10：错误处理 ===');

    // 示例10.1：更新时传入无效状态
    try {
      await repository.updateSession(
        sessionId: 1,
        status: 'invalid_status',
      );
    } catch (e) {
      print('❌ 捕获错误: $e');
    }

    // 示例10.2：删除不存在的课时
    try {
      await repository.deleteSession(sessionId: 99999);
    } catch (e) {
      print('❌ 捕获错误: $e');
    }

    // 示例10.3：在无效位置插入课时
    try {
      await repository.insertSessionAt(
        planId: 1,
        position: 999,
      );
    } catch (e) {
      print('❌ 捕获错误: $e');
    }

    print('✅ 所有错误已被正确捕获和处理');
  }
}

/// ============================================
/// 主函数：运行所有示例
/// ============================================
Future<void> runAllExamples(SessionRepository repository) async {
  final example = SessionRepositoryExample(repository: repository);

  try {
    await example.example1_addSession();
    await example.example2_addSessionsBatch();
    await example.example3_updateSession();
    await example.example4_insertSessionAt();
    await example.example5_moveSession();
    await example.example6_deleteSession();
    await example.example7_clearScheduledTime();
    await example.example8_fullSchedulingFlow();
    await example.example9_getProgress();
    await example.example10_errorHandling();

    print('\n✅ 所有示例运行完成！');
  } catch (e) {
    print('\n❌ 运行出错: $e');
  }
}

/// ============================================
/// 使用说明
/// ============================================
///
/// 在实际项目中使用：
///
/// ```dart
/// // 1. 初始化数据库
/// final db = await openDatabase(...);
///
/// // 2. 创建仓库实例
/// final sessionRepo = SessionRepository(database: db);
///
/// // 3. 添加课时
/// int sessionId = await sessionRepo.addSession(planId: 1);
///
/// // 4. 更新课时
/// await sessionRepo.updateSession(
///   sessionId: sessionId,
///   scheduledTime: '2025-01-15T10:00:00Z',
///   status: 'completed',
/// );
///
/// // 5. 删除课时
/// await sessionRepo.deleteSession(sessionId: sessionId);
///
/// // 6. 查询课时
/// List<Map> sessions = await sessionRepo.getSessionsByPlanId(planId: 1);
/// Map? detail = await sessionRepo.getSessionDetail(sessionId: sessionId);
/// ```
///
/// 注意事项：
/// 1. 所有操作都在事务中执行，保证数据一致性
/// 2. 删除课时会自动重新编号后续课时
/// 3. 插入课时到指定位置会自动调整其他课时序号
/// 4. 移动课时位置会自动处理中间的课时序号
/// 5. 状态值只能是：pending, completed, skipped
/// 6. 时间格式使用 ISO8601 标准
