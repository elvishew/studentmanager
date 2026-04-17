import 'package:student_manager/providers/settings_provider.dart'; // TimeSegment

/// 判断课程时间范围是否完全落在某个工作时间段内
bool isClassInWorkingHours(
    double startHour, double endHour, List<TimeSegment> segments) {
  if (segments.isEmpty) return true;
  return segments.any((s) => startHour >= s.start && endHour <= s.end);
}

/// 计算新建排课的默认开始小时
/// 返回 (hour, shouldAdvanceDate)
/// - segments 为空 → 保持现有行为 (now.hour+1, false)
/// - now.hour+1 在某段内 → (now.hour+1, false)
/// - 不在任何段内但有后续段 → (下一段start, false)
/// - 今日所有段已过 → (第一段start, true)
(int, bool) computeDefaultStartHour(
    DateTime now, List<TimeSegment> segments) {
  if (segments.isEmpty) {
    return (now.hour + 1, false);
  }

  final nextHour = now.hour + 1;

  // nextHour 在某段内
  if (segments.any((s) => nextHour >= s.start && nextHour < s.end)) {
    return (nextHour, false);
  }

  // 查找后续段（start > now.hour）
  final futureSegments =
      segments.where((s) => s.start > now.hour).toList();
  if (futureSegments.isNotEmpty) {
    return (futureSegments.first.start, false);
  }

  // 今日所有段已过 → 跳明天第一段
  return (segments.first.start, true);
}

/// 格式化时间段显示："9:00-12:00, 14:00-22:00"
String formatSegments(List<TimeSegment> segments) {
  if (segments.isEmpty) return '';
  return segments
      .map((s) =>
          '${_fmtHour(s.start)}-${_fmtHour(s.end)}')
      .join(', ');
}

String _fmtHour(int h) => '${h.toString().padLeft(2, '0')}:00';
