import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/pages/scheduled_class_detail_page.dart';
import 'package:student_manager/pages/create_scheduled_class_dialog.dart';

/// 日视图：0-24h 时间轴，支持左右滑动切换日期
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

  /// 左右滑动切换日期
  void _changeDate(int offset) {
    final current = ref.read(selectedDateProvider);
    final newDate = current.add(Duration(days: offset));
    ref.read(selectedDateProvider.notifier).setDate(newDate);
    ref.read(scheduledClassNotifierProvider.notifier).fetchByDate(newDate, silent: true);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scheduledClassNotifierProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final now = DateTime.now();
    final isToday = now.year == selectedDate.year &&
        now.month == selectedDate.month &&
        now.day == selectedDate.day;

    return Column(
      children: [
        // 增强型 Day Strip
        _buildEnhancedDayStrip(context, selectedDate),
        // 内容区域
        Expanded(
          child: state.when(
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
                    child: GestureDetector(
                      // 水平滑动切换日期
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity == null) return;
                        if (details.primaryVelocity! > 300) {
                          _changeDate(-1);
                        } else if (details.primaryVelocity! < -300) {
                          _changeDate(1);
                        }
                      },
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: SizedBox(
                          height: _totalHeight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 时间标签列
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
                              // 课程块列（支持重叠列布局）
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final availableWidth = constraints.maxWidth;
                                    return GestureDetector(
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
                                          // 课程色块（重叠时自动分列）
                                          ..._buildClassBlocksWithLayout(dayClasses, availableWidth),
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
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  /// 增强型 Day Strip：左侧月份导航 + 右侧7天横条
  Widget _buildEnhancedDayStrip(BuildContext context, DateTime selectedDate) {
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday % 7));
    final today = DateTime.now();

    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          // 左侧：月份导航
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, size: 20),
                onPressed: () => _navigateWeek(-1),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
              GestureDetector(
                onTap: () => _showDatePicker(selectedDate),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '${selectedDate.month}月',
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
          // 右侧：7天横条
          Expanded(
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
          ),
        ],
      ),
    );
  }

  void _navigateWeek(int direction) {
    final current = ref.read(selectedDateProvider);
    final newDate = current.add(Duration(days: direction * 7));
    ref.read(selectedDateProvider.notifier).setDate(newDate);
    ref.read(scheduledClassNotifierProvider.notifier).fetchByDate(newDate);
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
      ref.read(scheduledClassNotifierProvider.notifier).fetchByDate(picked);
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _weekdayShort(int weekday) {
    const days = ['一', '二', '三', '四', '五', '六', '日'];
    return days[weekday - 1];
  }

  /// 构建课程色块（支持重叠列布局）
  List<Widget> _buildClassBlocksWithLayout(List<ScheduledClass> classes, double width) {
    if (classes.isEmpty) return [];
    final layouts = _layoutClasses(classes);
    return layouts.map((entry) {
      final sc = entry.$1;
      final col = entry.$2;
      final totalCols = entry.$3;
      final startHour = sc.startTime.hour + sc.startTime.minute / 60;
      final durationHours = sc.endTime.difference(sc.startTime).inMinutes / 60;
      final top = startHour * _hourHeight;
      final height = durationHours * _hourHeight;
      final colWidth = (width - 8) / totalCols;

      return Positioned(
        top: top,
        left: 4 + col * colWidth,
        width: colWidth - 2,
        height: height.clamp(32.0, double.infinity),
        child: _buildClassBlock(sc),
      );
    }).toList();
  }

  /// 将重叠的课程分配到不同列
  /// 返回 [(课程, 列号, 总列数), ...]
  List<(ScheduledClass, int, int)> _layoutClasses(List<ScheduledClass> classes) {
    if (classes.isEmpty) return [];

    final sorted = List<ScheduledClass>.from(classes)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    // 分组：将时间重叠的课程归入同一组
    final groups = <List<int>>[];
    final assigned = <int>{};

    for (int i = 0; i < sorted.length; i++) {
      if (assigned.contains(i)) continue;
      final group = <int>[i];
      assigned.add(i);

      for (int j = i + 1; j < sorted.length; j++) {
        if (assigned.contains(j)) continue;
        for (final k in group) {
          if (_overlaps(sorted[k], sorted[j])) {
            group.add(j);
            assigned.add(j);
            break;
          }
        }
      }
      groups.add(group);
    }

    // 在每组内分配列号
    final layouts = <(ScheduledClass, int, int)>[];
    for (final group in groups) {
      final columns = <int>[]; // 每列的结束时间
      final colAssignments = <int, int>{};

      for (final idx in group) {
        final sc = sorted[idx];
        final startMs = sc.startTime.millisecondsSinceEpoch;
        int col = 0;
        while (col < columns.length && columns[col] > startMs) {
          col++;
        }
        colAssignments[idx] = col;
        if (col >= columns.length) {
          columns.add(sc.endTime.millisecondsSinceEpoch);
        } else {
          columns[col] = sc.endTime.millisecondsSinceEpoch;
        }
      }

      final totalCols = columns.length;
      for (final idx in group) {
        layouts.add((sorted[idx], colAssignments[idx]!, totalCols));
      }
    }

    return layouts;
  }

  /// 判断两节课是否时间重叠
  bool _overlaps(ScheduledClass a, ScheduledClass b) {
    return a.startTime.isBefore(b.endTime) && b.startTime.isBefore(a.endTime);
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
          margin: const EdgeInsets.symmetric(vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: blockColor.withOpacity(isCancelled ? 0.08 : 0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: blockColor.withOpacity(isCancelled ? 0.2 : 0.4),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
                '${_formatTime(sc.startTime)} - ${_formatTime(sc.endTime)}',
                style: TextStyle(
                  fontSize: 9,
                  color: blockColor.withOpacity(0.8),
                ),
              ),
              if (isCancelled)
                Text('已取消', style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
              if (isNoShow)
                Text('未到', style: TextStyle(fontSize: 9, color: Colors.orange.shade700)),
              if (isCompleted)
                Text('已完成', style: TextStyle(fontSize: 9, color: Colors.green.shade700)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaySummary(List<ScheduledClass> classes) {
    final active = classes.where((c) => c.status != ScheduledClassStatus.cancelled).toList();
    final completed = active.where((c) => c.status == ScheduledClassStatus.completed).length;
    final scheduled = active.where((c) => c.status == ScheduledClassStatus.scheduled).length;
    final noShow = active.where((c) => c.status == ScheduledClassStatus.noShow).length;
    final cancelled = classes.where((c) => c.status == ScheduledClassStatus.cancelled).length;

    final parts = ['今日 ${active.length} 节课 / 已完成 $completed / 待上 $scheduled'];
    if (noShow > 0) parts.add('未到 $noShow');
    if (cancelled > 0) parts.add('已取消 $cancelled');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.surface,
      child: Text(
        parts.join(' / '),
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
