import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/content_field_provider.dart';

/// 课程目标管理列表页
class GoalListPage extends ConsumerStatefulWidget {
  const GoalListPage({super.key});

  @override
  ConsumerState<GoalListPage> createState() => _GoalListPageState();
}

class _GoalListPageState extends ConsumerState<GoalListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(goalNotifierProvider.notifier).fetchAll();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showFormDialog(int? itemId) async {
    String? initialValue;
    if (itemId != null) {
      final state = ref.read(goalNotifierProvider);
      final item = state.items.where((i) => i.id == itemId).firstOrNull;
      if (item != null) {
        initialValue = item.name;
      }
    }

    final name = await showDialog<String>(
      context: context,
      builder: (context) => _GoalFormDialog(
        itemId: itemId,
        initialValue: initialValue,
      ),
    );

    if (name != null && mounted) {
      if (itemId != null) {
        final success = await ref.read(goalNotifierProvider.notifier).update(itemId, name);
        if (success && mounted) {
          final query = ref.read(goalNotifierProvider).searchQuery;
          ref.read(goalNotifierProvider.notifier).fetchAllAndSearch(query);
        }
      } else {
        final id = await ref.read(goalNotifierProvider.notifier).create(name);
        if (id != null && mounted) {
          final query = ref.read(goalNotifierProvider).searchQuery;
          ref.read(goalNotifierProvider.notifier).fetchAllAndSearch(query);
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('该目标名称已存在')),
          );
        }
      }
    }
  }

  Future<void> _handleDeprecate(GoalItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('弃用目标'),
        content: Text('确定要弃用「${item.name}」吗？\n\n弃用后，将不再显示在课程规划的选择列表中，但可在管理页面恢复。'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('确认弃用')),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await ref.read(goalNotifierProvider.notifier).toggleDeprecated(item.id, true);
      final query = ref.read(goalNotifierProvider).searchQuery;
      ref.read(goalNotifierProvider.notifier).fetchAllAndSearch(query);
    }
  }

  Future<void> _handleRestore(GoalItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('恢复目标'),
        content: Text('确定要恢复「${item.name}」吗？\n\n恢复后，将重新显示在课程规划的选择列表中。'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('确认恢复')),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await ref.read(goalNotifierProvider.notifier).toggleDeprecated(item.id, false);
      final query = ref.read(goalNotifierProvider).searchQuery;
      ref.read(goalNotifierProvider.notifier).fetchAllAndSearch(query);
    }
  }

  Future<void> _handleDelete(GoalItem item) async {
    final usageCount = await ref.read(goalNotifierProvider.notifier).checkUsage(item.id);

    if (usageCount > 0) {
      if (mounted) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 48),
            title: const Text('无法删除'),
            content: Text('该课程目标被 $usageCount 个课程规划引用。\n\n建议：您可以先将其弃用，弃用后将不会在选择列表中显示。'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('我知道了')),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  _handleDeprecate(item);
                },
                child: const Text('弃用该目标'),
              ),
            ],
          ),
        );
      }
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('确认删除'),
        content: Text('确定要删除「${item.name}」吗？\n\n此操作不可恢复。'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('确认删除'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final result = await ref.read(goalNotifierProvider.notifier).delete(item.id);
      if (mounted) {
        ref.read(goalNotifierProvider.notifier).fetchAll();
        if (result != DeleteItemResult.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('删除失败'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(goalNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('课程目标管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showFormDialog(null),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildContent(state)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    final notifier = ref.read(goalNotifierProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: '搜索课程目标...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    notifier.fetchAllAndSearch('');
                  },
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        onChanged: (query) => notifier.fetchAllAndSearch(query),
      ),
    );
  }

  Widget _buildContent(GoalItemState s) {
    switch (s.status) {
      case BasicItemStatus.initial:
        return _buildEmptyView('暂无数据', '点击右上角 + 按钮添加');
      case BasicItemStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case BasicItemStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('加载失败', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => ref.read(goalNotifierProvider.notifier).fetchAll(),
                icon: const Icon(Icons.refresh),
                label: const Text('重试'),
              ),
            ],
          ),
        );
      case BasicItemStatus.data:
        if (s.items.isEmpty) return _buildEmptyView('暂无数据', '');
        return RefreshIndicator(
          onRefresh: () => ref.read(goalNotifierProvider.notifier).fetchAll(),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: s.items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, index) => _buildTile(s.items[index]),
          ),
        );
    }
  }

  Widget _buildEmptyView(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flag_outlined, size: 64, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.outline)),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.outline)),
          ],
        ],
      ),
    );
  }

  Widget _buildTile(GoalItem item) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: item.isDeprecated ? Colors.grey : Theme.of(context).colorScheme.primary,
        child: Icon(Icons.flag_outlined, color: Colors.white, size: 20),
      ),
      title: Text(
        item.name,
        style: TextStyle(
          decoration: item.isDeprecated ? TextDecoration.lineThrough : null,
          color: item.isDeprecated ? Colors.grey : null,
        ),
      ),
      subtitle: item.isDeprecated
          ? const Text('已弃用', style: TextStyle(color: Colors.grey, fontSize: 12))
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.isDeprecated)
            IconButton(icon: const Icon(Icons.restore), tooltip: '恢复', onPressed: () => _handleRestore(item))
          else
            IconButton(icon: const Icon(Icons.archive), tooltip: '弃用', onPressed: () => _handleDeprecate(item)),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: '编辑',
            onPressed: () => _showFormDialog(item.id),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            tooltip: '删除',
            onPressed: () => _handleDelete(item),
          ),
        ],
      ),
      onTap: () => _showFormDialog(item.id),
    );
  }
}

class _GoalFormDialog extends StatefulWidget {
  final int? itemId;
  final String? initialValue;

  const _GoalFormDialog({this.itemId, this.initialValue});

  @override
  State<_GoalFormDialog> createState() => _GoalFormDialogState();
}

class _GoalFormDialogState extends State<_GoalFormDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.itemId != null ? '编辑课程目标' : '新增课程目标'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: '目标名称',
          hintText: '请输入课程目标名称',
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
            final value = _controller.text.trim();
            if (value.isNotEmpty) {
              Navigator.pop(context, value);
            }
          },
          child: const Text('确定'),
        ),
      ],
    );
  }
}
