import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/providers/settings_provider.dart';
import 'package:student_manager/utils/working_hours_utils.dart';
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
    return date.subtract(Duration(days: date.weekday % 7));
  }

  /// 根据 page index 计算该周的起始日期
  DateTime _weekStartFromIndex(int index) {
    return _baseWeekStart.add(Duration(days: (index - _initialPage) * 7));
  }

  void _onPageChanged(int index) {
    final weekStart = _weekStartFromIndex(index);
    final midWeek = weekStart.add(const Duration(days: 3));
    ref.read(selectedDateProvider.notifier).setDate(midWeek);
    ref.read(scheduledClassNotifierProvider.notifier).fetchByWeek(weekStart, silent: true);
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
            // 周导航栏
            _buildWeekNavBar(context, startOfWeek),
            // 星期标题行
            _buildWeekHeader(context, startOfWeek, selectedDate),
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
    final segments = ref.read(workingHoursNotifierProvider);
    final now = DateTime.now();
    final isToday = date.year == now.year && date.month == now.month && date.day == now.day;

    int defaultHour;
    if (isToday) {
      final (h, _) = computeDefaultStartHour(now, segments);
      defaultHour = h;
    } else {
      defaultHour = segments.isNotEmpty ? segments.first.start : 9;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => CreateScheduledClassDialog(
        initialStartHour: defaultHour,
      ),
    );
  }

  Widget _buildWeekNavBar(BuildContext context, DateTime startOfWeek) {
    final weekEnd = startOfWeek.add(const Duration(days: 6));
    final weekText = startOfWeek.month == weekEnd.month
        ? '${startOfWeek.month}月${startOfWeek.day}-${weekEnd.day}日'
        : '${startOfWeek.month}月${startOfWeek.day}日-${weekEnd.month}月${weekEnd.day}日';

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
            onPressed: () => _navigateWeek(-1),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          GestureDetector(
            onTap: () => _showDatePicker(startOfWeek),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                weekText,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 20),
            onPressed: () => _navigateWeek(1),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  void _navigateWeek(int direction) {
    final currentIndex = _pageController.page?.round() ?? _initialPage;
    _pageController.animateToPage(
      currentIndex + direction,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _showDatePicker(DateTime startOfWeek) async {
    final midWeek = startOfWeek.add(const Duration(days: 3));
    final picked = await showDatePicker(
      context: context,
      initialDate: midWeek,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      final newWeekStart = _weekStart(picked);
      ref.read(selectedDateProvider.notifier).setDate(picked);
      // 重新初始化 PageController，以新周为中心
      setState(() {
        _baseWeekStart = newWeekStart;
        _pageController.dispose();
        _pageController = PageController(initialPage: _initialPage);
      });
      ref.read(scheduledClassNotifierProvider.notifier).fetchByWeek(newWeekStart);
    }
  }

  Widget _buildWeekHeader(BuildContext context, DateTime startOfWeek, DateTime selectedDate) {
    const dayNames = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
    final today = DateTime.now();

    return Row(
      children: List.generate(7, (i) {
        final date = startOfWeek.add(Duration(days: i));
        final isToday = date.year == today.year &&
            date.month == today.month &&
            date.day == today.day;
        final isSelected = date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day;

        return Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : isToday
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
              border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: Column(
              children: [
                Text(
                  dayNames[i],
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : null,
                  ),
                ),
                Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : isToday
                            ? Theme.of(context).colorScheme.primary
                            : null,
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

    final Color blockColor;
    final double fillOpacity;
    if (isCancelled) {
      blockColor = Colors.grey;
      fillOpacity = 0.08;
    } else if (isNoShow) {
      blockColor = Colors.grey;
      fillOpacity = 0.18;
    } else {
      blockColor = color;
      fillOpacity = 0.18;
    }

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
          padding: const EdgeInsets.fromLTRB(6, 4, 4, 4),
          decoration: BoxDecoration(
            color: blockColor.withOpacity(fillOpacity),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _buildBlockLabel(sc),
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
              if (isCompleted)
                Icon(Icons.check, size: 14, color: blockColor.withOpacity(0.7)),
            ],
          ),
        ),
      ),
    );
  }

  /// 生成课程块显示文本：title → 参与人 → 课程类型
  String _buildBlockLabel(ScheduledClass sc) {
    if (sc.title != null && sc.title!.isNotEmpty) return sc.title!;
    final participants = sc.participants;
    if (participants != null && participants.isNotEmpty) {
      if (participants.length == 1) return participants.first.displayName;
      return '${participants.first.displayName}等${participants.length}人';
    }
    return sc.courseTypeName ?? '未命名';
  }

  Color? _parseColor(String? hexColor) {
    if (hexColor == null) return null;
    try {
      final hex = hexColor.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return null;
    }
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
