import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/l10n/enum_localizations.dart';
import 'package:student_manager/providers/content_field_provider.dart';
import 'package:student_manager/providers/session_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/widgets/content_block_editor.dart';
import 'package:student_manager/widgets/content_block_tile.dart';

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
              child: Text(s.btnConfirmDelete),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final notifier = ref.read(contentBlockNotifierProvider.notifier);
      await notifier.deleteContentBlock(block.id);
      if (mounted) {
        await _loadSession();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)!.contentBlockDeleted)),
        );
      }
    }
  }

  Future<void> _showDeleteSessionDialog() async {
    if (_session == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final s = S.of(context)!;
        return AlertDialog(
          icon: const Icon(Icons.warning, color: Colors.red, size: 48),
          title: Text(s.deleteSessionTitle),
          content: Text(s.confirmDeleteSessionMessage(_session!.sessionNumber)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(s.btnCancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
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

    if (confirmed == true && mounted) {
      await _deleteSession();
    }
  }

  Future<void> _deleteSession() async {
    try {
      final notifier = ref.read(sessionNotifierProvider.notifier);
      final success = await notifier.deleteSession(sessionId: widget.sessionId);

      if (success && mounted) {
        final s = S.of(context)!;
        Navigator.of(context).pop();
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

  Future<void> _showStatusChangeDialog() async {
    if (_session == null) return;

    final statuses = [
      SessionStatus.pending,
      SessionStatus.completed,
      SessionStatus.skipped,
    ];

    final result = await showDialog<SessionStatus>(
      context: context,
      builder: (context) {
        final s = S.of(context)!;
        return SimpleDialog(
          title: Text(s.changeStatusTitle),
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
                  Text(status.loc(context)),
                ],
              ),
            );
          }).toList(),
        );
      },
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
            SnackBar(content: Text(S.of(context)!.updateFailed), backgroundColor: Colors.red),
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
    final s = S.of(context)!;
    if (_session == null) {
      return Scaffold(
        appBar: AppBar(title: Text(s.sessionDetailTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final contentBlocks = _session!.contentBlocks ?? [];
    final maxOrder = contentBlocks.isEmpty ? 0 : contentBlocks.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.sessionNumberDetail(_session!.sessionNumber)),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: _showStatusChangeDialog,
            tooltip: s.changeStatusTitle,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            onPressed: () => _showDeleteSessionDialog(),
            tooltip: s.deleteSessionTooltip,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: s.basicInfoSection,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(s.sessionNumberLabelDetail, '${_session!.sessionNumber}'),
                  _buildInfoRow(s.statusLabel, _getStatusText(_session!.status)),
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
        if (contentBlocks.isEmpty)
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
    return status.loc(context);
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
