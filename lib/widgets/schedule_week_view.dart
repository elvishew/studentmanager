import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/pages/scheduled_class_detail_page.dart';
import 'package:student_manager/pages/create_scheduled_class_dialog.dart';

/// 周视图：7 列网格，支持左右滑动切换周
class ScheduleWeekView extends ConsumerStatefulWidget {
  const ScheduleWeekView({super.key});

  @override
  ConsumerState<ScheduleWeekView> createState() => _ScheduleWeekViewState();
}

class _ScheduleWeekViewState extends ConsumerState<ScheduleWeekView> {
  late PageController _pageController;
  late DateTime _baseWeekStart;
  static const int _initialPage = 5200; // 足够大的中间页

  @override
  void initState() {
    super.initState();
    final selectedDate = ref.read(selectedDateProvider);
    _baseWeekStart = _weekStart(selectedDate);
    _pageController = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 获取某天所在周的周一
  DateTime _weekStart(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  /// 根据 page index 计算该周的起始日期
  DateTime _weekStartFromIndex(int index) {
    return _baseWeekStart.add(Duration(days: (index - _initialPage) * 7));
  }

  void _onPageChanged(int index) {
    final weekStart = _weekStartFromIndex(index);
    final midWeek = weekStart.add(const Duration(days: 3));
    ref.read(selectedDateProvider.notifier).setDate(midWeek);
    ref.read(scheduledClassNotifierProvider.notifier).fetchByWeek(weekStart);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scheduledClassNotifierProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    return state.when(
      initial: () => const Center(child: Text('加载中...')),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('加载失败: $e')),
      data: (classes, _) {
        final startOfWeek = _weekStart(selectedDate);

        return Column(
          children: [
            // 星期标题行
            _buildWeekHeader(context, startOfWeek),
            // 可滑动的周内容
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, page) {
                  final weekStart = _weekStartFromIndex(page);
                  // 只对当前周使用实际数据，其他周显示空（滑动后会加载）
                  final isCurrentWeek = weekStart.year == startOfWeek.year &&
                      weekStart.month == startOfWeek.month &&
                      weekStart.day == startOfWeek.day;
                  final displayClasses = isCurrentWeek ? classes : <ScheduledClass>[];

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(7, (i) {
                      final date = weekStart.add(Duration(days: i));
                      final dayClasses = displayClasses.where((sc) =>
                        sc.startTime.year == date.year &&
                        sc.startTime.month == date.month &&
                        sc.startTime.day == date.day
                      ).toList();

                      return Expanded(
                        child: GestureDetector(
                          onTap: () => _showCreateForDate(context, date),
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
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCreateForDate(BuildContext context, DateTime date) {
    ref.read(selectedDateProvider.notifier).setDate(date);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => CreateScheduledClassDialog(),
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
    final isCancelled = sc.status == ScheduledClassStatus.cancelled;
    final isCompleted = sc.status == ScheduledClassStatus.completed;
    final isNoShow = sc.status == ScheduledClassStatus.noShow;
    final blockColor = isCancelled
        ? Colors.grey
        : isCompleted
            ? Colors.green
            : isNoShow
                ? Colors.orange
                : color;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScheduledClassDetailPage(classId: sc.id),
          ),
        );
      },
      child: Opacity(
        opacity: isCancelled ? 0.5 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: blockColor.withOpacity(isCancelled ? 0.05 : 0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: blockColor.withOpacity(isCancelled ? 0.15 : 0.3)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sc.title ?? sc.courseTypeName ?? '未命名',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: blockColor,
                        decoration: isCancelled ? TextDecoration.lineThrough : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _formatTime(sc.startTime),
                      style: TextStyle(fontSize: 10, color: blockColor.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              if (isCancelled)
                Text('取消', style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
              if (isNoShow)
                Text('未到', style: TextStyle(fontSize: 9, color: Colors.orange.shade700)),
              if (isCompleted)
                Text('完成', style: TextStyle(fontSize: 9, color: Colors.green.shade700)),
            ],
          ),
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
