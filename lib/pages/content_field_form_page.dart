import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/content_field_provider.dart';
import 'package:student_manager/providers/states.dart';

/// 内容字段编辑表单
class ContentFieldFormPage extends ConsumerStatefulWidget {
  final ContentField? field;

  const ContentFieldFormPage({super.key, this.field});

  @override
  ConsumerState<ContentFieldFormPage> createState() => _ContentFieldFormPageState();
}

class _ContentFieldFormPageState extends ConsumerState<ContentFieldFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedType = 'text';
  bool _isRequired = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.field != null) {
      _nameController.text = widget.field!.name;
      _selectedType = widget.field!.fieldType.name;
      _isRequired = widget.field!.isRequired;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.field != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? '编辑字段' : '新增字段'),
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
              onPressed: _nameController.text.trim().isNotEmpty ? _save : null,
              child: const Text('保存'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '字段名称',
                hintText: '例如：动作、曲目、练习内容',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return '请输入字段名称';
                return null;
              },
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: '字段类型',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'select', child: Text('下拉选择')),
                DropdownMenuItem(value: 'number', child: Text('数字')),
                DropdownMenuItem(value: 'text', child: Text('文本')),
                DropdownMenuItem(value: 'multiline', child: Text('多行文本')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedType = value);
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              '下拉选择类型支持预设选项列表，其他类型为自由输入。',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('必填'),
              subtitle: const Text('创建内容块时必须填写此字段'),
              value: _isRequired,
              onChanged: (value) {
                setState(() => _isRequired = value);
              },
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final notifier = ref.read(contentFieldNotifierProvider.notifier);
    bool success;

    if (widget.field != null) {
      success = await notifier.updateField(
        id: widget.field!.id,
        name: _nameController.text.trim(),
        fieldType: _selectedType,
        isRequired: _isRequired,
      );
    } else {
      final id = await notifier.createField(
        name: _nameController.text.trim(),
        fieldType: _selectedType,
        isRequired: _isRequired,
      );
      success = id != null;
    }

    if (mounted) {
      setState(() => _isSaving = false);
      if (success) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.field != null ? '字段已更新' : '字段已创建'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已存在同名字段')),
        );
      }
    }
  }
}
