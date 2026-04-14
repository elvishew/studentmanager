import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/content_field_provider.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/session_provider.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/widgets/content_block_editor.dart';
import 'package:student_manager/widgets/content_block_tile.dart';
import 'package:student_manager/widgets/session_action_dialogs.dart';

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
  List<ContentField> _contentFields = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadContentFields();
    await _loadSession();
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

  Future<void> _loadSession() async {
    final notifier = ref.read(sessionNotifierProvider.notifier);
    final session = await notifier.getDetailById(widget.sessionId);
    if (mounted) {
      setState(() {
        _session = session;
      });
    }
  }

  Future<void> _addContentBlock() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => ContentBlockEditor(
          sessionId: widget.sessionId,
          context: 'session',
        ),
      ),
    );

    if (result == true && mounted) {
      await _loadSession();
    }
  }

  Future<void> _editContentBlock(ContentBlock block) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => ContentBlockEditor(
          sessionId: widget.sessionId,
          blockId: block.id,
          context: 'session',
        ),
      ),
    );

    if (result == true && mounted) {
      await _loadSession();
    }
  }

  Future<void> _deleteContentBlock(ContentBlock block) async {
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
      final notifier = ref.read(contentBlockNotifierProvider.notifier);
      await notifier.deleteContentBlock(block.id);
      if (mounted) {
        await _loadSession();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('内容块已删除')),
        );
      }
    }
  }

  Future<void> _showDeleteSessionDialog() async {
    if (_session == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('删除课时'),
        content: Text(
          '确定要删除「第${_session!.sessionNumber}节课」吗？\n\n'
          '删除后将同时删除该课时的所有教学记录，此操作不可恢复。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('确认删除'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await _deleteSession();
    }
  }

  Future<void> _deleteSession() async {
    try {
      final notifier = ref.read(sessionNotifierProvider.notifier);
      final success = await notifier.deleteSession(sessionId: widget.sessionId);

      if (success && mounted) {
        Navigator.of(context).pop();
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

  Future<void> _showStatusChangeDialog() async {
    if (_session == null) return;

    final statuses = [
      SessionStatus.pending,
      SessionStatus.completed,
      SessionStatus.skipped,
    ];

    final result = await showDialog<SessionStatus>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('更改状态'),
        children: statuses.map((status) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, status),
            child: Row(
              children: [
                Icon(
                  status == _session!.status ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(status.label),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (result != null && result != _session!.status && mounted) {
      final notifier = ref.read(sessionNotifierProvider.notifier);
      final success = await notifier.updateSessionStatus(
        sessionId: widget.sessionId,
        status: result,
      );

      if (mounted) {
        if (success) {
          await _loadSession();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('更新失败'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  Future<void> _moveUpContentBlock(ContentBlock block) async {
    if (block.sortOrder > 0) {
      final notifier = ref.read(contentBlockNotifierProvider.notifier);
      await notifier.reorderContentBlock(
        blockId: block.id,
        newSortOrder: block.sortOrder - 1,
      );
      if (mounted) await _loadSession();
    }
  }

  Future<void> _moveDownContentBlock(ContentBlock block, int maxOrder) async {
    if (block.sortOrder < maxOrder) {
      final notifier = ref.read(contentBlockNotifierProvider.notifier);
      await notifier.reorderContentBlock(
        blockId: block.id,
        newSortOrder: block.sortOrder + 1,
      );
      if (mounted) await _loadSession();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_session == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('课时详情')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final contentBlocks = _session!.contentBlocks ?? [];
    final maxOrder = contentBlocks.isEmpty ? 0 : contentBlocks.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('第 ${_session!.sessionNumber} 节课'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: _showStatusChangeDialog,
            tooltip: '更改状态',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            onPressed: () => _showDeleteSessionDialog(),
            tooltip: '删除课时',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: '基本信息',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('课时序号', '${_session!.sessionNumber}'),
                  _buildInfoRow('状态', _getStatusText(_session!.status)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildContentBlocksSection(contentBlocks, maxOrder),
          ],
        ),
      ),
    );
  }

  Widget _buildContentBlocksSection(List<ContentBlock> contentBlocks, int maxOrder) {
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
        if (contentBlocks.isEmpty)
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
            children: contentBlocks.asMap().entries.map((entry) {
              final index = entry.key;
              final block = entry.value;
              return ContentBlockTile(
                block: block,
                number: index + 1,
                contentFields: _contentFields,
                maxOrder: maxOrder,
                onEdit: () => _editContentBlock(block),
                onDelete: () => _deleteContentBlock(block),
                onMoveUp: () => _moveUpContentBlock(block),
                onMoveDown: () => _moveDownContentBlock(block, maxOrder),
              );
            }).toList(),
          ),
      ],
    );
  }

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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
