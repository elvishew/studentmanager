import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/item_provider.dart';
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
  String? _selectedGoalName;
  late TextEditingController _blueprintController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedGoalName = widget.coursePlan.goal;
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
      goal: _selectedGoalName!,
      blueprint: _blueprintController.text.isEmpty ? null : _blueprintController.text,
    );

    if (mounted) {
      setState(() {
        _isSaving = false;
      });

      if (success) {
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('保存失败，请重试'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final goalsAsync = ref.watch(activeGoalsProvider);

    return AlertDialog(
      title: const Text('编辑课程规划'),
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
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '修改课程目标不会影响已有课时的训练内容',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 课程目标选择
            const Text(
              '课程目标',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            goalsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('加载失败: $e'),
              data: (goals) {
                final goalNames = goals.map((g) => g.name).toSet();

                // 构建下拉项：活跃目标 + "自定义"
                final items = <DropdownMenuItem<String>>[
                  ...goals.map((g) => DropdownMenuItem<String>(
                        value: g.name,
                        child: Text(g.name),
                      )),
                ];

                // 如果当前目标已弃用/不在活跃列表中，补入下拉项
                if (_selectedGoalName != null &&
                    _selectedGoalName != kCustomGoalName &&
                    !goalNames.contains(_selectedGoalName)) {
                  items.insert(
                    0,
                    DropdownMenuItem<String>(
                      value: _selectedGoalName,
                      child: Text('$_selectedGoalName（已弃用）'),
                    ),
                  );
                }

                items.add(const DropdownMenuItem<String>(
                  value: kCustomGoalName,
                  child: Text('自定义'),
                ));

                return DropdownButtonFormField<String>(
                  initialValue: _selectedGoalName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: items,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedGoalName = value);
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 16),

            // 蓝图编辑
            const Text(
              '蓝图描述（可选）',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _blueprintController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: '输入课程规划的整体描述...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _save,
          child: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('保存'),
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
