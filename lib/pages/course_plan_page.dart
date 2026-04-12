import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/session_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/widgets/session_action_dialogs.dart';
import 'edit_course_plan_dialog.dart';
import 'session_detail_page.dart';

/// 课程规划页
class CoursePlanPage extends ConsumerStatefulWidget {
  final int coursePlanId;

  const CoursePlanPage({
    super.key,
    required this.coursePlanId,
  });

  @override
  ConsumerState<CoursePlanPage> createState() => _CoursePlanPageState();
}

class _CoursePlanPageState extends ConsumerState<CoursePlanPage> {
  CoursePlan? _coursePlan;

  @override
  void initState() {
    super.initState();
    // 加载课程规划详情和课时列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCoursePlan();
      ref.read(sessionNotifierProvider.notifier).fetchByCoursePlanId(widget.coursePlanId);
    });
  }

  Future<void> _loadCoursePlan() async {
    final plan = await ref.read(coursePlanNotifierProvider.notifier).getDetailById(widget.coursePlanId);
    if (plan != null && mounted) {
      setState(() {
        _coursePlan = plan;
      });
    }
  }

  /// 跳转到课时详情页
  void _navigateToSessionDetail(int sessionId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SessionDetailPage(
          sessionId: sessionId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(sessionNotifierProvider);
    final stats = ref.watch(sessionStatisticsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('课程规划'),
      ),
      body: sessionState.when(
        initial: () => _buildInitialView(),
        loading: () => _buildLoadingView(),
        error: (error, stackTrace) => _buildErrorView(error),
        data: (sessions, selectedSession, coursePlanId) {
          // 过滤出当前课程规划的课时
          final coursePlanSessions = sessions
              .where((session) => session.coursePlanId == widget.coursePlanId)
              .toList();

          return Column(
            children: [
              // 课程目标 + 蓝图信息卡片
              _buildCourseInfoCard(theme),
              // 进度统计
              if (coursePlanSessions.isNotEmpty)
                _buildProgressStats(stats, theme),
              const Divider(height: 1),
              // 课时列表
              Expanded(
                child: coursePlanSessions.isEmpty
                    ? _buildEmptyView()
                    : _buildSessionList(coursePlanSessions),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 构建课程信息卡片（课程目标 + 蓝图）
  Widget _buildCourseInfoCard(ThemeData theme) {
    final goal = _coursePlan?.goalName ?? '';
    final blueprint = _coursePlan?.blueprint;
    final defaultDuration = _coursePlan?.defaultDuration ?? 60;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flag_outlined,
                size: 18,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                '课程目标',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (_coursePlan != null)
                SizedBox(
                  height: 32,
                  width: 32,
                  child: IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    tooltip: '编辑课程规划',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    onPressed: _handleEditCoursePlan,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            goal.isNotEmpty ? goal : '未设置',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: goal.isNotEmpty ? null : theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                size: 14,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(width: 4),
              Text(
                '默认时长: $defaultDuration 分钟',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
          if (blueprint != null && blueprint.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 16,
                  color: theme.colorScheme.outline,
                ),
                const SizedBox(width: 6),
                Text(
                  '蓝图',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              blueprint,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }

  /// 编辑课程规划（目标 + 蓝图）
  Future<void> _handleEditCoursePlan() async {
    if (_coursePlan == null) return;

    final saved = await showEditCoursePlanDialog(
      context,
      coursePlan: _coursePlan!,
    );

    if (saved && mounted) {
      // 重新加载课程规划详情以刷新UI
      await _loadCoursePlan();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('课程规划已更新')),
        );
      }
    }
  }

  /// 构建进度统计组件
  Widget _buildProgressStats(SessionStatistics stats, ThemeData theme) {
    final remaining = stats.total - stats.completed - stats.skipped;
    final percent = (stats.completionRate * 100).toInt();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          // 进度条
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: stats.completionRate.clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$percent%',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 统计数字
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                theme: theme,
                label: '总课时',
                value: '${stats.total}',
                color: theme.colorScheme.onSurface,
              ),
              _buildStatItem(
                theme: theme,
                label: '已完成',
                value: '${stats.completed}',
                color: Colors.green,
              ),
              _buildStatItem(
                theme: theme,
                label: '未开始',
                value: '$remaining',
                color: Colors.orange,
              ),
              _buildStatItem(
                theme: theme,
                label: '已跳过',
                value: '${stats.skipped}',
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建单个统计项
  Widget _buildStatItem({
    required ThemeData theme,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
      ],
    );
  }

  /// 构建初始视图
  Widget _buildInitialView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// 构建加载视图
  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// 构建错误视图
  Widget _buildErrorView(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            '加载失败',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(sessionNotifierProvider.notifier).fetchByCoursePlanId(widget.coursePlanId);
            },
            icon: const Icon(Icons.refresh),
            label: const Text('重试'),
          ),
        ],
      ),
    );
  }

  /// 构建空视图
  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_note,
            size: 48,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无课时',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }

  /// 构建课时列表
  Widget _buildSessionList(List<Session> sessions) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(sessionNotifierProvider.notifier).fetchByCoursePlanId(widget.coursePlanId);
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: sessions.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final session = sessions[index];
          return _buildSessionTile(index, session);
        },
      ),
    );
  }

  /// 构建课时列表项（带滑动删除功能）
  Widget _buildSessionTile(int index, Session session) {
    // 使用索引+1作为显示序号，这样删除课后序号会自动调整
    final displayNumber = index + 1;

    return Dismissible(
      key: Key('session_${session.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white, size: 32),
      ),
      confirmDismiss: (direction) async {
        return await _showDeleteSessionDialog(session, displayNumber);
      },
      onDismissed: (direction) {
        // 删除逻辑在对话框确认后执行，这里不需要额外操作
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(session.status),
          child: Text(
            '$displayNumber',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          '第 $displayNumber 节课',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 状态标签
            _buildStatusLabel(session.status),
            // 上课时间 + 时长
            if (session.scheduledTime != null)
              Text(
                _formatSessionTime(session),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 预约按钮
            _buildActionButton(
              icon: Icons.event_available_outlined,
              tooltip: '预约时间',
              onTap: () => _handleSchedule(session),
            ),
            // 完成按钮
            _buildActionButton(
              icon: Icons.check_circle_outline,
              tooltip: '标记完成',
              onTap: () => _handleComplete(session, displayNumber),
            ),
            // 跳过按钮
            _buildActionButton(
              icon: Icons.skip_next_outlined,
              tooltip: '跳过',
              onTap: () => _handleSkip(session, displayNumber),
            ),
            // 详情箭头
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: () => _navigateToSessionDetail(session.id),
      ),
    );
  }

  /// 显示删除课时确认对话框
  Future<bool?> _showDeleteSessionDialog(Session session, int displayNumber) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('删除课时'),
        content: Text(
          '确定要删除「第$displayNumber节课」吗？\n\n'
          '删除后将同时删除该课时的所有训练记录，此操作不可恢复。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context, true);
              await _deleteSession(session.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('确认删除'),
          ),
        ],
      ),
    );
  }

  /// 删除课时
  Future<void> _deleteSession(int sessionId) async {
    try {
      final notifier = ref.read(sessionNotifierProvider.notifier);
      final success = await notifier.deleteSession(sessionId: sessionId);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('课时已删除')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('删除失败：$e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 构建状态标签
  Widget _buildStatusLabel(SessionStatus status) {
    Color color;
    String label;

    switch (status) {
      case SessionStatus.pending:
        color = Colors.orange;
        label = '未开始';
        break;
      case SessionStatus.completed:
        color = Colors.green;
        label = '已完成';
        break;
      case SessionStatus.skipped:
        color = Colors.grey;
        label = '已跳过';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 根据状态获取颜色
  Color _getStatusColor(SessionStatus status) {
    switch (status) {
      case SessionStatus.pending:
        return Colors.orange;
      case SessionStatus.completed:
        return Colors.green;
      case SessionStatus.skipped:
        return Colors.grey;
    }
  }

  /// 格式化课时时间（含时长）
  String _formatSessionTime(Session session) {
    final scheduledTime = session.scheduledTime!;
    final duration = session.durationOverride ?? (_coursePlan?.defaultDuration ?? 60);
    final endTime = scheduledTime.add(Duration(minutes: duration));
    return '${scheduledTime.month}月${scheduledTime.day}日 '
           '${scheduledTime.hour.toString().padLeft(2, '0')}:${scheduledTime.minute.toString().padLeft(2, '0')}'
           ' - '
           '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
  }

  /// 构建快捷操作按钮
  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        icon: Icon(icon, size: 20),
        tooltip: tooltip,
        onPressed: onTap,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        padding: EdgeInsets.zero,
      ),
    );
  }

  /// 预约时间
  Future<void> _handleSchedule(Session session) async {
    final scheduledTime = await selectDateTime(context);
    if (scheduledTime == null) return;

    final notifier = ref.read(sessionNotifierProvider.notifier);
    final success = await notifier.updateSession(
      sessionId: session.id,
      scheduledTime: scheduledTime,
    );

    if (mounted) {
      _showResultSnackBar(success, '预约时间已设置');
    }
  }

  /// 标记完成
  Future<void> _handleComplete(Session session, int displayNumber) async {
    // 验证：必须先预约
    if (session.scheduledTime == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('请先预约上课时间'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    // 确认对话框
    final confirmed = await showConfirmActionDialog(
      context,
      title: '标记为已完成',
      content: '确定要将第$displayNumber节课标记为已完成吗？',
      confirmText: '确认',
    );

    if (confirmed != true) return;

    // 更新状态
    final notifier = ref.read(sessionNotifierProvider.notifier);
    final success = await notifier.updateSession(
      sessionId: session.id,
      status: SessionStatus.completed,
    );

    if (mounted) {
      _showResultSnackBar(success, '已标记为完成');
    }
  }

  /// 跳过课时
  Future<void> _handleSkip(Session session, int displayNumber) async {
    // 确认对话框
    final confirmed = await showConfirmActionDialog(
      context,
      title: '标记为已跳过',
      content: '确定要将第$displayNumber节课标记为已跳过吗？',
      confirmText: '确认',
    );

    if (confirmed != true) return;

    // 更新状态
    final notifier = ref.read(sessionNotifierProvider.notifier);
    final success = await notifier.updateSession(
      sessionId: session.id,
      status: SessionStatus.skipped,
    );

    if (mounted) {
      _showResultSnackBar(success, '已标记为跳过');
    }
  }

  /// 显示操作结果
  void _showResultSnackBar(bool success, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? message : '操作失败，请重试'),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }
}
