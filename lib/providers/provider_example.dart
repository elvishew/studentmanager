import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'student_provider.dart';
import 'course_plan_provider.dart';
import 'session_provider.dart';

/// ============================================
/// Provider 使用示例
/// ============================================

class ProviderExample {
  /// ============================================
  /// 示例 1: 学员管理
  /// ============================================

  static Future<void> example1_StudentManagement(WidgetRef ref) async {
    final notifier = ref.read(studentNotifierProvider.notifier);

    // 1. 查询所有学员
    await notifier.fetchAll();

    // 2. 搜索学员
    notifier.search('张三');

    // 3. 创建学员
    final studentId = await notifier.create(
      name: '李四',
      gender: '女',
      contact: '13800138000',
      notes: '产后2个月',
    );

    // 4. 更新学员
    if (studentId != null) {
      await notifier.update(
        id: studentId,
        name: '李四',
        gender: '女',
        contact: '13900139000',
        notes: '产后3个月，需要修复',
      );
    }

    // 5. 删除学员
    if (studentId != null) {
      await notifier.delete(studentId);
    }

    // 6. 获取学员详情
    if (studentId != null) {
      final student = await notifier.getById(studentId);
      print('学员姓名: ${student?.name}');
    }
  }

  /// ============================================
  /// 示例 2: 课程规划管理
  /// ============================================

  static Future<void> example2_CoursePlanManagement(WidgetRef ref) async {
    final notifier = ref.read(coursePlanNotifierProvider.notifier);

    // 1. 查询指定学员的课程规划
    await notifier.fetchByStudentId(1);

    // 2. 查询所有课程规划
    await notifier.fetchAll();

    // 3. 创建课程规划（自动应用默认配置）
    final coursePlanId = await notifier.create(
      studentId: 1,
      goal: CourseGoal.postpartum.value,
    );

    // 4. 创建自定义目标的课程规划
    final customPlanId = await notifier.create(
      studentId: 1,
      goal: CourseGoal.custom.value,
    );

    // 5. 更新课程规划
    if (coursePlanId != null) {
      await notifier.update(
        id: coursePlanId,
        blueprint: '调整后的蓝图',
      );
    }

    // 6. 选择课程规划
    if (coursePlanId != null) {
      notifier.selectCoursePlan(coursePlanId);
    }

    // 7. 获取课程规划详情（含课时）
    if (coursePlanId != null) {
      final detail = await notifier.getDetailById(coursePlanId);
      print('课时总数: ${detail?.totalSessions}');
      print('已完成课时: ${detail?.completedSessions}');
      print('完成率: ${(detail?.completionRate ?? 0 * 100).toStringAsFixed(1)}%');
    }

    // 8. 删除课程规划
    if (customPlanId != null) {
      await notifier.delete(customPlanId);
    }
  }

  /// ============================================
  /// 示例 3: 课时管理
  /// ============================================

  static Future<void> example3_SessionManagement(WidgetRef ref) async {
    final notifier = ref.read(sessionNotifierProvider.notifier);

    // 1. 查询课程规划的所有课时
    await notifier.fetchByCoursePlanId(1);

    // 2. 添加课时（到末尾）
    final sessionId = await notifier.addSession(coursePlanId: 1);

    // 3. 批量添加课时
    await notifier.addSessionsBatch(
      coursePlanId: 1,
      count: 5,
    );

    // 4. 在指定位置插入课时
    await notifier.insertSessionAt(
      coursePlanId: 1,
      position: 3,
    );

    // 5. 更新课时（设置上课时间和状态）
    if (sessionId != null) {
      await notifier.updateSession(
        sessionId: sessionId,
        scheduledTime: DateTime(2025, 1, 15, 10, 0),
        status: SessionStatus.completed,
      );
    }

    // 6. 移动课时位置
    if (sessionId != null) {
      await notifier.moveSession(
        sessionId: sessionId,
        newPosition: 1,
      );
    }

    // 7. 选择课时
    if (sessionId != null) {
      notifier.selectSession(sessionId);
    }

    // 8. 获取课时详情（含训练块）
    if (sessionId != null) {
      final detail = await notifier.getDetailById(sessionId);
      print('训练块数量: ${detail?.trainingBlocks?.length}');
    }

    // 9. 删除课时
    if (sessionId != null) {
      await notifier.deleteSession(sessionId: sessionId);
    }
  }

  /// ============================================
  /// 示例 4: 监听状态变化
  /// ============================================

