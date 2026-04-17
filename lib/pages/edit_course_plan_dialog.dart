import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/content_field_provider.dart';
import 'package:student_manager/providers/states.dart';

/// 编辑课程规划弹窗
class EditCoursePlanDialog extends ConsumerStatefulWidget {
  final CoursePlan coursePlan;

  const EditCoursePlanDialog({
    super.key,
    required this.coursePlan,
  });

  @override
  ConsumerState<EditCoursePlanDialog> createState() => _EditCoursePlanDialogState();
}

class _EditCoursePlanDialogState extends ConsumerState<EditCoursePlanDialog> {
  int? _selectedGoalId;
  String? _selectedGoalName;
  late TextEditingController _blueprintController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedGoalId = widget.coursePlan.goalId;
    _selectedGoalName = widget.coursePlan.goalName;
    _blueprintController = TextEditingController(text: widget.coursePlan.blueprint ?? '');
  }

  @override
  void dispose() {
    _blueprintController.dispose();
    super.dispose();
  }

  /// 保存修改
  Future<void> _save() async {
    setState(() {
      _isSaving = true;
    });

    final notifier = ref.read(coursePlanNotifierProvider.notifier);
    final success = await notifier.update(
      id: widget.coursePlan.id,
      goalId: _selectedGoalId,
      blueprint: _blueprintController.text.isEmpty ? null : _blueprintController.text,
    );

    if (mounted) {
      setState(() {
        _isSaving = false;
      });

      if (success) {
        Navigator.of(context).pop(true);
      } else {
        final s = S.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.saveFailedRetry), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    final goalsAsync = ref.watch(activeGoalsProvider);

    return AlertDialog(
      title: Text(s.editCoursePlanTitle),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 提示信息
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      s.courseGoalChangeNote,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 课程目标选择
            Text(s.courseGoalLabel, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            goalsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text(s.statisticsLoadingFailed(e.toString())),
              data: (goals) {
                final goalIds = goals.map((g) => g.id).toSet();

                final items = <DropdownMenuItem<int>>[
                  ...goals.map((g) => DropdownMenuItem<int>(
                    value: g.id,
                    child: Text(g.name),
                  )),
                ];

                if (_selectedGoalId != null &&
                    !goalIds.contains(_selectedGoalId)) {
                  items.insert(
                    0,
                    DropdownMenuItem<int>(
                      value: _selectedGoalId,
                      child: Text('${_selectedGoalName ?? "未知目标"}（已弃用）'),
                    ),
                  );
                }

                return DropdownButtonFormField<int>(
                  initialValue: _selectedGoalId,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: items,
                  onChanged: (value) {
                    if (value != null) {
                      final goal = goals.firstWhere((g) => g.id == value);
                      setState(() {
                        _selectedGoalId = value;
                        _selectedGoalName = goal.name;
                      });
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 16),

            // 蓝图编辑
            Text(s.blueprintLabel, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            TextField(
              controller: _blueprintController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: s.blueprintHint,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(false),
          child: Text(s.btnCancel),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _save,
          child: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(s.btnSave),
        ),
      ],
    );
  }
}

/// 显示编辑课程规划弹窗
///
/// 返回 true 表示保存成功
Future<bool> showEditCoursePlanDialog(
  BuildContext context, {
  required CoursePlan coursePlan,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => EditCoursePlanDialog(coursePlan: coursePlan),
  ).then((result) => result ?? false);
}
