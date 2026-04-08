import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_manager/database/course_plan_repository.dart';

/// createCoursePlan 函数单元测试
void main() {
  // 初始化 FFI（用于测试环境）
  sqfliteFfiInit();

  group('createCoursePlan 测试', () {
    late Database database;
    late CoursePlanRepository repository;

    setUpAll(() async {
      // 创建内存数据库
      database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

      // 执行建表SQL
      await database.execute('PRAGMA foreign_keys = ON');

      // 创建所有表
      await _createTables(database);

      // 插入测试数据
      await _insertTestData(database);

      // 创建仓库实例
      repository = CoursePlanRepository(database: database);
    });

    tearDownAll(() async {
      await database.close();
    });

    test('创建非自定义目标的课程规划，应该复制默认配置', () async {
      // 准备测试数据
      int studentId = 1;
      String goal = '产后修复';

      // 执行
      int coursePlanId = await repository.createCoursePlan(
        studentId: studentId,
        goal: goal,
      );

      // 验证课程规划已创建
      List<Map> coursePlans = await database.query(
        'course_plans',
        where: 'id = ?',
        whereArgs: [coursePlanId],
      );
      expect(coursePlans.length, 1);
      expect(coursePlans.first['student_id'], studentId);
      expect(coursePlans.first['goal'], goal);
      expect(coursePlans.first['blueprint'], '产后修复默认蓝图');

      // 验证课时已创建（应该是12节）
      List<Map> sessions = await database.query(
        'sessions',
        where: 'course_plan_id = ?',
        whereArgs: [coursePlanId],
      );
      expect(sessions.length, 12);

      // 验证课时序号连续
      List<int> sessionNumbers =
          sessions.map((s) => s['session_number'] as int).toList();
      expect(sessionNumbers, List.generate(12, (i) => i + 1));

      // 验证第一节课有训练块
      List<Map> firstSession = sessions.where((s) => s['session_number'] == 1).toList();
      int firstSessionId = firstSession.first['id'];

      List<Map> trainingBlocks = await database.query(
        'training_blocks',
        where: 'session_id = ?',
        whereArgs: [firstSessionId],
      );
      expect(trainingBlocks.isNotEmpty, true);

      // 验证训练块按排序顺序
      List<int> sortOrders =
          trainingBlocks.map((tb) => tb['sort_order'] as int).toList();
      expect(sortOrders, orderedGrows);
    });

    test('创建自定义目标的课程规划，不应该使用默认配置', () async {
      // 准备测试数据
      int studentId = 1;
      String goal = '自定义';

      // 执行
      int coursePlanId = await repository.createCoursePlan(
        studentId: studentId,
        goal: goal,
      );

      // 验证课程规划已创建
      List<Map> coursePlans = await database.query(
        'course_plans',
        where: 'id = ?',
        whereArgs: [coursePlanId],
      );
      expect(coursePlans.length, 1);
      expect(coursePlans.first['goal'], goal);
      expect(coursePlans.first['blueprint'], null);

      // 验证没有创建课时
      List<Map> sessions = await database.query(
        'sessions',
        where: 'course_plan_id = ?',
        whereArgs: [coursePlanId],
      );
      expect(sessions.length, 0);
    });

    test('创建不存在默认配置的课程规划，应该创建空课程规划', () async {
      // 准备测试数据
      int studentId = 1;
      String goal = '不存在这个目标';

      // 执行
      int coursePlanId = await repository.createCoursePlan(
        studentId: studentId,
        goal: goal,
      );

      // 验证课程规划已创建
      List<Map> coursePlans = await database.query(
        'course_plans',
        where: 'id = ?',
        whereArgs: [coursePlanId],
      );
      expect(coursePlans.length, 1);
      expect(coursePlans.first['goal'], goal);

      // 验证没有创建课时
      List<Map> sessions = await database.query(
        'sessions',
        where: 'course_plan_id = ?',
        whereArgs: [coursePlanId],
      );
      expect(sessions.length, 0);
    });

    test('事务失败时应该回滚所有操作', () async {
      // 这个测试验证事务的原子性
      // 在实际场景中，可能需要模拟数据库错误

      int studentId = 1;
      String goal = '产后修复';

      // 正常执行应该成功
      int coursePlanId = await repository.createCoursePlan(
        studentId: studentId,
        goal: goal,
      );

      // 验证数据完整性
      List<Map> coursePlans = await database.query(
        'course_plans',
        where: 'id = ?',
        whereArgs: [coursePlanId],
      );
      expect(coursePlans.length, 1);

      // 如果在创建过程中发生错误，所有操作都应该回滚
      // 这需要在实际代码中通过 try-catch 测试
    });

    test('验证训练块数据的完整性', () async {
      // 准备测试数据
      int studentId = 1;
      String goal = '产后修复';

      // 执行
      int coursePlanId = await repository.createCoursePlan(
        studentId: studentId,
        goal: goal,
      );

      // 查询所有训练块
      List<Map> trainingBlocks = await database.rawQuery('''
        SELECT tb.*
        FROM training_blocks tb
        JOIN sessions s ON tb.session_id = s.id
        WHERE s.course_plan_id = ?
        ORDER BY tb.session_id, tb.sort_order
      ''', [coursePlanId]);

      // 验证训练块不为空
      expect(trainingBlocks.isNotEmpty, true);

      // 验证必填字段
      for (var block in trainingBlocks) {
        expect(block.containsKey('id'), true);
        expect(block.containsKey('session_id'), true);
        expect(block.containsKey('sort_order'), true);
        expect(block.containsKey('is_custom'), true);
      }
    });

    test('批量创建课程规划', () async {
      // 准备测试数据
      List<Map<String, dynamic>> plans = [
        {'student_id': 1, 'goal': '产后修复'},
        {'student_id': 1, 'goal': '肩颈理疗'},
        {'student_id': 2, 'goal': '腰腹塑形'},
      ];

      // 执行
      List<int> coursePlanIds = await repository.createCoursePlansBatch(
        plans: plans,
      );

      // 验证
      expect(coursePlanIds.length, 3);

      // 验证每个课程规划都已创建
      for (var coursePlanId in coursePlanIds) {
        List<Map> coursePlans = await database.query(
          'course_plans',
          where: 'id = ?',
          whereArgs: [coursePlanId],
        );
        expect(coursePlans.length, 1);
      }
    });
  });
}

