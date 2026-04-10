import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/action_provider.dart';
import '../providers/states.dart' as models;
import 'action_form_page.dart';

/// ============================================
/// 动作列表页
/// ============================================

class ActionListPage extends ConsumerStatefulWidget {
  const ActionListPage({super.key});

  @override
  ConsumerState<ActionListPage> createState() => _ActionListPageState();
}

class _ActionListPageState extends ConsumerState<ActionListPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 页面初始化时加载数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(actionNotifierProvider.notifier).fetchAll();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  /// 跳转到创建动作页
  void _navigateToCreate() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ActionFormPage(),
      ),
    );
  }

  /// 跳转到编辑动作页
  void _navigateToEdit(models.Action action) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActionFormPage(actionId: action.id),
      ),
    );
  }

  /// 处理弃用动作
  Future<void> _handleDeprecate(models.Action action) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('弃用动作'),
        content: Text('确定要弃用动作「${action.name}」吗？\n\n弃用后，该动作将不再显示在"选择动作"列表中，但可在管理页面恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('确认弃用'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(actionNotifierProvider.notifier).toggleDeprecated(action.id, true);
    }
  }

  /// 处理恢复动作
  Future<void> _handleRestore(models.Action action) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('恢复动作'),
        content: Text('确定要恢复动作「${action.name}」吗？\n\n恢复后，该动作将重新显示在"选择动作"列表中。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('确认恢复'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(actionNotifierProvider.notifier).toggleDeprecated(action.id, false);
    }
  }

  /// 处理删除动作
  Future<void> _handleDelete(models.Action action) async {
    // 先检查引用
    final usageCount = await ref.read(actionNotifierProvider.notifier).checkUsage(action.id);

    if (usageCount > 0) {
      // 有引用，引导弃用
      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.warning_amber_rounded,
                            color: Colors.orange, size: 48),
            title: const Text('无法删除'),
            content: Text('该动作被 $usageCount 个训练块使用。\n\n建议：您可以先将其弃用，弃用后将不会在选择列表中显示。'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('我知道了'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleDeprecate(action);
                },
                child: const Text('弃用该动作'),
              ),
            ],
          ),
        );
      }
      return;
    }

    // 无引用，二次确认
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('确认删除'),
        content: Text('确定要删除动作「${action.name}」吗？\n\n此操作不可恢复。'),
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
      final result = await ref.read(actionNotifierProvider.notifier).delete(action.id);
      if (mounted && result != DeleteActionResult.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('删除失败'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(actionNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('动作管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToCreate,
            tooltip: '添加动作',
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          _buildSearchBar(),
          // 列表内容
          Expanded(
            child: _buildContent(actionState),
          ),
        ],
      ),
    );
  }

  /// 构建搜索栏
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          hintText: '搜索动作名称...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    ref.read(actionNotifierProvider.notifier).search('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        onChanged: (query) {
          ref.read(actionNotifierProvider.notifier).search(query);
        },
      ),
    );
  }

  /// 构建内容区域
  Widget _buildContent(models.ActionState state) {
    return state.when(
      initial: () => _buildInitialView(),
      loading: () => _buildLoadingView(),
      error: (error, stackTrace) => _buildErrorView(error, stackTrace),
      data: (actions, query) {
        // 根据搜索条件过滤
        final filteredActions = query.isEmpty
            ? actions
            : actions
                .where((action) =>
                    action.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

        if (filteredActions.isEmpty) {
          return _buildEmptyView(query.isNotEmpty);
        }
        return _buildListView(filteredActions);
      },
    );
  }

  /// 初始状态视图
  Widget _buildInitialView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_run_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无动作数据',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '点击右上角 + 按钮添加动作',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }

  /// 加载中视图
  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// 错误视图
  Widget _buildErrorView(Object error, StackTrace stackTrace) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(actionNotifierProvider.notifier).fetchAll();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('重试'),
          ),
        ],
      ),
    );
  }

  /// 空数据视图
  Widget _buildEmptyView(bool isSearchResult) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearchResult ? Icons.search_off : Icons.inbox,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            isSearchResult ? '未找到匹配的动作' : '暂无动作',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          if (isSearchResult) ...[
            const SizedBox(height: 8),
            Text(
              '尝试使用其他关键词搜索',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ],
      ),
    );
  }

  /// 列表视图
  Widget _buildListView(List<models.Action> actions) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(actionNotifierProvider.notifier).fetchAll();
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: actions.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final action = actions[index];
          return _buildActionTile(action);
        },
      ),
    );
  }

  /// 动作列表项
  Widget _buildActionTile(models.Action action) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: action.isDeprecated
            ? Colors.grey
            : Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.directions_run,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        action.name,
        style: TextStyle(
          decoration: action.isDeprecated
              ? TextDecoration.lineThrough
              : null,
          color: action.isDeprecated
              ? Colors.grey
              : null,
        ),
      ),
      subtitle: action.isDeprecated
          ? const Text(
              '已弃用',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            )
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (action.isDeprecated)
            IconButton(
              icon: const Icon(Icons.restore),
              tooltip: '恢复',
              onPressed: () => _handleRestore(action),
            )
          else
            IconButton(
              icon: const Icon(Icons.archive),
              tooltip: '弃用',
              onPressed: () => _handleDeprecate(action),
            ),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: '编辑',
            onPressed: () => _navigateToEdit(action),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            tooltip: '删除',
            onPressed: () => _handleDelete(action),
          ),
        ],
      ),
      onTap: () => _navigateToEdit(action),
    );
  }
}
