import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/providers/settings_provider.dart';
import 'package:student_manager/pages/scheduled_class_detail_page.dart';
import 'package:student_manager/pages/create_scheduled_class_dialog.dart';

/// 日视图：支持工作时间分段显示，左右滑动切换日期
class ScheduleDayView extends ConsumerStatefulWidget {
  const ScheduleDayView({super.key});

  @override
  ConsumerState<ScheduleDayView> createState() => _ScheduleDayViewState();
}

class _ScheduleDayViewState extends ConsumerState<ScheduleDayView> {
  late final ScrollController _scrollController;
  bool _hasScrolledOnMount = false;

  static const double _hourHeight = 80.0;
  static const double _timeLabelWidth = 48.0;
  static const double _breakHeight = 32.0; // 段间间隔高度
  static const double _contentPadding = 10.0; // 上下内边距，防止首尾标签被裁剪

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: _computeInitialOffset(),
    );
  }

  /// 有效的时间段列表：空配置 → 全天 0-24
  List<TimeSegment> get _effectiveSegments {
    final segments = ref.read(workingHoursNotifierProvider);
    if (segments.isEmpty) {
      return [const TimeSegment(start: 0, end: 24)];
    }
    return segments;
  }

  /// 计算 initState 时的初始滚动偏移（避免首帧闪烁）
  double _computeInitialOffset() {
    final now = DateTime.now();
    final selectedDate = ref.read(selectedDateProvider);
    final isToday = now.year == selectedDate.year &&
        now.month == selectedDate.month &&
        now.day == selectedDate.day;
    if (!isToday) return 0.0;

    final segments = _effectiveSegments;
    double targetHour = now.hour + now.minute / 60;
    if (!segments.any((s) => targetHour >= s.start && targetHour <= s.end)) {
      final nextSeg = segments.where((s) => s.start > targetHour).firstOrNull;
      targetHour = nextSeg?.start.toDouble() ?? segments.first.start.toDouble();
    }
    return (_hourToY(targetHour, segments) - 80).clamp(0.0, _totalHeight(segments));
  }

  /// 当前 watch 用的 segments（用于 build 中 watch）
  List<TimeSegment> _watchedSegments() {
    final segments = ref.watch(workingHoursNotifierProvider);
    if (segments.isEmpty) {
      return [const TimeSegment(start: 0, end: 24)];
    }
    return segments;
  }

  /// 总高度：各段时长之和 × _hourHeight + 段间间隔 + 上下内边距
  double _totalHeight(List<TimeSegment> segments) {
    final totalHours = segments.fold<double>(
      0,
      (sum, seg) => sum + (seg.end - seg.start),
    );
    final breakCount = segments.length > 1 ? segments.length - 1 : 0;
    return totalHours * _hourHeight + breakCount * _breakHeight + _contentPadding * 2;
  }

  /// 将真实小时映射到压缩视图的 Y 偏移（含顶部内边距）
  double _hourToY(double hour, List<TimeSegment> segments) {
    double y = _contentPadding;
    for (int i = 0; i < segments.length; i++) {
      final seg = segments[i];
      if (hour >= seg.start && hour <= seg.end) {
        return y + (hour - seg.start) * _hourHeight;
      }
      // 累加当前段的高度
      y += (seg.end - seg.start) * _hourHeight;
      // 加上段间间隔（非最后一段）
      if (i < segments.length - 1) {
        // 时间落在休息区：定位到休息区中间（与"休息"标签对齐）
        if (hour > seg.end && hour < segments[i + 1].start) {
          return y + _breakHeight / 2;
        }
        y += _breakHeight;
      }
    }
    // 超出范围时返回最后位置
    return y;
  }

  /// 将 Y 偏移反向映射为真实小时（减去顶部内边距）
  double _yToHour(double y, List<TimeSegment> segments) {
    double remaining = y - _contentPadding;
    if (remaining < 0) return segments.first.start.toDouble();
    for (int i = 0; i < segments.length; i++) {
      final seg = segments[i];
      final segHeight = (seg.end - seg.start) * _hourHeight;
      if (remaining <= segHeight) {
        return seg.start + remaining / _hourHeight;
      }
      remaining -= segHeight;
      // 跳过间隔区域，映射到下一段起始
      if (i < segments.length - 1) {
        if (remaining <= _breakHeight) {
          return segments[i + 1].start.toDouble();
        }
        remaining -= _breakHeight;
      }
    }
    // 兜底
    return segments.last.end.toDouble();
  }

  void _scrollToInitialPosition({List<ScheduledClass>? dayClasses, bool markScrolled = true}) {
    final now = DateTime.now();
    final selectedDate = ref.read(selectedDateProvider);
    final isToday = now.year == selectedDate.year &&
        now.month == selectedDate.month &&
        now.day == selectedDate.day;

    final segments = _effectiveSegments;
    double targetHour;
    if (isToday) {
      targetHour = now.hour + now.minute / 60;
      // 如果当前时间不在任何段内，定位到最近的段起始
      bool inAnySegment = segments.any((s) => targetHour >= s.start && targetHour <= s.end);
      if (!inAnySegment) {
        // 找到当前时间之后的第一个段
        final nextSeg = segments.where((s) => s.start > targetHour).firstOrNull;
        targetHour = nextSeg?.start.toDouble() ?? segments.first.start.toDouble();
      }
    } else {
      // 非今日：定位到第一节课的开始时间，无课则回到段起始
      if (dayClasses != null && dayClasses.isNotEmpty) {
        final sorted = List<ScheduledClass>.from(dayClasses)
          ..sort((a, b) => a.startTime.compareTo(b.startTime));
        targetHour = sorted.first.startTime.hour + sorted.first.startTime.minute / 60;
      } else {
        targetHour = segments.first.start.toDouble();
      }
    }

    final topPadding = isToday ? 80.0 : 20.0;
    final targetOffset = (_hourToY(targetHour, segments) - topPadding).clamp(0.0, _totalHeight(segments));

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(targetOffset.toDouble());
      if (markScrolled && !_hasScrolledOnMount) {
        _hasScrolledOnMount = true;
        setState(() {});
      }
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
    // watch segments 以响应设置变化
    final segments = _watchedSegments();

    // 监听日期变化自动滚动
    ref.listen(selectedDateProvider, (_, __) {
      _hasScrolledOnMount = false;
      // 粗定位（无 dayClasses），不标记完成，等 data 回调做精确定位
      _scrollToInitialPosition(markScrolled: false);
    });

    // 工作时间变化时重新定位
    ref.listen(workingHoursNotifierProvider, (prev, next) {
      if (prev != next) {
        _hasScrolledOnMount = false;
      }
    });

    // Tab 恢复可见时重新定位（配合 SchedulePage 的静默刷新）
    ref.listen(scheduleTabResumeProvider, (prev, next) {
      if (prev != next) {
        _hasScrolledOnMount = false;
      }
    });

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

              // 数据加载完成且尚未执行过初始滚动时，补一次滚动
              if (!_hasScrolledOnMount) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToInitialPosition(dayClasses: dayClasses);
                });
              }

              final content = Column(
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
                          height: _totalHeight(segments),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 时间标签列 + 段间隔标记
                              SizedBox(
                                width: _timeLabelWidth,
                                child: _buildTimeLabels(segments),
                              ),
                              // 课程块列（支持重叠列布局）
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final availableWidth = constraints.maxWidth;
                                    return GestureDetector(
                                      onTapUp: (details) {
                                        final hour = _yToHour(details.localPosition.dy, segments).clamp(0, 23);
                                        _showCreateDialog(hour.floor());
                                      },
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          // 网格线 + 段间隔
                                          ..._buildGridLinesAndBreaks(segments),
                                          // 课程色块（重叠时自动分列）
                                          ..._buildClassBlocksWithLayout(dayClasses, availableWidth, segments),
                                          // 当前时间指示线
                                          if (isToday)
                                            Positioned(
                                              top: _hourToY(now.hour + now.minute / 60, segments) - 4,
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

              // 非今日且滚动未完成时隐藏（避免从旧位置滑到新位置的动画）
              // 今日始终可见，保持原有行为
              if (isToday || _hasScrolledOnMount) return content;
              return Opacity(opacity: 0.0, child: content);
            },
          ),
        ),
      ],
    );
  }

  /// 构建时间标签列（含段间间隔标记）
  Widget _buildTimeLabels(List<TimeSegment> segments) {
    final items = <Widget>[];
    for (int i = 0; i < segments.length; i++) {
      final seg = segments[i];
      // 该段时间标签（含结束时间）
      for (int h = seg.start; h <= seg.end; h++) {
        final y = _hourToY(h.toDouble(), segments);
        items.add(Positioned(
          top: y - 9,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              '${h.toString().padLeft(2, '0')}:00',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
        ));
      }
      // 段间间隔
      if (i < segments.length - 1) {
        final breakY = _hourToY(seg.end.toDouble(), segments);
        items.add(Positioned(
          top: breakY,
          left: 0,
          right: 0,
          height: _breakHeight,
          child: Center(
            child: Text(
              '休息',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                  ),
            ),
          ),
        ));
      }
    }
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: items,
    );
  }

  /// 构建网格线和段间分隔
  List<Widget> _buildGridLinesAndBreaks(List<TimeSegment> segments) {
    final widgets = <Widget>[];
    double currentY = _contentPadding;

    for (int i = 0; i < segments.length; i++) {
      final seg = segments[i];
      final segHeight = (seg.end - seg.start) * _hourHeight;

      // 该段的网格线（含末尾边界线）
      for (int h = 0; h <= seg.end - seg.start; h++) {
        widgets.add(Positioned(
          top: currentY + h * _hourHeight,
          left: 0,
          right: 0,
          child: Container(
            height: h < seg.end - seg.start ? _hourHeight : 0,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
            ),
          ),
        ));
      }

      currentY += segHeight;

      // 段间分隔线
      if (i < segments.length - 1) {
        widgets.add(Positioned(
          top: currentY,
          left: 0,
          right: 0,
          height: _breakHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3),
              ),
            ],
          ),
        ));
        currentY += _breakHeight;
      }
    }

    return widgets;
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

  /// 构建课程色块（支持重叠列布局 + 时间段映射）
  List<Widget> _buildClassBlocksWithLayout(List<ScheduledClass> classes, double width, List<TimeSegment> segments) {
    if (classes.isEmpty) return [];
    final layouts = _layoutClasses(classes);
    return layouts.map((entry) {
      final sc = entry.$1;
      final col = entry.$2;
      final totalCols = entry.$3;
      final startHour = sc.startTime.hour + sc.startTime.minute / 60;
      final durationHours = sc.endTime.difference(sc.startTime).inMinutes / 60;
      final top = _hourToY(startHour, segments);
      final rawHeight = durationHours * _hourHeight;
      final height = rawHeight.clamp(32.0, double.infinity);
      final colWidth = (width - 8) / totalCols;

      return Positioned(
        top: top,
        left: 4 + col * colWidth,
        width: colWidth - 2,
        height: height,
        child: _buildClassBlock(sc, height),
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

  Widget _buildClassBlock(ScheduledClass sc, double blockHeight) {
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
          margin: const EdgeInsets.symmetric(vertical: 1),
          padding: const EdgeInsets.fromLTRB(6, 4, 4, 4),
          decoration: BoxDecoration(
            color: blockColor.withOpacity(fillOpacity),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
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
              ),
              if (isCompleted)
                Icon(Icons.check, size: 14, color: blockColor.withOpacity(0.7)),
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
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return null;
    }
  }

}
