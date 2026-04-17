import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/l10n/enum_localizations.dart';
import 'package:student_manager/providers/statistics_provider.dart';
import 'package:student_manager/providers/states.dart';

/// 统计 Tab
class StatisticsPage extends ConsumerWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statisticsDataProvider);
    final s = S.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.statisticsPageTitle),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.date_range, size: 18),
            label: Text(s.currentMonthButton),
            onPressed: () => _showRangePicker(context, ref),
          ),
        ],
      ),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(s.statisticsLoadingFailed(e.toString()))),
        data: (stats) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(statisticsDataProvider),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 概览卡片
              _buildOverviewGrid(context, stats),
              const SizedBox(height: 24),

              // 课程类型分布
              _buildSectionTitle(context, s.courseTypeDistributionTitle),
              const SizedBox(height: 8),
              _buildDistribution(context, stats),
              const SizedBox(height: 24),

              // 学员消费排行
              _buildSectionTitle(context, s.studentSpendingRankingTitle),
              const SizedBox(height: 8),
              _buildStudentRankings(context, stats),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewGrid(BuildContext context, StatisticsData stats) {
    final s = S.of(context)!;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(context, Icons.school, s.teachingHoursLabel, '${stats.totalClasses}', Colors.blue),
        _buildStatCard(context, Icons.payments, s.studentSpendingLabel, '¥${stats.totalStudentPayment.toStringAsFixed(0)}', Colors.green),
        _buildStatCard(context, Icons.account_balance_wallet, s.teacherIncomeLabel, '¥${stats.totalTeacherIncome.toStringAsFixed(0)}', Colors.orange),
        _buildStatCard(context, Icons.check_circle, s.attendanceRateLabel, '${(stats.attendanceRate * 100).toStringAsFixed(1)}%', Colors.purple),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, IconData icon, String label, String value, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 4),
                Text(label, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline)),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold));
  }

  Widget _buildDistribution(BuildContext context, StatisticsData stats) {
    final s = S.of(context)!;
    if (stats.courseTypeDistribution.isEmpty) {
      return Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(s.noStatisticsDataMessage)));
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: stats.courseTypeDistribution.map((d) {
            final color = _parseColor(d.color) ?? Theme.of(context).colorScheme.primary;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(d.name, style: const TextStyle(fontSize: 13)),
                      Text('${d.count} 节', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: d.percentage,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(color),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStudentRankings(BuildContext context, StatisticsData stats) {
    final s = S.of(context)!;
    if (stats.studentRankings.isEmpty) {
      return Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(s.noStatisticsDataMessage)));
    }

    return Card(
      child: Column(
        children: stats.studentRankings.asMap().entries.map((entry) {
          final i = entry.key;
          final ranking = entry.value;
          return ListTile(
            leading: CircleAvatar(
              radius: 14,
              backgroundColor: i < 3 ? [Colors.amber, Colors.grey, Colors.brown][i] : Colors.grey[300],
              child: Text('${i + 1}', style: const TextStyle(fontSize: 12, color: Colors.white)),
            ),
            title: Text(ranking.studentName),
            subtitle: Text('${ranking.classCount} 节课'),
            trailing: Text('¥${ranking.totalAmount.toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showRangePicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: StatisticsRange.values.map((range) {
            if (range == StatisticsRange.custom) {
              final s = S.of(context)!;
              return ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(s.customRangeOption),
                onTap: () async {
                  Navigator.pop(context);
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    ref.read(statisticsDateRangeProvider.notifier).setCustomRange(picked.start, picked.end);
                  }
                },
              );
            }
            return ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(range.loc(context)),
              onTap: () {
                ref.read(statisticsDateRangeProvider.notifier).setRange(range);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Color _parseColor(String? hexColor) {
    if (hexColor == null) return Colors.blue;
    try {
      final hex = hexColor.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return Colors.blue;
    }
  }
}
