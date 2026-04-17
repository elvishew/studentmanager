import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/l10n/app_localizations.dart';
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
          final s = S.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(s.optionNameExists)),
          );
        }
      }
    }
  }

  Future<void> _handleDeprecate(GoalItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final s = S.of(ctx)!;
        return AlertDialog(
          title: Text(s.deprecateGoalTitle),
          content: Text(s.confirmDeprecateGoalMessage(item.name)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(s.btnCancel)),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: Text(s.confirmDeprecate)),
          ],
        );
      },
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
      builder: (ctx) {
        final s = S.of(ctx)!;
        return AlertDialog(
          title: Text(s.restoreGoalTitle),
          content: Text(s.confirmRestoreGoalMessage(item.name)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(s.btnCancel)),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: Text(s.confirmRestore)),
          ],
        );
      },
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
          builder: (ctx) {
            final s = S.of(ctx)!;
            return AlertDialog(
              icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 48),
              title: Text(s.cannotDeleteTitle),
              content: Text(s.goalInUseMessage(usageCount)),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: Text(s.iKnow)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _handleDeprecate(item);
                  },
                  child: Text(s.deprecateThisGoal),
                ),
              ],
            );
          },
        );
      }
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final s = S.of(ctx)!;
        return AlertDialog(
          icon: const Icon(Icons.warning, color: Colors.red, size: 48),
          title: Text(s.btnConfirmDelete),
          content: Text(s.confirmDeleteGoalMessage(item.name)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(s.btnCancel)),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: Text(s.btnConfirmDelete),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      final result = await ref.read(goalNotifierProvider.notifier).delete(item.id);
      if (mounted) {
        ref.read(goalNotifierProvider.notifier).fetchAll();
        if (result != DeleteItemResult.success) {
          final s = S.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(s.saveFailed), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    final state = ref.watch(goalNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.goalListPageTitle),
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
    final s = S.of(context)!;
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
          hintText: s.searchGoalHint,
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
    final l = S.of(context)!;
    switch (s.status) {
      case BasicItemStatus.initial:
        return _buildEmptyView(l.noStatisticsDataMessage, l.clickToAddStudentMessage);
      case BasicItemStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case BasicItemStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(l.loadingFailedMessage, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => ref.read(goalNotifierProvider.notifier).fetchAll(),
                icon: const Icon(Icons.refresh),
                label: Text(l.retry),
              ),
            ],
          ),
        );
      case BasicItemStatus.data:
        if (s.items.isEmpty) return _buildEmptyView(l.noStatisticsDataMessage, '');
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
    final s = S.of(context)!;
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
          ? Text(s.deprecatedLabel, style: const TextStyle(color: Colors.grey, fontSize: 12))
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.isDeprecated)
            IconButton(icon: const Icon(Icons.restore), tooltip: s.restoreTooltip, onPressed: () => _handleRestore(item))
          else
            IconButton(icon: const Icon(Icons.archive), tooltip: s.deprecateTooltip, onPressed: () => _handleDeprecate(item)),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: s.edit,
            onPressed: () => _showFormDialog(item.id),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            tooltip: s.btnDelete,
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
    final s = S.of(context)!;
    return AlertDialog(
      title: Text(widget.itemId != null ? s.editGoalTitle : s.newGoalTitle),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: s.goalNameLabel,
          hintText: s.goalNameHint,
          border: const OutlineInputBorder(),
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(s.btnCancel),
        ),
        TextButton(
          onPressed: () {
            final value = _controller.text.trim();
            if (value.isNotEmpty) {
              Navigator.pop(context, value);
            }
          },
          child: Text(s.btnConfirm),
        ),
      ],
    );
  }
}
