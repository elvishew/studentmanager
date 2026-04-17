import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/content_field_provider.dart';
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
      final s = S.of(context)!;

      setState(() {
        _templateInfo = templateInfo;

        if (templateInfo == null) {
          _useTemplate = false;
          _templateError = s.templateNotFoundWarning;
        } else if (_actualSessionCount != null && _actualSessionCount! > templateInfo.availableSessionCount) {
          _templateError = s.templateLimitedSessions(templateInfo.availableSessionCount);
        }

        _currentStep = 2;

        if (_useTemplate && templateInfo?.blueprint != null) {
          _blueprintController.text = templateInfo!.blueprint!;
        }
      });
    } catch (e) {
      final s = S.of(context)!;
      setState(() {
        _templateError = s.templateDetectFailed(e.toString());
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
    );

    if (mounted) {
      setState(() {
        _isCreating = false;
      });

      if (coursePlanId != null) {
        final s = S.of(context)!;
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.coursePlanCreatedWithCount(sessionCount))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    return AlertDialog(
      title: Text(_getTitle(s)),
      content: SizedBox(
        width: 400,
        child: _buildContent(),
      ),
      actions: _buildActions(s),
    );
  }

  String _getTitle(S s) {
    switch (_currentStep) {
      case 0:
        return s.stepCreateCoursePlan;
      case 1:
        return s.stepDetectTemplate;
      case 2:
        return s.stepEditBlueprint;
      default:
        return s.createCoursePlanTitle;
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
    final s = S.of(context)!;
    final goalsAsync = ref.watch(activeGoalsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.courseGoalFieldLabel, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        goalsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text(s.loadGoalsFailed(e.toString())),
          data: (goals) {
            return DropdownButtonFormField<int>(
              value: _selectedGoalId,
              decoration: InputDecoration(
                hintText: s.selectGoalHint,
                border: const OutlineInputBorder(),
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
    final s = S.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.sessionCountLabel, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: _selectedSessionCount,
          decoration: InputDecoration(
            hintText: s.selectSessionCount,
            border: const OutlineInputBorder(),
          ),
          items: presetSessionCounts.map((count) => DropdownMenuItem<int>(
            value: count,
            child: Text('$count'),
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
          hintText: s.sessionCountLabel,
          suffix: s.sessionCountUnit,
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
    final s = S.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.defaultDurationTitle, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: _selectedDuration,
          decoration: InputDecoration(
            hintText: s.selectDuration,
            border: const OutlineInputBorder(),
          ),
          items: presetDurations.map((minutes) => DropdownMenuItem<int>(
            value: minutes,
            child: Text('$minutes'),
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
          hintText: s.defaultDurationTitle,
          suffix: s.durationUnit,
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
    final s = S.of(context)!;
    return Row(
      children: [
        Text(s.orCustomLabel, style: const TextStyle(fontSize: 13)),
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
    final s = S.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(s.detectingTemplate),
          ],
        ),
      ),
    );
  }

  // ============================================
  // 步骤 3/3: 编辑蓝图
  // ============================================

  Widget _buildBlueprintEditing() {
    final s = S.of(context)!;
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
                Text(s.summaryGoal(_selectedGoalName ?? s.noTemplateSelected)),
                const SizedBox(height: 4),
                Text(s.summarySessions(sessionCount)),
                const SizedBox(height: 4),
                Text(s.summaryDuration(duration)),
                if (_templateInfo != null) ...[
                  const SizedBox(height: 4),
                  Text(s.summaryTemplateSessions(_templateInfo!.availableSessionCount)),
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
              title: Text(s.useTemplateData),
              subtitle: Text(_useTemplate ? s.useTemplateOn : s.useTemplateOff),
              value: _useTemplate,
              onChanged: (value) {
                setState(() {
                  _useTemplate = value;
                });
              },
            ),

          const SizedBox(height: 8),

          // 蓝图编辑
          Text(s.blueprintLabel),
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
    );
  }

  // ============================================
  // 按钮
  // ============================================

  List<Widget> _buildActions(S s) {
    switch (_currentStep) {
      case 0: // 选择参数
        return [
          TextButton(
            onPressed: _isCreating ? null : () => Navigator.of(context).pop(false),
            child: Text(s.btnCancel),
          ),
          ElevatedButton(
            onPressed: _isCreating || !_canProceedFromStep0 ? null : _handleNext,
            child: Text(s.nextStep),
          ),
        ];

      case 1: // 检测模板（无按钮，自动进行）
        return [];

      case 2: // 编辑蓝图
        return [
          TextButton(
            onPressed: _isCreating ? null : _handleBack,
            child: Text(s.prevStep),
          ),
          TextButton(
            onPressed: _isCreating ? null : () => Navigator.of(context).pop(false),
            child: Text(s.btnCancel),
          ),
          ElevatedButton(
            onPressed: _isCreating ? null : _createCoursePlan,
            child: _isCreating
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(s.createButton),
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
