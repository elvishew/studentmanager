import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'pages/student_list_page.dart';
import 'providers/student_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化数据库
  final database = await _initDatabase();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
      ],
      child: const MyApp(),
    ),
  );
}

/// 初始化数据库
Future<Database> _initDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'student_manager.db');

  // 删除旧数据库（开发阶段可选）
  // await deleteDatabase(path);

  final database = await openDatabase(
    path,
    version: 4,
    onCreate: (db, version) async {
      await db.execute('PRAGMA foreign_keys = ON');

      // 创建学员表
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

      // 创建课程规划表
      await db.execute('''
        CREATE TABLE course_plans (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          student_id INTEGER NOT NULL,
          goal_id INTEGER NOT NULL,
          blueprint TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
          FOREIGN KEY (goal_id) REFERENCES course_goals(id)
        )
      ''');

      // 创建课时表
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

      // 创建训练块表
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
          sort_order INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (session_id) REFERENCES sessions(id) ON DELETE CASCADE
        )
      ''');

      // 创建动作表
      await db.execute('''
        CREATE TABLE actions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE,
          is_deprecated INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // 创建器械表
      await db.execute('''
        CREATE TABLE equipments (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE,
          is_deprecated INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // 创建工具表
      await db.execute('''
        CREATE TABLE tools (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE,
          is_deprecated INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // 创建课程目标默认配置表
      await db.execute('''
        CREATE TABLE goal_configs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          goal_id INTEGER NOT NULL UNIQUE,
          blueprint TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (goal_id) REFERENCES course_goals(id)
        )
      ''');

      // 创建课程目标表
      await db.execute('''
        CREATE TABLE course_goals (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE,
          is_deprecated INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // 创建默认配置课时模板表
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

      // 创建默认配置训练块模板表
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
          sort_order INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (goal_config_session_id) REFERENCES goal_config_sessions(id) ON DELETE CASCADE
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

      // 插入初始数据
      await _insertInitialData(db);
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // 添加is_deprecated字段
        await db.execute('ALTER TABLE actions ADD COLUMN is_deprecated INTEGER NOT NULL DEFAULT 0');
        await db.execute('ALTER TABLE equipments ADD COLUMN is_deprecated INTEGER NOT NULL DEFAULT 0');
        await db.execute('ALTER TABLE tools ADD COLUMN is_deprecated INTEGER NOT NULL DEFAULT 0');
      }
      if (oldVersion < 3) {
        // 创建课程目标表并插入初始数据
        await db.execute('''
          CREATE TABLE course_goals (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE,
            is_deprecated INTEGER NOT NULL DEFAULT 0,
            is_custom INTEGER NOT NULL DEFAULT 0,
            created_at TEXT DEFAULT CURRENT_TIMESTAMP,
            updated_at TEXT DEFAULT CURRENT_TIMESTAMP
          )
        ''');
        await _insertInitialGoals(db);
      }
      if (oldVersion < 4) {
        // v3→v4：goal TEXT → goal_id INTEGER 外键引用
        // 1. course_plans 添加 goal_id
        await db.execute('ALTER TABLE course_plans ADD COLUMN goal_id INTEGER');
        await db.execute('UPDATE course_plans SET goal_id = (SELECT id FROM course_goals WHERE name = course_plans.goal)');

        // 2. goal_configs 添加 goal_id
        await db.execute('ALTER TABLE goal_configs ADD COLUMN goal_id INTEGER');
        await db.execute('UPDATE goal_configs SET goal_id = (SELECT id FROM course_goals WHERE name = goal_configs.goal)');

        // 3. 删除"自定义"目标行
        await db.execute('DELETE FROM course_goals WHERE is_custom = 1');

        // 4. 旧 TEXT 列保留不删（SQLite < 3.35 不支持 DROP COLUMN），代码不再使用
      }
    },
  );

  return database;
}

/// 插入初始数据
Future<void> _insertInitialData(Database db) async {
  // 插入默认动作
  await db.insert('actions', {'name': '宽蹲'});
  await db.insert('actions', {'name': '侧弓步蹲'});
  await db.insert('actions', {'name': '侧蹬腿'});
  await db.insert('actions', {'name': '站姿弓步（一）'});
  await db.insert('actions', {'name': '站姿弓步（二）'});
  await db.insert('actions', {'name': '站姿弓步（三）'});

  // 插入默认器械
  await db.insert('equipments', {'name': '核心床（Reformer）'});
  await db.insert('equipments', {'name': '凯迪拉克床（Cadillac）'});
  await db.insert('equipments', {'name': '稳踏椅（Chair）'});
  await db.insert('equipments', {'name': '梯桶（Ladder Barrel）'});
  await db.insert('equipments', {'name': 'ARC'});

  // 插入默认工具
  await db.insert('tools', {'name': '盒子'});
  await db.insert('tools', {'name': '小球'});
  await db.insert('tools', {'name': '弹力带'});
  await db.insert('tools', {'name': '普拉提环'});
  await db.insert('tools', {'name': '泡沫轴'});
  await db.insert('tools', {'name': '瑜伽砖'});

  // 插入示例学员数据（用于测试）
  await db.insert('students', {
    'name': '张三',
    'gender': '女',
    'contact': '13800138000',
    'notes': '产后2个月，需要修复',
  });

  await db.insert('students', {
    'name': '李四',
    'gender': '女',
    'contact': '13900139000',
    'notes': '肩颈不适',
  });

  // 插入默认课程目标
  await _insertInitialGoals(db);
}

/// 插入初始课程目标
Future<void> _insertInitialGoals(Database db) async {
  final goals = [
    '产后修复', '肩颈理疗', '肩背打造', '腰酸治疗',
    '腰腹塑形', '全身塑形', '臀腿打造', '膝盖疼痛',
  ];
  for (final name in goals) {
    await db.insert('course_goals', {'name': name});
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '普拉提学员管理系统',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const StudentListPage(),
    );
  }
}
