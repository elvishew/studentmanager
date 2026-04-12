import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/goal_config_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'goal_config_training_block_form_page.dart';

/// 课时模板详情页（训练块编辑）
class GoalConfigSessionDetailPage extends ConsumerStatefulWidget {
  final GoalConfigSession session;

  const GoalConfigSessionDetailPage({
    super.key,
    required this.session,
  });

  @override
  ConsumerState<GoalConfigSessionDetailPage> createState() => _GoalConfigSessionDetailPageState();
}

class _GoalConfigSessionDetailPageState extends ConsumerState<GoalConfigSessionDetailPage> {
  GoalConfigSession? _session;

  @override
  void initState() {
    super.initState();
    _session = widget.session;
  }

  Future<void> _loadDetail() async {
    final configId = _session!.goalConfigId;
    final detail = await ref.read(goalConfigNotifierProvider.notifier).fetchDetail(configId);
    if (detail != null && mounted) {
      final session = detail.sessions?.where((s) => s.id == _session!.id).firstOrNull;
      if (session != null && mounted) {
        setState(() => _session = session);
      }
    }
  }

  /// 添加训练块
  Future<void> _addTrainingBlock() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => GoalConfigTrainingBlockFormPage(
          goalConfigSessionId: _session!.id,
        ),
      ),
    );

    if (result == true && mounted) {
      await _loadDetail();
    }
  }

  /// 编辑训练块
  Future<void> _editTrainingBlock(GoalConfigTrainingBlock block) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => GoalConfigTrainingBlockFormPage(
          goalConfigSessionId: _session!.id,
          blockId: block.id,
        ),
      ),
    );

    if (result == true && mounted) {
      await _loadDetail();
    }
  }

  /// 删除训练块
  Future<void> _deleteTrainingBlock(GoalConfigTrainingBlock block) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除训练块 ${block.sortOrder + 1} 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(goalConfigNotifierProvider.notifier).deleteBlock(block.id);
      if (mounted) {
        await _loadDetail();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('训练块已删除')),
        );
      }
    }
  }

  /// 上移训练块
  Future<void> _moveUp(GoalConfigTrainingBlock block) async {
    if (block.sortOrder > 0) {
      await ref.read(goalConfigNotifierProvider.notifier).reorderBlock(
            blockId: block.id,
            newSortOrder: block.sortOrder - 1,
          );
      if (mounted) await _loadDetail();
    }
  }

  /// 下移训练块
  Future<void> _moveDown(GoalConfigTrainingBlock block, int maxOrder) async {
    if (block.sortOrder < maxOrder) {
      await ref.read(goalConfigNotifierProvider.notifier).reorderBlock(
            blockId: block.id,
            newSortOrder: block.sortOrder + 1,
          );
      if (mounted) await _loadDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_session == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('课时模板详情')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final trainingBlocks = _session!.trainingBlocks ?? [];
    final maxOrder = trainingBlocks.isEmpty ? 0 : trainingBlocks.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('第 ${_session!.sessionNumber} 节课模板'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildTrainingBlocksSection(trainingBlocks, maxOrder),
      ),
    );
  }

  /// 构建训练块部分
  Widget _buildTrainingBlocksSection(List<GoalConfigTrainingBlock> blocks, int maxOrder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '训练内容',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton.icon(
              onPressed: _addTrainingBlock,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('添加'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (blocks.isEmpty)
          Container(
            padding: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Center(
              child: Text('暂无训练内容'),
            ),
          )
        else
          Column(
            children: blocks.asMap().entries.map((entry) {
              final index = entry.key;
              final block = entry.value;
              return _buildTrainingBlockTile(index + 1, block, maxOrder);
            }).toList(),
          ),
      ],
    );
  }

  /// 构建训练块卡片
  Widget _buildTrainingBlockTile(int number, GoalConfigTrainingBlock block, int maxOrder) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 序号、操作按钮
            Row(
              children: [
                Text(
                  '训练块 $number',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.arrow_upward, size: 18),
                  tooltip: '上移',
                  onPressed: block.sortOrder > 0 ? () => _moveUp(block) : null,
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_downward, size: 18),
                  tooltip: '下移',
                  onPressed: block.sortOrder < maxOrder ? () => _moveDown(block, maxOrder) : null,
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  tooltip: '编辑',
                  onPressed: () => _editTrainingBlock(block),
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18),
                  tooltip: '删除',
                  onPressed: () => _deleteTrainingBlock(block),
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (block.action != null)
              _buildDetailRow('动作', block.action!.name),
            if (block.equipment != null)
              _buildDetailRow('器械', block.equipment!.name),
            if (block.tool != null)
              _buildDetailRow('工具', block.tool!.name),
            const SizedBox(height: 4),
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
            if (block.notes != null && block.notes!.isNotEmpty)
              _buildDetailRow('备注', block.notes!),
          ],
        ),
      ),
    );
  }

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
}
