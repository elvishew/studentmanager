import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/providers/content_field_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'content_field_form_page.dart';
import 'field_option_list_page.dart';

/// 内容字段管理列表页
class ContentFieldListPage extends ConsumerStatefulWidget {
  const ContentFieldListPage({super.key});

  @override
  ConsumerState<ContentFieldListPage> createState() => _ContentFieldListPageState();
}

class _ContentFieldListPageState extends ConsumerState<ContentFieldListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(contentFieldNotifierProvider.notifier).loadFields();
    });
  }

  String _fieldTypeLabel(BuildContext context, FieldType type) {
    final s = S.of(context)!;
    switch (type) {
      case FieldType.select: return s.fieldTypeSelect;
      case FieldType.number: return s.fieldTypeNumber;
      case FieldType.text: return s.fieldTypeText;
      case FieldType.multiline: return s.fieldTypeMultiline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    final fields = ref.watch(contentFieldNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.contentFieldPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ContentFieldFormPage(),
                ),
              );
              ref.read(contentFieldNotifierProvider.notifier).loadFields();
            },
            tooltip: s.addFieldTooltip,
          ),
        ],
      ),
      body: fields.isEmpty
          ? Center(child: Text(s.noContentFieldsMessage))
          : ListView.builder(
              itemCount: fields.length,
              itemBuilder: (context, index) {
                final field = fields[index];
                return _buildFieldTile(field, index);
              },
            ),
    );
  }

  Widget _buildFieldTile(ContentField field, int index) {
    final s = S.of(context)!;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: field.isDeprecated
            ? Theme.of(context).colorScheme.surfaceContainerHighest
            : Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: field.isDeprecated
                ? Theme.of(context).colorScheme.outline
                : Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        field.name,
        style: TextStyle(
          decoration: field.isDeprecated ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _fieldTypeLabel(context, field.fieldType),
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 6),
          if (field.isRequired)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                s.requiredLabel,
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (field.fieldType == FieldType.select)
            IconButton(
              icon: const Icon(Icons.list, size: 20),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FieldOptionListPage(
                      fieldId: field.id,
                      fieldName: field.name,
                    ),
                  ),
                );
                ref.read(contentFieldNotifierProvider.notifier).loadFields();
              },
              tooltip: s.manageOptionsTooltip,
            ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value, field, index),
            itemBuilder: (context) {
              final s = S.of(context)!;
              return [
                if (index > 0)
                  PopupMenuItem(value: 'up', child: Text(s.moveUpTooltip)),
                if (index < ref.read(contentFieldNotifierProvider).length - 1)
                  PopupMenuItem(value: 'down', child: Text(s.moveDownTooltip)),
                PopupMenuItem(value: 'edit', child: Text(s.edit)),
                PopupMenuItem(
                  value: 'toggle',
                  child: Text(field.isDeprecated ? s.activateTooltip : s.deprecateTooltip),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(s.btnDelete, style: const TextStyle(color: Colors.red)),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleMenuAction(String action, ContentField field, int index) async {
    final notifier = ref.read(contentFieldNotifierProvider.notifier);

    switch (action) {
      case 'up':
        await notifier.moveFieldUp(index);
        break;
      case 'down':
        await notifier.moveFieldDown(index);
        break;
      case 'edit':
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ContentFieldFormPage(field: field),
          ),
        );
        notifier.loadFields();
        break;
      case 'toggle':
        await notifier.toggleFieldDeprecated(field.id, !field.isDeprecated);
        notifier.loadFields();
        break;
      case 'delete':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) {
            final s = S.of(context)!;
            return AlertDialog(
              title: Text(s.btnConfirmDelete),
              content: Text('${s.confirm} ${s.btnDelete}「${field.name}」？'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(s.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: Text(s.btnDelete),
                ),
              ],
            );
          },
        );
        if (confirmed == true) {
          await notifier.deleteField(field.id);
          notifier.loadFields();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context)!.fieldDeleted)),
            );
          }
        }
        break;
    }
  }
}
