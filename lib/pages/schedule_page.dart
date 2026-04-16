import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/providers/course_type_provider.dart';
import 'package:student_manager/widgets/schedule_day_view.dart';
import 'package:student_manager/widgets/schedule_week_view.dart';
import 'package:student_manager/widgets/schedule_month_view.dart';
import 'create_scheduled_class_dialog.dart';

/// 课表 Tab
class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  @override
  void initState() {
    super.initState();
    // 初始化加载当天数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final selectedDate = ref.read(selectedDateProvider);
    final viewMode = ref.read(scheduleViewProvider);
    final notifier = ref.read(scheduledClassNotifierProvider.notifier);
    // 根据当前视图加载对应范围的数据
    if (viewMode == ScheduleViewMode.week) {
      final weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday % 7));
      notifier.fetchByWeek(weekStart);
    } else if (viewMode == ScheduleViewMode.month) {
      final startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
      final endOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 1);
      notifier.fetchByDateRange(startOfMonth, endOfMonth);
    } else {
      notifier.fetchByDate(selectedDate);
    }
    // 确保课程类型数据已加载
    ref.read(courseTypeNotifierProvider.notifier).fetchAll();
  }

  /// Tab 恢复时静默刷新（不触发 loading 状态，保留 ScrollView 实例）
  void _silentRefresh() {
    final selectedDate = ref.read(selectedDateProvider);
    final viewMode = ref.read(scheduleViewProvider);
    final notifier = ref.read(scheduledClassNotifierProvider.notifier);
    if (viewMode == ScheduleViewMode.week) {
      final weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday % 7));
      notifier.fetchByWeek(weekStart, silent: true);
    } else if (viewMode == ScheduleViewMode.month) {
      final startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
      final endOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 1);
      notifier.fetchByDateRange(startOfMonth, endOfMonth);
    } else {
      notifier.fetchByDate(selectedDate, silent: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewMode = ref.watch(scheduleViewProvider);

    // 监听课表 tab 恢复可见信号，静默刷新数据（不触发 loading，避免 ScrollView 重建丢失滚动位置）
    ref.listen(scheduleTabResumeProvider, (prev, next) {
      if (prev != next) {
        _silentRefresh();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('课表'),
        centerTitle: false,
        actions: [
          _buildViewModeToggle(viewMode),
        ],
      ),
      body: _buildView(viewMode),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        tooltip: '新建排课',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildViewModeToggle(ScheduleViewMode currentMode) {
    return SegmentedButton<ScheduleViewMode>(
      segments: const [
        ButtonSegment(value: ScheduleViewMode.day, label: Text('日')),
        ButtonSegment(value: ScheduleViewMode.week, label: Text('周')),
        ButtonSegment(value: ScheduleViewMode.month, label: Text('月')),
      ],
      selected: {currentMode},
      onSelectionChanged: (modes) {
        final mode = modes.first;
        ref.read(scheduleViewProvider.notifier).setMode(mode);
        // 切换视图时重新加载对应范围数据
        final selectedDate = ref.read(selectedDateProvider);
        final notifier = ref.read(scheduledClassNotifierProvider.notifier);
        if (mode == ScheduleViewMode.week) {
          final weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday % 7));
          notifier.fetchByWeek(weekStart);
        } else if (mode == ScheduleViewMode.month) {
          final startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
          final endOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 1);
          notifier.fetchByDateRange(startOfMonth, endOfMonth);
        } else {
          notifier.fetchByDate(selectedDate);
        }
      },
    );
  }

  Widget _buildView(ScheduleViewMode mode) {
    switch (mode) {
      case ScheduleViewMode.day:
        return const ScheduleDayView();
      case ScheduleViewMode.week:
        return const ScheduleWeekView();
      case ScheduleViewMode.month:
        return const ScheduleMonthView();
    }
  }

  void _showCreateDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const CreateScheduledClassDialog(),
    );
  }

}
