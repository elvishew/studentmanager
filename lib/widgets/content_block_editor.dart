import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_manager/providers/content_field_provider.dart';
import 'package:student_manager/providers/goal_config_provider.dart';
import 'package:student_manager/providers/session_provider.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/l10n/app_localizations.dart';

/// 内容块编辑器组件
/// 支持两种上下文：'session' 和 'goal_config'
class ContentBlockEditor extends ConsumerStatefulWidget {
  final int sessionId;
  final int? blockId;
  final String context; // 'session' or 'goal_config'
  final String? appBarTitle;

  const ContentBlockEditor({
    super.key,
    required this.sessionId,
    this.blockId,
    this.context = 'session',
    this.appBarTitle,
  });

  @override
  ConsumerState<ContentBlockEditor> createState() => _ContentBlockEditorState();
}

class _ContentBlockEditorState extends ConsumerState<ContentBlockEditor> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = <int, TextEditingController>{};
  final _selectedOptions = <int, String?>{};
  bool _isSaving = false;

  List<ContentField> _fields = [];
  Map<int, String> _existingValues = {};

  /// 所有必填字段均已填写且数字字段值合法时才可保存
  bool get _canSave {
    if (_fields.isEmpty) return false;
    for (final field in _fields) {
      if (field.isDeprecated) continue;
      if (field.fieldType == FieldType.select) {
        if (field.isRequired &&
            (_selectedOptions[field.id] == null || _selectedOptions[field.id]!.isEmpty)) {
          return false;
        }
      } else {
        final controller = _controllers[field.id];
        final text = controller?.text.trim() ?? '';
        if (field.isRequired && text.isEmpty) return false;
        // 数字类型字段：非空时必须是合法数字
        if (field.fieldType == FieldType.number && text.isNotEmpty) {
          if (double.tryParse(text) == null) return false;
        }
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final fieldNotifier = ref.read(contentFieldNotifierProvider.notifier);
      _fields = await fieldNotifier.loadFields();

      if (widget.blockId != null) {
        await _loadExistingValues();
      }

      if (mounted) {
        setState(() {
          for (final field in _fields) {
            if (field.fieldType == FieldType.select) {
              _selectedOptions[field.id] = _existingValues[field.id];
            } else {
              _controllers[field.id] = TextEditingController(
                text: _existingValues[field.id] ?? '',
              );
            }
          }
        });
      }
    } catch (e) {
      if (mounted) setState(() {});
    }
  }

  Future<void> _loadExistingValues() async {
    final db = ref.read(databaseProvider);
    String valuesTable;
    String blockTable;
    String blockIdColumn;

    if (widget.context == 'goal_config') {
      valuesTable = 'goal_config_content_block_values';
      blockTable = 'goal_config_content_blocks';
      blockIdColumn = 'content_block_id';
    } else {
      valuesTable = 'content_block_values';
      blockTable = 'content_blocks';
      blockIdColumn = 'content_block_id';
    }

    final values = await db.query(
      valuesTable,
      where: '$blockIdColumn = ?',
      whereArgs: [widget.blockId],
    );

    for (final v in values) {
      _existingValues[v['content_field_id'] as int] = v['value'] as String? ?? '';
    }
  }

  Future<void> _save() async {
    if (!_canSave) return;

    setState(() => _isSaving = true);

    // 构建值映射
    final values = <int, String>{};
    for (final field in _fields) {
      if (field.fieldType == FieldType.select) {
        final value = _selectedOptions[field.id];
        if (value != null && value.isNotEmpty) {
          values[field.id] = value;
        }
      } else {
        final controller = _controllers[field.id];
        final value = controller?.text.trim() ?? '';
        if (value.isNotEmpty) {
          values[field.id] = value;
        }
      }
    }

    bool success = false;

    try {
      if (widget.context == 'goal_config') {
        final notifier = ref.read(goalConfigNotifierProvider.notifier);
        if (widget.blockId != null) {
          await notifier.updateBlock(id: widget.blockId!, values: values);
          success = true;
        } else {
          final blockId = await notifier.addBlock(
            goalConfigSessionId: widget.sessionId,
            values: values,
          );
          success = blockId > 0;
        }
      } else {
        final notifier = ref.read(contentBlockNotifierProvider.notifier);
        if (widget.blockId != null) {
          await notifier.updateContentBlock(blockId: widget.blockId!, values: values);
          success = true;
        } else {
          final blockId = await notifier.addContentBlock(
            sessionId: widget.sessionId,
            values: values,
          );
          success = blockId != null;
        }
      }
    } catch (e) {
      success = false;
    }

    if (mounted) {
      setState(() => _isSaving = false);
      final s = S.of(context)!;
      if (success) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.blockId != null ? s.contentBlockUpdated : s.contentBlockAdded),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.saveFailed), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    if (_fields.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.appBarTitle ?? s.editContentTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle ?? (widget.blockId != null ? s.editContentTitle : s.addContentTitle)),
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
              onPressed: _canSave ? _save : null,
              child: Text(s.btnSave),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: _fields.map((field) {
            if (field.isDeprecated) return const SizedBox.shrink();
            return _buildFieldWidget(field);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFieldWidget(ContentField field) {
    final label = field.isRequired ? '${field.name} *' : field.name;

    switch (field.fieldType) {
      case FieldType.select:
        return _buildSelectField(field, label);
      case FieldType.number:
        return _buildNumberField(field, label);
      case FieldType.text:
        return _buildTextField(field, label);
      case FieldType.multiline:
        return _buildMultilineField(field, label);
    }
  }

  Widget _buildSelectField(ContentField field, String label) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ref.read(contentFieldRepositoryProvider).getActiveFieldOptions(field.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: label,
                  border: const OutlineInputBorder(),
                ),
                items: const [],
                onChanged: null,
              ),
              const SizedBox(height: 16),
            ],
          );
        }

        final options = snapshot.data!;

        // 编辑模式：将弃用但已选的选项补入列表
        final existingValue = _existingValues[field.id];
        if (existingValue != null && existingValue.isNotEmpty) {
          final exists = options.any((o) => o['value'] == existingValue);
          if (!exists) {
            options.add({'id': -1, 'value': '$existingValue${S.of(context)!.deprecatedSuffix}'});
          }
        }

        return Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedOptions[field.id],
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
              items: options.map((o) {
                return DropdownMenuItem<String>(
                  value: o['value'] as String,
                  child: Text(o['value'] as String),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOptions[field.id] = value;
                });
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildNumberField(ContentField field, String label) {
    return Column(
      children: [
        TextFormField(
          controller: _controllers[field.id],
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d.\-]')),
          ],
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTextField(ContentField field, String label) {
    return Column(
      children: [
        TextFormField(
          controller: _controllers[field.id],
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMultilineField(ContentField field, String label) {
    return Column(
      children: [
        TextFormField(
          controller: _controllers[field.id],
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
