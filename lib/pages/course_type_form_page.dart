import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/course_type_provider.dart';

/// 课程类型编辑表单
class CourseTypeFormPage extends ConsumerStatefulWidget {
  final CourseType? courseType;

  const CourseTypeFormPage({super.key, this.courseType});

  @override
  ConsumerState<CourseTypeFormPage> createState() => _CourseTypeFormPageState();
}

class _CourseTypeFormPageState extends ConsumerState<CourseTypeFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  String? _selectedIcon;
  String? _selectedColor;
  late TextEditingController _durationController;
  bool _isGroup = false;
  TextEditingController? _maxStudentsController;
  late TextEditingController _studentPriceController;
  late TextEditingController _sessionFeeController;
  CommissionType _commissionType = CommissionType.none;
  late TextEditingController _commissionValueController;

  static const _presetIcons = [
    ('person', Icons.person),
    ('groups', Icons.groups),
    ('card_giftcard', Icons.card_giftcard),
    ('fitness_center', Icons.fitness_center),
    ('music_note', Icons.music_note),
    ('palette', Icons.palette),
    ('sports_martial_arts', Icons.sports_martial_arts),
    ('school', Icons.school),
    ('self_improvement', Icons.self_improvement),
    ('pool', Icons.pool),
  ];

  static const _presetColors = [
    '#2196F3', '#4CAF50', '#FF9800', '#F44336', '#9C27B0',
    '#00BCD4', '#795548', '#607D8B', '#E91E63', '#3F51B5',
  ];

  bool get _isEditing => widget.courseType != null;

  @override
  void initState() {
    super.initState();
    final ct = widget.courseType;
    _nameController = TextEditingController(text: ct?.name ?? '');
    _selectedIcon = ct?.icon;
    _selectedColor = ct?.color;
    _durationController = TextEditingController(text: '${ct?.defaultDuration ?? 60}');
    _isGroup = ct?.isGroup ?? false;
    _maxStudentsController = TextEditingController(text: ct?.maxStudents?.toString() ?? '');
    _studentPriceController = TextEditingController(text: '${ct?.defaultStudentPrice ?? 0}');
    _sessionFeeController = TextEditingController(text: '${ct?.defaultSessionFee ?? 0}');
    _commissionType = ct?.defaultCommissionType ?? CommissionType.none;
    _commissionValueController = TextEditingController(text: '${ct?.defaultCommissionValue ?? 0}');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _maxStudentsController?.dispose();
    _studentPriceController.dispose();
    _sessionFeeController.dispose();
    _commissionValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? '编辑课程类型' : '新增课程类型'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('保存'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 名称
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: '名称 *'),
              validator: (v) => v?.trim().isEmpty == true ? '请输入名称' : null,
            ),
            const SizedBox(height: 16),

            // 图标选择
            Text('图标', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _presetIcons.map((e) {
                final isSelected = _selectedIcon == e.$1;
                return ChoiceChip(
                  avatar: Icon(e.$2, size: 18),
                  label: Text(e.$1),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedIcon = e.$1),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // 颜色选择
            Text('颜色', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _presetColors.map((hex) {
                final isSelected = _selectedColor == hex;
                final color = _parseColor(hex)!;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = hex),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // 默认时长
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(labelText: '默认时长（分钟）'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // 是否团课
            SwitchListTile(
              title: const Text('团课'),
              subtitle: const Text('允许多人同时参加'),
              value: _isGroup,
              onChanged: (v) => setState(() => _isGroup = v),
            ),
            if (_isGroup) ...[
              TextFormField(
                controller: _maxStudentsController,
                decoration: const InputDecoration(labelText: '最大人数'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
            ],

            // 学员默认价格
            TextFormField(
              controller: _studentPriceController,
              decoration: const InputDecoration(labelText: '学员默认价格'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // 教师课时费
            TextFormField(
              controller: _sessionFeeController,
              decoration: const InputDecoration(labelText: '教师课时费'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // 提成类型
            Text('销售提成', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<CommissionType>(
              segments: CommissionType.values.map((t) => ButtonSegment(
                value: t,
                label: Text(t.label),
              )).toList(),
              selected: {_commissionType},
              onSelectionChanged: (types) => setState(() => _commissionType = types.first),
            ),
            if (_commissionType != CommissionType.none) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _commissionValueController,
                decoration: InputDecoration(
                  labelText: _commissionType == CommissionType.fixed ? '固定金额' : '百分比 (%)',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(courseTypeNotifierProvider.notifier);
    final name = _nameController.text.trim();
    final duration = int.tryParse(_durationController.text) ?? 60;
    final maxStudents = int.tryParse(_maxStudentsController?.text ?? '');
    final studentPrice = double.tryParse(_studentPriceController.text) ?? 0;
    final sessionFee = double.tryParse(_sessionFeeController.text) ?? 0;
    final commissionValue = double.tryParse(_commissionValueController.text) ?? 0;

    bool success;
    if (_isEditing) {
      success = await notifier.updateType(
        id: widget.courseType!.id,
        name: name,
        icon: _selectedIcon,
        color: _selectedColor,
        defaultDuration: duration,
        isGroup: _isGroup,
        maxStudents: maxStudents,
        defaultStudentPrice: studentPrice,
        defaultSessionFee: sessionFee,
        defaultCommissionType: _commissionType,
        defaultCommissionValue: commissionValue,
      );
    } else {
      final id = await notifier.create(
        name: name,
        icon: _selectedIcon,
        color: _selectedColor,
        defaultDuration: duration,
        isGroup: _isGroup,
        maxStudents: maxStudents,
        defaultStudentPrice: studentPrice,
        defaultSessionFee: sessionFee,
        defaultCommissionType: _commissionType,
        defaultCommissionValue: commissionValue,
      );
      success = id != null;
    }

    if (mounted) {
      if (success) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('名称已存在或保存失败'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Color? _parseColor(String hexColor) {
    try {
      final hex = hexColor.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return null;
    }
  }
}