  static void example4_WatchStateChanges(WidgetRef ref) {
    // 1. 监听学员状态
    ref.listen<StudentState>(
      studentNotifierProvider,
      (previous, next) {
        next.when(
          initial: () => print('学员状态：初始'),
          loading: () => print('学员状态：加载中'),
          data: (students, filtered, query) {
            print('学员状态：数据加载完成');
            print('总数：${students.length}');
            print('过滤后：${filtered.length}');
            print('搜索关键词：$query');
          },
          error: (e, stackTrace) => print('学员状态：错误 - $e'),
        );
      },
    );

    // 2. 监听课程规划状态
    ref.listen<CoursePlanState>(
      coursePlanNotifierProvider,
      (previous, next) {
        next.when(
          initial: () => print('课程规划状态：初始'),
          loading: () => print('课程规划状态：加载中'),
          data: (plans, selected, studentId) {
            print('课程规划状态：数据加载完成');
            print('总数：${plans.length}');
            print('选中：${selected?.goal}');
            print('筛选学员ID：$studentId');
          },
          error: (e, stackTrace) => print('课程规划状态：错误 - $e'),
        );
      },
    );

    // 3. 监听课时状态
    ref.listen<SessionState>(
      sessionNotifierProvider,
      (previous, next) {
        next.when(
          initial: () => print('课时状态：初始'),
          loading: () => print('课时状态：加载中'),
          data: (sessions, selected, planId) {
            print('课时状态：数据加载完成');
            print('总数：${sessions.length}');
            print('选中：课时${selected?.sessionNumber}');
            print('课程规划ID：$planId');
          },
          error: (e, stackTrace) => print('课时状态：错误 - $e'),
        );
      },
    );

    // 4. 监听计算属性
    ref.listen<int>(
      studentCountProvider,
      (previous, next) {
        print('学员总数变化：$previous -> $next');
      },
    );

    ref.listen<double>(
      sessionCompletionRateProvider,
      (previous, next) {
        print('课程完成率变化：${(previous * 100).toStringAsFixed(1)}% -> ${(next * 100).toStringAsFixed(1)}%');
      },
    );

    ref.listen<SessionStatistics>(
      sessionStatisticsProvider,
      (previous, next) {
        print('课时统计：');
        print('  总数：${next.total}');
        print('  已完成：${next.completed}');
        print('  未开始：${next.pending}');
        print('  已跳过：${next.skipped}');
        print('  完成率：${(next.completionRate * 100).toStringAsFixed(1)}%');
      },
    );
  }

  /// ============================================
  /// 示例 5: 在 Widget 中使用
  /// ============================================

  static Widget example5_UsageInWidget(BuildContext context, WidgetRef ref) {
    // 1. 读取学员列表
    final studentState = ref.watch(studentNotifierProvider);
    final students = studentState.maybeWhen(
      data: (students, filtered, _) => filtered,
      orElse: () => [],
    );

    // 2. 读取课程规划列表
    final coursePlanState = ref.watch(coursePlanNotifierProvider);
    final coursePlans = coursePlanState.maybeWhen(
      data: (plans, _, __) => plans,
      orElse: () => [],
    );

    // 3. 读取课时列表
    final sessionState = ref.watch(sessionNotifierProvider);
    final sessions = sessionState.maybeWhen(
      data: (sessions, _, __) => sessions,
      orElse: () => [],
    );

    // 4. 读取计算属性
    final studentCount = ref.watch(studentCountProvider);
    final selectedCoursePlan = ref.watch(selectedCoursePlanProvider);
    final sessionStatistics = ref.watch(sessionStatisticsProvider);

    // 5. 根据 loading/error 状态显示不同 UI
    return studentState.when(
      initial: () => const Center(child: Text('初始化')),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, stackTrace) => Center(child: Text('错误: $e')),
      data: (allStudents, filtered, query) {
        return Column(
          children: [
            Text('学员总数: $studentCount'),
            Text('当前筛选: ${query ?? "无"}'),
            Text('显示 ${filtered.length} 条结果'),
            // ... 列表视图
          ],
        );
      },
    );
  }

  /// ============================================
  /// 示例 6: 完整的业务流程
  /// ============================================

  static Future<void> example6_CompleteWorkflow(WidgetRef ref) async {
    final studentNotifier = ref.read(studentNotifierProvider.notifier);
    final coursePlanNotifier = ref.read(coursePlanNotifierProvider.notifier);
    final sessionNotifier = ref.read(sessionNotifierProvider.notifier);

    // 步骤 1: 创建学员
    final studentId = await studentNotifier.create(
      name: '王芳',
      gender: '女',
      contact: '13700137000',
      notes: '产后1个月，需要修复',
    );

    if (studentId == null) {
      print('创建学员失败');
      return;
    }

    print('✅ 创建学员成功，ID: $studentId');

    // 步骤 2: 创建课程规划
    final coursePlanId = await coursePlanNotifier.create(
      studentId: studentId,
      goal: CourseGoal.postpartum.value,
    );

    if (coursePlanId == null) {
      print('创建课程规划失败');
      return;
    }

    print('✅ 创建课程规划成功，ID: $coursePlanId');

    // 步骤 3: 查询课程规划详情（验证前12节课已自动生成）
    final coursePlanDetail = await coursePlanNotifier.getDetailById(coursePlanId);
    print('✅ 课程规划已生成 ${coursePlanDetail?.totalSessions} 节课');

    // 步骤 4: 加载课时列表
    await sessionNotifier.fetchByCoursePlanId(coursePlanId);
    print('✅ 加载课时列表成功');

    // 步骤 5: 为第1节课安排时间
    final sessionState = ref.read(sessionNotifierProvider);
    final firstSession = sessionState.maybeWhen(
      data: (sessions, _, __) => sessions.isNotEmpty ? sessions.first : null,
      orElse: () => null,
    );

    if (firstSession != null) {
      await sessionNotifier.updateSession(
        sessionId: firstSession.id,
        scheduledTime: DateTime(2025, 1, 20, 14, 0),
        status: SessionStatus.pending,
      );
      print('✅ 已为第1节课安排时间');
    }

    // 步骤 6: 完成第1节课
    if (firstSession != null) {
      await sessionNotifier.updateSession(
        sessionId: firstSession.id,
        status: SessionStatus.completed,
      );
      print('✅ 第1节课已完成');
    }

    // 步骤 7: 查看完成率
    final statistics = ref.read(sessionStatisticsProvider);
    print('📊 课程进度:');
    print('  总课时: ${statistics.total}');
    print('  已完成: ${statistics.completed}');
    print('  完成率: ${(statistics.completionRate * 100).toStringAsFixed(1)}%');
  }
}

