import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.fieldName} - 选项管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDialog(context),
            tooltip: '新增选项',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索选项...',
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
                    ? const Center(child: Text('暂无选项'))
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
              tooltip: '启用',
            )
          else
            IconButton(
              icon: const Icon(Icons.pause_circle_outline, size: 20),
              onPressed: () async {
                await _notifier.toggleDeprecated(item.id, true);
                _fetchAndRefresh();
              },
              tooltip: '弃用',
            ),
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () => _showEditDialog(context, item),
            tooltip: '编辑',
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 20, color: Colors.red),
            onPressed: () => _confirmDelete(context, item),
            tooltip: '删除',
          ),
        ],
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('新增选项'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: '选项名称',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                Navigator.pop(context, value);
              }
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
    controller.dispose();

    if (result != null) {
      final id = await _notifier.create(result);
      if (id != null) {
        _fetchAndRefresh();
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('该选项名称已存在')),
        );
      }
    }
  }

  Future<void> _showEditDialog(BuildContext context, FieldOptionItem item) async {
    final controller = TextEditingController(text: item.name);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑选项'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: '选项名称',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                Navigator.pop(context, value);
              }
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
    controller.dispose();

    if (result != null) {
      final success = await _notifier.update(item.id, result);
      if (success) {
        _fetchAndRefresh();
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('该选项名称已存在')),
        );
      }
    }
  }

  Future<void> _confirmDelete(BuildContext context, FieldOptionItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除选项「${item.name}」吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final result = await _notifier.delete(item.id);
      if (context.mounted) {
        switch (result) {
          case DeleteItemResult.success:
            _fetchAndRefresh();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('选项已删除')),
            );
          case DeleteItemResult.hasReferences:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('该选项已被使用，无法删除')),
            );
          case DeleteItemResult.notFound:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('选项不存在')),
            );
          case DeleteItemResult.error:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('删除失败'), backgroundColor: Colors.red),
            );
        }
      }
    }
  }
}
