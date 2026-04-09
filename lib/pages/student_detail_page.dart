import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'create_course_plan_dialog.dart';
import 'course_plan_page.dart';

/// 学员详情页
class StudentDetailPage extends ConsumerStatefulWidget {
  final int studentId;

  const StudentDetailPage({
    super.key,
    required this.studentId,
  });

  @override
  ConsumerState<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends ConsumerState<StudentDetailPage> {
  Student? _student;

  @override
  void initState() {
    super.initState();
    _loadStudent();
    // 加载课程规划列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(coursePlanNotifierProvider.notifier).fetchByStudentId(widget.studentId);
    });
  }

  /// 加载学员信息
  Future<void> _loadStudent() async {
    final notifier = ref.read(studentNotifierProvider.notifier);
    final student = await notifier.getById(widget.studentId);
    if (mounted) {
      setState(() {
        _student = student;
      });
    }
  }

  /// 显示新建课程规划对话框
  Future<void> _showCreateCoursePlanDialog() async {
    await showCreateCoursePlanDialog(
      context,
      studentId: widget.studentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final coursePlanState = ref.watch(coursePlanNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('学员详情'),
      ),
      body: _student == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 学员信息
                  _buildStudentInfo(),
                  const SizedBox(height: 24),
                  // 课程规划列表
                  _buildCoursePlansSection(coursePlanState),
                ],
              ),
            ),
    );
  }

  /// 构建学员信息卡片
  Widget _buildStudentInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  child: Text(
                    _student!.name.isNotEmpty ? _student!.name[0] : '?',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _student!.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (_student!.gender != null)
                        Text(
                          _student!.gender!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            // 信息行
            _buildInfoRow(
              icon: Icons.phone,
              label: '联系方式',
              value: _student!.contact,
            ),
            if (_student!.notes != null && _student!.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                icon: Icons.note,
                label: '备注',
                value: _student!.notes!,
              ),
            ],
            const SizedBox(height: 12),
            _buildInfoRow(
              icon: Icons.access_time,
              label: '创建时间',
              value: _formatDateTime(_student!.createdAt),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建信息行
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.outline,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建课程规划部分
  Widget _buildCoursePlansSection(CoursePlanState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题行
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '课程规划',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton.icon(
              onPressed: _showCreateCoursePlanDialog,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('新建'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 课程规划列表
        state.when(
          initial: () => _buildEmptyState('暂无课程规划'),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stackTrace) => _buildErrorState(error),
          data: (coursePlans, selectedCoursePlan, filteredStudentId) {
            // 过滤出当前学员的课程规划
            final studentCoursePlans = coursePlans
                .where((plan) => plan.studentId == widget.studentId)
                .toList();

            if (studentCoursePlans.isEmpty) {
              return _buildEmptyState('暂无课程规划');
            }

            return Column(
              children: studentCoursePlans.map((coursePlan) {
                return _buildCoursePlanCard(coursePlan);
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  /// 构建课程规划卡片
  Widget _buildCoursePlanCard(CoursePlan coursePlan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getGoalColor(coursePlan.goal),
          child: Icon(
            _getGoalIcon(coursePlan.goal),
            color: Colors.white,
          ),
        ),
        title: Text(
          coursePlan.goal,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (coursePlan.blueprint != null && coursePlan.blueprint!.isNotEmpty)
              Text(
                coursePlan.blueprint!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            // 进度信息
            Row(
              children: [
                Icon(
                  Icons.fitness_center,
                  size: 14,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(width: 4),
                Text(
                  '${coursePlan.completedSessions ?? 0}/${coursePlan.totalSessions ?? 0} 节课',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.pie_chart,
                  size: 14,
                  color: _getCompletionRateColor(coursePlan.completionRate),
                ),
                const SizedBox(width: 4),
                Text(
                  '${(coursePlan.completionRate * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getCompletionRateColor(coursePlan.completionRate),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CoursePlanPage(
                coursePlanId: coursePlan.id,
              ),
            ),
          );
        },
      ),
    );
  }

  /// 空状态
  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Icon(
            Icons.folder_open,
            size: 48,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }

  /// 错误状态
  Widget _buildErrorState(Object error) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 12),
          Text(
            '加载失败',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 格式化日期时间
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// 根据课程目标获取颜色
  Color _getGoalColor(String goal) {
    switch (goal) {
      case '产后修复':
        return Colors.pink;
      case '肩颈理疗':
        return Colors.blue;
      case '肩背打造':
        return Colors.purple;
      case '腰酸治疗':
        return Colors.orange;
      case '腰腹塑形':
        return Colors.red;
      case '全身塑形':
        return Colors.green;
      case '臀腿打造':
        return Colors.teal;
      case '膝盖疼痛':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  /// 根据课程目标获取图标
  IconData _getGoalIcon(String goal) {
    switch (goal) {
      case '产后修复':
        return Icons.pregnant_woman;
      case '肩颈理疗':
        return Icons.accessibility_new;
      case '肩背打造':
        return Icons.rowing;
      case '腰酸治疗':
        return Icons.healing;
      case '腰腹塑形':
        return Icons.monitor_heart;
      case '全身塑形':
        return Icons.fitness_center;
      case '臀腿打造':
        return Icons.directions_run;
      case '膝盖疼痛':
        return Icons.airline_seat_recline_extra;
      default:
        return Icons.event_note;
    }
  }

  /// 根据完成率获取颜色
  Color _getCompletionRateColor(double rate) {
    if (rate >= 1.0) return Colors.green;
    if (rate >= 0.5) return Colors.orange;
    return Colors.grey;
  }
}