/// ============================================
/// WidgetRef 扩展方法（可选）
/// ============================================

extension WidgetRefX on WidgetRef {
  /// 便捷方法：显示错误提示
  void showError(Object error) {
    // 实际项目中可以使用 Snackbar 或 Dialog
    print('错误: $error');
  }

  /// 便捷方法：显示成功提示
  void showSuccess(String message) {
    // 实际项目中可以使用 Snackbar 或 Dialog
    print('成功: $message');
  }
}

/// ============================================
/// 使用说明
/// ============================================

///
/// **1. 初始化（在 main.dart 中）**
///
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   // 初始化数据库
///   final database = await openDatabase(...);
///
///   // 提供 Database 实例
///   final container = ProviderContainer(
///     overrides: [
///       databaseProvider.overrideWithValue(database),
///     ],
///   );
///
///   runApp(
///     UncontrolledProviderScope(
///       container: container,
///       child: const MyApp(),
///     ),
///   );
/// }
/// ```
///
/// **2. 在 Widget 中使用**
///
/// ```dart
/// class StudentListPage extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final studentState = ref.watch(studentNotifierProvider);
///
///     return studentState.when(
///       loading: () => CircularProgressIndicator(),
///       error: (e, _) => Text('错误: $e'),
///       data: (students, filtered, query) {
///         return ListView.builder(
///           itemCount: filtered.length,
///           itemBuilder: (context, index) {
///             final student = filtered[index];
///             return ListTile(
///               title: Text(student.name),
///               subtitle: Text(student.contact),
///             );
///           },
///         );
///       },
///     );
///   }
/// }
/// ```
///
/// **3. 调用方法**
///
/// ```dart
/// ElevatedButton(
///   onPressed: () async {
///     final notifier = ref.read(studentNotifierProvider.notifier);
///     await notifier.create(
///       name: '张三',
///       contact: '13800138000',
///     );
///   },
///   child: Text('创建学员'),
/// )
/// ```
///
/// **4. 监听状态变化**
///
/// ```dart
/// ref.listen<StudentState>(
///   studentNotifierProvider,
///   (previous, next) {
///     next.maybeWhen(
///       data: (students, filtered, query) {
///         ScaffoldMessenger.of(context).showSnackBar(
///           SnackBar(content: Text('加载了 ${filtered.length} 条数据')),
///         );
///       },
///       orElse: () {},
///     );
///   },
/// );
/// ```
///
/// **注意事项：**
///
/// 1. 使用 `ref.watch()` 监听状态变化并在 UI 中显示
/// 2. 使用 `ref.read()` 在回调中获取 Notifier 并调用方法
/// 3. 使用 `ref.listen()` 监听状态变化并执行副作用
/// 4. 状态更新后，监听该状态的 Widget 会自动重建
/// 5. 计算属性 Provider 自动缓存结果，只有依赖变化才重新计算
