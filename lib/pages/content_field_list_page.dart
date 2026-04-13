import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  String _fieldTypeLabel(FieldType type) {
    switch (type) {
      case FieldType.select: return '下拉选择';
      case FieldType.number: return '数字';
      case FieldType.text: return '文本';
      case FieldType.multiline: return '多行文本';
    }
  }

  @override
  Widget build(BuildContext context) {
    final fields = ref.watch(contentFieldNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('教学内容字段'),
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
            tooltip: '新增字段',
          ),
        ],
      ),
      body: fields.isEmpty
          ? const Center(child: Text('暂无内容字段'))
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
              _fieldTypeLabel(field.fieldType),
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
                '必填',
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
              tooltip: '管理选项',
            ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value, field, index),
            itemBuilder: (context) => [
              if (index > 0)
                const PopupMenuItem(value: 'up', child: Text('上移')),
              if (index < ref.read(contentFieldNotifierProvider).length - 1)
                const PopupMenuItem(value: 'down', child: Text('下移')),
              const PopupMenuItem(value: 'edit', child: Text('编辑')),
              PopupMenuItem(
                value: 'toggle',
                child: Text(field.isDeprecated ? '启用' : '弃用'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('删除', style: TextStyle(color: Colors.red)),
              ),
            ],
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
          builder: (context) => AlertDialog(
            title: const Text('确认删除'),
            content: Text('确定要删除字段「${field.name}」吗？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('删除'),
              ),
            ],
          ),
        );
        if (confirmed == true) {
          await notifier.deleteField(field.id);
          notifier.loadFields();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('字段已删除')),
            );
          }
        }
        break;
    }
  }
}
