import 'package:sqflite/sqflite.dart';

/// 训练块仓库
class TrainingBlockRepository {
  final Database database;

  TrainingBlockRepository({required this.database});

  /// ============================================
  /// 1. 添加训练块
  /// ============================================
  ///
  /// 为指定课时添加训练块
  ///
  /// [sessionId] 课时ID
  /// [actionId] 动作ID（可选）
  /// [equipmentId] 器械ID（可选）
  /// [toolId] 工具ID（可选）
  /// [reps] 次数（可选）
  /// [sets] 组数（可选）
  /// [duration] 时长（可选）
  /// [intensity] 强度（可选）
  /// [notes] 备注（可选）
  /// [sortOrder] 排序序号（可选，默认添加到末尾）
  ///
  /// 返回新创建的训练块ID
  Future<int> addTrainingBlock({
    required int sessionId,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
    int? sortOrder,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：确定排序序号
      // ============================================
      int finalSortOrder;

      if (sortOrder != null) {
        // 使用指定的排序序号
        finalSortOrder = sortOrder;

        // 如果指定了位置，需要将 >= 该位置的训练块后移
        await txn.rawQuery('''
          UPDATE training_blocks
          SET sort_order = sort_order + 1,
              updated_at = ?
          WHERE session_id = ? AND sort_order >= ?
        ''', [DateTime.now().toIso8601String(), sessionId, finalSortOrder]);
      } else {
        // 添加到末尾：查询当前最大排序序号
        List<Map<String, dynamic>> result = await txn.rawQuery('''
          SELECT COALESCE(MAX(sort_order), -1) as max_order
          FROM training_blocks
          WHERE session_id = ?
        ''', [sessionId]);

        int maxOrder = result.first['max_order'] as int;
        finalSortOrder = maxOrder + 1;
      }

      // ============================================
      // 第二步：创建训练块
      // ============================================
      int blockId = await txn.insert(
        'training_blocks',
        {
          'session_id': sessionId,
          'action_id': actionId,
          'equipment_id': equipmentId,
          'tool_id': toolId,
          'reps': reps,
          'sets': sets,
          'duration': duration,
          'intensity': intensity,
          'notes': notes,
          'sort_order': finalSortOrder,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      return blockId;
    });
  }

  /// ============================================
  /// 2. 局部更新训练块
  /// ============================================
  ///
  /// 只更新提供的字段，未提供的字段保持不变
  ///
  /// [blockId] 训练块ID
  /// [actionId] 动作ID（可选）
  /// [equipmentId] 器械ID（可选）
  /// [toolId] 工具ID（可选）
  /// [reps] 次数（可选）
  /// [sets] 组数（可选）
  /// [duration] 时长（可选）
  /// [intensity] 强度（可选）
  /// [notes] 备注（可选）
  /// [notes] 备注（可选）
  ///
  /// 返回影响的行数（1表示成功，0表示失败）
  Future<int> updateTrainingBlock({
    required int blockId,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
  }) async {
    // ============================================
    // 第一步：构建更新数据（只包含非空字段）
    // ============================================
    Map<String, dynamic> updateData = {
      'updated_at': DateTime.now().toIso8601String(),
    };

    // 注意：这里使用显式 null 检查，支持将字段设置为 null
    if (actionId != null) updateData['action_id'] = actionId;
    if (equipmentId != null) updateData['equipment_id'] = equipmentId;
    if (toolId != null) updateData['tool_id'] = toolId;
    if (reps != null) updateData['reps'] = reps;
    if (sets != null) updateData['sets'] = sets;
    if (duration != null) updateData['duration'] = duration;
    if (intensity != null) updateData['intensity'] = intensity;
    if (notes != null) updateData['notes'] = notes;

    // 如果没有需要更新的字段，返回0
    if (updateData.length == 1) {
      return 0;
    }

    // ============================================
    // 第二步：执行更新
    // ============================================
    int count = await database.update(
      'training_blocks',
      updateData,
      where: 'id = ?',
      whereArgs: [blockId],
    );

    return count;
  }

  /// ============================================
  /// 3. 删除训练块（自动重新排序）
  /// ============================================
  ///
  /// 删除指定训练块，并自动调整后续训练块的排序序号
  ///
  /// [blockId] 训练块ID
  ///
  /// 返回删除的训练块的原排序序号
  Future<int> deleteTrainingBlock({
    required int blockId,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：查询要删除的训练块信息
      // ============================================
      List<Map<String, dynamic>> blocks = await txn.query(
        'training_blocks',
        where: 'id = ?',
        whereArgs: [blockId],
      );

      if (blocks.isEmpty) {
        throw ArgumentError('Training block not found: $blockId');
      }

      Map<String, dynamic> block = blocks.first;
      int sessionId = block['session_id'] as int;
      int deletedSortOrder = block['sort_order'] as int;

      // ============================================
      // 第二步：删除训练块
      // ============================================
      int deletedCount = await txn.delete(
        'training_blocks',
        where: 'id = ?',
        whereArgs: [blockId],
      );

      if (deletedCount == 0) {
        throw StateError('Failed to delete training block: $blockId');
      }

      // ============================================
      // 第三步：重新编号后续训练块
      // ============================================
      await txn.rawQuery('''
        UPDATE training_blocks
        SET sort_order = sort_order - 1,
            updated_at = ?
        WHERE session_id = ? AND sort_order > ?
      ''', [DateTime.now().toIso8601String(), sessionId, deletedSortOrder]);

      // ============================================
      // 第四步：返回删除的训练块的原排序序号
      // ============================================
      return deletedSortOrder;
    });
  }

