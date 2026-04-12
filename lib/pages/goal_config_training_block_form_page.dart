import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_manager/providers/goal_config_provider.dart';
import 'package:student_manager/providers/student_provider.dart';

/// 训练块模板表单页（添加/编辑）
class GoalConfigTrainingBlockFormPage extends ConsumerStatefulWidget {
  final int goalConfigSessionId;
  final int? blockId;

  const GoalConfigTrainingBlockFormPage({
    super.key,
    required this.goalConfigSessionId,
    this.blockId,
  });

  @override
  ConsumerState<GoalConfigTrainingBlockFormPage> createState() => _GoalConfigTrainingBlockFormPageState();
}

class _GoalConfigTrainingBlockFormPageState extends ConsumerState<GoalConfigTrainingBlockFormPage> {
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

  List<Map<String, dynamic>> _actions = [];
  List<Map<String, dynamic>> _equipments = [];
  List<Map<String, dynamic>> _tools = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (widget.blockId != null) {
      await _loadTrainingBlock();
    }
    await _loadBasicData();
  }

  /// 加载基础数据（动作、器械、工具）
  Future<void> _loadBasicData() async {
    final db = ref.read(databaseProvider);

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

    final actionList = actions.map((e) => {'id': e['id'], 'name': e['name']}).toList();
    final equipmentList = equipments.map((e) => {'id': e['id'], 'name': e['name']}).toList();
    final toolList = tools.map((e) => {'id': e['id'], 'name': e['name']}).toList();

    // 编辑模式：将被引用的弃用项补入列表
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

  Future<void> _appendDeprecatedIfNeeded(
    Database db,
    String table,
    int? selectedId,
    List<Map<String, dynamic>> items,
  ) async {
    if (selectedId == null) return;
    final alreadyInList = items.any((e) => e['id'] == selectedId);
    if (alreadyInList) return;

    final results = await db.query(table, where: 'id = ?', whereArgs: [selectedId], limit: 1);
    if (results.isNotEmpty) {
      final item = results.first;
      items.add({'id': item['id'], 'name': '${item['name']}（已弃用）'});
    }
  }

  /// 加载训练块数据（编辑模式）
  Future<void> _loadTrainingBlock() async {
    final db = ref.read(databaseProvider);
    final blocks = await db.query(
      'goal_config_training_blocks',
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

  /// 保存训练块模板
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final notifier = ref.read(goalConfigNotifierProvider.notifier);
    bool success;

    if (widget.blockId != null) {
      // 编辑
      await notifier.updateBlock(
        id: widget.blockId!,
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
      final blockId = await notifier.addBlock(
        goalConfigSessionId: widget.goalConfigSessionId,
        actionId: _selectedActionId,
        equipmentId: _selectedEquipmentId,
        toolId: _selectedToolId,
        reps: _repsController.text.trim().isEmpty ? null : _repsController.text.trim(),
        sets: _setsController.text.trim().isEmpty ? null : _setsController.text.trim(),
        duration: _durationController.text.trim().isEmpty ? null : _durationController.text.trim(),
        intensity: _intensityController.text.trim().isEmpty ? null : _intensityController.text.trim(),
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      success = blockId > 0;
    }

    if (mounted) {
      setState(() => _isSaving = false);

      if (success) {
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
                setState(() => _selectedActionId = value);
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
                setState(() => _selectedEquipmentId = value);
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
                setState(() => _selectedToolId = value);
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
