import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/payment_provider.dart';
import 'package:student_manager/providers/course_type_provider.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/l10n/enum_localizations.dart';

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
  CoursePlan? _selectedCoursePlan;
  CommissionType _commissionType = CommissionType.none;
  double _commissionValue = 0;
  DateTime _paidAt = DateTime.now();
  bool _isSubmitting = false;
  List<CoursePlan> _coursePlans = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCoursePlans();
    });
  }

  Future<void> _loadCoursePlans() async {
    await ref.read(coursePlanNotifierProvider.notifier).fetchByStudentId(widget.studentId);
    if (mounted) {
      final state = ref.read(coursePlanNotifierProvider);
      state.when(
        initial: () {},
        loading: () {},
        error: (_, __) {},
        data: (plans, _, __) {
          setState(() {
            _coursePlans = plans.where((p) => p.studentId == widget.studentId).toList();
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    final courseTypes = ref.watch(activeCourseTypesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.newPaymentRecordTitle),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submit,
            child: Text(s.btnSave),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 课程类型选择
          Text(s.courseTypeOptionalLabel, style: Theme.of(context).textTheme.titleSmall),
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

          // 课程规划选择
          Text(s.coursePlanOptionalLabel, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _coursePlans.isEmpty
              ? Text(s.noCoursePlansAvailable,
                  style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.outline))
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _coursePlans.map((plan) {
                    final isSelected = _selectedCoursePlan?.id == plan.id;
                    return ChoiceChip(
                      label: Text(plan.goalName ?? s.unknown),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          _selectedCoursePlan = isSelected ? null : plan;
                        });
                      },
                    );
                  }).toList(),
                ),
          const SizedBox(height: 16),

          // 金额
          TextFormField(
            controller: _amountController,
            decoration: InputDecoration(
              labelText: s.amountRequiredLabel,
              prefixText: '¥ ',
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (v) => v == null || double.tryParse(v) == null ? s.invalidAmountMessage : null,
          ),
          const SizedBox(height: 16),

          // 描述
          TextFormField(
            controller: _descController,
            decoration: InputDecoration(
              labelText: s.paymentDescriptionLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // 提成设置
          Text(s.salesCommissionLabel, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          SegmentedButton<CommissionType>(
            segments: CommissionType.values.map((t) => ButtonSegment(
              value: t, label: Text(t.loc(context)),
            )).toList(),
            selected: {_commissionType},
            onSelectionChanged: (types) => setState(() => _commissionType = types.first),
          ),
          if (_commissionType != CommissionType.none) ...[
            const SizedBox(height: 8),
            TextFormField(
              initialValue: _commissionValue.toString(),
              decoration: InputDecoration(
                labelText: _commissionType == CommissionType.fixed ? s.commissionFixed : s.percentageLabel,
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commissionValue = double.tryParse(v) ?? 0,
            ),
          ],
          const SizedBox(height: 16),

          // 付款日期
          InputDecorator(
            decoration: InputDecoration(labelText: s.paymentDateLabel, border: const OutlineInputBorder()),
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
            decoration: InputDecoration(
              labelText: s.paymentNotesLabel,
              border: const OutlineInputBorder(),
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
        SnackBar(content: Text(S.of(context)!.invalidAmountMessage), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final notifier = ref.read(paymentNotifierProvider.notifier);
      final id = await notifier.create(
        studentId: widget.studentId,
        courseTypeId: _selectedCourseType?.id,
        coursePlanId: _selectedCoursePlan?.id,
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context)!.paymentSaved)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context)!.saveFailed), backgroundColor: Colors.red),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
