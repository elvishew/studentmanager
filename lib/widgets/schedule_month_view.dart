import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';

/// 月视图：日历网格 + 课时数徽章
class ScheduleMonthView extends ConsumerWidget {
  const ScheduleMonthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduledClassNotifierProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    // 加载整月数据
    final startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final endOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 1);

    return state.when(
      initial: () => const Center(child: Text('加载中...')),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('加载失败: $e')),
      data: (classes, _) {
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
                itemCount: firstWeekday - 1 + daysInMonth,
                itemBuilder: (context, index) {
                  final dayOffset = index - (firstWeekday - 1);
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
    );
  }

  Widget _buildWeekdayHeader(BuildContext context) {
    const days = ['一', '二', '三', '四', '五', '六', '日'];
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
