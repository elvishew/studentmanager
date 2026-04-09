import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/session_provider.dart';
import 'package:student_manager/providers/states.dart';

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
          return _buildSessionTile(session);
        },
      ),
    );
  }

  /// 构建课时列表项
  Widget _buildSessionTile(Session session) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getStatusColor(session.status),
        child: Text(
          '${session.sessionNumber}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        '第 ${session.sessionNumber} 节课',
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
    );
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

/// 课时详情页
class SessionDetailPage extends ConsumerStatefulWidget {
  final int sessionId;

  const SessionDetailPage({
    super.key,
    required this.sessionId,
  });

  @override
  ConsumerState<SessionDetailPage> createState() => _SessionDetailPageState();
}

class _SessionDetailPageState extends ConsumerState<SessionDetailPage> {
  Session? _session;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  /// 加载课时详情
  Future<void> _loadSession() async {
    final notifier = ref.read(sessionNotifierProvider.notifier);
    final session = await notifier.getDetailById(widget.sessionId);
    if (mounted) {
      setState(() {
        _session = session;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_session == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('课时详情'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('第 ${_session!.sessionNumber} 节课'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 基本信息
            _buildSection(
              title: '基本信息',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('课时序号', '${_session!.sessionNumber}'),
                  _buildInfoRow('状态', _getStatusText(_session!.status)),
                  if (_session!.scheduledTime != null)
                    _buildInfoRow('上课时间', _formatDateTime(_session!.scheduledTime!)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 训练块列表
            _buildTrainingBlocksSection(),
          ],
        ),
      ),
    );
  }

  /// 构建训练块部分
  Widget _buildTrainingBlocksSection() {
    final trainingBlocks = _session!.trainingBlocks;

    if (trainingBlocks == null || trainingBlocks.isEmpty) {
      return _buildSection(
        title: '训练内容',
        child: const Center(
          child: Text('暂无训练内容'),
        ),
      );
    }

    return _buildSection(
      title: '训练内容',
      child: Column(
        children: trainingBlocks.asMap().entries.map((entry) {
          final index = entry.key;
          final block = entry.value;
          return _buildTrainingBlockTile(index + 1, block);
        }).toList(),
      ),
    );
  }

  /// 构建训练块卡片
  Widget _buildTrainingBlockTile(int number, TrainingBlock block) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 序号和自定义标记
            Row(
              children: [
                Text(
                  '训练块 $number',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 8),
                if (block.isCustom)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.purple, width: 1),
                    ),
                    child: const Text(
                      '自定义',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // 动作
            if (block.action != null)
              _buildDetailRow('动作', block.action!.name),
            // 器械
            if (block.equipment != null)
              _buildDetailRow('器械', block.equipment!.name),
            // 工具
            if (block.tool != null)
              _buildDetailRow('工具', block.tool!.name),
            const SizedBox(height: 4),
            // 次数、组数、时长、强度
            if (block.reps != null || block.sets != null)
              Row(
                children: [
                  if (block.reps != null) ...[
                    Expanded(child: _buildDetailItem('次数', block.reps!)),
                    const SizedBox(width: 8),
                  ],
                  if (block.sets != null) ...[
                    Expanded(child: _buildDetailItem('组数', block.sets!)),
                  ],
                ],
              ),
            if (block.duration != null)
              _buildDetailRow('时长', block.duration!),
            if (block.intensity != null)
              _buildDetailRow('强度', block.intensity!),
            // 备注
            if (block.notes != null && block.notes!.isNotEmpty)
              _buildDetailRow('备注', block.notes!),
          ],
        ),
      ),
    );
  }

  /// 构建信息行
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建详情行
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建详情项
  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  /// 构建部分
  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: child,
        ),
      ],
    );
  }

  /// 获取状态文本
  String _getStatusText(SessionStatus status) {
    switch (status) {
      case SessionStatus.pending:
        return '未开始';
      case SessionStatus.completed:
        return '已完成';
      case SessionStatus.skipped:
        return '已跳过';
    }
  }

  /// 格式化日期时间
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
