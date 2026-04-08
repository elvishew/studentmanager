import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:student_manager/database/training_block_repository.dart';

/// TrainingBlockRepository 单元测试
void main() {
  sqfliteFfiInit();

  group('TrainingBlockRepository 测试', () {
    late Database database;
    late TrainingBlockRepository repository;
    int testSessionId = 1;

    setUpAll(() async {
      database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      await database.execute('PRAGMA foreign_keys = ON');
      await _createTables(database);
      await _insertTestData(database);

      repository = TrainingBlockRepository(database: database);
    });

    tearDown(() async {
      // 每个测试后清空训练块数据
      await database.delete('training_blocks', where: '1=1');
    });

    tearDownAll(() async {
      await database.close();
    });

    group('addTrainingBlock 测试', () {
      test('添加第1个训练块，排序序号应为0', () async {
        // 执行
        int blockId = await repository.addTrainingBlock(
          sessionId: testSessionId,
          actionId: 1,
          reps: '12',
        );

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'id = ?',
          whereArgs: [blockId],
        );

        expect(blocks.length, 1);
        expect(blocks.first['sort_order'], 0);
        expect(blocks.first['action_id'], 1);
        expect(blocks.first['reps'], '12');
      });

      test('在已有3个训练块后添加，新训练块序号应为3', () async {
        // 准备数据：创建3个训练块
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 1,
          'sort_order': 0,
        });
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 1,
          'sort_order': 1,
        });
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 1,
          'sort_order': 2,
        });

        // 执行
        int blockId = await repository.addTrainingBlock(
          sessionId: testSessionId,
          actionId: 2,
        );

        // 验证
        List<Map> block = await database.query(
          'training_blocks',
          where: 'id = ?',
          whereArgs: [blockId],
        );

        expect(block.first['sort_order'], 3);

        // 验证总训练块数为4
        List<Map> allBlocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
        );

        expect(allBlocks.length, 4);
      });

      test('在指定位置插入训练块，后续训练块应后移', () async {
        // 准备数据：创建3个训练块
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 1,
          'sort_order': 0,
        });
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 2,
          'sort_order': 1,
        });
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 3,
          'sort_order': 2,
        });

        // 执行：在位置1插入新训练块
        int blockId = await repository.addTrainingBlock(
          sessionId: testSessionId,
          actionId: 99,
          sortOrder: 1,
        );

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
          orderBy: 'sort_order ASC',
        );

        expect(blocks.length, 4);
        expect(blocks[0]['sort_order'], 0);
        expect(blocks[1]['id'], blockId);
        expect(blocks[1]['sort_order'], 1);
        expect(blocks[2]['sort_order'], 2); // 原位置1的训练块变为2
        expect(blocks[3]['sort_order'], 3); // 原位置2的训练块变为3
      });
    });

    group('updateTrainingBlock 测试', () {
      test('局部更新多个字段', () async {
        // 准备数据
        int blockId = await database.insert(
          'training_blocks',
          {
            'session_id': testSessionId,
            'action_id': 1,
            'reps': '10',
            'sets': '3',
            'intensity': '中等',
            'sort_order': 0,
          },
        );

        // 执行：只更新 reps 和 sets
        int count = await repository.updateTrainingBlock(
          blockId: blockId,
          reps: '15',
          sets: '4',
        );

        // 验证
        expect(count, 1);

        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'id = ?',
          whereArgs: [blockId],
        );

        expect(blocks.first['reps'], '15');
        expect(blocks.first['sets'], '4');
        expect(blocks.first['intensity'], '中等'); // 未更新
        expect(blocks.first['action_id'], 1); // 未更新
      });

      test('只更新一个字段', () async {
        // 准备数据
        int blockId = await database.insert(
          'training_blocks',
          {
            'session_id': testSessionId,
            'reps': '10',
            'sets': '3',
            'sort_order': 0,
          },
        );

        // 执行：只更新 intensity
        await repository.updateTrainingBlock(
          blockId: blockId,
          intensity: '高',
        );

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'id = ?',
          whereArgs: [blockId],
        );

        expect(blocks.first['intensity'], '高');
        expect(blocks.first['reps'], '10'); // 未变
      });

      test('更新不存在训练块应返回0', () async {
        // 执行
        int count = await repository.updateTrainingBlock(
          blockId: 99999,
          reps: '20',
        );

        // 验证
        expect(count, 0);
      });

      test('使用 updateTrainingBlockFull 清空字段', () async {
        // 准备数据
        int blockId = await database.insert(
          'training_blocks',
          {
            'session_id': testSessionId,
            'reps': '12',
            'sets': '3',
            'notes': '这是备注',
            'sort_order': 0,
          },
        );

        // 执行：清空 sets 和 notes
        await repository.updateTrainingBlockFull(
          blockId: blockId,
          data: {
            'sets': null,
            'notes': null,
          },
        );

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'id = ?',
          whereArgs: [blockId],
        );

        expect(blocks.first['reps'], '12'); // 未变
        expect(blocks.first['sets'], null); // 已清空
        expect(blocks.first['notes'], null); // 已清空
      });
    });

    group('deleteTrainingBlock 测试', () {
      test('删除中间训练块，后续训练块应自动重新编号', () async {
        // 准备数据：5个训练块
        List<int> blockIds = [];
        for (int i = 0; i < 5; i++) {
          int id = await database.insert('training_blocks', {
            'session_id': testSessionId,
            'action_id': i + 1,
            'sort_order': i,
          });
          blockIds.add(id);
        }

        // 执行：删除第3个训练块（索引2）
        int deletedOrder = await repository.deleteTrainingBlock(
          blockId: blockIds[2],
        );

        // 验证
        expect(deletedOrder, 2);

        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
          orderBy: 'sort_order ASC',
        );

        expect(blocks.length, 4);
        expect(blocks[0]['id'], blockIds[0]);
        expect(blocks[0]['sort_order'], 0);
        expect(blocks[1]['id'], blockIds[1]);
        expect(blocks[1]['sort_order'], 1);
        expect(blocks[2]['id'], blockIds[3]); // 原序号3变为2
        expect(blocks[2]['sort_order'], 2);
        expect(blocks[3]['id'], blockIds[4]); // 原序号4变为3
        expect(blocks[3]['sort_order'], 3);
      });

      test('删除最后一个训练块', () async {
        // 准备数据：3个训练块
        List<int> blockIds = [];
        for (int i = 0; i < 3; i++) {
          int id = await database.insert('training_blocks', {
            'session_id': testSessionId,
            'sort_order': i,
          });
          blockIds.add(id);
        }

        // 执行：删除最后一个
        await repository.deleteTrainingBlock(blockId: blockIds[2]);

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
          orderBy: 'sort_order ASC',
        );

        expect(blocks.length, 2);
        expect(blocks[0]['sort_order'], 0);
        expect(blocks[1]['sort_order'], 1);
      });

      test('删除第一个训练块', () async {
        // 准备数据
        List<int> blockIds = [];
        for (int i = 0; i < 3; i++) {
          int id = await database.insert('training_blocks', {
            'session_id': testSessionId,
            'sort_order': i,
          });
          blockIds.add(id);
        }

        // 执行：删除第一个
        await repository.deleteTrainingBlock(blockId: blockIds[0]);

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
          orderBy: 'sort_order ASC',
        );

        expect(blocks.length, 2);
        expect(blocks[0]['id'], blockIds[1]);
        expect(blocks[0]['sort_order'], 0); // 原序号1变为0
        expect(blocks[1]['id'], blockIds[2]);
        expect(blocks[1]['sort_order'], 1); // 原序号2变为1
      });

      test('删除不存在的训练块应抛出异常', () async {
        // 执行并验证
        expect(
          () => repository.deleteTrainingBlock(blockId: 99999),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('reorderTrainingBlock 测试', () {
      test('向前移动训练块（从位置4移到位置1）', () async {
        // 准备数据：5个训练块
        List<int> blockIds = [];
        for (int i = 0; i < 5; i++) {
          int id = await database.insert('training_blocks', {
            'session_id': testSessionId,
            'action_id': i + 1,
            'sort_order': i,
          });
          blockIds.add(id);
        }

        // 执行：将第5个训练块（序号4）移到位置1
        await repository.reorderTrainingBlock(
          blockId: blockIds[4],
          newSortOrder: 1,
        );

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
          orderBy: 'sort_order ASC',
        );

        expect(blocks.length, 5);
        expect(blocks[0]['id'], blockIds[0]); // 位置0不变
        expect(blocks[1]['id'], blockIds[4]); // 位置1是原来的5
        expect(blocks[2]['id'], blockIds[1]); // 位置2是原来的2
        expect(blocks[3]['id'], blockIds[2]); // 位置3是原来的3
        expect(blocks[4]['id'], blockIds[3]); // 位置4是原来的4
      });

      test('向后移动训练块（从位置1移到位置3）', () async {
        // 准备数据：5个训练块
        List<int> blockIds = [];
        for (int i = 0; i < 5; i++) {
          int id = await database.insert('training_blocks', {
            'session_id': testSessionId,
            'action_id': i + 1,
            'sort_order': i,
          });
          blockIds.add(id);
        }

        // 执行：将第2个训练块（序号1）移到位置3
        await repository.reorderTrainingBlock(
          blockId: blockIds[1],
          newSortOrder: 3,
        );

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
          orderBy: 'sort_order ASC',
        );

        expect(blocks.length, 5);
        expect(blocks[0]['id'], blockIds[0]); // 位置0不变
        expect(blocks[1]['id'], blockIds[2]); // 位置1是原来的3
        expect(blocks[2]['id'], blockIds[3]); // 位置2是原来的4
        expect(blocks[3]['id'], blockIds[1]); // 位置3是原来的2
        expect(blocks[4]['id'], blockIds[4]); // 位置4不变
      });

      test('移动到相同位置应无变化', () async {
        // 准备数据
        int blockId = await database.insert('training_blocks', {
          'session_id': testSessionId,
          'sort_order': 1,
        });

        // 执行：移动到相同位置
        int resultId = await repository.reorderTrainingBlock(
          blockId: blockId,
          newSortOrder: 1,
        );

        // 验证
        expect(resultId, blockId);

        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'id = ?',
          whereArgs: [blockId],
        );

        expect(blocks.first['sort_order'], 1);
      });

      test('移动到无效位置应抛出异常', () async {
        // 准备数据
        int blockId = await database.insert('training_blocks', {
          'session_id': testSessionId,
          'sort_order': 0,
        });

        // 执行并验证
        expect(
          () => repository.reorderTrainingBlock(
            blockId: blockId,
            newSortOrder: 999,
          ),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('insertTrainingBlockAt 测试', () {
      test('在中间位置插入训练块', () async {
        // 准备数据：3个训练块
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 1,
          'sort_order': 0,
        });
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 2,
          'sort_order': 1,
        });
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 3,
          'sort_order': 2,
        });

        // 执行：在位置1插入
        int blockId = await repository.insertTrainingBlockAt(
          sessionId: testSessionId,
          sortOrder: 1,
          actionId: 99,
        );

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
          orderBy: 'sort_order ASC',
        );

        expect(blocks.length, 4);
        expect(blocks[0]['action_id'], 1);
        expect(blocks[1]['id'], blockId);
        expect(blocks[1]['sort_order'], 1);
        expect(blocks[2]['action_id'], 2);
        expect(blocks[2]['sort_order'], 2); // 原位置1变为2
        expect(blocks[3]['action_id'], 3);
        expect(blocks[3]['sort_order'], 3); // 原位置2变为3
      });

      test('在末尾插入训练块', () async {
        // 准备数据
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'sort_order': 0,
        });
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'sort_order': 1,
        });

        // 执行：在位置2（末尾）插入
        int blockId = await repository.insertTrainingBlockAt(
          sessionId: testSessionId,
          sortOrder: 2,
        );

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
          orderBy: 'sort_order ASC',
        );

        expect(blocks.length, 3);
        expect(blocks[2]['id'], blockId);
        expect(blocks[2]['sort_order'], 2);
      });

      test('在无效位置插入应抛出异常', () async {
        // 执行并验证：负数位置
        expect(
          () => repository.insertTrainingBlockAt(
            sessionId: testSessionId,
            sortOrder: -1,
          ),
          throwsA(isA<ArgumentError>()),
        );

        // 执行并验证：超出范围的位置
        expect(
          () => repository.insertTrainingBlockAt(
            sessionId: testSessionId,
            sortOrder: 999,
          ),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('addTrainingBlocksBatch 测试', () {
      test('批量添加3个训练块', () async {
        // 执行
        List<int> blockIds = await repository.addTrainingBlocksBatch(
          sessionId: testSessionId,
          blocks: [
            {'action_id': 1, 'reps': '10'},
            {'action_id': 2, 'reps': '12'},
            {'action_id': 3, 'reps': '15'},
          ],
        );

        // 验证
        expect(blockIds.length, 3);

        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
          orderBy: 'sort_order ASC',
        );

        expect(blocks.length, 3);
        expect(blocks[0]['sort_order'], 0);
        expect(blocks[1]['sort_order'], 1);
        expect(blocks[2]['sort_order'], 2);
      });
    });

    group('reorderTrainingBlocksBatch 测试', () {
      test('批量重新排序训练块', () async {
        // 准备数据：5个训练块
        List<int> blockIds = [];
        for (int i = 0; i < 5; i++) {
          int id = await database.insert('training_blocks', {
            'session_id': testSessionId,
            'action_id': i + 1,
            'sort_order': i,
          });
          blockIds.add(id);
        }

        // 执行：反转顺序
        List<int> reversedIds = blockIds.reversed.toList();
        await repository.reorderTrainingBlocksBatch(blockIds: reversedIds);

        // 验证
        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
          orderBy: 'sort_order ASC',
        );

        expect(blocks.length, 5);
        expect(blocks[0]['id'], blockIds[4]);
        expect(blocks[1]['id'], blockIds[3]);
        expect(blocks[2]['id'], blockIds[2]);
        expect(blocks[3]['id'], blockIds[1]);
        expect(blocks[4]['id'], blockIds[0]);
      });

      test('不同课时的训练块批量排序应抛出异常', () async {
        // 准备数据：创建两个课时的训练块
        int blockId1 = await database.insert('training_blocks', {
          'session_id': 1,
          'sort_order': 0,
        });
        int blockId2 = await database.insert('training_blocks', {
          'session_id': 2,
          'sort_order': 0,
        });

        // 执行并验证
        expect(
          () => repository.reorderTrainingBlocksBatch(blockIds: [blockId1, blockId2]),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('copyTrainingBlock 测试', () {
      test('复制训练块到末尾', () async {
        // 准备数据
        int originalId = await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 1,
          'equipment_id': 1,
          'reps': '12',
          'sets': '3',
          'notes': '原始训练',
          'sort_order': 0,
        });

        // 执行
        int copiedId = await repository.copyTrainingBlock(blockId: originalId);

        // 验证
        expect(copiedId, isNot(equals(originalId)));

        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'id = ?',
          whereArgs: [copiedId],
        );

        expect(blocks.first['action_id'], 1);
        expect(blocks.first['equipment_id'], 1);
        expect(blocks.first['reps'], '12');
        expect(blocks.first['sets'], '3');
        expect(blocks.first['notes'], '原始训练');
        expect(blocks.first['sort_order'], 1); // 在末尾
      });

      test('复制不存在的训练块应抛出异常', () async {
        // 执行并验证
        expect(
          () => repository.copyTrainingBlock(blockId: 99999),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('clearTrainingBlocks 测试', () {
      test('清空课时的所有训练块', () async {
        // 准备数据：创建5个训练块
        for (int i = 0; i < 5; i++) {
          await database.insert('training_blocks', {
            'session_id': testSessionId,
            'sort_order': i,
          });
        }

        // 执行
        int count = await repository.clearTrainingBlocks(
          sessionId: testSessionId,
        );

        // 验证
        expect(count, 5);

        List<Map> blocks = await database.query(
          'training_blocks',
          where: 'session_id = ?',
          whereArgs: [testSessionId],
        );

        expect(blocks.length, 0);
      });
    });

    group('查询功能测试', () {
      test('查询课时的所有训练块（按排序）', () async {
        // 准备数据：创建3个训练块（乱序插入）
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 2,
          'sort_order': 2,
        });
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 1,
          'sort_order': 0,
        });
        await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 3,
          'sort_order': 1,
        });

        // 执行
        List<Map> blocks = await repository.getTrainingBlocksBySession(
          sessionId: testSessionId,
        );

        // 验证：应该按 sort_order 排序
        expect(blocks.length, 3);
        expect(blocks[0]['action_id'], 1);
        expect(blocks[1]['action_id'], 3);
        expect(blocks[2]['action_id'], 2);
      });

      test('查询训练块详情（含关联数据）', () async {
        // 准备数据
        int blockId = await database.insert('training_blocks', {
          'session_id': testSessionId,
          'action_id': 1,
          'equipment_id': 1,
          'tool_id': 1,
          'sort_order': 0,
        });

        // 执行
        Map? detail = await repository.getTrainingBlockDetail(blockId: blockId);

        // 验证
        expect(detail, isNotNull);
        expect(detail!['id'], blockId);
        expect(detail['action_name'], '动作1');
        expect(detail['equipment_name'], '器械1');
        expect(detail['tool_name'], '工具1');
      });

      test('查询不存在的训练块应返回null', () async {
        // 执行
        Map? detail = await repository.getTrainingBlockDetail(blockId: 99999);

        // 验证
        expect(detail, isNull);
      });
    });
  });
}

