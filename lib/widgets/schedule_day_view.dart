import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/pages/scheduled_class_detail_page.dart';
import 'package:student_manager/pages/create_scheduled_class_dialog.dart';

/// 日视图：0-24h 时间轴
class ScheduleDayView extends ConsumerStatefulWidget {
  const ScheduleDayView({super.key});

  @override
  ConsumerState<ScheduleDayView> createState() => _ScheduleDayViewState();
}

class _ScheduleDayViewState extends ConsumerState<ScheduleDayView> {
  final ScrollController _scrollController = ScrollController();

  static const double _hourHeight = 80.0;
  static const double _timeLabelWidth = 48.0;
  static const double _totalHeight = 24 * _hourHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToInitialPosition());
  }

  void _scrollToInitialPosition() {
    final now = DateTime.now();
    final selectedDate = ref.read(selectedDateProvider);
    final isToday = now.year == selectedDate.year &&
        now.month == selectedDate.month &&
        now.day == selectedDate.day;

    final targetHour = isToday ? now.hour : 8;
    final targetOffset = (targetHour - 1).clamp(0, 23) * _hourHeight;

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(targetOffset);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scheduledClassNotifierProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final now = DateTime.now();
    final isToday = now.year == selectedDate.year &&
        now.month == selectedDate.month &&
        now.day == selectedDate.day;

    return state.when(
      initial: () => const Center(child: Text('加载中...')),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('加载失败: $e')),
      data: (classes, _) {
        // 筛选当天的课程
        final dayClasses = classes.where((sc) {
          return sc.startTime.year == selectedDate.year &&
              sc.startTime.month == selectedDate.month &&
              sc.startTime.day == selectedDate.day;
        }).toList();

        return Column(
          children: [
            // 今日统计横幅
            if (dayClasses.isNotEmpty) _buildDaySummary(dayClasses),
            // 时间轴
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: SizedBox(
                  height: _totalHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 时间标签列（固定宽度，随滚动）
                      SizedBox(
                        width: _timeLabelWidth,
                        child: Column(
                          children: List.generate(24, (index) {
                            return SizedBox(
                              height: _hourHeight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4, right: 8),
                                child: Text(
                                  '${index.toString().padLeft(2, '0')}:00',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      // 课程块列
                      Expanded(
                        child: GestureDetector(
                          onTapUp: (details) {
                            final hour = (details.localPosition.dy / _hourHeight).clamp(0, 23).floor();
                            _showCreateDialog(hour);
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // 小时网格线
                              ...List.generate(24, (index) {
                                return Positioned(
                                  top: index * _hourHeight,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: _hourHeight,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Theme.of(context).dividerColor.withOpacity(0.2),
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              // 课程色块
                              ...dayClasses.map((sc) {
                                final startHour = sc.startTime.hour + sc.startTime.minute / 60;
                                final durationHours = sc.endTime.difference(sc.startTime).inMinutes / 60;
                                final top = startHour * _hourHeight;
                                final height = durationHours * _hourHeight;

                                return Positioned(
                                  top: top,
                                  left: 4,
                                  right: 4,
                                  height: height.clamp(32.0, double.infinity),
                                  child: _buildClassBlock(sc),
                                );
                              }),
                              // 当前时间指示线
                              if (isToday)
                                Positioned(
                                  top: (now.hour + now.minute / 60) * _hourHeight,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 2,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCreateDialog(int startHour) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => CreateScheduledClassDialog(
        initialStartHour: startHour,
      ),
    );
  }

  Widget _buildClassBlock(ScheduledClass sc) {
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
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withOpacity(0.4), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              sc.title ?? sc.courseTypeName ?? '未命名课程',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${_formatTime(sc.startTime)} - ${_formatTime(sc.endTime)}',
              style: TextStyle(
                fontSize: 10,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySummary(List<ScheduledClass> classes) {
    final completed = classes.where((c) => c.status == ScheduledClassStatus.completed).length;
    final scheduled = classes.where((c) => c.status == ScheduledClassStatus.scheduled).length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.surface,
      child: Text(
        '今日 ${classes.length} 节课 / 已完成 $completed / 待上 $scheduled',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.outline,
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
