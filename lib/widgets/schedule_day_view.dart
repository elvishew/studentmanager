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

    // 目标：滚动到当天第一节课或当前时刻，留 1 小时余量
    final targetHour = isToday ? now.hour : 8;
    final targetOffset = (targetHour - 1).clamp(0, 23) * _hourHeight;

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(targetOffset);
    }
  }

  static const double _hourHeight = 80.0;
  static const double _timeLabelWidth = 48.0;

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
        return Stack(
          children: [
            // 主滚动区域
            Row(
              children: [
                // 时间标签列
                SizedBox(
                  width: _timeLabelWidth,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: 24,
                    itemBuilder: (context, index) {
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
                    },
                  ),
                ),
                // 课程块列
                Expanded(
                  child: GestureDetector(
                    // 点击空白区域 → 新建排课
                    onTapUp: (details) {
                      final hour = (details.localPosition.dy / _hourHeight).clamp(0, 23).floor();
                      _showCreateDialog(hour);
                    },
                    child: Stack(
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
                        ...classes.map((sc) {
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
            // 今日统计横幅
            if (classes.isNotEmpty)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _buildDaySummary(classes),
              ),
          ],
        );
      },
    );
  }

  /// 点击空白区域时，根据点击位置推算时间，打开新建排课对话框
  void _showCreateDialog(int startHour) {
    final selectedDate = ref.read(selectedDateProvider);
    // 将选中日期的小时设为点击位置对应的时间
    ref.read(selectedDateProvider.notifier).setDate(
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day, startHour),
    );
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
