import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/content_field_provider.dart';
import 'package:student_manager/providers/goal_config_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/widgets/content_block_editor.dart';
import 'package:student_manager/widgets/content_block_tile.dart';

/// 课时模板详情页（内容块编辑）
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
  List<ContentField> _contentFields = [];

  @override
  void initState() {
    super.initState();
    _session = widget.session;
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadContentFields();
    await _loadDetail();
  }

  Future<void> _loadContentFields() async {
    final notifier = ref.read(contentFieldNotifierProvider.notifier);
    final fields = await notifier.loadFields();
    if (mounted) {
      setState(() {
        _contentFields = fields;
      });
    }
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

  Future<void> _addContentBlock() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => ContentBlockEditor(
          sessionId: _session!.id,
          context: 'goal_config',
        ),
      ),
    );

    if (result == true && mounted) {
      await _loadDetail();
    }
  }

  Future<void> _editContentBlock(GoalConfigContentBlock block) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => ContentBlockEditor(
          sessionId: _session!.id,
          blockId: block.id,
          context: 'goal_config',
        ),
      ),
    );

    if (result == true && mounted) {
      await _loadDetail();
    }
  }

  Future<void> _deleteContentBlock(GoalConfigContentBlock block) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除内容块 ${block.sortOrder + 1} 吗？'),
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
          const SnackBar(content: Text('内容块已删除')),
        );
      }
    }
  }

  Future<void> _moveUp(GoalConfigContentBlock block) async {
    if (block.sortOrder > 0) {
      await ref.read(goalConfigNotifierProvider.notifier).reorderBlock(
            blockId: block.id,
            newSortOrder: block.sortOrder - 1,
          );
      if (mounted) await _loadDetail();
    }
  }

  Future<void> _moveDown(GoalConfigContentBlock block, int maxOrder) async {
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

    final contentBlocks = _session!.contentBlocks ?? [];
    final maxOrder = contentBlocks.isEmpty ? 0 : contentBlocks.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('第 ${_session!.sessionNumber} 节课模板'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildContentBlocksSection(contentBlocks, maxOrder),
      ),
    );
  }

  Widget _buildContentBlocksSection(List<GoalConfigContentBlock> blocks, int maxOrder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '教学内容',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton.icon(
              onPressed: _addContentBlock,
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
            child: const Center(child: Text('暂无教学内容')),
          )
        else
          Column(
            children: blocks.asMap().entries.map((entry) {
              final index = entry.key;
              final block = entry.value;
              return ContentBlockTile(
                block: block,
                number: index + 1,
                contentFields: _contentFields,
                maxOrder: maxOrder,
                onEdit: () => _editContentBlock(block),
                onDelete: () => _deleteContentBlock(block),
                onMoveUp: () => _moveUp(block),
                onMoveDown: () => _moveDown(block, maxOrder),
              );
            }).toList(),
          ),
      ],
    );
  }
}
