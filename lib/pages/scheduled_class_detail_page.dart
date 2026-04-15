import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/pages/create_scheduled_class_dialog.dart';

/// 排课详情页
class ScheduledClassDetailPage extends ConsumerStatefulWidget {
  final int classId;

  const ScheduledClassDetailPage({super.key, required this.classId});

  @override
  ConsumerState<ScheduledClassDetailPage> createState() => _ScheduledClassDetailPageState();
}

class _ScheduledClassDetailPageState extends ConsumerState<ScheduledClassDetailPage> {
  Map<String, dynamic>? _detail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    final notifier = ref.read(scheduledClassNotifierProvider.notifier);
    final detail = await notifier.getDetail(widget.classId);
    if (mounted) {
      setState(() {
        _detail = detail;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_detail == null) {
      return const Scaffold(
        body: Center(child: Text('排课记录不存在')),
      );
    }

    final status = _detail!['status'] as String? ?? 'scheduled';
    final courseTypeName = _detail!['course_type_name'] as String? ?? '未知';
    final courseTypeColor = _detail!['course_type_color'] as String?;
    final startTime = DateTime.parse(_detail!['start_time'] as String);
    final endTime = DateTime.parse(_detail!['end_time'] as String);
    final participants = _detail!['participants'] as List? ?? [];
    final sessionInfo = _detail!['session'] as Map<String, dynamic>?;
    final coursePlanInfo = _detail!['course_plan'] as Map<String, dynamic>?;
    final location = _detail!['location'] as String?;
    final notes = _detail!['notes'] as String?;
    final sessionFee = (_detail!['teacher_session_fee'] as num?)?.toDouble() ?? 0;
    final title = _detail!['title'] as String?;

    final color = _parseColor(courseTypeColor) ?? Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? courseTypeName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: '编辑',
            onPressed: () => _editScheduledClass(),
          ),
          PopupMenuButton<String>(
            onSelected: (action) => _handleAction(action),
            itemBuilder: (context) => [
              if (status == 'scheduled') ...[
                const PopupMenuItem(value: 'complete', child: Text('完成上课（消课）')),
                const PopupMenuItem(value: 'cancel', child: Text('取消排课')),
                const PopupMenuItem(value: 'noshow', child: Text('标记未到')),
              ],
              if (status == 'cancelled' || status == 'no_show')
                const PopupMenuItem(value: 'restore', child: Text('恢复为待上课')),
              if (status == 'completed')
                const PopupMenuItem(value: 'restore', child: Text('撤销完成')),
              const PopupMenuItem(value: 'delete', child: Text('删除', style: TextStyle(color: Colors.red))),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 状态标签
            _buildStatusChip(status, color),
            const SizedBox(height: 16),

            // 基本信息卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4, height: 24,
                          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
                        ),
                        const SizedBox(width: 8),
                        Text(courseTypeName, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: color, fontWeight: FontWeight.bold,
                        )),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(Icons.access_time, '时间', _formatDateTime(startTime)),
                    _buildInfoRow(Icons.timer, '时长', '${endTime.difference(startTime).inMinutes} 分钟'),
                    if (location != null)
                      _buildInfoRow(Icons.location_on, '地点', location),
                    _buildInfoRow(Icons.payments, '课时费', '¥${sessionFee.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 参与人列表
            Text('参与人 (${participants.length})', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...participants.map((p) {
              final studentName = p['student_name'] as String?;
              final guestName = p['guest_name'] as String?;
              final attendance = p['attendance'] as String? ?? 'pending';
              final displayName = studentName ?? guestName ?? '未知';
              final isGuest = studentName == null && guestName != null;

              return Card(
                child: ListTile(
                  leading: Icon(isGuest ? Icons.person_outline : Icons.person),
                  title: Row(
                    children: [
                      Text(displayName),
                      if (isGuest) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('客', style: TextStyle(fontSize: 10, color: Colors.orange)),
                        ),
                      ],
                    ],
                  ),
                  trailing: _buildAttendanceChip(attendance, p['id'] as int),
                ),
              );
            }),

            // 关联 session 信息
            if (sessionInfo != null) ...[
              const SizedBox(height: 16),
              Text('关联课时', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('第 ${sessionInfo['session_number']} 课时'),
                      if (coursePlanInfo != null)
                        Text('课程规划: ${coursePlanInfo['goal_name'] ?? ''} - ${coursePlanInfo['student_name'] ?? ''}',
                          style: TextStyle(color: Theme.of(context).colorScheme.outline),
                        ),
                    ],
                  ),
                ),
              ),
            ],

            // 备注
            if (notes != null && notes.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('备注', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(notes),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, Color color) {
    final statusInfo = _getStatusInfo(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: statusInfo.$2.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(statusInfo.$1, style: TextStyle(color: statusInfo.$2, fontSize: 12)),
    );
  }

  (String, Color) _getStatusInfo(String status) {
    switch (status) {
      case 'scheduled': return ('待上课', Colors.blue);
      case 'completed': return ('已完成', Colors.green);
      case 'cancelled': return ('已取消', Colors.grey);
      case 'no_show': return ('未到', Colors.orange);
      default: return ('未知', Colors.grey);
    }
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.outline),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: Theme.of(context).colorScheme.outline)),
          const Spacer(),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildAttendanceChip(String attendance, int participantId) {
    final (label, color) = switch (attendance) {
      'present' => ('出勤', Colors.green),
      'absent' => ('缺勤', Colors.red),
      'late' => ('迟到', Colors.orange),
      _ => ('待记录', Colors.grey),
    };

    return GestureDetector(
      onTap: () => _cycleAttendance(participantId, attendance),
      child: Chip(
        label: Text(label, style: TextStyle(fontSize: 11, color: color)),
        backgroundColor: color.withOpacity(0.1),
        side: BorderSide.none,
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  void _cycleAttendance(int participantId, String current) {
    final next = switch (current) {
      'pending' => AttendanceStatus.present,
      'present' => AttendanceStatus.late,
      'late' => AttendanceStatus.absent,
      'absent' => AttendanceStatus.pending,
      _ => AttendanceStatus.present,
    };

    ref.read(scheduledClassNotifierProvider.notifier)
        .updateParticipantAttendance(participantId: participantId, attendance: next)
        .then((_) => _loadDetail());
  }

  Future<void> _editScheduledClass() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (_) => CreateScheduledClassDialog(
        editingClassId: widget.classId,
        editingData: _detail,
      ),
    );
    if (result == true) {
      _loadDetail();
    }
  }

  Future<void> _handleAction(String action) async {
    final notifier = ref.read(scheduledClassNotifierProvider.notifier);

    switch (action) {
      case 'complete':
        final confirmed = await _showConfirmDialog(
          title: '确认消课',
          content: '确认标记此排课为已完成？关联的课时也会自动标记完成。',
        );
        if (confirmed == true) {
          await notifier.completeClass(widget.classId);
          if (mounted) {
            notifier.refreshAfterMutation();
            _loadDetail();
          }
        }
        break;
      case 'cancel':
        final confirmed = await _showConfirmDialog(
          title: '取消排课',
          content: '确定要取消此排课吗？取消后可以随时恢复。',
          confirmText: '确认取消',
          isDangerous: true,
        );
        if (confirmed == true) {
          await notifier.cancelClass(widget.classId);
          if (mounted) {
            notifier.refreshAfterMutation();
            _loadDetail();
          }
        }
        break;
      case 'noshow':
        final confirmed = await _showConfirmDialog(
          title: '标记未到',
          content: '确定要将此排课标记为学员未到吗？',
        );
        if (confirmed == true) {
          await notifier.markNoShow(widget.classId);
          if (mounted) {
            notifier.refreshAfterMutation();
            _loadDetail();
          }
        }
        break;
      case 'restore':
        final confirmed = await _showConfirmDialog(
          title: '恢复排课',
          content: '确定要将此排课恢复为待上课状态吗？',
        );
        if (confirmed == true) {
          await notifier.restoreClass(widget.classId);
          if (mounted) {
            notifier.refreshAfterMutation();
            _loadDetail();
          }
        }
        break;
      case 'delete':
        final confirmed = await _showConfirmDialog(
          title: '确认删除',
          content: '确定要删除此排课记录吗？此操作不可撤销。',
          isDangerous: true,
        );
        if (confirmed == true) {
          await notifier.deleteClass(widget.classId);
          if (mounted) {
            notifier.refreshAfterMutation();
            Navigator.pop(context, true);
          }
        }
        break;
    }
  }

  Future<bool?> _showConfirmDialog({
    required String title,
    required String content,
    String confirmText = '确认',
    bool isDangerous = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: isDangerous ? FilledButton.styleFrom(backgroundColor: Colors.red) : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.month}月${dt.day}日 ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Color? _parseColor(String? hexColor) {
    if (hexColor == null) return null;
    try {
      final hex = hexColor.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return null;
    }
  }
}
