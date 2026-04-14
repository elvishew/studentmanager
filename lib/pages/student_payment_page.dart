import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/payment_provider.dart';
import 'package:student_manager/providers/course_type_provider.dart';

/// 学员付费记录页面
class StudentPaymentPage extends ConsumerStatefulWidget {
  final int studentId;

  const StudentPaymentPage({super.key, required this.studentId});

  @override
  ConsumerState<StudentPaymentPage> createState() => _StudentPaymentPageState();
}

class _StudentPaymentPageState extends ConsumerState<StudentPaymentPage> {
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  final _notesController = TextEditingController();
  CourseType? _selectedCourseType;
  CommissionType _commissionType = CommissionType.none;
  double _commissionValue = 0;
  DateTime _paidAt = DateTime.now();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseTypes = ref.watch(activeCourseTypesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('新增付费记录'),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submit,
            child: const Text('保存'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 课程类型选择
          Text('课程类型（可选）', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: courseTypes.map((ct) {
              final isSelected = _selectedCourseType?.id == ct.id;
              return ChoiceChip(
                label: Text(ct.name),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    _selectedCourseType = ct;
                    _amountController.text = ct.defaultStudentPrice.toStringAsFixed(0);
                    _commissionType = ct.defaultCommissionType;
                    _commissionValue = ct.defaultCommissionValue;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // 金额
          TextFormField(
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: '金额 *',
              prefixText: '¥ ',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (v) => v == null || double.tryParse(v) == null ? '请输入有效金额' : null,
          ),
          const SizedBox(height: 16),

          // 描述
          TextFormField(
            controller: _descController,
            decoration: const InputDecoration(
              labelText: '描述',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // 提成设置
          Text('销售提成', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          SegmentedButton<CommissionType>(
            segments: CommissionType.values.map((t) => ButtonSegment(
              value: t, label: Text(t.label),
            )).toList(),
            selected: {_commissionType},
            onSelectionChanged: (types) => setState(() => _commissionType = types.first),
          ),
          if (_commissionType != CommissionType.none) ...[
            const SizedBox(height: 8),
            TextFormField(
              initialValue: _commissionValue.toString(),
              decoration: InputDecoration(
                labelText: _commissionType == CommissionType.fixed ? '固定金额' : '百分比 (%)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commissionValue = double.tryParse(v) ?? 0,
            ),
          ],
          const SizedBox(height: 16),

          // 付款日期
          InputDecorator(
            decoration: const InputDecoration(labelText: '付款日期', border: OutlineInputBorder()),
            child: InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _paidAt,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) setState(() => _paidAt = picked);
              },
              child: Text('${_paidAt.year}-${_paidAt.month.toString().padLeft(2, '0')}-${_paidAt.day.toString().padLeft(2, '0')}'),
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
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入有效金额'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final notifier = ref.read(paymentNotifierProvider.notifier);
      final id = await notifier.create(
        studentId: widget.studentId,
        courseTypeId: _selectedCourseType?.id,
        amount: amount,
        description: _descController.text.trim().isEmpty ? null : _descController.text.trim(),
        commissionType: _commissionType,
        commissionValue: _commissionValue,
        paidAt: _paidAt,
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );

      if (mounted) {
        if (id != null) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('付费记录已保存')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('保存失败'), backgroundColor: Colors.red),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
