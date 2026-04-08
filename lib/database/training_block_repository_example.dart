import 'package:sqflite/sqflite.dart';
import 'training_block_repository.dart';

/// TrainingBlockRepository 使用示例
class TrainingBlockRepositoryExample {
  final TrainingBlockRepository repository;

  TrainingBlockRepositoryExample({required this.repository});

  /// ============================================
  /// 示例1：添加训练块
  /// ============================================
  Future<void> example1_addTrainingBlock() async {
    print('\n=== 示例1：添加训练块 ===');

    int sessionId = 1;
    int actionId = 1; // 宽蹲
    int equipmentId = 1; // 核心床

    // 添加第一组训练
    int blockId1 = await repository.addTrainingBlock(
      sessionId: sessionId,
      actionId: actionId,
      equipmentId: equipmentId,
      reps: '12',
      sets: '3',
      intensity: '中等',
      notes: '注意保持核心稳定',
    );

    print('✅ 添加训练块1成功，ID: $blockId1');

    // 添加第二组训练
    int blockId2 = await repository.addTrainingBlock(
      sessionId: sessionId,
      actionId: 2, // 侧弓步蹲
      equipmentId: 1,
      reps: '10',
      sets: '3',
      intensity: '中等',
    );

    print('✅ 添加训练块2成功，ID: $blockId2');

    // 查询所有训练块
    List<Map<String, dynamic>> blocks = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );

