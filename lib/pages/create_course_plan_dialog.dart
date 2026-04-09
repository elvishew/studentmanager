import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/states.dart';

/// 创建课程规划弹窗
class CreateCoursePlanDialog extends ConsumerStatefulWidget {
  final int studentId;

  const CreateCoursePlanDialog({
    super.key,
    required this.studentId,
  });

  @override
  ConsumerState<CreateCoursePlanDialog> createState() => _CreateCoursePlanDialogState();
}

class _CreateCoursePlanDialogState extends ConsumerState<CreateCoursePlanDialog> {
  CourseGoal? _selectedGoal;
  bool _isCreating = false;

  /// 创建课程规划
  Future<void> _createCoursePlan() async {
    if (_selectedGoal == null) return;

    setState(() {
      _isCreating = true;
    });

    final notifier = ref.read(coursePlanNotifierProvider.notifier);
    final coursePlanId = await notifier.create(
      studentId: widget.studentId,
      goal: _selectedGoal!.value,
    );

    if (mounted) {
      setState(() {
        _isCreating = false;
      });

      if (coursePlanId != null) {
        Navigator.of(context).pop(true); // 返回 true 表示成功
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('课程规划已创建')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('创建课程规划'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('请选择课程目标'),
          const SizedBox(height: 16),
          // 目标列表
          ListView.builder(
            shrinkWrap: true,
            itemCount: CourseGoal.values.length,
            itemBuilder: (context, index) {
              final goal = CourseGoal.values[index];
              final isSelected = _selectedGoal == goal;

              return ListTile(
                leading: Radio<CourseGoal>(
                  value: goal,
                  groupValue: _selectedGoal,
                  onChanged: (value) {
                    setState(() {
                      _selectedGoal = value;
                    });
                  },
                ),
                title: Text(goal.label),
                onTap: () {
                  setState(() {
                    _selectedGoal = goal;
                  });
                },
                selected: isSelected,
              );
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isCreating ? null : () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _isCreating || _selectedGoal == null ? null : _createCoursePlan,
          child: _isCreating
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('确认'),
        ),
      ],
    );
  }
}

/// 显示创建课程规划弹窗
///
/// 返回 true 表示创建成功，false 表示取消或失败
Future<bool> showCreateCoursePlanDialog(
  BuildContext context, {
  required int studentId,
}) {
  return Navigator.of(context).push<bool>(
    MaterialPageRoute(
      builder: (context) => CreateCoursePlanDialog(studentId: studentId),
    ),
  ).then((result) => result ?? false);
}
