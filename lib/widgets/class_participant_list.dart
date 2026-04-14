import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';

/// 参与人列表组件（正式学员 + 临时人员混排）
class ClassParticipantList extends ConsumerWidget {
  final List<Map<String, dynamic>> participants;
  final bool showAttendanceControls;

  const ClassParticipantList({
    super.key,
    required this.participants,
    this.showAttendanceControls = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (participants.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            '暂无参与人',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ),
      );
    }

    return Column(
      children: participants.map((p) {
        final studentName = p['student_name'] as String?;
        final guestName = p['guest_name'] as String?;
        final attendance = p['attendance'] as String? ?? 'pending';
        final displayName = studentName ?? guestName ?? '未知';
        final isGuest = studentName == null && guestName != null;

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isGuest
                  ? Colors.orange.withOpacity(0.1)
                  : Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                isGuest ? Icons.person_outline : Icons.person,
                color: isGuest
                    ? Colors.orange
                    : Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
            title: Row(
              children: [
                Flexible(child: Text(displayName, overflow: TextOverflow.ellipsis)),
                if (isGuest) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: const Text(
                      '客',
                      style: TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ],
            ),
            subtitle: p['notes'] != null
                ? Text(
                    p['notes'] as String,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            trailing: showAttendanceControls
                ? _AttendanceChip(
                    attendance: attendance,
                    onTap: () => _cycleAttendance(ref, p['id'] as int, attendance),
                  )
                : _buildStaticAttendanceLabel(context, attendance),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStaticAttendanceLabel(BuildContext context, String attendance) {
    final (label, color) = _getAttendanceInfo(attendance);
    return Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500));
  }

  void _cycleAttendance(WidgetRef ref, int participantId, String current) {
    final next = switch (current) {
      'pending' => AttendanceStatus.present,
      'present' => AttendanceStatus.late,
      'late' => AttendanceStatus.absent,
      'absent' => AttendanceStatus.pending,
      _ => AttendanceStatus.present,
    };

    ref
        .read(scheduledClassNotifierProvider.notifier)
        .updateParticipantAttendance(participantId: participantId, attendance: next);
  }

  static (String, Color) _getAttendanceInfo(String attendance) {
    return switch (attendance) {
      'present' => ('出勤', Colors.green),
      'absent' => ('缺勤', Colors.red),
      'late' => ('迟到', Colors.orange),
      _ => ('待记录', Colors.grey),
    };
  }
}

/// 出勤状态可点击切换的 Chip
class _AttendanceChip extends StatelessWidget {
  final String attendance;
  final VoidCallback onTap;

  const _AttendanceChip({required this.attendance, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final (label, color) = ClassParticipantList._getAttendanceInfo(attendance);

    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
        backgroundColor: color.withOpacity(0.1),
        side: BorderSide(color: color.withOpacity(0.3)),
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