/// 辅助函数：创建表
Future<void> _createTables(Database db) async {
  await db.execute('''
    CREATE TABLE sessions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      course_plan_id INTEGER NOT NULL,
      session_number INTEGER NOT NULL,
      scheduled_time TEXT,
      status TEXT NOT NULL DEFAULT 'pending',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''');

  await db.execute('''
    CREATE TABLE training_blocks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      session_id INTEGER NOT NULL,
      action_id INTEGER,
      equipment_id INTEGER,
      tool_id INTEGER,
      reps TEXT,
      sets TEXT,
      duration TEXT,
      intensity TEXT,
      notes TEXT,
      is_custom INTEGER NOT NULL DEFAULT 0,
      sort_order INTEGER NOT NULL DEFAULT 0,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (session_id) REFERENCES sessions(id) ON DELETE CASCADE
    )
  ''');

  await db.execute('''
    CREATE TABLE actions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE
    )
  ''');

  await db.execute('''
    CREATE TABLE equipments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE
    )
  ''');

  await db.execute('''
    CREATE TABLE tools (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE
    )
  ''');

  await db.execute('CREATE INDEX idx_training_blocks_session ON training_blocks(session_id)');
}

/// 辅助函数：插入测试数据
Future<void> _insertTestData(Database db) async {
  await db.insert('sessions', {
    'course_plan_id': 1,
    'session_number': 1,
    'status': 'pending',
  });

  await db.insert('actions', {'name': '动作1'});
  await db.insert('actions', {'name': '动作2'});
  await db.insert('actions', {'name': '动作3'});

  await db.insert('equipments', {'name': '器械1'});
  await db.insert('equipments', {'name': '器械2'});

  await db.insert('tools', {'name': '工具1'});
  await db.insert('tools', {'name': '工具2'});
}
