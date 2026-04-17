import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/l10n/enum_localizations.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/session_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/widgets/session_action_dialogs.dart';
import 'edit_course_plan_dialog.dart';
import 'session_detail_page.dart';
import 'create_scheduled_class_dialog.dart';

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
    final s = S.of(context)!;
    final sessionState = ref.watch(sessionNotifierProvider);
    final stats = ref.watch(sessionStatisticsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.coursePlanPageTitle),
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
    final s = S.of(context)!;
    final goal = _coursePlan?.goalName ?? '';
    final blueprint = _coursePlan?.blueprint;

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
                s.courseGoalSectionLabel,
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
                    tooltip: s.editCoursePlanTooltip,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    onPressed: _handleEditCoursePlan,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            goal.isNotEmpty ? goal : s.goalNotSet,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: goal.isNotEmpty ? null : theme.colorScheme.outline,
            ),
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
                  s.blueprintSectionLabel,
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
        final s = S.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.coursePlanUpdated)),
        );
      }
    }
  }

  /// 构建进度统计组件
  Widget _buildProgressStats(SessionStatistics stats, ThemeData theme) {
    final s = S.of(context)!;
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
                label: s.totalSessionsLabel,
                value: '${stats.total}',
                color: theme.colorScheme.onSurface,
              ),
              _buildStatItem(
                theme: theme,
                label: s.completedSessionsLabel,
                value: '${stats.completed}',
                color: Colors.green,
              ),
              _buildStatItem(
                theme: theme,
                label: s.pendingSessionsLabel,
                value: '$remaining',
                color: Colors.orange,
              ),
              _buildStatItem(
                theme: theme,
                label: s.skippedSessionsLabel,
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
    final s = S.of(context)!;
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
            s.loadingFailedMessage,
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
            label: Text(s.retry),
          ),
        ],
      ),
    );
  }

  /// 构建空视图
  Widget _buildEmptyView() {
    final s = S.of(context)!;
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
            s.noSessionsMessage,
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
    final s = S.of(context)!;
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
          s.sessionNumberDisplay(displayNumber),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: _buildStatusLabel(session.status),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 排课按钮（仅未开始的课时显示）
            if (session.status == SessionStatus.pending)
              _buildActionButton(
                icon: Icons.schedule,
                tooltip: s.scheduleClassTooltip,
                onTap: () => _handleScheduleSession(session, displayNumber),
              ),
            // 完成按钮
            _buildActionButton(
              icon: Icons.check_circle_outline,
              tooltip: s.markCompletedTooltip,
              onTap: () => _handleComplete(session, displayNumber),
            ),
            // 跳过按钮
            _buildActionButton(
              icon: Icons.skip_next_outlined,
              tooltip: s.skipTooltip,
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
      builder: (context) {
        final s = S.of(context)!;
        return AlertDialog(
          icon: const Icon(Icons.warning, color: Colors.red, size: 48),
          title: Text(s.deleteSessionTitle),
          content: Text(
            s.confirmDeleteSessionMessage(displayNumber),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(s.btnCancel),
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
              child: Text(s.btnConfirmDelete),
            ),
          ],
        );
      },
    );
  }

  /// 删除课时
  Future<void> _deleteSession(int sessionId) async {
    try {
      final notifier = ref.read(sessionNotifierProvider.notifier);
      final success = await notifier.deleteSession(sessionId: sessionId);

      if (success && mounted) {
        final s = S.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.sessionDeleted)),
        );
      }
    } catch (e) {
      if (mounted) {
        final s = S.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s.deleteSessionFailed(e.toString())),
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
        label = status.loc(context);
        break;
      case SessionStatus.completed:
        color = Colors.green;
        label = status.loc(context);
        break;
      case SessionStatus.skipped:
        color = Colors.grey;
        label = status.loc(context);
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

  /// 标记完成
  Future<void> _handleComplete(Session session, int displayNumber) async {
    final s = S.of(context)!;
    // 确认对话框
    final confirmed = await showConfirmActionDialog(
      context,
      title: s.confirmMarkCompletedTitle,
      content: s.confirmMarkCompletedMessage(displayNumber),
      confirmText: s.btnConfirm,
    );

    if (confirmed != true) return;

    // 更新状态
    final notifier = ref.read(sessionNotifierProvider.notifier);
    final success = await notifier.updateSessionStatus(
      sessionId: session.id,
      status: SessionStatus.completed,
    );

    if (mounted) {
      _showResultSnackBar(success, S.of(context)!.markedAsCompleted);
    }
  }

  /// 跳过课时
  Future<void> _handleSkip(Session session, int displayNumber) async {
    final s = S.of(context)!;
    // 确认对话框
    final confirmed = await showConfirmActionDialog(
      context,
      title: s.confirmMarkSkippedTitle,
      content: s.confirmMarkSkippedMessage(displayNumber),
      confirmText: s.btnConfirm,
    );

    if (confirmed != true) return;

    // 更新状态
    final notifier = ref.read(sessionNotifierProvider.notifier);
    final success = await notifier.updateSessionStatus(
      sessionId: session.id,
      status: SessionStatus.skipped,
    );

    if (mounted) {
      _showResultSnackBar(success, S.of(context)!.markedAsSkipped);
    }
  }

  /// 排课：为课时创建排课记录
  Future<void> _handleScheduleSession(Session session, int displayNumber) async {
    // 获取学员 ID
    final studentId = _coursePlan?.studentId;
    if (studentId == null) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CreateScheduledClassDialog(
        preselectedSessionId: session.id,
        preselectedStudentId: studentId,
      ),
    );
  }

  /// 显示操作结果
  void _showResultSnackBar(bool success, String message) {
    final s = S.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? message : s.operationFailed),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }
}
