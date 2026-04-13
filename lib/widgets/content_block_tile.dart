import 'package:flutter/material.dart';
import 'package:student_manager/providers/states.dart';

/// 内容块展示卡片
/// 根据 contentFields 动态渲染字段值
class ContentBlockTile extends StatelessWidget {
  final dynamic block; // ContentBlock or GoalConfigContentBlock
  final int number;
  final List<ContentField> contentFields;
  final int maxOrder;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  const ContentBlockTile({
    super.key,
    required this.block,
    required this.number,
    required this.contentFields,
    required this.maxOrder,
    this.onEdit,
    this.onDelete,
    this.onMoveUp,
    this.onMoveDown,
  });

  int get _sortOrder {
    if (block is ContentBlock) return block.sortOrder;
    if (block is GoalConfigContentBlock) return block.sortOrder;
    return 0;
  }

  Map<int, String> get _values {
    if (block is ContentBlock) return block.values;
    if (block is GoalConfigContentBlock) return block.values;
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 序号和操作按钮
            Row(
              children: [
                Text(
                  '内容块 $number',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                if (onMoveUp != null)
                  IconButton(
                    icon: const Icon(Icons.arrow_upward, size: 18),
                    tooltip: '上移',
                    onPressed: _sortOrder > 0 ? onMoveUp : null,
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    padding: EdgeInsets.zero,
                  ),
                if (onMoveDown != null)
                  IconButton(
                    icon: const Icon(Icons.arrow_downward, size: 18),
                    tooltip: '下移',
                    onPressed: _sortOrder < maxOrder ? onMoveDown : null,
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    padding: EdgeInsets.zero,
                  ),
                if (onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit, size: 18),
                    tooltip: '编辑',
                    onPressed: onEdit,
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    padding: EdgeInsets.zero,
                  ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, size: 18),
                    tooltip: '删除',
                    onPressed: onDelete,
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    padding: EdgeInsets.zero,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            // 动态渲染字段值
            _buildFieldValues(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldValues(BuildContext context) {
    final nonEmptyFields = contentFields.where((field) {
      if (field.isDeprecated) return false;
      final value = _values[field.id];
      return value != null && value.isNotEmpty;
    }).toList();

    if (nonEmptyFields.isEmpty) {
      return Text(
        '（空）',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
      );
    }

    // 对非必填字段中的数字和文本类型，两两分组显示
    final pairedFields = <ContentField>[];
    final singleFields = <ContentField>[];

    for (final field in nonEmptyFields) {
      if (field.fieldType == FieldType.number &&
          !field.isRequired &&
          pairedFields.length < 2) {
        pairedFields.add(field);
      } else if (field.fieldType == FieldType.text &&
          !field.isRequired &&
          pairedFields.length < 2) {
        pairedFields.add(field);
      } else {
        singleFields.add(field);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 两两分组显示
        if (pairedFields.length == 2)
          Row(
            children: pairedFields.map((field) {
              return Expanded(
                child: _buildDetailItem(
                  context,
                  field.name,
                  _values[field.id]!,
                ),
              );
            }).toList(),
          )
        else
          for (final field in pairedFields)
            _buildDetailRow(context, field.name, _values[field.id]!),
        // 其余字段逐行显示
        for (final field in singleFields)
          _buildDetailRow(context, field.name, _values[field.id]!),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
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

  Widget _buildDetailItem(BuildContext context, String label, String value) {
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
}
