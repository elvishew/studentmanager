import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/states.dart';
import '../database/course_plan_repository.dart';

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
  // 当前步骤：0=选择目标, 1=选择课时数, 2=检测模板, 3=编辑蓝图
  int _currentStep = 0;

  // 用户选择
  CourseGoal? _selectedGoal;
  int? _selectedSessionCount; // 预设选择
  final TextEditingController _customSessionCountController = TextEditingController();
  final TextEditingController _blueprintController = TextEditingController();

  // 模板相关状态
  bool _isLoadingTemplate = false;
  GoalTemplateInfo? _templateInfo;
  bool _useTemplate = true;
  String? _templateError;

  static const List<int> presetSessionCounts = [12, 24, 33, 55];

  @override
  void dispose() {
    _customSessionCountController.dispose();
    _blueprintController.dispose();
    super.dispose();
  }

  /// 获取实际课时数
  int? get _actualSessionCount {
    if (_selectedSessionCount != null) {
      return _selectedSessionCount;
    }
    if (_customSessionCountController.text.isNotEmpty) {
      final value = int.tryParse(_customSessionCountController.text);
      if (value != null && value >= 1 && value <= 60) {
        return value;
      }
    }
    return null;
  }

  /// 检测模板数据
  Future<void> _checkTemplate() async {
    if (_selectedGoal == null || _selectedGoal == CourseGoal.custom) {
      setState(() {
        _currentStep = 3; // 跳过模板检测，直接到蓝图编辑
      });
      return;
    }

    setState(() {
      _isLoadingTemplate = true;
      _templateError = null;
    });

    try {
      final repository = ref.read(coursePlanRepositoryProvider);
      final templateInfo = await repository.checkGoalTemplate(_selectedGoal!.value);

      setState(() {
        _isLoadingTemplate = false;
        _templateInfo = templateInfo;

        if (templateInfo == null) {
          _useTemplate = false;
          _templateError = '未找到模板数据，将手动创建';
        } else if (_actualSessionCount != null && _actualSessionCount! > templateInfo.availableSessionCount) {
          _templateError = '模板仅有 ${templateInfo.availableSessionCount} 节课，超出部分为空课时';
        }

        _currentStep = 3;

        // 预填充蓝图
        if (_useTemplate && templateInfo?.blueprint != null) {
          _blueprintController.text = templateInfo!.blueprint!;
        }
      });
    } catch (e) {
      setState(() {
        _isLoadingTemplate = false;
        _templateError = '检测模板失败: $e';
        _useTemplate = false;
        _currentStep = 3;
      });
    }
  }

  /// 创建课程规划
  Future<void> _createCoursePlan() async {
    final sessionCount = _actualSessionCount ?? 12;

    setState(() {
      _isCreating = true;
    });

    final notifier = ref.read(coursePlanNotifierProvider.notifier);
    final coursePlanId = await notifier.create(
      studentId: widget.studentId,
      goal: _selectedGoal!.value,
      sessionCount: sessionCount,
      customBlueprint: _blueprintController.text.isEmpty ? null : _blueprintController.text,
      useTemplate: _useTemplate,
    );

    if (mounted) {
      setState(() {
        _isCreating = false;
      });

      if (coursePlanId != null) {
        Navigator.of(context).pop(true); // 返回 true 表示成功
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('课程规划已创建 ($sessionCount节课)')),
        );
      }
    }
  }

  bool _isCreating = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_getTitle()),
      content: SizedBox(
        width: 400,
        child: _buildContent(),
      ),
      actions: _buildActions(),
    );
  }

  String _getTitle() {
    switch (_currentStep) {
      case 0:
        return '创建课程规划 (1/4)';
      case 1:
        return '选择课时数量 (2/4)';
      case 2:
        return '检测模板数据 (3/4)';
      case 3:
        return '编辑蓝图 (4/4)';
      default:
        return '创建课程规划';
    }
  }

  Widget _buildContent() {
    switch (_currentStep) {
      case 0:
        return _buildGoalSelection();
      case 1:
        return _buildSessionCountSelection();
      case 2:
        return _buildTemplateChecking();
      case 3:
        return _buildBlueprintEditing();
      default:
        return const SizedBox.shrink();
    }
  }

  /// 步骤1: 选择课程目标
  Widget _buildGoalSelection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('请选择课程目标'),
        const SizedBox(height: 16),
        ...CourseGoal.values.map((goal) {
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
        }).toList(),
      ],
    );
  }

  /// 步骤2: 选择课时数量
  Widget _buildSessionCountSelection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('请选择课时数量'),
        const SizedBox(height: 16),
        // 预设选项
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: presetSessionCounts.map((count) {
            final isSelected = _selectedSessionCount == count;
            return ChoiceChip(
              label: Text('$count节'),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedSessionCount = count;
                    _customSessionCountController.clear();
                  } else {
                    _selectedSessionCount = null;
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        // 自定义输入
        Row(
          children: [
            const Text('自定义：'),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _customSessionCountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '课时数',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedSessionCount = null;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            const Text('节 (1-60)'),
          ],
        ),
        const SizedBox(height: 8),
        // 验证提示
        if (_customSessionCountController.text.isNotEmpty)
          Text(
            _getValidationMessage(),
            style: TextStyle(
              color: _getValidationMessage().contains('✓')
                  ? Colors.green
                  : Colors.red,
              fontSize: 12,
            ),
          ),
      ],
    );
  }

  String _getValidationMessage() {
    if (_selectedSessionCount != null) {
      return '✓ 已选择 ${_selectedSessionCount} 节课';
    }
    if (_customSessionCountController.text.isEmpty) {
      return '请选择或输入课时数量';
    }
    final value = int.tryParse(_customSessionCountController.text);
    if (value == null) {
      return '请输入有效的数字';
    }
    if (value < 1 || value > 60) {
      return '课时数量必须在 1-60 之间';
    }
    return '✓ 自定义 $value 节课';
  }

  /// 步骤3: 检测模板（显示loading）
  Widget _buildTemplateChecking() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('正在检测模板数据...'),
          ],
        ),
      ),
    );
  }

  /// 步骤4: 编辑蓝图
  Widget _buildBlueprintEditing() {
    final sessionCount = _actualSessionCount ?? 12;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 摘要信息
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('课程目标: ${_selectedGoal?.label ?? "未选择"}'),
              const SizedBox(height: 4),
              Text('课时数量: $sessionCount 节'),
              if (_templateInfo != null) ...[
                const SizedBox(height: 4),
                Text('模板课时: ${_templateInfo!.availableSessionCount} 节'),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 模板提示信息
        if (_templateError != null)
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: _useTemplate ? Colors.orange.shade50 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _useTemplate ? Colors.orange.shade200 : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _useTemplate ? Icons.info_outline : Icons.warning_outlined,
                  color: _useTemplate ? Colors.orange : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(_templateError!)),
              ],
            ),
          ),

        // 模板开关（如果有模板）
        if (_templateInfo != null)
          SwitchListTile(
            title: const Text('使用模板数据'),
            subtitle: Text(_useTemplate ? '将复制模板课时内容' : '将创建空白课时'),
            value: _useTemplate,
            onChanged: (value) {
              setState(() {
                _useTemplate = value;
              });
            },
          ),

        const SizedBox(height: 8),

        // 蓝图编辑
        const Text('蓝图描述（可选）'),
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
    );
  }

  /// 构建按钮
  List<Widget> _buildActions() {
    switch (_currentStep) {
      case 0: // 选择目标
        return [
          TextButton(
            onPressed: _isCreating ? null : () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: _isCreating || _selectedGoal == null ? null : _handleNext,
            child: const Text('下一步'),
          ),
        ];

      case 1: // 选择课时数
        return [
          TextButton(
            onPressed: _isCreating ? null : _handleBack,
            child: const Text('上一步'),
          ),
          TextButton(
            onPressed: _isCreating ? null : () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: _isCreating || _actualSessionCount == null ? null : _handleNext,
            child: const Text('下一步'),
          ),
        ];

      case 2: // 检测模板
        return [
          // 无按钮，自动进行
        ];

      case 3: // 编辑蓝图
        return [
          TextButton(
            onPressed: _isCreating ? null : _handleBack,
            child: const Text('上一步'),
          ),
          TextButton(
            onPressed: _isCreating ? null : () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: _isCreating ? null : _createCoursePlan,
            child: _isCreating
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('创建'),
          ),
        ];

      default:
        return [];
    }
  }

  void _handleNext() {
    setState(() {
      if (_currentStep == 0) {
        // 从目标选择到课时选择
        if (_selectedGoal == CourseGoal.custom) {
          // 自定义目标跳过课时选择，直接到蓝图编辑
          _currentStep = 3;
          _useTemplate = false;
        } else {
          _currentStep = 1;
        }
      } else if (_currentStep == 1) {
        // 从课时选择到模板检测
        _currentStep = 2;
        _checkTemplate();
      }
    });
  }

  void _handleBack() {
    setState(() {
      if (_currentStep == 3) {
        // 从蓝图编辑返回
        if (_selectedGoal == CourseGoal.custom) {
          _currentStep = 0;
        } else {
          _currentStep = 1;
        }
      } else {
        _currentStep--;
      }
    });
  }
}

/// 显示创建课程规划弹窗
///
/// 返回 true 表示创建成功，false 表示取消或失败
Future<bool> showCreateCoursePlanDialog(
  BuildContext context, {
  required int studentId,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => CreateCoursePlanDialog(studentId: studentId),
  ).then((result) => result ?? false);
}
