import 'package:flutter/widgets.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/statistics_provider.dart';

extension SessionStatusL10n on SessionStatus {
  String loc(BuildContext context) {
    final s = S.of(context)!;
    switch (this) {
      case SessionStatus.pending:
        return s.statusPending;
      case SessionStatus.completed:
        return s.statusCompleted;
      case SessionStatus.skipped:
        return s.statusSkipped;
    }
  }
}

extension ScheduledClassStatusL10n on ScheduledClassStatus {
  String loc(BuildContext context) {
    final s = S.of(context)!;
    switch (this) {
      case ScheduledClassStatus.scheduled:
        return s.statusScheduled;
      case ScheduledClassStatus.completed:
        return s.statusCompleted;
      case ScheduledClassStatus.cancelled:
        return s.statusCancelled;
      case ScheduledClassStatus.noShow:
        return s.statusNoShow;
    }
  }
}

extension AttendanceStatusL10n on AttendanceStatus {
  String loc(BuildContext context) {
    final s = S.of(context)!;
    switch (this) {
      case AttendanceStatus.pending:
        return s.attendancePending;
      case AttendanceStatus.present:
        return s.attendancePresent;
      case AttendanceStatus.absent:
        return s.attendanceAbsent;
      case AttendanceStatus.late:
        return s.attendanceLate;
    }
  }
}

extension CommissionTypeL10n on CommissionType {
  String loc(BuildContext context) {
    final s = S.of(context)!;
    switch (this) {
      case CommissionType.none:
        return s.commissionNone;
      case CommissionType.fixed:
        return s.commissionFixed;
      case CommissionType.percent:
        return s.commissionPercent;
    }
  }
}

extension StatisticsRangeL10n on StatisticsRange {
  String loc(BuildContext context) {
    final s = S.of(context)!;
    switch (this) {
      case StatisticsRange.week:
        return s.statisticsRangeWeek;
      case StatisticsRange.month:
        return s.statisticsRangeMonth;
      case StatisticsRange.quarter:
        return s.statisticsRangeQuarter;
      case StatisticsRange.custom:
        return s.statisticsRangeCustom;
    }
  }
}
