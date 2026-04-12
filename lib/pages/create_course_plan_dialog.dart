import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/item_provider.dart';
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
  // 当前步骤：0=选择参数, 1=检测模板(自动过渡), 2=编辑蓝图
  int _currentStep = 0;

  // 用户选择
  int? _selectedGoalId;
  String? _selectedGoalName;
  int? _selectedSessionCount; // Dropdown 选中的预设值
  final TextEditingController _customSessionCountController = TextEditingController();
  final TextEditingController _blueprintController = TextEditingController();

  // 时长相关
  int? _selectedDuration; // Dropdown 选中的预设值
  final TextEditingController _customDurationController = TextEditingController();

  static const List<int> presetSessionCounts = [12, 24, 33, 55];
  static const List<int> presetDurations = [30, 45, 60, 90];

  // 模板相关状态
  GoalTemplateInfo? _templateInfo;
  bool _useTemplate = true;
  String? _templateError;

  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    _selectedDuration = 60; // 默认选中60分钟
  }

  @override
  void dispose() {
    _customSessionCountController.dispose();
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
    return 60;
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

  /// 步骤1是否可以下一步
  bool get _canProceedFromStep0 {
    return _selectedGoalId != null && _actualSessionCount != null;
  }

  /// 检测模板数据
  Future<void> _checkTemplate() async {
    if (_selectedGoalId == null) {
      setState(() {
        _currentStep = 2;
      });
      return;
    }

    setState(() {
      _templateError = null;
    });

    try {
      final repository = ref.read(coursePlanRepositoryProvider);
      final templateInfo = await repository.checkGoalTemplate(_selectedGoalId!);

      setState(() {
        _templateInfo = templateInfo;

        if (templateInfo == null) {
          _useTemplate = false;
          _templateError = '未找到模板数据，将手动创建';
        } else if (_actualSessionCount != null && _actualSessionCount! > templateInfo.availableSessionCount) {
          _templateError = '模板仅有 ${templateInfo.availableSessionCount} 节课，超出部分为空课时';
        }

        _currentStep = 2;

        if (_useTemplate && templateInfo?.blueprint != null) {
          _blueprintController.text = templateInfo!.blueprint!;
        }
      });
    } catch (e) {
      setState(() {
        _templateError = '检测模板失败: $e';
        _useTemplate = false;
        _currentStep = 2;
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
      goalId: _selectedGoalId!,
      sessionCount: sessionCount,
      customBlueprint: _blueprintController.text.isEmpty ? null : _blueprintController.text,
      useTemplate: _useTemplate,
      defaultDuration: _actualDuration,
    );

    if (mounted) {
      setState(() {
        _isCreating = false;
      });

      if (coursePlanId != null) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('课程规划已创建 ($sessionCount节课)')),
        );
      }
    }
  }

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
        return '创建课程规划 (1/3)';
      case 1:
        return '检测模板数据 (2/3)';
      case 2:
        return '编辑蓝图 (3/3)';
      default:
        return '创建课程规划';
    }
  }

  Widget _buildContent() {
    switch (_currentStep) {
      case 0:
        return _buildParamsSelection();
      case 1:
        return _buildTemplateChecking();
      case 2:
        return _buildBlueprintEditing();
      default:
        return const SizedBox.shrink();
    }
  }

  // ============================================
  // 步骤 1/3: 选择参数（Dropdown + 自定义输入）
  // ============================================

  Widget _buildParamsSelection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 课程目标
        _buildGoalDropdown(),
        const SizedBox(height: 16),

        // 课时数量
        _buildSessionCountField(),
        const SizedBox(height: 16),

        // 默认课时时长
        _buildDurationField(),
      ],
    );
  }

  Widget _buildGoalDropdown() {
    final goalsAsync = ref.watch(activeGoalsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('课程目标', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        goalsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('加载目标失败: $e'),
          data: (goals) {
            return DropdownButtonFormField<int>(
              value: _selectedGoalId,
              decoration: const InputDecoration(
                hintText: '请选择课程目标',
                border: OutlineInputBorder(),
              ),
              items: goals.map((g) => DropdownMenuItem<int>(
                value: g.id,
                child: Text(g.name),
              )).toList(),
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
      ],
    );
  }

  Widget _buildSessionCountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('课时数量', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: _selectedSessionCount,
          decoration: const InputDecoration(
            hintText: '选择课时数量',
            border: OutlineInputBorder(),
          ),
          items: presetSessionCounts.map((count) => DropdownMenuItem<int>(
            value: count,
            child: Text('$count 节'),
          )).toList(),
          onChanged: (value) {
            setState(() {
              _selectedSessionCount = value;
              _customSessionCountController.clear();
            });
          },
        ),
        const SizedBox(height: 8),
        _buildCustomInputRow(
          controller: _customSessionCountController,
          hintText: '课时数',
          suffix: '节 (1-60)',
          onChanged: () {
            setState(() {
              _selectedSessionCount = null;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDurationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        _buildCustomInputRow(
          controller: _customDurationController,
          hintText: '时长',
          suffix: '分钟 (1-180)',
          onChanged: () {
            setState(() {
              _selectedDuration = null;
            });
          },
        ),
      ],
    );
  }

  /// 可复用的"或自定义"输入行
  Widget _buildCustomInputRow({
    required TextEditingController controller,
    required String hintText,
    required String suffix,
    required VoidCallback onChanged,
  }) {
    return Row(
      children: [
        const Text('或自定义：', style: TextStyle(fontSize: 13)),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
            style: const TextStyle(fontSize: 14),
            onChanged: (_) => onChanged(),
          ),
        ),
        const SizedBox(width: 6),
        Text(suffix, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  // ============================================
  // 步骤 2/3: 检测模板（自动过渡 loading）
  // ============================================

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

  // ============================================
  // 步骤 3/3: 编辑蓝图
  // ============================================

  Widget _buildBlueprintEditing() {
    final sessionCount = _actualSessionCount ?? 12;
    final duration = _actualDuration;

    return SingleChildScrollView(
      child: Column(
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
                Text('课程目标: ${_selectedGoalName ?? "未选择"}'),
                const SizedBox(height: 4),
                Text('课时数量: $sessionCount 节'),
                const SizedBox(height: 4),
                Text('默认时长: $duration 分钟'),
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
      ),
    );
  }

  // ============================================
  // 按钮
  // ============================================

  List<Widget> _buildActions() {
    switch (_currentStep) {
      case 0: // 选择参数
        return [
          TextButton(
            onPressed: _isCreating ? null : () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: _isCreating || !_canProceedFromStep0 ? null : _handleNext,
            child: const Text('下一步'),
          ),
        ];

      case 1: // 检测模板（无按钮，自动进行）
        return [];

      case 2: // 编辑蓝图
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
    if (_currentStep == 0) {
      setState(() {
        _currentStep = 1;
      });
      _checkTemplate();
    }
  }

  void _handleBack() {
    setState(() {
      _currentStep = 0;
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
