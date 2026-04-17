import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/content_field_provider.dart';
import 'package:student_manager/providers/goal_config_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/l10n/app_localizations.dart';
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
      builder: (context) {
        final s = S.of(context)!;
        return AlertDialog(
          title: Text(s.btnConfirmDelete),
          content: Text(s.confirmDeleteContentBlockMessage(block.sortOrder + 1)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(s.btnCancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: Text(s.btnDelete),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await ref.read(goalConfigNotifierProvider.notifier).deleteBlock(block.id);
      if (mounted) {
        await _loadDetail();
        final s = S.of(this.context)!;
        ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(content: Text(s.contentBlockDeleted)),
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
    final s = S.of(context)!;

    if (_session == null) {
      return Scaffold(
        appBar: AppBar(title: Text(s.sessionTemplateDetailTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final contentBlocks = _session!.contentBlocks ?? [];
    final maxOrder = contentBlocks.isEmpty ? 0 : contentBlocks.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.sessionTemplateNumber(_session!.sessionNumber)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildContentBlocksSection(contentBlocks, maxOrder),
      ),
    );
  }

  Widget _buildContentBlocksSection(List<GoalConfigContentBlock> blocks, int maxOrder) {
    final s = S.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              s.teachingContentSection,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton.icon(
              onPressed: _addContentBlock,
              icon: const Icon(Icons.add, size: 18),
              label: Text(s.addContentButton),
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
            child: Center(child: Text(s.noTeachingContentMessage)),
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
