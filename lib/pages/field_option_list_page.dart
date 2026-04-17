import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/content_field_provider.dart';
import '../database/content_field_repository.dart';

/// 字段选项管理列表页
class FieldOptionListPage extends ConsumerStatefulWidget {
  final int fieldId;
  final String fieldName;

  const FieldOptionListPage({
    super.key,
    required this.fieldId,
    required this.fieldName,
  });

  @override
  ConsumerState<FieldOptionListPage> createState() => _FieldOptionListPageState();
}

class _FieldOptionListPageState extends ConsumerState<FieldOptionListPage> {
  late FieldOptionNotifier _notifier;
  FieldOptionState _state = const FieldOptionState();

  @override
  void initState() {
    super.initState();
    _notifier = FieldOptionNotifier(
      repository: ContentFieldRepository(database: ref.read(databaseProvider)),
      fieldId: widget.fieldId,
    );
    _notifier.fetchAll().then((_) {
      if (mounted) {
        setState(() {
          _state = _notifier.state;
        });
      }
    });
  }

  void _refresh() {
    if (mounted) {
      setState(() {
        _state = _notifier.state;
      });
    }
  }

  Future<void> _fetchAndRefresh() async {
    await _notifier.fetchAll();
    _refresh();
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.fieldName} - ${s.addOptionTooltip}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDialog(context),
            tooltip: s.addOptionTooltip,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: s.searchOptionHint,
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onChanged: (query) {
                _notifier.search(query);
              },
            ),
          ),
          Expanded(
            child: _state.status == BasicItemStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : _state.items.isEmpty
                    ? Center(child: Text(s.noOptionsMessage))
                    : ListView.builder(
                        itemCount: _state.items.length,
                        itemBuilder: (context, index) {
                          final item = _state.items[index];
                          return _buildItemTile(context, item);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemTile(BuildContext context, FieldOptionItem item) {
    final s = S.of(context)!;
    return ListTile(
      title: Text(
        item.name,
        style: TextStyle(
          decoration: item.isDeprecated ? TextDecoration.lineThrough : null,
          color: item.isDeprecated ? Theme.of(context).colorScheme.outline : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.isDeprecated)
            IconButton(
              icon: const Icon(Icons.restore, size: 20),
              onPressed: () async {
                await _notifier.toggleDeprecated(item.id, false);
                _fetchAndRefresh();
              },
              tooltip: s.activateTooltip,
            )
          else
            IconButton(
              icon: const Icon(Icons.pause_circle_outline, size: 20),
              onPressed: () async {
                await _notifier.toggleDeprecated(item.id, true);
                _fetchAndRefresh();
              },
              tooltip: s.deprecateTooltip,
            ),
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () => _showEditDialog(context, item),
            tooltip: s.edit,
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 20, color: Colors.red),
            onPressed: () => _confirmDelete(context, item),
            tooltip: s.btnDelete,
          ),
        ],
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    final s = S.of(context)!;
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        final s = S.of(context)!;
        return AlertDialog(
          title: Text(s.newOptionTitle),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: s.optionNameLabel,
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(s.cancel),
            ),
            TextButton(
              onPressed: () {
                final value = controller.text.trim();
                if (value.isNotEmpty) {
                  Navigator.pop(context, value);
                }
              },
              child: Text(s.confirm),
            ),
          ],
        );
      },
    );
    controller.dispose();

    if (result != null) {
      final id = await _notifier.create(result);
      if (id != null) {
        _fetchAndRefresh();
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.optionNameExists)),
        );
      }
    }
  }

  Future<void> _showEditDialog(BuildContext context, FieldOptionItem item) async {
    final controller = TextEditingController(text: item.name);
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        final s = S.of(context)!;
        return AlertDialog(
          title: Text(s.editOptionTitle),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: s.optionNameLabel,
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(s.cancel),
            ),
            TextButton(
              onPressed: () {
                final value = controller.text.trim();
                if (value.isNotEmpty) {
                  Navigator.pop(context, value);
                }
              },
              child: Text(s.confirm),
            ),
          ],
        );
      },
    );
    controller.dispose();

    if (result != null) {
      final success = await _notifier.update(item.id, result);
      if (success) {
        _fetchAndRefresh();
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)!.optionNameExists)),
        );
      }
    }
  }

  Future<void> _confirmDelete(BuildContext context, FieldOptionItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final s = S.of(context)!;
        return AlertDialog(
          title: Text(s.btnConfirmDelete),
          content: Text(s.confirmDeleteOptionMessage(item.name)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(s.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(s.btnDelete),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final result = await _notifier.delete(item.id);
      if (context.mounted) {
        final s = S.of(context)!;
        switch (result) {
          case DeleteItemResult.success:
            _fetchAndRefresh();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(s.optionDeleted)),
            );
          case DeleteItemResult.hasReferences:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(s.optionInUse)),
            );
          case DeleteItemResult.notFound:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(s.optionNotFound)),
            );
          case DeleteItemResult.error:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(s.saveFailed), backgroundColor: Colors.red),
            );
        }
      }
    }
  }
}
