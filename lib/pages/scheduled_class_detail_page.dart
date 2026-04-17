import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/pages/create_scheduled_class_dialog.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/l10n/enum_localizations.dart';

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
    final s = S.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_detail == null) {
      return Scaffold(
        body: Center(child: Text(s.scheduledClassNotFound)),
      );
    }

    final status = _detail!['status'] as String? ?? 'scheduled';
    final courseTypeName = _detail!['course_type_name'] as String? ?? s.unknown;
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
            tooltip: s.edit,
            onPressed: () => _editScheduledClass(),
          ),
          PopupMenuButton<String>(
            onSelected: (action) => _handleAction(action),
            itemBuilder: (context) => [
              if (status == 'scheduled') ...[
                PopupMenuItem(value: 'complete', child: Text(s.markCompleted)),
                PopupMenuItem(value: 'cancel', child: Text(s.cancelScheduledClass)),
                PopupMenuItem(value: 'noshow', child: Text(s.markNoShow)),
              ],
              if (status == 'cancelled' || status == 'no_show')
                PopupMenuItem(value: 'restore', child: Text(s.restoreToScheduled)),
              if (status == 'completed')
                PopupMenuItem(value: 'restore', child: Text(s.restoreCompleted)),
              PopupMenuItem(value: 'delete', child: Text(s.btnDelete, style: const TextStyle(color: Colors.red))),
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
                    _buildInfoRow(Icons.access_time, s.timeLabel, _formatDateTime(startTime)),
                    _buildInfoRow(Icons.timer, s.durationLabel, s.durationMinutes(endTime.difference(startTime).inMinutes)),
                    if (location != null)
                      _buildInfoRow(Icons.location_on, s.locationLabel, location),
                    _buildInfoRow(Icons.payments, s.sessionFeeLabel, '¥${sessionFee.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 参与人列表
            Text(s.participantsCountLabel(participants.length), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...participants.map((p) {
              final studentName = p['student_name'] as String?;
              final guestName = p['guest_name'] as String?;
              final attendance = p['attendance'] as String? ?? 'pending';
              final displayName = studentName ?? guestName ?? s.unknown;
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
                          child: Text(s.guestBadge, style: const TextStyle(fontSize: 10, color: Colors.orange)),
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
              Text(s.relatedSessionLabel, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.sessionNumberLabel(sessionInfo['session_number'] as int)),
                      if (coursePlanInfo != null)
                        Text(s.coursePlanLabel('${coursePlanInfo['goal_name'] ?? ''} - ${coursePlanInfo['student_name'] ?? ''}'),
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
              Text(s.notesTitle, style: Theme.of(context).textTheme.titleMedium),
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
    final s = S.of(context)!;
    final schedStatus = ScheduledClassStatus.values.where((e) => e.value == status).firstOrNull;
    if (schedStatus != null) {
      final color = switch (schedStatus) {
        ScheduledClassStatus.scheduled => Colors.blue,
        ScheduledClassStatus.completed => Colors.green,
        ScheduledClassStatus.cancelled => Colors.grey,
        ScheduledClassStatus.noShow => Colors.orange,
      };
      return (schedStatus.loc(context), color);
    }
    return (s.unknown, Colors.grey);
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
    final attStatus = AttendanceStatus.values.where((e) => e.value == attendance).firstOrNull ?? AttendanceStatus.pending;
    final (label, color) = switch (attStatus) {
      AttendanceStatus.present => (attStatus.loc(context), Colors.green),
      AttendanceStatus.absent => (attStatus.loc(context), Colors.red),
      AttendanceStatus.late => (attStatus.loc(context), Colors.orange),
      AttendanceStatus.pending => (attStatus.loc(context), Colors.grey),
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
    final s = S.of(context)!;

    switch (action) {
      case 'complete':
        final confirmed = await _showConfirmDialog(
          title: s.confirmCompleteTitle,
          content: s.confirmCompleteMessage,
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
          title: s.confirmCancelTitle,
          content: s.confirmCancelMessage,
          confirmText: s.btnConfirm,
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
          title: s.confirmNoShowTitle,
          content: s.confirmNoShowMessage,
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
          title: s.confirmRestoreTitle,
          content: s.confirmRestoreMessage,
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
          title: s.btnConfirmDelete,
          content: s.confirmDeleteScheduledClassMessage,
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
    String? confirmText,
    bool isDangerous = false,
  }) {
    final s = S.of(context)!;
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(s.btnCancel)),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: isDangerous ? FilledButton.styleFrom(backgroundColor: Colors.red) : null,
            child: Text(confirmText ?? s.btnConfirm),
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
