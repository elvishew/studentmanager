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
    final notifier = ref.read(scheduledClassNotifierProvider.notifier);
    notifier.fetchByDate(selectedDate);
    // 确保课程类型数据已加载
    ref.read(courseTypeNotifierProvider.notifier).fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    final viewMode = ref.watch(scheduleViewProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    return Scaffold(
      appBar: AppBar(
        title: _buildDateNavigator(),
        actions: [
          _buildViewModeToggle(viewMode),
        ],
      ),
      body: Column(
        children: [
          _buildDayStrip(selectedDate),
          Expanded(
            child: _buildView(viewMode),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        tooltip: '新建排课',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDateNavigator() {
    final selectedDate = ref.watch(selectedDateProvider);
    final today = DateTime.now();
    final isToday = _isSameDay(selectedDate, today);

    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          ref.read(selectedDateProvider.notifier).setDate(picked);
          ref.read(scheduledClassNotifierProvider.notifier).fetchByDate(picked);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, size: 20),
              onPressed: () => _changeDate(-1),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            Text(
              isToday ? '今天' : _formatDate(selectedDate),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, size: 20),
              onPressed: () => _changeDate(1),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
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
        ref.read(scheduleViewProvider.notifier).setMode(modes.first);
      },
    );
  }

  Widget _buildDayStrip(DateTime selectedDate) {
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final today = DateTime.now();

    return SizedBox(
      height: 56,
      child: Row(
        children: List.generate(7, (i) {
          final date = startOfWeek.add(Duration(days: i));
          final isSelected = _isSameDay(date, selectedDate);
          final isToday = _isSameDay(date, today);

          return Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(selectedDateProvider.notifier).setDate(date);
                ref.read(scheduledClassNotifierProvider.notifier).fetchByDate(date);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : isToday
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _weekdayShort(date.weekday),
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    Text(
                      '${date.day}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                        color: isSelected
                            ? Theme.of(context).colorScheme.onPrimary
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
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

  void _changeDate(int days) {
    final current = ref.read(selectedDateProvider);
    final newDate = current.add(Duration(days: days));
    ref.read(selectedDateProvider.notifier).setDate(newDate);
    ref.read(scheduledClassNotifierProvider.notifier).fetchByDate(newDate);
  }

  void _showCreateDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const CreateScheduledClassDialog(),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatDate(DateTime date) {
    return '${date.month}月${date.day}日';
  }

  String _weekdayShort(int weekday) {
    const days = ['一', '二', '三', '四', '五', '六', '日'];
    return days[weekday - 1];
  }
}
