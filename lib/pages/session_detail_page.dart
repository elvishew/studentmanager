import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/session_provider.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/widgets/session_edit_dialog.dart';

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

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  /// 加载课时详情
  Future<void> _loadSession() async {
    final notifier = ref.read(sessionNotifierProvider.notifier);
    final session = await notifier.getDetailById(widget.sessionId);
    if (mounted) {
      setState(() {
        _session = session;
      });
    }
  }

  /// 添加训练块
  Future<void> _addTrainingBlock() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => TrainingBlockFormPage(
          sessionId: widget.sessionId,
        ),
      ),
    );

    if (result == true && mounted) {
      await _loadSession();
    }
  }

  /// 编辑训练块
  Future<void> _editTrainingBlock(TrainingBlock block) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => TrainingBlockFormPage(
          sessionId: widget.sessionId,
          blockId: block.id,
        ),
      ),
    );

    if (result == true && mounted) {
      await _loadSession();
    }
  }

  /// 删除训练块
  Future<void> _deleteTrainingBlock(TrainingBlock block) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除训练块 ${block.sortOrder + 1} 吗？'),
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
      final notifier = ref.read(trainingBlockNotifierProvider.notifier);
      await notifier.deleteTrainingBlock(blockId: block.id);
      if (mounted) {
        await _loadSession();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('训练块已删除')),
        );
      }
    }
  }

  /// 显示删除课时确认对话框
  Future<void> _showDeleteSessionDialog() async {
    if (_session == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('删除课时'),
        content: Text(
          '确定要删除「第${_session!.sessionNumber}节课」吗？\n\n'
          '删除后将同时删除该课时的所有训练记录，此操作不可恢复。',
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

  /// 删除课时
  Future<void> _deleteSession() async {
    try {
      final notifier = ref.read(sessionNotifierProvider.notifier);
      final success = await notifier.deleteSession(sessionId: widget.sessionId);

      if (success && mounted) {
        // 返回上一页并显示提示
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

  /// 显示编辑课时对话框
  Future<void> _showEditSessionDialog() async {
    if (_session == null) return;

    // 获取课程规划的默认时长
    final coursePlan = await ref.read(coursePlanNotifierProvider.notifier)
        .getDetailById(_session!.coursePlanId);
    final defaultDuration = coursePlan?.defaultDuration ?? 60;

    final result = await showSessionEditDialog(
      context,
      session: _session!,
      defaultDuration: defaultDuration,
    );

    if (result != null && mounted) {
      final notifier = ref.read(sessionNotifierProvider.notifier);
      final durationOverride = result['durationOverride'] as int?;
      final success = await notifier.updateSession(
        sessionId: widget.sessionId,
        scheduledTime: result['scheduledTime'] as DateTime?,
        status: result['status'] as SessionStatus?,
        durationOverride: durationOverride,
        clearDurationOverride: durationOverride == null &&
            _session!.durationOverride != null,
      );

      if (mounted) {
        if (success) {
          await _loadSession();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('课时已更新')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('更新失败'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  /// 上移训练块
  Future<void> _moveUpTrainingBlock(TrainingBlock block) async {
    if (block.sortOrder > 0) {
      final notifier = ref.read(trainingBlockNotifierProvider.notifier);
      await notifier.reorderTrainingBlock(
        blockId: block.id,
        newSortOrder: block.sortOrder - 1,
      );
      if (mounted) {
        await _loadSession();
      }
    }
  }

  /// 下移训练块
  Future<void> _moveDownTrainingBlock(TrainingBlock block, int maxOrder) async {
    if (block.sortOrder < maxOrder) {
      final notifier = ref.read(trainingBlockNotifierProvider.notifier);
      await notifier.reorderTrainingBlock(
        blockId: block.id,
        newSortOrder: block.sortOrder + 1,
      );
      if (mounted) {
        await _loadSession();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_session == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('课时详情'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final trainingBlocks = _session!.trainingBlocks ?? [];
    final maxOrder = trainingBlocks.isEmpty ? 0 : trainingBlocks.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('第 ${_session!.sessionNumber} 节课'),
        actions: [
          // 编辑按钮
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: _showEditSessionDialog,
            tooltip: '编辑课时',
          ),
          // 删除按钮
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
            // 基本信息
            _buildSection(
              title: '基本信息',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('课时序号', '${_session!.sessionNumber}'),
                  _buildInfoRow('状态', _getStatusText(_session!.status)),
                  if (_session!.scheduledTime != null)
                    _buildInfoRow('上课时间', _formatDateTime(_session!.scheduledTime!)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 训练块列表
            _buildTrainingBlocksSection(trainingBlocks, maxOrder),
          ],
        ),
      ),
    );
  }

  /// 构建训练块部分
  Widget _buildTrainingBlocksSection(List<TrainingBlock> trainingBlocks, int maxOrder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题 + 添加按钮
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '训练内容',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton.icon(
              onPressed: _addTrainingBlock,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('添加'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 训练块列表
        if (trainingBlocks.isEmpty)
          Container(
            padding: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Center(
              child: Text('暂无训练内容'),
            ),
          )
        else
          Column(
            children: trainingBlocks.asMap().entries.map((entry) {
              final index = entry.key;
              final block = entry.value;
              return _buildTrainingBlockTile(index + 1, block, maxOrder);
            }).toList(),
          ),
      ],
    );
  }

  /// 构建训练块卡片
  Widget _buildTrainingBlockTile(int number, TrainingBlock block, int maxOrder) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 序号、操作按钮
            Row(
              children: [
                Text(
                  '训练块 $number',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                // 上移按钮
                IconButton(
                  icon: const Icon(Icons.arrow_upward, size: 18),
                  tooltip: '上移',
                  onPressed: block.sortOrder > 0
                      ? () => _moveUpTrainingBlock(block)
                      : null,
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  padding: EdgeInsets.zero,
                ),
                // 下移按钮
                IconButton(
                  icon: const Icon(Icons.arrow_downward, size: 18),
                  tooltip: '下移',
                  onPressed: block.sortOrder < maxOrder
                      ? () => _moveDownTrainingBlock(block, maxOrder)
                      : null,
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  padding: EdgeInsets.zero,
                ),
                // 编辑按钮
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  tooltip: '编辑',
                  onPressed: () => _editTrainingBlock(block),
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  padding: EdgeInsets.zero,
                ),
                // 删除按钮
                IconButton(
                  icon: const Icon(Icons.delete, size: 18),
                  tooltip: '删除',
                  onPressed: () => _deleteTrainingBlock(block),
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 动作
            if (block.action != null)
              _buildDetailRow('动作', block.action!.name),
            // 器械
            if (block.equipment != null)
              _buildDetailRow('器械', block.equipment!.name),
            // 工具
            if (block.tool != null)
              _buildDetailRow('工具', block.tool!.name),
            const SizedBox(height: 4),
            // 次数、组数、时长、强度
            if (block.reps != null || block.sets != null)
              Row(
                children: [
                  if (block.reps != null) ...[
                    Expanded(child: _buildDetailItem('次数', block.reps!)),
                    const SizedBox(width: 8),
                  ],
                  if (block.sets != null) ...[
                    Expanded(child: _buildDetailItem('组数', block.sets!)),
                  ],
                ],
              ),
            if (block.duration != null)
              _buildDetailRow('时长', block.duration!),
            if (block.intensity != null)
              _buildDetailRow('强度', block.intensity!),
            // 备注
            if (block.notes != null && block.notes!.isNotEmpty)
              _buildDetailRow('备注', block.notes!),
          ],
        ),
      ),
    );
  }

  /// 构建信息行
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

  /// 构建详情行
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建详情项
  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  /// 构建部分
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

  /// 获取状态文本
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

  /// 格式化日期时间
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

/// 训练块表单页（添加/编辑）
class TrainingBlockFormPage extends ConsumerStatefulWidget {
  final int sessionId;
  final int? blockId;

  const TrainingBlockFormPage({
    super.key,
    required this.sessionId,
    this.blockId,
  });

  @override
  ConsumerState<TrainingBlockFormPage> createState() => _TrainingBlockFormPageState();
}

class _TrainingBlockFormPageState extends ConsumerState<TrainingBlockFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _repsController = TextEditingController();
  final _setsController = TextEditingController();
  final _durationController = TextEditingController();
  final _intensityController = TextEditingController();
  final _notesController = TextEditingController();

  int? _selectedActionId;
  int? _selectedEquipmentId;
  int? _selectedToolId;
  bool _isSaving = false;

  // 可选数据（用于下拉选择）
  List<Map<String, dynamic>> _actions = [];
  List<Map<String, dynamic>> _equipments = [];
  List<Map<String, dynamic>> _tools = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// 加载数据（编辑模式先加载训练块，再加载基础数据）
  Future<void> _loadData() async {
    // 编辑模式：先加载训练块数据，拿到已选的 action/equipment/tool ID
    if (widget.blockId != null) {
      await _loadTrainingBlock();
    }
    // 再加载基础数据（会将已弃用但被引用的项补入候选列表）
    await _loadBasicData();
  }

  /// 加载基础数据（动作、器械、工具）
  /// 编辑模式下，会将已弃用但被当前训练块引用的项补入候选列表
  Future<void> _loadBasicData() async {
    final db = ref.read(databaseProvider);

    // 只加载未弃用的动作、器械、工具
    final actions = await db.query(
      'actions',
      where: 'is_deprecated = ?',
      whereArgs: [0],
      orderBy: 'name ASC',
    );
    final equipments = await db.query(
      'equipments',
      where: 'is_deprecated = ?',
      whereArgs: [0],
      orderBy: 'name ASC',
    );
    final tools = await db.query(
      'tools',
      where: 'is_deprecated = ?',
      whereArgs: [0],
      orderBy: 'name ASC',
    );

    // 编辑模式：将被引用的弃用项补入列表（显示在最后并标记已弃用）
    final actionList = actions.map((e) => {'id': e['id'], 'name': e['name']}).toList();
    final equipmentList = equipments.map((e) => {'id': e['id'], 'name': e['name']}).toList();
    final toolList = tools.map((e) => {'id': e['id'], 'name': e['name']}).toList();

    if (widget.blockId != null) {
      await _appendDeprecatedIfNeeded(db, 'actions', _selectedActionId, actionList);
      await _appendDeprecatedIfNeeded(db, 'equipments', _selectedEquipmentId, equipmentList);
      await _appendDeprecatedIfNeeded(db, 'tools', _selectedToolId, toolList);
    }

    if (mounted) {
      setState(() {
        _actions = actionList;
        _equipments = equipmentList;
        _tools = toolList;
      });
    }
  }

  /// 如果被引用的项已弃用且不在候选列表中，补入列表末尾并标记
  Future<void> _appendDeprecatedIfNeeded(
    Database db,
    String table,
    int? selectedId,
    List<Map<String, dynamic>> items,
  ) async {
    if (selectedId == null) return;

    final alreadyInList = items.any((e) => e['id'] == selectedId);
    if (alreadyInList) return;

    final results = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [selectedId],
      limit: 1,
    );

    if (results.isNotEmpty) {
      final item = results.first;
      items.add({
        'id': item['id'],
        'name': '${item['name']}（已弃用）',
      });
    }
  }

  /// 加载训练块数据（编辑模式）
  Future<void> _loadTrainingBlock() async {
    final db = ref.read(databaseProvider);
    final blocks = await db.query(
      'training_blocks',
      where: 'id = ?',
      whereArgs: [widget.blockId],
    );

    if (blocks.isNotEmpty && mounted) {
      final block = blocks.first;
      setState(() {
        _selectedActionId = block['action_id'] as int?;
        _selectedEquipmentId = block['equipment_id'] as int?;
        _selectedToolId = block['tool_id'] as int?;
        _repsController.text = (block['reps'] ?? '') as String;
        _setsController.text = (block['sets'] ?? '') as String;
        _durationController.text = (block['duration'] ?? '') as String;
        _intensityController.text = (block['intensity'] ?? '') as String;
        _notesController.text = (block['notes'] ?? '') as String;
      });
    }
  }

  @override
  void dispose() {
    _repsController.dispose();
    _setsController.dispose();
    _durationController.dispose();
    _intensityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  /// 保存训练块
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final notifier = ref.read(trainingBlockNotifierProvider.notifier);
    bool? success;

    if (widget.blockId != null) {
      // 编辑
      await notifier.updateTrainingBlock(
        blockId: widget.blockId!,
        actionId: _selectedActionId,
        equipmentId: _selectedEquipmentId,
        toolId: _selectedToolId,
        reps: _repsController.text.trim().isEmpty ? null : _repsController.text.trim(),
        sets: _setsController.text.trim().isEmpty ? null : _setsController.text.trim(),
        duration: _durationController.text.trim().isEmpty ? null : _durationController.text.trim(),
        intensity: _intensityController.text.trim().isEmpty ? null : _intensityController.text.trim(),
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      success = true;
    } else {
      // 添加
      final blockId = await notifier.addTrainingBlock(
        sessionId: widget.sessionId,
        actionId: _selectedActionId,
        equipmentId: _selectedEquipmentId,
        toolId: _selectedToolId,
        reps: _repsController.text.trim().isEmpty ? null : _repsController.text.trim(),
        sets: _setsController.text.trim().isEmpty ? null : _setsController.text.trim(),
        duration: _durationController.text.trim().isEmpty ? null : _durationController.text.trim(),
        intensity: _intensityController.text.trim().isEmpty ? null : _intensityController.text.trim(),
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      success = blockId != null;
    }

    if (mounted) {
      setState(() {
        _isSaving = false;
      });

      if (success == true) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.blockId != null ? '训练块已更新' : '训练块已添加'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blockId != null ? '编辑训练块' : '添加训练块'),
        actions: [
          if (_isSaving)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text('保存'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // 动作
            DropdownButtonFormField<int>(
              value: _selectedActionId,
              decoration: const InputDecoration(
                labelText: '动作',
                border: OutlineInputBorder(),
              ),
              items: _actions.map<DropdownMenuItem<int>>((action) {
                return DropdownMenuItem<int>(
                  value: action['id'] as int,
                  child: Text(action['name'] as String),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedActionId = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // 器械
            DropdownButtonFormField<int>(
              value: _selectedEquipmentId,
              decoration: const InputDecoration(
                labelText: '器械',
                border: OutlineInputBorder(),
              ),
              items: _equipments.map<DropdownMenuItem<int>>((equipment) {
                return DropdownMenuItem<int>(
                  value: equipment['id'] as int,
                  child: Text(equipment['name'] as String),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedEquipmentId = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // 工具
            DropdownButtonFormField<int>(
              value: _selectedToolId,
              decoration: const InputDecoration(
                labelText: '工具',
                border: OutlineInputBorder(),
              ),
              items: _tools.map<DropdownMenuItem<int>>((tool) {
                return DropdownMenuItem<int>(
                  value: tool['id'] as int,
                  child: Text(tool['name'] as String),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedToolId = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // 次数、组数
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _repsController,
                    decoration: const InputDecoration(
                      labelText: '次数',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _setsController,
                    decoration: const InputDecoration(
                      labelText: '组数',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 时长
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: '时长',
                hintText: '例如：30秒',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // 强度
            TextFormField(
              controller: _intensityController,
              decoration: const InputDecoration(
                labelText: '强度',
                hintText: '例如：低、中、高',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // 备注
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: '备注',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
