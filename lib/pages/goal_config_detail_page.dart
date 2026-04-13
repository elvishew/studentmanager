import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/goal_config_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'goal_config_session_detail_page.dart';

/// 课程目标配置详情页（蓝图编辑 + 课时模板列表）
class GoalConfigDetailPage extends ConsumerStatefulWidget {
  final int goalId;
  final String goalName;
  final int? goalConfigId;

  const GoalConfigDetailPage({
    super.key,
    required this.goalId,
    required this.goalName,
    this.goalConfigId,
  });

  @override
  ConsumerState<GoalConfigDetailPage> createState() => _GoalConfigDetailPageState();
}

class _GoalConfigDetailPageState extends ConsumerState<GoalConfigDetailPage> {
  GoalConfig? _config;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    setState(() => _isLoading = true);

    // 优先使用 _config（可能由 _ensureConfig 惰性创建），其次使用 widget.goalConfigId
    final configId = _config?.id ?? widget.goalConfigId;

    if (configId != null) {
      final detail = await ref.read(goalConfigNotifierProvider.notifier).fetchDetail(configId);
      if (mounted) {
        setState(() {
          _config = detail;
          _isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// 确保配置记录存在，返回 configId（惰性创建）
  Future<int> _ensureConfig() async {
    if (_config != null) return _config!.id;
    final id = await ref.read(goalConfigNotifierProvider.notifier).upsertConfig(
          goalId: widget.goalId,
          blueprint: null,
        );
    final detail = await ref.read(goalConfigNotifierProvider.notifier).fetchDetail(id);
    if (mounted) {
      setState(() => _config = detail);
    }
    return id;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.goalName)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final sessions = _config?.sessions ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.goalName),
        actions: [
          if (_config != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
              onPressed: _showResetConfigDialog,
              tooltip: '重置配置',
            ),
        ],
      ),
      body: Column(
        children: [
          // 蓝图编辑区
          _buildBlueprintCard(theme),
          const Divider(height: 1),
          // 课时模板列表
          Expanded(
            child: sessions.isEmpty
                ? _buildEmptyView()
                : _buildSessionList(sessions),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_session',
        onPressed: () => _showAddSessionDialog(sessions),
        child: const Icon(Icons.add),
        tooltip: '添加课时模板',
      ),
    );
  }

  /// 构建蓝图编辑卡片
  Widget _buildBlueprintCard(ThemeData theme) {
    final blueprint = _config?.blueprint;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: theme.colorScheme.primaryContainer.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                size: 18,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                '蓝图',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 32,
                width: 32,
                child: IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  tooltip: '编辑蓝图',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  onPressed: _showEditBlueprintDialog,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            blueprint != null && blueprint.isNotEmpty ? blueprint : '未设置蓝图',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: blueprint != null && blueprint.isNotEmpty
                  ? null
                  : theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建课时模板列表
  Widget _buildSessionList(List<GoalConfigSession> sessions) {
    return RefreshIndicator(
      onRefresh: _loadDetail,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: sessions.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final session = sessions[index];
          return _buildSessionTile(session);
        },
      ),
    );
  }

  /// 构建课时模板列表项
  Widget _buildSessionTile(GoalConfigSession session) {
    final theme = Theme.of(context);
    final blockCount = session.contentBlocks?.length ?? 0;

    return Dismissible(
      key: Key('gc_session_${session.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white, size: 32),
      ),
      confirmDismiss: (direction) => _showDeleteSessionDialog(session),
      onDismissed: (direction) {},
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary,
          child: Text(
            '${session.sessionNumber}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          '第 ${session.sessionNumber} 节课模板',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          blockCount > 0 ? '$blockCount 个训练块' : '暂无训练内容',
          style: theme.textTheme.bodySmall?.copyWith(
            color: blockCount > 0 ? theme.colorScheme.primary : theme.colorScheme.outline,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _navigateToSessionDetail(session),
      ),
    );
  }

  /// 构建空视图
  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_note,
            size: 48,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无课时模板',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '点击右下角按钮添加课时模板',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }

  /// 编辑蓝图对话框
  Future<void> _showEditBlueprintDialog() async {
    final controller = TextEditingController(text: _config?.blueprint ?? '');

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑蓝图'),
        content: TextFormField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '请输入蓝图描述',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('保存'),
          ),
        ],
      ),
    );

    if (result != null && mounted) {
      if (result.isEmpty) {
        // 空蓝图：如果也没有课时模板，直接删除整条配置
        if (_config != null) {
          await ref.read(goalConfigNotifierProvider.notifier).upsertConfig(
                goalId: widget.goalId,
                blueprint: null,
              );
          final cleaned = await ref.read(goalConfigNotifierProvider.notifier).cleanIfEmpty(_config!.id);
          if (cleaned && mounted) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('蓝图已清除，配置已重置')),
            );
            return;
          }
        }
      } else {
        // 非空蓝图：正常保存
        await _ensureConfig();
        await ref.read(goalConfigNotifierProvider.notifier).upsertConfig(
              goalId: widget.goalId,
              blueprint: result,
            );
      }
      await _loadDetail();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('蓝图已更新')),
        );
      }
    }
  }

  /// 添加课时模板对话框
  Future<void> _showAddSessionDialog(List<GoalConfigSession> sessions) async {
    // 已存在的课时序号
    final existingNumbers = sessions.map((s) => s.sessionNumber).toSet();
    // 可选的课时序号（1~12，排除已存在的）
    final availableNumbers = List.generate(12, (i) => i + 1)
        .where((n) => !existingNumbers.contains(n))
        .toList();

    if (availableNumbers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已达到最大课时数（12节）')),
      );
      return;
    }

    int? selectedNumber = availableNumbers.first;

    final result = await showDialog<int>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('添加课时模板'),
          content: DropdownButtonFormField<int>(
            value: selectedNumber,
            decoration: const InputDecoration(
              labelText: '课时序号',
              border: OutlineInputBorder(),
            ),
            items: availableNumbers.map((n) => DropdownMenuItem(
                  value: n,
                  child: Text('第 $n 节课'),
                )).toList(),
            onChanged: (value) {
              setState(() => selectedNumber = value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, selectedNumber),
              child: const Text('添加'),
            ),
          ],
        ),
      ),
    );

    if (result != null && mounted) {
      final configId = await _ensureConfig();
      await ref.read(goalConfigNotifierProvider.notifier).addSession(
            goalConfigId: configId,
            sessionNumber: result,
          );
      await _loadDetail();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('课时模板已添加')),
        );
      }
    }
  }

  /// 删除课时模板确认对话框
  Future<bool?> _showDeleteSessionDialog(GoalConfigSession session) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('删除课时模板'),
        content: Text(
          '确定要删除「第${session.sessionNumber}节课模板」吗？\n\n'
          '删除后将同时删除该课时的所有训练块模板，此操作不可恢复。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context, true);
              final notifier = ref.read(goalConfigNotifierProvider.notifier);
              await notifier.deleteSession(session.id);
              // 删完后检查是否需要清理空配置
              if (_config != null) {
                final cleaned = await notifier.cleanIfEmpty(_config!.id);
                if (cleaned && mounted) {
                  Navigator.of(this.context).pop();
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(content: Text('最后一个课时已删除，配置已重置')),
                  );
                  return;
                }
              }
              await _loadDetail();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('确认删除'),
          ),
        ],
      ),
    );
  }

  /// 跳转到课时模板详情页
  Future<void> _navigateToSessionDetail(GoalConfigSession session) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoalConfigSessionDetailPage(
          session: session,
        ),
      ),
    );
    // 返回时刷新详情
    await _loadDetail();
  }

  /// 重置配置确认对话框
  Future<void> _showResetConfigDialog() async {
    if (_config == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('重置配置'),
        content: Text(
          '确定要重置「${widget.goalName}」的默认配置吗？\n\n'
          '蓝图和所有课时模板将被删除，此操作不可恢复。',
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
            child: const Text('确认重置'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(goalConfigNotifierProvider.notifier).deleteConfig(_config!.id);
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('配置已重置')),
        );
      }
    }
  }
}