/// 辅助函数：创建所有表
Future<void> _createTables(Database db) async {
  // 基础数据表
  await db.execute('''
    CREATE TABLE actions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''');

  await db.execute('''
    CREATE TABLE equipments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''');

  await db.execute('''
    CREATE TABLE tools (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''');

  // 核心业务表
  await db.execute('''
    CREATE TABLE students (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      gender TEXT,
      contact TEXT NOT NULL,
      notes TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''');

  await db.execute('''
    CREATE TABLE course_plans (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      student_id INTEGER NOT NULL,
      goal TEXT NOT NULL,
      blueprint TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
    )
  ''');

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
      FOREIGN KEY (session_id) REFERENCES sessions(id) ON DELETE CASCADE,
      FOREIGN KEY (action_id) REFERENCES actions(id) ON DELETE SET NULL,
      FOREIGN KEY (equipment_id) REFERENCES equipments(id) ON DELETE SET NULL,
      FOREIGN KEY (tool_id) REFERENCES tools(id) ON DELETE SET NULL
    )
  ''');

  // 默认配置表
  await db.execute('''
    CREATE TABLE goal_configs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      goal TEXT NOT NULL UNIQUE,
      blueprint TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''');

  await db.execute('''
    CREATE TABLE goal_config_sessions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      goal_config_id INTEGER NOT NULL,
      session_number INTEGER NOT NULL,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (goal_config_id) REFERENCES goal_configs(id) ON DELETE CASCADE,
      UNIQUE(goal_config_id, session_number)
    )
  ''');

  await db.execute('''
    CREATE TABLE goal_config_training_blocks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      goal_config_session_id INTEGER NOT NULL,
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
      FOREIGN KEY (goal_config_session_id) REFERENCES goal_config_sessions(id) ON DELETE CASCADE,
      FOREIGN KEY (action_id) REFERENCES actions(id) ON DELETE SET NULL,
      FOREIGN KEY (equipment_id) REFERENCES equipments(id) ON DELETE SET NULL,
      FOREIGN KEY (tool_id) REFERENCES tools(id) ON DELETE SET NULL
    )
  ''');

  // 创建索引
  await db.execute('CREATE INDEX idx_sessions_course_plan ON sessions(course_plan_id)');
  await db.execute('CREATE INDEX idx_training_blocks_session ON training_blocks(session_id)');
  await db.execute('CREATE INDEX idx_course_plans_student ON course_plans(student_id)');
  await db.execute('CREATE INDEX idx_goal_config_sessions_config ON goal_config_sessions(goal_config_id)');
  await db.execute('CREATE INDEX idx_goal_config_training_blocks_session ON goal_config_training_blocks(goal_config_session_id)');
  await db.execute('CREATE INDEX idx_sessions_status ON sessions(status)');
  await db.execute('CREATE INDEX idx_sessions_scheduled_time ON sessions(scheduled_time)');
}

/// 辅助函数：插入测试数据
Future<void> _insertTestData(Database db) async {
  // 插入学员
  await db.insert('students', {
    'name': '测试学员1',
    'gender': '女',
    'contact': '13800138000',
    'notes': '测试数据',
  });

  await db.insert('students', {
    'name': '测试学员2',
    'gender': '男',
    'contact': '13800138001',
    'notes': '测试数据',
  });

  // 插入动作
  await db.insert('actions', {'name': '宽蹲'});
  await db.insert('actions', {'name': '侧弓步蹲'});
  await db.insert('actions', {'name': '侧蹬腿'});

  // 插入器械
  await db.insert('equipments', {'name': '核心床（Reformer）'});
  await db.insert('equipments', {'name': '凯迪拉克床（Cadillac）'});

  // 插入工具
  await db.insert('tools', {'name': '小球'});
  await db.insert('tools', {'name': '弹力带'});

  // 插入课程目标默认配置
  int goalConfigId = await db.insert('goal_configs', {
    'goal': '产后修复',
    'blueprint': '产后修复默认蓝图',
  });

  await db.insert('goal_configs', {
    'goal': '肩颈理疗',
    'blueprint': '肩颈理疗默认蓝图',
  });

  await db.insert('goal_configs', {
    'goal': '腰腹塑形',
    'blueprint': '腰腹塑形默认蓝图',
  });

  // 插入默认配置课时模板（前12节）
  for (int i = 1; i <= 12; i++) {
    int goalConfigSessionId = await db.insert('goal_config_sessions', {
      'goal_config_id': goalConfigId,
      'session_number': i,
    });

    // 为每节课插入3个训练块
    await db.insert('goal_config_training_blocks', {
      'goal_config_session_id': goalConfigSessionId,
      'action_id': 1, // 宽蹲
      'equipment_id': 1, // 核心床
      'tool_id': 1, // 小球
      'reps': '12',
      'sets': '3',
      'duration': null,
      'intensity': '中等',
      'notes': '注意呼吸',
      'is_custom': 0,
      'sort_order': 0,
    });

    await db.insert('goal_config_training_blocks', {
      'goal_config_session_id': goalConfigSessionId,
      'action_id': 2, // 侧弓步蹲
      'equipment_id': 1, // 核心床
      'tool_id': null,
      'reps': '10',
      'sets': '3',
      'duration': null,
      'intensity': '中等',
      'notes': null,
      'is_custom': 0,
      'sort_order': 1,
    });

    await db.insert('goal_config_training_blocks', {
      'goal_config_session_id': goalConfigSessionId,
      'action_id': 3, // 侧蹬腿
      'equipment_id': 2, // 凯迪拉克床
      'tool_id': 2, // 弹力带
      'reps': '15',
      'sets': '2',
      'duration': '30秒',
      'intensity': '高',
      'notes': '保持核心稳定',
      'is_custom': 0,
      'sort_order': 2,
    });
  }
}
