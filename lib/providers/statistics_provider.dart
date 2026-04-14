import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'states.dart';
import 'student_provider.dart';
import '../database/scheduled_class_repository.dart';
import '../database/payment_repository.dart';

part 'statistics_provider.g.dart';

/// ============================================
/// 统计时间范围
/// ============================================

enum StatisticsRange {
  week('本周'),
  month('本月'),
  quarter('本季'),
  custom('自定义');

  final String label;
  const StatisticsRange(this.label);
}

/// ============================================
/// 统计时间范围 Provider
/// ============================================

@riverpod
class StatisticsDateRange extends _$StatisticsDateRange {
  @override
  DateTimeRange build() {
    // 默认本月
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 1);
    return DateTimeRange(start: start, end: end);
  }

  void setRange(StatisticsRange range) {
    final now = DateTime.now();
    DateTime start;
    DateTime end;

    switch (range) {
      case StatisticsRange.week:
        // 本周（周一开始）
        final weekday = now.weekday;
        start = DateTime(now.year, now.month, now.day - weekday + 1);
        end = start.add(const Duration(days: 7));
        break;
      case StatisticsRange.month:
        start = DateTime(now.year, now.month, 1);
        end = DateTime(now.year, now.month + 1, 1);
        break;
      case StatisticsRange.quarter:
        final quarterStart = ((now.month - 1) ~/ 3) * 3 + 1;
        start = DateTime(now.year, quarterStart, 1);
        end = DateTime(now.year, quarterStart + 3, 1);
        break;
      case StatisticsRange.custom:
        return; // 自定义不在此处处理
    }

    state = DateTimeRange(start: start, end: end);
  }

  void setCustomRange(DateTime start, DateTime end) {
    state = DateTimeRange(start: start, end: end);
  }
}

class DateTimeRange {
  final DateTime start;
  final DateTime end;

  const DateTimeRange({required this.start, required this.end});
}

/// ============================================
/// 统计数据 Provider
/// ============================================

@riverpod
Future<StatisticsData> statisticsData(StatisticsDataRef ref) async {
  final dateRange = ref.watch(statisticsDateRangeProvider);
  final db = ref.watch(databaseProvider);
  final scheduledRepo = ScheduledClassRepository(database: db);
  final paymentRepo = PaymentRepository(database: db);

  final startDate = dateRange.start.toIso8601String();
  final endDate = dateRange.end.toIso8601String();

  // 并行查询
  final results = await Future.wait([
    scheduledRepo.getCompletedClassCount(startDate, endDate),
    scheduledRepo.getTotalSessionFee(startDate, endDate),
    scheduledRepo.getAttendanceRate(startDate, endDate),
    paymentRepo.getTotalPaymentAmount(startDate, endDate),
    paymentRepo.getTotalCommissionEarned(startDate, endDate),
    scheduledRepo.getCourseTypeDistribution(startDate, endDate),
    scheduledRepo.getStudentRankings(startDate, endDate),
  ]);

  final totalClasses = results[0] as int;
  final totalSessionFee = results[1] as double;
  final attendanceRate = results[2] as double;
  final totalStudentPayment = results[3] as double;
  final totalCommission = results[4] as double;
  final distributionMaps = results[5] as List<Map<String, dynamic>>;
  final rankingMaps = results[6] as List<Map<String, dynamic>>;

  // 课程类型分布
  final totalCount = distributionMaps.fold<int>(0, (sum, m) => sum + ((m['count'] as int?) ?? 0));
  final distribution = distributionMaps.map((m) {
    final count = (m['count'] as int?) ?? 0;
    return CourseTypeDistribution(
      name: m['name'] as String? ?? '未知',
      color: m['color'] as String?,
      count: count,
      percentage: totalCount > 0 ? count / totalCount : 0,
    );
  }).toList();

  // 学员排行
  final rankings = rankingMaps.map((m) => StudentRanking(
    studentId: m['student_id'] as int,
    studentName: m['student_name'] as String? ?? '未知',
    totalAmount: (m['total_amount'] as num?)?.toDouble() ?? 0,
    classCount: (m['class_count'] as int?) ?? 0,
  )).toList();

  return StatisticsData(
    totalClasses: totalClasses,
    totalStudentPayment: totalStudentPayment,
    totalTeacherIncome: totalSessionFee + totalCommission,
    attendanceRate: attendanceRate,
    courseTypeDistribution: distribution,
    studentRankings: rankings,
  );
}
