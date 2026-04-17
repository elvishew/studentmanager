import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/l10n/app_localizations.dart';
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
    final s = S.of(context)!;
    final isEdit = widget.field != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? s.editFieldTitle : s.newFieldTitle),
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
              child: Text(s.btnSave),
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
              decoration: InputDecoration(
                labelText: s.fieldNameLabel,
                hintText: s.fieldNameHint,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return s.fieldNameRequired;
                return null;
              },
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: InputDecoration(
                labelText: s.fieldTypeLabel,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 'select', child: Text(s.fieldTypeSelect)),
                DropdownMenuItem(value: 'number', child: Text(s.fieldTypeNumber)),
                DropdownMenuItem(value: 'text', child: Text(s.fieldTypeText)),
                DropdownMenuItem(value: 'multiline', child: Text(s.fieldTypeMultiline)),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedType = value);
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              s.selectTypeHint,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: Text(s.requiredLabel),
              subtitle: Text(s.requiredSubtitle),
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
      final s = S.of(context)!;
      setState(() => _isSaving = false);
      if (success) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.field != null ? s.fieldUpdated : s.fieldCreated),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.fieldNameExists)),
        );
      }
    }
  }
}
