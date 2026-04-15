import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';

/// 月视图：日历网格 + 课时数徽章
class ScheduleMonthView extends ConsumerStatefulWidget {
  const ScheduleMonthView({super.key});

  @override
  ConsumerState<ScheduleMonthView> createState() => _ScheduleMonthViewState();
}

class _ScheduleMonthViewState extends ConsumerState<ScheduleMonthView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scheduledClassNotifierProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    return Column(
      children: [
        // 月导航栏
        _buildMonthNavBar(context, selectedDate),
        // 内容区域
        Expanded(
          child: state.when(
            initial: () => const Center(child: Text('加载中...')),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('加载失败: $e')),
            data: (classes, _) {
              final startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
              // 按日分组（取消的课不计入徽章）
              final classesByDay = <int, int>{};
              for (final sc in classes) {
                if (sc.status == ScheduledClassStatus.cancelled) continue;
                final day = sc.startTime.day;
                classesByDay[day] = (classesByDay[day] ?? 0) + 1;
              }

              final daysInMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
              final firstWeekday = startOfMonth.weekday; // 1=Mon, 7=Sun
              final today = DateTime.now();

              return Column(
                children: [
                  // 星期标题
                  _buildWeekdayHeader(context),
                  // 日历网格
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemCount: firstWeekday % 7 + daysInMonth,
                      itemBuilder: (context, index) {
                        final dayOffset = index - (firstWeekday % 7);
                        if (dayOffset < 0) {
                          return const SizedBox();
                        }
                        final day = dayOffset + 1;
                        final date = DateTime(selectedDate.year, selectedDate.month, day);
                        final isToday = date.year == today.year &&
                            date.month == today.month &&
                            date.day == today.day;
                        final isSelected = date.year == selectedDate.year &&
                            date.month == selectedDate.month &&
                            date.day == selectedDate.day;
                        final classCount = classesByDay[day] ?? 0;

                        return GestureDetector(
                          onTap: () {
                            ref.read(selectedDateProvider.notifier).setDate(date);
                            ref.read(scheduleViewProvider.notifier).setMode(ScheduleViewMode.day);
                            ref.read(scheduledClassNotifierProvider.notifier).fetchByDate(date);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : isToday
                                      ? Theme.of(context).colorScheme.primaryContainer
                                      : null,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    '$day',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isToday || isSelected ? FontWeight.bold : null,
                                      color: isSelected
                                          ? Theme.of(context).colorScheme.onPrimary
                                          : null,
                                    ),
                                  ),
                                ),
                                if (classCount > 0)
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Theme.of(context).colorScheme.onPrimary
                                            : Theme.of(context).colorScheme.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                      child: Text(
                                        '$classCount',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: isSelected
                                              ? Theme.of(context).colorScheme.primary
                                              : Theme.of(context).colorScheme.onPrimary,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMonthNavBar(BuildContext context, DateTime selectedDate) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 20),
            onPressed: () => _navigateMonth(-1),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          GestureDetector(
            onTap: () => _showDatePicker(selectedDate),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${selectedDate.year}年${selectedDate.month}月',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 20),
            onPressed: () => _navigateMonth(1),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  void _navigateMonth(int direction) {
    final current = ref.read(selectedDateProvider);
    final targetMonth = DateTime(current.year, current.month + direction, 1);
    final daysInNewMonth = DateTime(targetMonth.year, targetMonth.month + 1, 0).day;
    final newDate = DateTime(targetMonth.year, targetMonth.month, current.day.clamp(1, daysInNewMonth));
    ref.read(selectedDateProvider.notifier).setDate(newDate);
    final startOfMonth = DateTime(newDate.year, newDate.month, 1);
    final endOfMonth = DateTime(newDate.year, newDate.month + 1, 1);
    ref.read(scheduledClassNotifierProvider.notifier).fetchByDateRange(startOfMonth, endOfMonth);
  }

  Future<void> _showDatePicker(DateTime selectedDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      ref.read(selectedDateProvider.notifier).setDate(picked);
      final startOfMonth = DateTime(picked.year, picked.month, 1);
      final endOfMonth = DateTime(picked.year, picked.month + 1, 1);
      ref.read(scheduledClassNotifierProvider.notifier).fetchByDateRange(startOfMonth, endOfMonth);
    }
  }

  Widget _buildWeekdayHeader(BuildContext context) {
    const days = ['日', '一', '二', '三', '四', '五', '六'];
    return Row(
      children: days.map((d) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            d,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      )).toList(),
    );
  }
}
