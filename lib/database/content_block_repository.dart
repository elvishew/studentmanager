import 'package:sqflite/sqflite.dart';

/// 内容块仓库（替代 TrainingBlockRepository）
class ContentBlockRepository {
  final Database database;

  ContentBlockRepository({required this.database});

  /// 添加内容块及其值
  Future<int> addContentBlock({
    required int sessionId,
    required Map<int, String> values, // contentFieldId -> value
    int? sortOrder,
  }) async {
    return await database.transaction((txn) async {
      // 确定排序序号
      int finalSortOrder;
      if (sortOrder != null) {
        finalSortOrder = sortOrder;
        await txn.rawQuery('''
          UPDATE content_blocks
          SET sort_order = sort_order + 1, updated_at = ?
          WHERE session_id = ? AND sort_order >= ?
        ''', [DateTime.now().toIso8601String(), sessionId, finalSortOrder]);
      } else {
        final result = await txn.rawQuery('''
          SELECT COALESCE(MAX(sort_order), -1) as max_order
          FROM content_blocks WHERE session_id = ?
        ''', [sessionId]);
        finalSortOrder = (result.first['max_order'] as int) + 1;
      }

      final now = DateTime.now().toIso8601String();
      final blockId = await txn.insert('content_blocks', {
        'session_id': sessionId,
        'sort_order': finalSortOrder,
        'created_at': now,
        'updated_at': now,
      });

      // 插入字段值
      for (final entry in values.entries) {
        if (entry.value.isNotEmpty) {
          await txn.insert('content_block_values', {
            'content_block_id': blockId,
            'content_field_id': entry.key,
            'value': entry.value,
            'created_at': now,
            'updated_at': now,
          });
        }
      }

      return blockId;
    });
  }

  /// 更新内容块值
  Future<bool> updateContentBlock({
    required int blockId,
    required Map<int, String> values,
  }) async {
    return await database.transaction((txn) async {
      final now = DateTime.now().toIso8601String();

      // 先删除旧值
      await txn.delete(
        'content_block_values',
        where: 'content_block_id = ?',
        whereArgs: [blockId],
      );

      // 插入新值
      for (final entry in values.entries) {
        if (entry.value.isNotEmpty) {
          await txn.insert('content_block_values', {
            'content_block_id': blockId,
            'content_field_id': entry.key,
            'value': entry.value,
            'created_at': now,
            'updated_at': now,
          });
        }
      }

      // 更新时间戳
      await txn.update(
        'content_blocks',
        {'updated_at': now},
        where: 'id = ?',
        whereArgs: [blockId],
      );

      return true;
    });
  }

  /// 删除内容块
  Future<void> deleteContentBlock(int blockId) async {
    await database.transaction((txn) async {
      final blocks = await txn.query(
        'content_blocks',
        where: 'id = ?',
        whereArgs: [blockId],
      );
      if (blocks.isEmpty) return;

      final sessionId = blocks.first['session_id'] as int;
      final deletedSortOrder = blocks.first['sort_order'] as int;

      await txn.delete('content_blocks', where: 'id = ?', whereArgs: [blockId]);

      await txn.rawQuery('''
        UPDATE content_blocks
        SET sort_order = sort_order - 1, updated_at = ?
        WHERE session_id = ? AND sort_order > ?
      ''', [DateTime.now().toIso8601String(), sessionId, deletedSortOrder]);
    });
  }

