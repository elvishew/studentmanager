import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'course_plan_repository.dart';

/// createCoursePlan 函数使用示例
class CoursePlanRepositoryExample {
  static Future<Database> initDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'student_manager.db');
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        // 执行 schema.sql 中的建表语句
        // 实际项目中建议将 schema 放在单独的文件中
        await db.execute('PRAGMA foreign_keys = ON');

        // 创建基础数据表
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

        // 创建核心业务表
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

        // 创建默认配置表
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

        // 插入初始数据
        await db.execute("INSERT INTO actions (name) VALUES ('宽蹲'), ('侧弓步蹲'), ('侧蹬腿'), ('站姿弓步（一）'), ('站姿弓步（二）'), ('站姿弓步（三）')");
        await db.execute("INSERT INTO equipments (name) VALUES ('核心床（Reformer）'), ('凯迪拉克床（Cadillac）'), ('稳踏椅（Chair）'), ('梯桶（Ladder Barrel）'), ('ARC')");
        await db.execute("INSERT INTO tools (name) VALUES ('盒子'), ('小球'), ('弹力带'), ('普拉提环'), ('泡沫轴'), ('瑜伽砖')");
      },
    );
  }

  /// 示例1：创建一个课程规划
  static Future<void> example1() async {
    final db = await initDatabase();
    final repository = CoursePlanRepository(database: db);

    // 假设学员ID为1
    int studentId = 1;
    String goal = '产后修复';

    // 创建课程规划
    int coursePlanId = await repository.createCoursePlan(
      studentId: studentId,
      goal: goal,
    );

    print('创建课程规划成功，ID: $coursePlanId');
    await db.close();
  }

  /// 示例2：创建自定义目标的课程规划（不使用默认配置）
  static Future<void> example2() async {
    final db = await initDatabase();
    final repository = CoursePlanRepository(database: db);

    int coursePlanId = await repository.createCoursePlan(
      studentId: 1,
      goal: '自定义',
    );

    print('创建自定义课程规划成功，ID: $coursePlanId');
    await db.close();
  }

  /// 示例3：验证创建的课程规划数据
  static Future<void> example3() async {
    final db = await initDatabase();
    final repository = CoursePlanRepository(database: db);

    // 创建课程规划
    int coursePlanId = await repository.createCoursePlan(
      studentId: 1,
      goal: '产后修复',
    );

    // 查询课程规划
    List<Map> coursePlan = await db.query(
      'course_plans',
      where: 'id = ?',
      whereArgs: [coursePlanId],
    );
    print('课程规划: $coursePlan');

    // 查询课时数量
    List<Map> sessionCount = await db.rawQuery('''
      SELECT COUNT(*) as count FROM sessions WHERE course_plan_id = ?
    ''', [coursePlanId]);
    print('课时数量: ${sessionCount.first['count']}');

    // 查询第一个课时的训练块
    List<Map> sessions = await db.query(
      'sessions',
      where: 'course_plan_id = ?',
      whereArgs: [coursePlanId],
      orderBy: 'session_number ASC',
      limit: 1,
    );

    if (sessions.isNotEmpty) {
      int sessionId = sessions.first['id'];
      List<Map> trainingBlocks = await db.query(
        'training_blocks',
        where: 'session_id = ?',
        whereArgs: [sessionId],
        orderBy: 'sort_order ASC',
      );
      print('第1节课的训练块数量: ${trainingBlocks.length}');
    }

    await db.close();
  }

  /// 示例4：批量创建课程规划
  static Future<void> example4() async {
    final db = await initDatabase();
    final repository = CoursePlanRepository(database: db);

    List<int> coursePlanIds = await repository.createCoursePlansBatch(
      plans: [
        {'student_id': 1, 'goal': '产后修复'},
        {'student_id': 1, 'goal': '肩颈理疗'},
        {'student_id': 2, 'goal': '腰腹塑形'},
      ],
    );

    print('批量创建课程规划成功，IDs: $coursePlanIds');
    await db.close();
  }

  /// 示例5：完整的使用流程（包含创建学员）
  static Future<void> example5() async {
    final db = await initDatabase();
    final repository = CoursePlanRepository(database: db);

    // 步骤1：创建学员
    int studentId = await db.insert('students', {
      'name': '张三',
      'gender': '女',
      'contact': '13800138000',
      'notes': '产后2个月，需要修复',
    });

    print('创建学员成功，ID: $studentId');

    // 步骤2：创建课程规划
    int coursePlanId = await repository.createCoursePlan(
      studentId: studentId,
      goal: '产后修复',
    );

    print('创建课程规划成功，ID: $coursePlanId');

    // 步骤3：查询完整的课程规划数据
    var result = await db.rawQuery('''
      SELECT
        cp.id as course_plan_id,
        cp.goal,
        cp.blueprint,
        s.name as student_name,
        (SELECT COUNT(*) FROM sessions WHERE course_plan_id = cp.id) as session_count
      FROM course_plans cp
      JOIN students s ON cp.student_id = s.id
      WHERE cp.id = ?
    ''', [coursePlanId]);

    print('课程规划详情: ${result.first}');

    await db.close();
  }
}

/// 在 main 函数中运行示例
void main() async {
  // 确保Flutter绑定初始化
  // WidgetsFlutterBinding.ensureInitialized();

  // 运行示例
  await CoursePlanRepositoryExample.example1();
  await CoursePlanRepositoryExample.example2();
  await CoursePlanRepositoryExample.example3();
  await CoursePlanRepositoryExample.example4();
  await CoursePlanRepositoryExample.example5();
}