    print('📊 当前训练块列表:');
    for (var block in blocks) {
      print('  - 位置${block['sort_order']}: 动作ID=${block['action_id']}, 次数=${block['reps']}');
    }
  }

  /// ============================================
  /// 示例2：局部更新训练块
  /// ============================================
  Future<void> example2_partialUpdate() async {
    print('\n=== 示例2：局部更新训练块 ===');

    int blockId = 1;

    // 只更新次数和组数
    await repository.updateTrainingBlock(
      blockId: blockId,
      reps: '15',
      sets: '4',
    );

    print('✅ 已更新次数: 15次, 组数: 4组');

    // 再次更新，只修改强度
    await repository.updateTrainingBlock(
      blockId: blockId,
      intensity: '高',
    );

    print('✅ 已更新强度: 高');

    // 验证：查询详情
    Map<String, dynamic>? detail = await repository.getTrainingBlockDetail(
      blockId: blockId,
    );

    if (detail != null) {
      print('📊 训练块详情:');
      print('  - 次数: ${detail['reps']}');
      print('  - 组数: ${detail['sets']}');
      print('  - 强度: ${detail['intensity']}');
      print('  - 备注: ${detail['notes'] ?? "（保持不变）"}');
    }
  }

  /// ============================================
  /// 示例3：删除训练块
  /// ============================================
  Future<void> example3_deleteTrainingBlock() async {
    print('\n=== 示例3：删除训练块 ===');

    int sessionId = 1;

    // 查询删除前的训练块
    List<Map<String, dynamic>> beforeDelete = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );

    print('📊 删除前的训练块:');
    for (var block in beforeDelete) {
      print('  - 位置${block['sort_order']}: ID=${block['id']}');
    }

    // 删除第2个训练块
    int blockId = beforeDelete[1]['id'];
    print('📋 准备删除训练块: $blockId');

    int deletedOrder = await repository.deleteTrainingBlock(
      blockId: blockId,
    );

    print('✅ 已删除位置 $deletedOrder 的训练块');

    // 查询删除后的训练块
    List<Map<String, dynamic>> afterDelete = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );

    print('📊 删除后的训练块（自动重新排序）:');
    for (var block in afterDelete) {
      print('  - 位置${block['sort_order']}: ID=${block['id']}');
    }
  }

  /// ============================================
  /// 示例4：重新排序训练块
  /// ============================================
  Future<void> example4_reorderTrainingBlock() async {
    print('\n=== 示例4：重新排序训练块 ===');

    int sessionId = 1;

    // 准备数据：创建5个训练块
    await repository.clearTrainingBlocks(sessionId: sessionId);
    List<int> blockIds = [];
    for (int i = 0; i < 5; i++) {
      int id = await repository.addTrainingBlock(
        sessionId: sessionId,
        actionId: 1,
        reps: '${10 + i}',
      );
      blockIds.add(id);
    }

    print('📊 初始顺序:');
    List<Map<String, dynamic>> beforeReorder = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );
    for (var block in beforeReorder) {
      print('  - 位置${block['sort_order']}: ID=${block['id']}, 次数=${block['reps']}');
    }

    // 将第5个训练块移到位置1
    print('\n📋 将第5个训练块（ID=${blockIds[4]}）移到位置1');
    await repository.reorderTrainingBlock(
      blockId: blockIds[4],
      newSortOrder: 0,
    );

    print('✅ 移动完成');

    // 查看新顺序
    print('\n📊 移动后的顺序:');
    List<Map<String, dynamic>> afterReorder = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );
    for (var block in afterReorder) {
      print('  - 位置${block['sort_order']}: ID=${block['id']}, 次数=${block['reps']}');
    }
  }

  /// ============================================
  /// 示例5：在指定位置插入训练块
  /// ============================================
  Future<void> example5_insertTrainingBlockAt() async {
    print('\n=== 示例5：在指定位置插入训练块 ===');

    int sessionId = 1;

    // 准备数据
    await repository.clearTrainingBlocks(sessionId: sessionId);
    for (int i = 0; i < 3; i++) {
      await repository.addTrainingBlock(
        sessionId: sessionId,
        actionId: 1,
        reps: '${10 + i * 2}',
      );
    }

    print('📊 插入前的训练块:');
    List<Map<String, dynamic>> beforeInsert = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );
    for (var block in beforeInsert) {
      print('  - 位置${block['sort_order']}: 次数=${block['reps']}');
    }

    // 在位置1插入新训练块
    print('\n📋 在位置1插入新训练块');
    await repository.insertTrainingBlockAt(
      sessionId: sessionId,
      sortOrder: 1,
      actionId: 2,
      reps: '99',
      notes: '新插入的训练',
    );

    print('✅ 插入完成');

    // 查看结果
    print('\n📊 插入后的训练块:');
    List<Map<String, dynamic>> afterInsert = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );
    for (var block in afterInsert) {
      print('  - 位置${block['sort_order']}: 次数=${block['reps']}, 备注=${block['notes'] ?? "无"}');
    }
  }

  /// ============================================
  /// 示例6：批量添加训练块
  /// ============================================
  Future<void> example6_addTrainingBlocksBatch() async {
    print('\n=== 示例6：批量添加训练块 ===');

    int sessionId = 1;

    // 清空现有数据
    await repository.clearTrainingBlocks(sessionId: sessionId);

    // 批量添加训练块
    List<Map<String, dynamic>> blocks = [
      {
        'action_id': 1,
        'equipment_id': 1,
        'reps': '12',
        'sets': '3',
        'intensity': '中等',
        'notes': '第一组',
      },
      {
        'action_id': 2,
        'equipment_id': 1,
        'reps': '10',
        'sets': '3',
        'intensity': '中等',
        'notes': '第二组',
      },
      {
        'action_id': 3,
        'equipment_id': 2,
        'reps': '15',
        'sets': '2',
        'intensity': '高',
        'notes': '第三组',
      },
    ];

    List<int> blockIds = await repository.addTrainingBlocksBatch(
      sessionId: sessionId,
      blocks: blocks,
    );

    print('✅ 批量添加${blockIds.length}个训练块成功');
    print('📋 新增训练块IDs: $blockIds');

    // 验证
    List<Map<String, dynamic>> result = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );

    print('📊 当前训练块总数: ${result.length}');
  }

  /// ============================================
  /// 示例7：批量重新排序
  /// ============================================
  Future<void> example7_reorderTrainingBlocksBatch() async {
    print('\n=== 示例7：批量重新排序 ===');

    int sessionId = 1;

    // 准备数据
    await repository.clearTrainingBlocks(sessionId: sessionId);
    List<int> blockIds = [];
    for (int i = 0; i < 5; i++) {
      int id = await repository.addTrainingBlock(
        sessionId: sessionId,
        actionId: 1,
        reps: '${i + 1}',
      );
      blockIds.add(id);
    }

    print('📊 原始顺序:');
    List<Map<String, dynamic>> beforeReorder = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );
    for (var block in beforeReorder) {
      print('  - 位置${block['sort_order']}: ID=${block['id']}, 次数=${block['reps']}");
    }

    // 反转顺序
    print('\n📋 反转训练块顺序');
    List<int> reversedIds = blockIds.reversed.toList();
    await repository.reorderTrainingBlocksBatch(blockIds: reversedIds);

    print('✅ 重新排序完成');

    // 查看新顺序
    print('\n📊 反转后的顺序:');
    List<Map<String, dynamic>> afterReorder = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );
    for (var block in afterReorder) {
      print('  - 位置${block['sort_order']}: ID=${block['id']}, 次数=${block['reps']}");
    }
  }

  /// ============================================
  /// 示例8：复制训练块
  /// ============================================
  Future<void> example8_copyTrainingBlock() async {
    print('\n=== 示例8：复制训练块 ===');

    int sessionId = 1;

    // 准备数据
    await repository.clearTrainingBlocks(sessionId: sessionId);
    int originalId = await repository.addTrainingBlock(
      sessionId: sessionId,
      actionId: 1,
      equipmentId: 1,
      reps: '12',
      sets: '3',
      intensity: '中等',
      notes: '原始训练块',
    );

    print('📋 原始训练块ID: $originalId');

    // 复制训练块
    int copiedId = await repository.copyTrainingBlock(
      blockId: originalId,
    );

    print('✅ 复制成功，新训练块ID: $copiedId');

    // 验证
    List<Map<String, dynamic>> blocks = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );

    print('📊 当前训练块列表:');
    for (var block in blocks) {
      Map<String, dynamic>? detail = await repository.getTrainingBlockDetail(
        blockId: block['id'],
      );
      String actionName = detail?['action_name'] ?? '未知';
      print('  - 位置${block['sort_order']}: 动作=$actionName, 次数=${block['reps']}, 备注=${block['notes'] ?? "无"}');
    }
  }

  /// ============================================
  /// 示例9：更新训练块（支持清空字段）
  /// ============================================
  Future<void> example9_updateTrainingBlockFull() async {
    print('\n=== 示例9：更新训练块（支持清空字段） ===');

    int blockId = 1;

    // 先创建一个有数据的训练块
    await repository.updateTrainingBlock(
      blockId: blockId,
      reps: '12',
      sets: '3',
      notes: '这是备注',
    );

    print('📋 原始数据:');
    Map<String, dynamic>? beforeUpdate = await repository.getTrainingBlockDetail(
      blockId: blockId,
    );
    print('  - 次数: ${beforeUpdate?['reps']}');
    print('  - 组数: ${beforeUpdate?['sets']}');
    print('  - 备注: ${beforeUpdate?['notes']}');

    // 清空备注和组数
    print('\n📋 清空备注和组数');
    await repository.updateTrainingBlockFull(
      blockId: blockId,
      data: {
        'sets': null,
        'notes': null,
      },
    );

    print('✅ 更新完成');

    // 验证
    print('\n📊 更新后数据:');
    Map<String, dynamic>? afterUpdate = await repository.getTrainingBlockDetail(
      blockId: blockId,
    );
    print('  - 次数: ${afterUpdate?['reps']}');
    print('  - 组数: ${afterUpdate?['sets'] ?? "（已清空）"}');
    print('  - 备注: ${afterUpdate?['notes'] ?? "（已清空）"}');
  }

  /// ============================================
  /// 示例10：完整的训练块编辑流程
  /// ============================================
  Future<void> example10_fullEditingWorkflow() async {
    print('\n=== 示例10：完整的训练块编辑流程 ===');

    int sessionId = 1;

    // 步骤1：清空现有数据
    await repository.clearTrainingBlocks(sessionId: sessionId);
    print('✅ 步骤1: 已清空现有数据');

    // 步骤2：批量创建训练块
    List<int> blockIds = await repository.addTrainingBlocksBatch(
      sessionId: sessionId,
      blocks: [
        {'action_id': 1, 'reps': '10', 'sets': '3'},
        {'action_id': 2, 'reps': '12', 'sets': '3'},
        {'action_id': 3, 'reps': '15', 'sets': '2'},
      ],
    );
    print('✅ 步骤2: 已创建3个训练块');

    // 步骤3：修改第1个训练块的次数
    await repository.updateTrainingBlock(
      blockId: blockIds[0],
      reps: '20',
    );
    print('✅ 步骤3: 已修改第1个训练块的次数为20');

    // 步骤4：将第3个训练块移到第1个位置
    await repository.reorderTrainingBlock(
      blockId: blockIds[2],
      newSortOrder: 0,
    );
    print('✅ 步骤4: 已将第3个训练块移到首位');

    // 步骤5：复制第1个训练块到末尾
    await repository.copyTrainingBlock(blockId: blockIds[2]);
    print('✅ 步骤5: 已复制第1个训练块到末尾');

    // 步骤6：查询最终结果
    List<Map<String, dynamic>> finalBlocks = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );

    print('\n📊 最终训练块列表:');
    for (var block in finalBlocks) {
      Map<String, dynamic>? detail = await repository.getTrainingBlockDetail(
        blockId: block['id'],
      );
      String actionName = detail?['action_name'] ?? '未知';
      print('  - 位置${block['sort_order']}: 动作=$actionName, 次数=${block['reps']}, 组数=${block['sets']}");
    }
  }

  /// ============================================
  /// 示例11：查询统计信息
  /// ============================================
  Future<void> example11_statistics() async {
    print('\n=== 示例11：查询统计信息 ===');

    int sessionId = 1;

    // 查询所有训练块
    List<Map<String, dynamic>> blocks = await repository.getTrainingBlocksBySession(
      sessionId: sessionId,
    );

    // 统计
    int totalCount = blocks.length;
    int customCount = blocks.where((b) => b['is_custom'] == 1).length;
    int withNotesCount = blocks.where((b) => b['notes'] != null && b['notes'].toString().isNotEmpty).length;

    print('📊 训练块统计:');
    print('  - 总数: $totalCount');
    print('  - 自定义: $customCount');
    print('  - 有备注: $withNotesCount');

    // 统计动作使用情况
    print('\n📊 动作使用情况:');
    Map<int, int> actionUsage = {};
    for (var block in blocks) {
      int? actionId = block['action_id'];
      if (actionId != null) {
        actionUsage[actionId] = (actionUsage[actionId] ?? 0) + 1;
      }
    }

    actionUsage.forEach((actionId, count) {
      print('  - 动作ID $actionId: $count 次');
    });
  }

  /// ============================================
  /// 示例12：错误处理
  /// ============================================
  Future<void> example12_errorHandling() async {
    print('\n=== 示例12：错误处理 ===');

    int sessionId = 1;

    // 示例12.1：删除不存在的训练块
    try {
      await repository.deleteTrainingBlock(blockId: 99999);
    } catch (e) {
      print('❌ 捕获错误（删除不存在）: $e');
    }

    // 示例12.2：移动到无效位置
    try {
      await repository.reorderTrainingBlock(
        blockId: 1,
        newSortOrder: 999,
      );
    } catch (e) {
      print('❌ 捕获错误（无效位置）: $e');
    }

    // 示例12.3：在无效位置插入
    try {
      await repository.insertTrainingBlockAt(
        sessionId: sessionId,
        sortOrder: -1,
      );
    } catch (e) {
      print('❌ 捕获错误（负数位置）: $e');
    }

    print('✅ 所有错误已被正确捕获和处理');
  }
}