  /// 重新排序内容块
  Future<void> reorderContentBlock({
    required int blockId,
    required int newSortOrder,
  }) async {
    await database.transaction((txn) async {
      final blocks = await txn.query(
        'content_blocks',
        where: 'id = ?',
        whereArgs: [blockId],
      );
      if (blocks.isEmpty) return;

      final sessionId = blocks.first['session_id'] as int;
      final currentSortOrder = blocks.first['sort_order'] as int;

      if (currentSortOrder == newSortOrder) return;

      final now = DateTime.now().toIso8601String();

      if (currentSortOrder < newSortOrder) {
        await txn.rawQuery('''
          UPDATE content_blocks
          SET sort_order = sort_order - 1, updated_at = ?
          WHERE session_id = ? AND sort_order > ? AND sort_order <= ?
        ''', [now, sessionId, currentSortOrder, newSortOrder]);
      } else {
        await txn.rawQuery('''
          UPDATE content_blocks
          SET sort_order = sort_order + 1, updated_at = ?
          WHERE session_id = ? AND sort_order >= ? AND sort_order < ?
        ''', [now, sessionId, newSortOrder, currentSortOrder]);
      }

      await txn.update(
        'content_blocks',
        {'sort_order': newSortOrder, 'updated_at': now},
        where: 'id = ?',
        whereArgs: [blockId],
      );
    });
  }

  /// 查询课时的所有内容块（含值）
  Future<List<Map<String, dynamic>>> getContentBlocksBySession(int sessionId) async {
    final blocks = await database.query(
      'content_blocks',
      where: 'session_id = ?',
      whereArgs: [sessionId],
      orderBy: 'sort_order ASC',
    );

    final result = <Map<String, dynamic>>[];
    for (final rawBlock in blocks) {
      final block = Map<String, dynamic>.from(rawBlock);
      final blockId = block['id'] as int;
      final values = await database.rawQuery('''
        SELECT cbv.content_field_id, cbv.value, cf.name as field_name, cf.field_type
        FROM content_block_values cbv
        JOIN content_fields cf ON cbv.content_field_id = cf.id
        WHERE cbv.content_block_id = ?
      ''', [blockId]);

      block['values'] = values;
      result.add(block);
    }

    return result;
  }

  /// 复制内容块
  Future<int> copyContentBlock(int blockId) async {
    final blocks = await database.query(
      'content_blocks',
      where: 'id = ?',
      whereArgs: [blockId],
    );
    if (blocks.isEmpty) throw ArgumentError('Content block not found: $blockId');

    final sessionId = blocks.first['session_id'] as int;

    // 获取值
    final valuesResult = await database.query(
      'content_block_values',
      where: 'content_block_id = ?',
      whereArgs: [blockId],
    );

    final values = <int, String>{};
    for (final v in valuesResult) {
      values[v['content_field_id'] as int] = v['value'] as String? ?? '';
    }

    return await addContentBlock(sessionId: sessionId, values: values);
  }

  /// 批量添加内容块
  Future<List<int>> addContentBlocksBatch({
    required int sessionId,
    required List<Map<String, String>> blocksData,
  }) async {
    return await database.transaction((txn) async {
      final result = await txn.rawQuery('''
        SELECT COALESCE(MAX(sort_order), -1) as max_order
        FROM content_blocks WHERE session_id = ?
      ''', [sessionId]);

      int maxOrder = (result.first['max_order'] as int);
      final now = DateTime.now().toIso8601String();
      final blockIds = <int>[];

      for (int i = 0; i < blocksData.length; i++) {
        final blockData = blocksData[i];
        final sortOrder = maxOrder + i + 1;

        final blockId = await txn.insert('content_blocks', {
          'session_id': sessionId,
          'sort_order': sortOrder,
          'created_at': now,
          'updated_at': now,
        });

        for (final entry in blockData.entries) {
          if (entry.value.isNotEmpty) {
            final fieldId = int.tryParse(entry.key);
            if (fieldId != null) {
              await txn.insert('content_block_values', {
                'content_block_id': blockId,
                'content_field_id': fieldId,
                'value': entry.value,
                'created_at': now,
                'updated_at': now,
              });
            }
          }
        }

        blockIds.add(blockId);
      }

      return blockIds;
    });
  }

  /// 清空课时的所有内容块
  Future<int> clearContentBlocks(int sessionId) async {
    return await database.delete(
      'content_blocks',
      where: 'session_id = ?',
      whereArgs: [sessionId],
    );
  }
}
