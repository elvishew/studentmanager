import 'package:flutter/material.dart';
import '../providers/states.dart';
import 'session_action_dialogs.dart';

/// 课时编辑对话框
class SessionEditDialog extends StatefulWidget {
  final Session session;
  final int defaultDuration;

  const SessionEditDialog({
    super.key,
    required this.session,
    required this.defaultDuration,
  });

  @override
  State<SessionEditDialog> createState() => _SessionEditDialogState();
}

class _SessionEditDialogState extends State<SessionEditDialog> {
  late DateTime? _scheduledTime;
  late SessionStatus _selectedStatus;
  bool _isSaving = false;

  // 时长相关
  bool _useCustomDuration = false;
  int? _selectedDuration;
  final TextEditingController _customDurationController = TextEditingController();

  static const List<int> presetDurations = [30, 45, 60, 90];

  @override
  void initState() {
    super.initState();
    _scheduledTime = widget.session.scheduledTime;
    _selectedStatus = widget.session.status;

    // 回填时长覆盖状态
    if (widget.session.durationOverride != null) {
      _useCustomDuration = true;
      final override = widget.session.durationOverride!;
      if (presetDurations.contains(override)) {
        _selectedDuration = override;
      } else {
        _selectedDuration = null;
        _customDurationController.text = override.toString();
      }
    }
  }

  @override
  void dispose() {
    _customDurationController.dispose();
    super.dispose();
  }

  /// 获取实际时长覆盖值（null 表示使用默认）
  int? get _actualDurationOverride {
    if (!_useCustomDuration) return null;
    if (_selectedDuration != null) {
      return _selectedDuration;
    }
    if (_customDurationController.text.isNotEmpty) {
      final value = int.tryParse(_customDurationController.text);
      if (value != null && value >= 1 && value <= 180) {
        return value;
      }
    }
    return widget.defaultDuration;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('编辑课时'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 时间选择
            _buildDateTimeSection(),
            const SizedBox(height: 24),
            // 状态选择
            _buildStatusSection(),
            const SizedBox(height: 24),
            // 时长选择
            _buildDurationSection(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _isSaving || !_canSave ? null : _handleSave,
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

  /// 构建时间选择部分
  Widget _buildDateTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '上课时间',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _selectDateTime,
                icon: const Icon(Icons.calendar_today, size: 18),
                label: Text(
                  _scheduledTime != null
                      ? _formatDateTime(_scheduledTime!)
                      : '选择时间',
                ),
              ),
            ),
            if (_scheduledTime != null) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _scheduledTime = null;
                  });
                },
                tooltip: '清除时间',
              ),
            ],
          ],
        ),
      ],
    );
  }

  /// 构建状态选择部分
  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '课时状态',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SegmentedButton<SessionStatus>(
          segments: SessionStatus.values.map((status) {
            return ButtonSegment<SessionStatus>(
              value: status,
              label: Text(status.label),
              icon: Icon(_getStatusIcon(status)),
            );
          }).toList(),
          selected: {_selectedStatus},
          onSelectionChanged: (Set<SessionStatus> selected) {
            setState(() {
              _selectedStatus = selected.first;
            });
          },
        ),
      ],
    );
  }

  /// 选择日期时间
  Future<void> _selectDateTime() async {
    final dateTime = await selectDateTime(context);
    if (dateTime != null) {
      setState(() {
        _scheduledTime = dateTime;
      });
    }
  }

  /// 保存按钮是否可用
  bool get _canSave {
    // 已完成状态必须有上课时间
    if (_selectedStatus == SessionStatus.completed && _scheduledTime == null) return false;
    // 自定义时长必须在有效范围内
    if (_useCustomDuration && _selectedDuration == null && _customDurationController.text.isNotEmpty) {
      final value = int.tryParse(_customDurationController.text);
      if (value == null || value < 1 || value > 180) return false;
    }
    return true;
  }

  /// 保存
  void _handleSave() {
    Navigator.of(context).pop({
      'scheduledTime': _scheduledTime,
      'status': _selectedStatus,
      'durationOverride': _actualDurationOverride,
    });
  }

  IconData _getStatusIcon(SessionStatus status) {
    switch (status) {
      case SessionStatus.pending:
        return Icons.schedule;
      case SessionStatus.completed:
        return Icons.check_circle;
      case SessionStatus.skipped:
        return Icons.skip_next;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.month}月${dateTime.day}日 '
           '${dateTime.hour.toString().padLeft(2, '0')}:'
           '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// 构建课时时长选择区域
  Widget _buildDurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '课时时长',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '课程默认时长: ${widget.defaultDuration} 分钟',
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('自定义时长'),
          subtitle: Text(
            _useCustomDuration
                ? '使用自定义时长'
                : '使用课程默认时长（${widget.defaultDuration}分钟）',
          ),
          value: _useCustomDuration,
          onChanged: (value) {
            setState(() {
              _useCustomDuration = value;
              if (!value) {
                _selectedDuration = null;
                _customDurationController.clear();
              }
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
        if (_useCustomDuration) ...[
          const SizedBox(height: 4),
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
        ],
      ],
    );
  }
}

/// 显示课时编辑对话框
Future<Map<String, dynamic>?> showSessionEditDialog(
  BuildContext context, {
  required Session session,
  required int defaultDuration,
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) => SessionEditDialog(
      session: session,
      defaultDuration: defaultDuration,
    ),
  );
}
