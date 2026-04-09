import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/session_provider.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/states.dart';
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
  @override
  void initState() {
    super.initState();
    // 加载课时列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sessionNotifierProvider.notifier).fetchByCoursePlanId(widget.coursePlanId);
    });
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

          if (coursePlanSessions.isEmpty) {
            return _buildEmptyView();
          }

          return _buildSessionList(coursePlanSessions);
        },
      ),
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
            // 上课时间
            if (session.scheduledTime != null)
              Text(
                _formatDateTime(session.scheduledTime!),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
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

  /// 格式化日期时间
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.month}月${dateTime.day}日 ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
