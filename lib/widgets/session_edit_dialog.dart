import 'package:flutter/material.dart';
import '../providers/states.dart';
import 'session_action_dialogs.dart';

/// 课时编辑对话框
class SessionEditDialog extends StatefulWidget {
  final Session session;

  const SessionEditDialog({
    super.key,
    required this.session,
  });

  @override
  State<SessionEditDialog> createState() => _SessionEditDialogState();
}

class _SessionEditDialogState extends State<SessionEditDialog> {
  late DateTime? _scheduledTime;
  late SessionStatus _selectedStatus;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _scheduledTime = widget.session.scheduledTime;
    _selectedStatus = widget.session.status;
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _handleSave,
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

  /// 保存
  void _handleSave() {
    // 验证：如果状态是已完成，必须有时间
    if (_selectedStatus == SessionStatus.completed && _scheduledTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('标记为完成前必须先预约上课时间'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // 返回结果
    Navigator.of(context).pop({
      'scheduledTime': _scheduledTime,
      'status': _selectedStatus,
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
}

/// 显示课时编辑对话框
Future<Map<String, dynamic>?> showSessionEditDialog(
  BuildContext context, {
  required Session session,
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) => SessionEditDialog(session: session),
  );
}
