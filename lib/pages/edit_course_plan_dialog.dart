import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  // 时长相关
  int? _selectedDuration;
  final TextEditingController _customDurationController = TextEditingController();

  static const List<int> presetDurations = [30, 45, 60, 90];

  @override
  void initState() {
    super.initState();
    _selectedGoalId = widget.coursePlan.goalId;
    _selectedGoalName = widget.coursePlan.goalName;
    _blueprintController = TextEditingController(text: widget.coursePlan.blueprint ?? '');

    // 回填时长：匹配预设则选中 Dropdown，否则填入自定义输入框
    final duration = widget.coursePlan.defaultDuration ?? 60;
    if (presetDurations.contains(duration)) {
      _selectedDuration = duration;
    } else {
      _selectedDuration = null;
      _customDurationController.text = duration.toString();
    }
  }

  @override
  void dispose() {
    _blueprintController.dispose();
    _customDurationController.dispose();
    super.dispose();
  }

  /// 获取实际时长
  int get _actualDuration {
    if (_selectedDuration != null) {
      return _selectedDuration!;
    }
    if (_customDurationController.text.isNotEmpty) {
      final value = int.tryParse(_customDurationController.text);
      if (value != null && value >= 1 && value <= 180) {
        return value;
      }
    }
    return widget.coursePlan.defaultDuration ?? 60;
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
      defaultDuration: _actualDuration,
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
            const Text('课程目标', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            goalsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('加载失败: $e'),
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

            // 默认课时时长
            const Text('默认课时时长', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: _selectedDuration,
              decoration: const InputDecoration(
                hintText: '选择课时时长',
                border: OutlineInputBorder(),
              ),
              items: presetDurations.map((minutes) => DropdownMenuItem<int>(
                value: minutes,
                child: Text('$minutes 分钟'),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDuration = value;
                  _customDurationController.clear();
                });
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('或自定义：', style: TextStyle(fontSize: 13)),
                const SizedBox(width: 8),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _customDurationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '时长',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                    style: const TextStyle(fontSize: 14),
                    onChanged: (_) {
                      setState(() {
                        _selectedDuration = null;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 6),
                const Text('分钟 (1-180)', style: TextStyle(fontSize: 13)),
              ],
            ),
            const SizedBox(height: 16),

            // 蓝图编辑
            const Text('蓝图描述（可选）', style: TextStyle(fontWeight: FontWeight.w500)),
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