/// ============================================
/// 主函数：运行所有示例
/// ============================================
Future<void> runAllExamples(TrainingBlockRepository repository) async {
  final example = TrainingBlockRepositoryExample(repository: repository);

  try {
    await example.example1_addTrainingBlock();
    await example.example2_partialUpdate();
    await example.example3_deleteTrainingBlock();
    await example.example4_reorderTrainingBlock();
    await example.example5_insertTrainingBlockAt();
    await example.example6_addTrainingBlocksBatch();
    await example.example7_reorderTrainingBlocksBatch();
    await example.example8_copyTrainingBlock();
    await example.example9_updateTrainingBlockFull();
    await example.example10_fullEditingWorkflow();
    await example.example11_statistics();
    await example.example12_errorHandling();

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
/// final blockRepo = TrainingBlockRepository(database: db);
///
/// // 3. 添加训练块
/// int blockId = await blockRepo.addTrainingBlock(
///   sessionId: 1,
///   actionId: 1,
///   reps: '12',
///   sets: '3',
/// );
///
/// // 4. 局部更新
/// await blockRepo.updateTrainingBlock(
///   blockId: blockId,
///   reps: '15',
///   intensity: '高',
/// );
///
/// // 5. 重新排序
/// await blockRepo.reorderTrainingBlock(
///   blockId: blockId,
///   newSortOrder: 0,
/// );
///
/// // 6. 删除
/// await blockRepo.deleteTrainingBlock(blockId: blockId);
///
/// // 7. 查询
/// List<Map> blocks = await blockRepo.getTrainingBlocksBySession(sessionId: 1);
/// Map? detail = await blockRepo.getTrainingBlockDetail(blockId: blockId);
/// ```
///
/// 注意事项：
/// 1. 所有操作都在事务中执行，保证数据一致性
/// 2. 排序序号从0开始
/// 3. 删除训练块会自动重新编号后续训练块
/// 4. 局部更新只修改提供的字段
/// 5. 批量操作在一个事务中完成
/// 6. 支持 null 值的更新（使用 updateTrainingBlockFull）