  /// ============================================
  /// 4. 重新排序训练块
  /// ============================================
  ///
  /// 将训练块移动到指定位置
  ///
  /// [blockId] 训练块ID
  /// [newSortOrder] 新的排序序号（从0开始）
  ///
  /// 返回移动成功后的训练块ID
  Future<int> reorderTrainingBlock({
    required int blockId,
    required int newSortOrder,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：查询要移动的训练块信息
      // ============================================
      List<Map<String, dynamic>> blocks = await txn.query(
        'training_blocks',
        where: 'id = ?',
        whereArgs: [blockId],
      );

      if (blocks.isEmpty) {
        throw ArgumentError('Training block not found: $blockId');
      }

      Map<String, dynamic> block = blocks.first;
      int sessionId = block['session_id'] as int;
      int currentSortOrder = block['sort_order'] as int;

      // 如果位置没变，直接返回
      if (currentSortOrder == newSortOrder) {
        return blockId;
      }

      // ============================================
      // 第二步：查询该课时的训练块总数
      // ============================================
      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COUNT(*) as total_count
        FROM training_blocks
        WHERE session_id = ?
      ''', [sessionId]);

      int totalCount = result.first['total_count'] as int;

      // 验证位置合法性
      if (newSortOrder < 0 || newSortOrder >= totalCount) {
        throw ArgumentError(
          'Invalid sort order: $newSortOrder. Must be between 0 and ${totalCount - 1}',
        );
      }

      // ============================================
      // 第三步：调整其他训练块的序号
      // ============================================
      if (currentSortOrder < newSortOrder) {
        // 向后移动：将 [currentSortOrder+1, newSortOrder] 的训练块序号 -1
        await txn.rawQuery('''
          UPDATE training_blocks
          SET sort_order = sort_order - 1,
              updated_at = ?
          WHERE session_id = ?
            AND sort_order > ?
            AND sort_order <= ?
        ''', [
          DateTime.now().toIso8601String(),
          sessionId,
          currentSortOrder,
          newSortOrder,
        ]);
      } else {
        // 向前移动：将 [newSortOrder, currentSortOrder-1] 的训练块序号 +1
        await txn.rawQuery('''
          UPDATE training_blocks
          SET sort_order = sort_order + 1,
              updated_at = ?
          WHERE session_id = ?
            AND sort_order >= ?
            AND sort_order < ?
        ''', [
          DateTime.now().toIso8601String(),
          sessionId,
          newSortOrder,
          currentSortOrder,
        ]);
      }

      // ============================================
      // 第四步：更新目标训练块到新位置
      // ============================================
      await txn.update(
        'training_blocks',
        {
          'sort_order': newSortOrder,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [blockId],
      );

      return blockId;
    });
  }

  /// ============================================
  /// 5. 批量添加训练块
  /// ============================================
  ///
  /// 为指定课时批量添加训练块
  ///
  /// [sessionId] 课时ID
  /// [blocks] 训练块数据列表
  ///
  /// 返回新创建的训练块ID列表
  Future<List<int>> addTrainingBlocksBatch({
    required int sessionId,
    required List<Map<String, dynamic>> blocks,
  }) async {
    return await database.transaction((txn) async {
      // 查询当前最大排序序号
      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COALESCE(MAX(sort_order), -1) as max_order
        FROM training_blocks
        WHERE session_id = ?
      ''', [sessionId]);

      int maxOrder = result.first['max_order'] as int;
      List<int> blockIds = [];

      // 批量创建训练块
      for (int i = 0; i < blocks.length; i++) {
        Map<String, dynamic> block = blocks[i];
        int sortOrder = maxOrder + i + 1;

        int blockId = await txn.insert(
          'training_blocks',
          {
            'session_id': sessionId,
            'action_id': block['action_id'],
            'equipment_id': block['equipment_id'],
            'tool_id': block['tool_id'],
            'reps': block['reps'],
            'sets': block['sets'],
            'duration': block['duration'],
            'intensity': block['intensity'],
            'notes': block['notes'],
            'sort_order': sortOrder,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          },
        );
        blockIds.add(blockId);
      }

      return blockIds;
    });
  }

  /// ============================================
  /// 6. 在指定位置插入训练块
  /// ============================================
  ///
  /// 在指定位置插入新训练块，后续训练块自动后移
  ///
  /// [sessionId] 课时ID
  /// [sortOrder] 插入位置（从0开始）
  /// [actionId] 动作ID
  /// [equipmentId] 器械ID
  /// [toolId] 工具ID
  /// [reps] 次数
  /// [sets] 组数
  /// [duration] 时长
  /// [intensity] 强度
  /// [notes] 备注
  /// [notes] 备注
  ///
  /// 返回新创建的训练块ID
  Future<int> insertTrainingBlockAt({
    required int sessionId,
    required int sortOrder,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
  }) async {
    return await database.transaction((txn) async {
      // ============================================
      // 第一步：查询当前训练块总数
      // ============================================
      List<Map<String, dynamic>> result = await txn.rawQuery('''
        SELECT COUNT(*) as total_count
        FROM training_blocks
        WHERE session_id = ?
      ''', [sessionId]);

      int totalCount = result.first['total_count'] as int;

      // 验证位置合法性
      if (sortOrder < 0 || sortOrder > totalCount) {
        throw ArgumentError(
          'Invalid sort order: $sortOrder. Must be between 0 and $totalCount',
        );
      }

      // ============================================
      // 第二步：将位置 >= sortOrder 的训练块后移
      // ============================================
      if (sortOrder < totalCount) {
        await txn.rawQuery('''
          UPDATE training_blocks
          SET sort_order = sort_order + 1,
              updated_at = ?
          WHERE session_id = ? AND sort_order >= ?
        ''', [DateTime.now().toIso8601String(), sessionId, sortOrder]);
      }

      // ============================================
      // 第三步：在腾出的位置插入新训练块
      // ============================================
      int blockId = await txn.insert(
        'training_blocks',
        {
          'session_id': sessionId,
          'action_id': actionId,
          'equipment_id': equipmentId,
          'tool_id': toolId,
          'reps': reps,
          'sets': sets,
          'duration': duration,
          'intensity': intensity,
          'notes': notes,
          'sort_order': sortOrder,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );

      return blockId;
    });
  }

  /// ============================================
  /// 7. 批量重新排序训练块
  /// ============================================
  ///
  /// 根据训练块ID列表重新排序
  ///
  /// [blockIds] 训练块ID列表（按新顺序排列）
  ///
  /// 返回是否成功
  Future<bool> reorderTrainingBlocksBatch({
    required List<int> blockIds,
  }) async {
    return await database.transaction((txn) async {
      // 验证所有训练块属于同一课时
      if (blockIds.isNotEmpty) {
        List<Map<String, dynamic>> result = await txn.rawQuery('''
          SELECT DISTINCT session_id
          FROM training_blocks
          WHERE id IN (${List.filled(blockIds.length, '?').join(',')})
        ''', blockIds);

        if (result.length != 1) {
          throw ArgumentError('All training blocks must belong to the same session');
        }
      }

      // 更新每个训练块的排序序号
      for (int i = 0; i < blockIds.length; i++) {
        await txn.update(
          'training_blocks',
          {
            'sort_order': i,
            'updated_at': DateTime.now().toIso8601String(),
          },
          where: 'id = ?',
          whereArgs: [blockIds[i]],
        );
      }

      return true;
    });
  }

  /// ============================================
  /// 8. 查询课时的所有训练块（按排序）
  /// ============================================
  ///
  /// [sessionId] 课时ID
  ///
  /// 返回训练块列表（按 sort_order 排序）
  Future<List<Map<String, dynamic>>> getTrainingBlocksBySession({
    required int sessionId,
  }) async {
    List<Map<String, dynamic>> blocks = await database.query(
      'training_blocks',
      where: 'session_id = ?',
      whereArgs: [sessionId],
      orderBy: 'sort_order ASC',
    );

    return blocks;
  }

  /// ============================================
  /// 9. 查询训练块详情（含关联数据）
  /// ============================================
  ///
  /// [blockId] 训练块ID
  ///
  /// 返回训练块详情（包含动作、器械、工具名称）
  Future<Map<String, dynamic>?> getTrainingBlockDetail({
    required int blockId,
  }) async {
    List<Map<String, dynamic>> result = await database.rawQuery('''
      SELECT
        tb.*,
        a.name as action_name,
        e.name as equipment_name,
        t.name as tool_name
      FROM training_blocks tb
      LEFT JOIN actions a ON tb.action_id = a.id
      LEFT JOIN equipments e ON tb.equipment_id = e.id
      LEFT JOIN tools t ON tb.tool_id = t.id
      WHERE tb.id = ?
    ''', [blockId]);

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  /// ============================================
  /// 10. 复制训练块
  /// ============================================
  ///
  /// 复制指定训练块到同一课时的末尾
  ///
  /// [blockId] 要复制的训练块ID
  ///
  /// 返回新创建的训练块ID
  Future<int> copyTrainingBlock({
    required int blockId,
  }) async {
    // 查询原训练块
    List<Map<String, dynamic>> blocks = await database.query(
      'training_blocks',
      where: 'id = ?',
      whereArgs: [blockId],
    );

    if (blocks.isEmpty) {
      throw ArgumentError('Training block not found: $blockId');
    }

    Map<String, dynamic> sourceBlock = blocks.first;
    int sessionId = sourceBlock['session_id'] as int;

    // 复制训练块
    int newBlockId = await addTrainingBlock(
      sessionId: sessionId,
      actionId: sourceBlock['action_id'],
      equipmentId: sourceBlock['equipment_id'],
      toolId: sourceBlock['tool_id'],
      reps: sourceBlock['reps'],
      sets: sourceBlock['sets'],
      duration: sourceBlock['duration'],
      intensity: sourceBlock['intensity'],
      notes: sourceBlock['notes'],
    );

    return newBlockId;
  }

  /// ============================================
  /// 11. 清空训练块
  /// ============================================
  ///
  /// 删除指定课时的所有训练块
  ///
  /// [sessionId] 课时ID
  ///
  /// 返回删除的训练块数量
  Future<int> clearTrainingBlocks({
    required int sessionId,
  }) async {
    int count = await database.delete(
      'training_blocks',
      where: 'session_id = ?',
      whereArgs: [sessionId],
    );

    return count;
  }

  /// ============================================
  /// 12. 更新训练块字段（支持设置为 NULL）
  /// ============================================
  ///
  /// 支持将字段设置为 null 的完整更新方法
  ///
  /// [blockId] 训练块ID
  /// [data] 要更新的数据（字段可以为 null）
  ///
  /// 返回影响的行数
  Future<int> updateTrainingBlockFull({
    required int blockId,
    required Map<String, dynamic?> data,
  }) async {
    Map<String, dynamic> updateData = {
      'updated_at': DateTime.now().toIso8601String(),
    };

    // 显式处理每个字段，支持设置为 null
    if (data.containsKey('action_id')) {
      updateData['action_id'] = data['action_id'];
    }
    if (data.containsKey('equipment_id')) {
      updateData['equipment_id'] = data['equipment_id'];
    }
    if (data.containsKey('tool_id')) {
      updateData['tool_id'] = data['tool_id'];
    }
    if (data.containsKey('reps')) {
      updateData['reps'] = data['reps'];
    }
    if (data.containsKey('sets')) {
      updateData['sets'] = data['sets'];
    }
    if (data.containsKey('duration')) {
      updateData['duration'] = data['duration'];
    }
    if (data.containsKey('intensity')) {
      updateData['intensity'] = data['intensity'];
    }
    if (data.containsKey('notes')) {
      updateData['notes'] = data['notes'];
    }

    int count = await database.update(
      'training_blocks',
      updateData,
      where: 'id = ?',
      whereArgs: [blockId],
    );

    return count;
  }
}
