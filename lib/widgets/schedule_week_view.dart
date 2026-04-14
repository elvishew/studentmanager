import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/pages/scheduled_class_detail_page.dart';

/// 周视图：7 列网格
class ScheduleWeekView extends ConsumerWidget {
  const ScheduleWeekView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduledClassNotifierProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    return state.when(
      initial: () => const Center(child: Text('加载中...')),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('加载失败: $e')),
      data: (classes, _) {
        final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));

        return Column(
          children: [
            // 星期标题行
            _buildWeekHeader(context, startOfWeek),
            // 课程网格
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(7, (i) {
                  final date = startOfWeek.add(Duration(days: i));
                  final dayClasses = classes.where((sc) =>
                    sc.startTime.year == date.year &&
                    sc.startTime.month == date.month &&
                    sc.startTime.day == date.day
                  ).toList();

                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Theme.of(context).dividerColor.withOpacity(0.2),
                          ),
                        ),
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(4),
                        itemCount: dayClasses.length,
                        itemBuilder: (context, index) {
                          return _buildWeekClassTile(context, dayClasses[index]);
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildWeekHeader(BuildContext context, DateTime startOfWeek) {
    const dayNames = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    final today = DateTime.now();

    return Row(
      children: List.generate(7, (i) {
        final date = startOfWeek.add(Duration(days: i));
        final isToday = date.year == today.year &&
            date.month == today.month &&
            date.day == today.day;

        return Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isToday
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
              border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: Column(
              children: [
                Text(dayNames[i], style: const TextStyle(fontSize: 12)),
                Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: isToday ? Theme.of(context).colorScheme.primary : null,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildWeekClassTile(BuildContext context, ScheduledClass sc) {
    final color = _parseColor(sc.courseTypeColor) ?? Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScheduledClassDetailPage(classId: sc.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sc.title ?? sc.courseTypeName ?? '未命名',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${_formatTime(sc.startTime)}',
              style: TextStyle(fontSize: 10, color: color.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }

  Color? _parseColor(String? hexColor) {
    if (hexColor == null) return null;
    try {
      final hex = hexColor.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 32));
    } catch (_) {
      return null;
    }
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
