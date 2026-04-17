import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'l10n/app_localizations.dart';
import 'pages/main_shell_page.dart';
import 'pages/template_selection_page.dart';
import 'providers/student_provider.dart';
import 'utils/template_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

Future<Database> _initDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'student_manager.db');

  final database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('PRAGMA foreign_keys = ON');

      // ============================================
      // 应用设置表
      // ============================================
      await db.execute('''
        CREATE TABLE app_settings (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          key TEXT NOT NULL UNIQUE,
          value TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // ============================================
      // 内容字段定义
      // ============================================
      await db.execute('''
        CREATE TABLE content_fields (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          field_type TEXT NOT NULL CHECK(field_type IN ('select', 'number', 'text', 'multiline')),
          is_required INTEGER NOT NULL DEFAULT 0,
          sort_order INTEGER NOT NULL DEFAULT 0,
          is_deprecated INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // ============================================
      // 字段选项
      // ============================================
      await db.execute('''
        CREATE TABLE field_options (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          content_field_id INTEGER NOT NULL,
          value TEXT NOT NULL,
          is_deprecated INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (content_field_id) REFERENCES content_fields(id) ON DELETE CASCADE,
          UNIQUE(content_field_id, value)
        )
      ''');

      // ============================================
      // 学员表
      // ============================================
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

      // ============================================
      // 课程目标表
      // ============================================
      await db.execute('''
        CREATE TABLE course_goals (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE,
          is_deprecated INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // ============================================
      // 课程类型表
      // ============================================
      await db.execute('''
        CREATE TABLE course_types (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE,
          icon TEXT,
          color TEXT,
          default_duration INTEGER NOT NULL DEFAULT 60,
          is_group INTEGER NOT NULL DEFAULT 0,
          max_students INTEGER,
          default_student_price REAL NOT NULL DEFAULT 0,
          default_session_fee REAL NOT NULL DEFAULT 0,
          default_commission_type TEXT NOT NULL DEFAULT 'none' CHECK(default_commission_type IN ('none', 'fixed', 'percent')),
          default_commission_value REAL NOT NULL DEFAULT 0,
          sort_order INTEGER NOT NULL DEFAULT 0,
          is_deprecated INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // ============================================
      // 课程规划表 (移除 default_duration)
      // ============================================
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

      // ============================================
      // 课时表 (移除 scheduled_time, duration_override)
      // ============================================
      await db.execute('''
        CREATE TABLE sessions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          course_plan_id INTEGER NOT NULL,
          session_number INTEGER NOT NULL,
          status TEXT NOT NULL DEFAULT 'pending' CHECK(status IN ('pending', 'completed', 'skipped')),
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (course_plan_id) REFERENCES course_plans(id) ON DELETE CASCADE,
          UNIQUE(course_plan_id, session_number)
        )
      ''');

      // ============================================
      // 内容块
      // ============================================
      await db.execute('''
        CREATE TABLE content_blocks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          session_id INTEGER NOT NULL,
          sort_order INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (session_id) REFERENCES sessions(id) ON DELETE CASCADE
        )
      ''');

      // ============================================
      // 内容块字段值（EAV 模式）
      // ============================================
      await db.execute('''
        CREATE TABLE content_block_values (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          content_block_id INTEGER NOT NULL,
          content_field_id INTEGER NOT NULL,
          value TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (content_block_id) REFERENCES content_blocks(id) ON DELETE CASCADE,
          FOREIGN KEY (content_field_id) REFERENCES content_fields(id) ON DELETE CASCADE,
          UNIQUE(content_block_id, content_field_id)
        )
      ''');

      // ============================================
      // 排课记录表
      // ============================================
      await db.execute('''
        CREATE TABLE scheduled_classes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          course_type_id INTEGER NOT NULL,
          title TEXT,
          start_time TEXT NOT NULL,
          end_time TEXT NOT NULL,
          status TEXT NOT NULL DEFAULT 'scheduled' CHECK(status IN ('scheduled', 'completed', 'cancelled', 'no_show')),
          session_id INTEGER,
          location TEXT,
          notes TEXT,
          teacher_session_fee REAL NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (course_type_id) REFERENCES course_types(id),
          FOREIGN KEY (session_id) REFERENCES sessions(id) ON DELETE SET NULL
        )
      ''');

      // ============================================
      // 参与人表（支持正式学员和临时人员）
      // ============================================
      await db.execute('''
        CREATE TABLE class_participants (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          scheduled_class_id INTEGER NOT NULL,
          student_id INTEGER,
          guest_name TEXT,
          attendance TEXT NOT NULL DEFAULT 'pending' CHECK(attendance IN ('pending', 'present', 'absent', 'late')),
          notes TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (scheduled_class_id) REFERENCES scheduled_classes(id) ON DELETE CASCADE,
          FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
          CHECK(student_id IS NOT NULL OR guest_name IS NOT NULL)
        )
      ''');

      // ============================================
      // 学员付费记录表
      // ============================================
      await db.execute('''
        CREATE TABLE student_payments (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          student_id INTEGER NOT NULL,
          course_type_id INTEGER,
          course_plan_id INTEGER,
          amount REAL NOT NULL DEFAULT 0,
          description TEXT,
          commission_type TEXT NOT NULL DEFAULT 'none' CHECK(commission_type IN ('none', 'fixed', 'percent')),
          commission_value REAL NOT NULL DEFAULT 0,
          commission_earned REAL NOT NULL DEFAULT 0,
          paid_at TEXT NOT NULL,
          notes TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
          FOREIGN KEY (course_type_id) REFERENCES course_types(id) ON DELETE SET NULL,
          FOREIGN KEY (course_plan_id) REFERENCES course_plans(id) ON DELETE SET NULL
        )
      ''');

      // ============================================
      // 课程目标默认配置表
      // ============================================
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

      // ============================================
      // 默认配置课时模板表
      // ============================================
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

      // ============================================
      // 默认配置内容块
      // ============================================
      await db.execute('''
        CREATE TABLE goal_config_content_blocks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          goal_config_session_id INTEGER NOT NULL,
          sort_order INTEGER NOT NULL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (goal_config_session_id) REFERENCES goal_config_sessions(id) ON DELETE CASCADE
        )
      ''');

      // ============================================
      // 默认配置内容块字段值
      // ============================================
      await db.execute('''
        CREATE TABLE goal_config_content_block_values (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          content_block_id INTEGER NOT NULL,
          content_field_id INTEGER NOT NULL,
          value TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (content_block_id) REFERENCES goal_config_content_blocks(id) ON DELETE CASCADE,
          FOREIGN KEY (content_field_id) REFERENCES content_fields(id) ON DELETE CASCADE,
          UNIQUE(content_block_id, content_field_id)
        )
      ''');

      // ============================================
      // 相册表
      // ============================================
      await db.execute('''
        CREATE TABLE albums (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          student_id INTEGER NOT NULL,
          name TEXT NOT NULL,
          notes TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
        )
      ''');

      // ============================================
      // 相册照片表
      // ============================================
      await db.execute('''
        CREATE TABLE album_photos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          album_id INTEGER NOT NULL,
          file_path TEXT NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE CASCADE
        )
      ''');

      // ============================================
      // 创建索引
      // ============================================
      // 原有索引
      await db.execute('CREATE INDEX idx_content_fields_sort ON content_fields(sort_order)');
      await db.execute('CREATE INDEX idx_field_options_field ON field_options(content_field_id)');
      await db.execute('CREATE INDEX idx_content_blocks_session ON content_blocks(session_id)');
      await db.execute('CREATE INDEX idx_content_block_values_block ON content_block_values(content_block_id)');
      await db.execute('CREATE INDEX idx_goal_config_content_blocks_session ON goal_config_content_blocks(goal_config_session_id)');
      await db.execute('CREATE INDEX idx_goal_config_content_block_values_block ON goal_config_content_block_values(content_block_id)');
      await db.execute('CREATE INDEX idx_sessions_course_plan ON sessions(course_plan_id)');
      await db.execute('CREATE INDEX idx_course_plans_student ON course_plans(student_id)');
      await db.execute('CREATE INDEX idx_goal_config_sessions_config ON goal_config_sessions(goal_config_id)');
      await db.execute('CREATE INDEX idx_sessions_status ON sessions(status)');
      await db.execute('CREATE INDEX idx_albums_student ON albums(student_id)');
      await db.execute('CREATE INDEX idx_album_photos_album ON album_photos(album_id)');

      // 新增索引
      await db.execute('CREATE INDEX idx_scheduled_classes_start_time ON scheduled_classes(start_time)');
      await db.execute('CREATE INDEX idx_scheduled_classes_course_type ON scheduled_classes(course_type_id)');
      await db.execute('CREATE INDEX idx_scheduled_classes_status ON scheduled_classes(status)');
      await db.execute('CREATE INDEX idx_scheduled_classes_session ON scheduled_classes(session_id)');
      await db.execute('CREATE INDEX idx_class_participants_class ON class_participants(scheduled_class_id)');
      await db.execute('CREATE INDEX idx_class_participants_student ON class_participants(student_id)');
      await db.execute('CREATE INDEX idx_student_payments_student ON student_payments(student_id)');
      await db.execute('CREATE INDEX idx_student_payments_paid_at ON student_payments(paid_at)');
    },
  );

  return database;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context)!.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        ...S.localizationsDelegates,
      ],
      supportedLocales: S.supportedLocales,
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
      home: const _AppHome(),
    );
  }
}

/// 首页路由：根据模板选择状态决定显示哪个页面
class _AppHome extends ConsumerWidget {
  const _AppHome();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String?>(
      future: TemplateLoader.getSelectedTemplate(ref.read(databaseProvider)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final selectedTemplate = snapshot.data;
        if (selectedTemplate == null || selectedTemplate.isEmpty) {
          return const TemplateSelectionPage();
        }
        return const MainShellPage();
      },
    );
  }
}
