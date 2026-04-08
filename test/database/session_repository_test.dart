import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:student_manager/database/session_repository.dart';

/// SessionRepository 单元测试
void main() {
  sqfliteFfiInit();

  group('SessionRepository 测试', () {
    late Database database;
    late SessionRepository repository;
    int testPlanId = 1;

    setUpAll(() async {
      database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      await database.execute('PRAGMA foreign_keys = ON');
      await _createTables(database);
      await _insertTestData(database);

      repository = SessionRepository(database: database);
    });

    tearDownAll(() async {
      await database.close();
    });

    group('addSession 测试', () {
      test('添加第1节课时，序号应为1', () async {
        // 清空现有数据
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);

        // 执行
        int sessionId = await repository.addSession(planId: testPlanId);

        // 验证
        List<Map> sessions = await database.query(
          'sessions',
          where: 'id = ?',
          whereArgs: [sessionId],
        );

        expect(sessions.length, 1);
        expect(sessions.first['session_number'], 1);
        expect(sessions.first['course_plan_id'], testPlanId);
        expect(sessions.first['status'], 'pending');
        expect(sessions.first['scheduled_time'], null);
      });

      test('在已有3节课时后添加，新课时序号应为4', () async {
        // 准备数据：创建3节课时
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': 1, 'status': 'pending', 'scheduled_time': null});
        await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': 2, 'status': 'pending', 'scheduled_time': null});
        await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': 3, 'status': 'pending', 'scheduled_time': null});

        // 执行
        int sessionId = await repository.addSession(planId: testPlanId);

        // 验证
        List<Map> session = await database.query(
          'sessions',
          where: 'id = ?',
          whereArgs: [sessionId],
        );

        expect(session.first['session_number'], 4);

        // 验证总课时数为4
        List<Map> allSessions = await database.query(
          'sessions',
          where: 'course_plan_id = ?',
          whereArgs: [testPlanId],
        );

        expect(allSessions.length, 4);
      });

      test('批量添加5节课时，序号应连续', () async {
        // 清空数据
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);

        // 执行
        List<int> sessionIds = await repository.addSessionsBatch(
          planId: testPlanId,
          count: 5,
        );

        // 验证
        expect(sessionIds.length, 5);

        // 验证序号连续
        List<Map> sessions = await database.query(
          'sessions',
          where: 'course_plan_id = ?',
          whereArgs: [testPlanId],
          orderBy: 'session_number ASC',
        );

        expect(sessions.length, 5);

        List<int> numbers = sessions.map((s) => s['session_number'] as int).toList();
        expect(numbers, [1, 2, 3, 4, 5]);
      });
    });

    group('updateSession 测试', () {
      test('更新上课时间和状态', () async {
        // 准备数据
        int sessionId = await database.insert(
          'sessions',
          {
            'course_plan_id': testPlanId,
            'session_number': 1,
            'status': 'pending',
            'scheduled_time': null,
          },
        );

        // 执行
        int count = await repository.updateSession(
          sessionId: sessionId,
          scheduledTime: '2025-01-15T10:00:00Z',
          status: 'completed',
        );

        // 验证
        expect(count, 1);

        List<Map> sessions = await database.query(
          'sessions',
          where: 'id = ?',
          whereArgs: [sessionId],
        );

        expect(sessions.first['scheduled_time'], '2025-01-15T10:00:00Z');
        expect(sessions.first['status'], 'completed');
      });

      test('只更新时间，不更新状态', () async {
        // 准备数据
        int sessionId = await database.insert(
          'sessions',
          {
            'course_plan_id': testPlanId,
            'session_number': 1,
            'status': 'pending',
            'scheduled_time': null,
          },
        );

        // 执行：只更新时间
        await repository.updateSession(
          sessionId: sessionId,
          scheduledTime: '2025-01-20T14:00:00Z',
        );

        // 验证
        List<Map> sessions = await database.query(
          'sessions',
          where: 'id = ?',
          whereArgs: [sessionId],
        );

        expect(sessions.first['scheduled_time'], '2025-01-20T14:00:00Z');
        expect(sessions.first['status'], 'pending'); // 状态未变
      });

      test('传入无效状态应抛出异常', () async {
        // 准备数据
        int sessionId = await database.insert(
          'sessions',
          {
            'course_plan_id': testPlanId,
            'session_number': 1,
            'status': 'pending',
            'scheduled_time': null,
          },
        );

        // 执行并验证
        expect(
          () => repository.updateSession(
            sessionId: sessionId,
            status: 'invalid_status',
          ),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('更新不存在课时应返回0', () async {
        // 执行
        int count = await repository.updateSession(
          sessionId: 99999,
          status: 'completed',
        );

        // 验证
        expect(count, 0);
      });
    });

    group('insertSessionAt 测试', () {
      test('在位置1插入新课时，原有课时应后移', () async {
        // 准备数据
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': 1, 'status': 'pending', 'scheduled_time': null});
        await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': 2, 'status': 'pending', 'scheduled_time': null});

        // 执行：在位置1插入
        int sessionId = await repository.insertSessionAt(
          planId: testPlanId,
          position: 1,
        );

        // 验证
        List<Map> sessions = await database.query(
          'sessions',
          where: 'course_plan_id = ?',
          whereArgs: [testPlanId],
          orderBy: 'session_number ASC',
        );

        expect(sessions.length, 3);
        expect(sessions[0]['id'], sessionId);
        expect(sessions[0]['session_number'], 1);
        expect(sessions[1]['session_number'], 2); // 原课时1变为2
        expect(sessions[2]['session_number'], 3); // 原课时2变为3
      });

      test('在中间位置插入新课时', () async {
        // 准备数据：已有5节课时
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        for (int i = 1; i <= 5; i++) {
          await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': i, 'status': 'pending', 'scheduled_time': null});
        }

        // 执行：在位置3插入
        int sessionId = await repository.insertSessionAt(
          planId: testPlanId,
          position: 3,
        );

        // 验证
        List<Map> sessions = await database.query(
          'sessions',
          where: 'course_plan_id = ?',
          whereArgs: [testPlanId],
          orderBy: 'session_number ASC',
        );

        expect(sessions.length, 6);
        expect(sessions[0]['session_number'], 1);
        expect(sessions[1]['session_number'], 2);
        expect(sessions[2]['id'], sessionId); // 新插入的课时
        expect(sessions[2]['session_number'], 3);
        expect(sessions[3]['session_number'], 4); // 原课时3变为4
        expect(sessions[4]['session_number'], 5); // 原课时4变为5
        expect(sessions[5]['session_number'], 6); // 原课时5变为6
      });

      test('在末尾插入新课时', () async {
        // 准备数据
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        for (int i = 1; i <= 3; i++) {
          await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': i, 'status': 'pending', 'scheduled_time': null});
        }

        // 执行：在位置4（末尾）插入
        int sessionId = await repository.insertSessionAt(
          planId: testPlanId,
          position: 4,
        );

        // 验证
        List<Map> sessions = await database.query(
          'sessions',
          where: 'course_plan_id = ?',
          whereArgs: [testPlanId],
          orderBy: 'session_number ASC',
        );

        expect(sessions.length, 4);
        expect(sessions[3]['id'], sessionId);
        expect(sessions[3]['session_number'], 4);
      });

      test('位置超出范围应抛出异常', () async {
        // 准备数据
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': 1, 'status': 'pending', 'scheduled_time': null});

        // 执行并验证：尝试在位置10插入（超出范围）
        expect(
          () => repository.insertSessionAt(
            planId: testPlanId,
            position: 10,
          ),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('moveSession 测试', () {
      test('向前移动课时（从位置5移到位置2）', () async {
        // 准备数据：5节课时
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        List<int> sessionIds = [];
        for (int i = 1; i <= 5; i++) {
          int id = await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': i, 'status': 'pending', 'scheduled_time': null});
          sessionIds.add(id);
        }

        // 执行：将第5节课时移到位置2
        await repository.moveSession(
          sessionId: sessionIds[4],
          newPosition: 2,
        );

        // 验证
        List<Map> sessions = await database.query(
          'sessions',
          where: 'course_plan_id = ?',
          whereArgs: [testPlanId],
          orderBy: 'session_number ASC',
        );

        expect(sessions.length, 5);
        expect(sessions[0]['id'], sessionIds[0]); // 位置1不变
        expect(sessions[1]['id'], sessionIds[4]); // 位置2是原来的5
        expect(sessions[2]['id'], sessionIds[1]); // 位置3是原来的2
        expect(sessions[3]['id'], sessionIds[2]); // 位置4是原来的3
        expect(sessions[4]['id'], sessionIds[3]); // 位置5是原来的4
      });

      test('向后移动课时（从位置2移到位置4）', () async {
        // 准备数据：5节课时
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        List<int> sessionIds = [];
        for (int i = 1; i <= 5; i++) {
          int id = await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': i, 'status': 'pending', 'scheduled_time': null});
          sessionIds.add(id);
        }

        // 执行：将第2节课时移到位置4
        await repository.moveSession(
          sessionId: sessionIds[1],
          newPosition: 4,
        );

        // 验证
        List<Map> sessions = await database.query(
          'sessions',
          where: 'course_plan_id = ?',
          whereArgs: [testPlanId],
          orderBy: 'session_number ASC',
        );

        expect(sessions.length, 5);
        expect(sessions[0]['id'], sessionIds[0]); // 位置1不变
        expect(sessions[1]['id'], sessionIds[2]); // 位置2是原来的3
        expect(sessions[2]['id'], sessionIds[3]); // 位置3是原来的4
        expect(sessions[3]['id'], sessionIds[1]); // 位置4是原来的2
        expect(sessions[4]['id'], sessionIds[4]); // 位置5不变
      });

      test('移动到相同位置应无变化', () async {
        // 准备数据
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        int sessionId = await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': 1, 'status': 'pending', 'scheduled_time': null});

        // 执行：移动到位置1（相同位置）
        int resultId = await repository.moveSession(
          sessionId: sessionId,
          newPosition: 1,
        );

        // 验证
        expect(resultId, sessionId);

        List<Map> sessions = await database.query(
          'sessions',
          where: 'id = ?',
          whereArgs: [sessionId],
        );

        expect(sessions.first['session_number'], 1);
      });
    });

    group('deleteSession 测试', () {
      test('删除中间课时，后续课时应自动重新编号', () async {
        // 准备数据：5节课时
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        List<int> sessionIds = [];
        for (int i = 1; i <= 5; i++) {
          int id = await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': i, 'status': 'pending', 'scheduled_time': null});
          sessionIds.add(id);
        }

        // 执行：删除第3节课时
        int deletedNumber = await repository.deleteSession(
          sessionId: sessionIds[2],
        );

        // 验证
        expect(deletedNumber, 3);

        List<Map> sessions = await database.query(
          'sessions',
          where: 'course_plan_id = ?',
          whereArgs: [testPlanId],
          orderBy: 'session_number ASC',
        );

        expect(sessions.length, 4);
        expect(sessions[0]['id'], sessionIds[0]);
        expect(sessions[0]['session_number'], 1);
        expect(sessions[1]['id'], sessionIds[1]);
        expect(sessions[1]['session_number'], 2);
        expect(sessions[2]['id'], sessionIds[3]); // 原课时4变为3
        expect(sessions[2]['session_number'], 3);
        expect(sessions[3]['id'], sessionIds[4]); // 原课时5变为4
        expect(sessions[3]['session_number'], 4);
      });

      test('删除最后一节课时', () async {
        // 准备数据
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        List<int> sessionIds = [];
        for (int i = 1; i <= 3; i++) {
          int id = await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': i, 'status': 'pending', 'scheduled_time': null});
          sessionIds.add(id);
        }

        // 执行：删除第3节课时（最后一节）
        await repository.deleteSession(sessionId: sessionIds[2]);

        // 验证
        List<Map> sessions = await database.query(
          'sessions',
          where: 'course_plan_id = ?',
          whereArgs: [testPlanId],
          orderBy: 'session_number ASC',
        );

        expect(sessions.length, 2);
        expect(sessions[0]['session_number'], 1);
        expect(sessions[1]['session_number'], 2);
      });

      test('删除第一节课时', () async {
        // 准备数据
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        List<int> sessionIds = [];
        for (int i = 1; i <= 3; i++) {
          int id = await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': i, 'status': 'pending', 'scheduled_time': null});
          sessionIds.add(id);
        }

        // 执行：删除第1节课时
        await repository.deleteSession(sessionId: sessionIds[0]);

        // 验证
        List<Map> sessions = await database.query(
          'sessions',
          where: 'course_plan_id = ?',
 whereArgs: [testPlanId],
          orderBy: 'session_number ASC',
        );

        expect(sessions.length, 2);
        expect(sessions[0]['id'], sessionIds[1]);
        expect(sessions[0]['session_number'], 1); // 原课时2变为1
        expect(sessions[1]['id'], sessionIds[2]);
        expect(sessions[1]['session_number'], 2); // 原课时3变为2
      });

      test('删除不存在的课时应抛出异常', () async {
        // 执行并验证
        expect(
          () => repository.deleteSession(sessionId: 99999),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('查询功能测试', () {
      test('查询课程规划的所有课时', () async {
        // 准备数据
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        for (int i = 1; i <= 3; i++) {
          await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': i, 'status': i == 1 ? 'completed' : 'pending', 'scheduled_time': null});
        }

        // 执行
        List<Map> sessions = await repository.getSessionsByPlanId(planId: testPlanId);

        // 验证
        expect(sessions.length, 3);
        expect(sessions[0]['session_number'], 1);
        expect(sessions[1]['session_number'], 2);
        expect(sessions[2]['session_number'], 3);
      });

      test('查询课时详情（含训练块）', () async {
        // 准备数据
        await database.delete('sessions', where: 'course_plan_id = ?', whereArgs: [testPlanId]);
        int sessionId = await database.insert('sessions', {'course_plan_id': testPlanId, 'session_number': 1, 'status': 'pending', 'scheduled_time': null});

        // 插入训练块
        await database.insert('training_blocks', {
          'session_id': sessionId,
          'action_id': null,
          'equipment_id': null,
          'tool_id': null,
          'reps': '12',
          'sets': '3',
          'is_custom': 0,
          'sort_order': 0,
        });

        // 执行
        Map? detail = await repository.getSessionDetail(sessionId: sessionId);

        // 验证
        expect(detail, isNotNull);
        expect(detail!['id'], sessionId);
        expect(detail['training_blocks'], isNotEmpty);
        expect(detail['training_blocks'].length, 1);
      });

      test('查询不存在的课时应返回null', () async {
        // 执行
        Map? detail = await repository.getSessionDetail(sessionId: 99999);

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
      status TEXT NOT NULL DEFAULT 'pending' CHECK(status IN ('pending', 'completed', 'skipped')),
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (course_plan_id) REFERENCES course_plans(id) ON DELETE CASCADE,
      UNIQUE(course_plan_id, session_number)
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
    CREATE TABLE course_plans (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      student_id INTEGER NOT NULL,
      goal TEXT NOT NULL,
      blueprint TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''');

  await db.execute('CREATE INDEX idx_sessions_course_plan ON sessions(course_plan_id)');
  await db.execute('CREATE INDEX idx_training_blocks_session ON training_blocks(session_id)');
}

/// 辅助函数：插入测试数据
Future<void> _insertTestData(Database db) async {
  await db.insert('course_plans', {
    'student_id': 1,
    'goal': '测试目标',
    'blueprint': '测试蓝图',
  });
}
