import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/album_provider.dart';
import 'package:student_manager/providers/payment_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/database/scheduled_class_repository.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'create_course_plan_dialog.dart';
import 'create_album_dialog.dart';
import 'course_plan_page.dart';
import 'album_detail_page.dart';
import 'student_payment_page.dart';
import 'scheduled_class_detail_page.dart';

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
      ref.read(albumNotifierProvider.notifier).fetchByStudentId(widget.studentId);
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

  /// 显示新建相册对话框
  Future<void> _showCreateAlbumDialog() async {
    final result = await showCreateAlbumDialog(
      context,
      studentId: widget.studentId,
    );

    if (result != null && mounted) {
      final notifier = ref.read(albumNotifierProvider.notifier);
      await notifier.create(
        studentId: widget.studentId,
        name: result['name'] as String,
        notes: result['notes'] as String?,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)!.albumCreated)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    final coursePlanState = ref.watch(coursePlanNotifierProvider);
    final albumState = ref.watch(albumNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.studentDetailTitle),
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
                  _buildStudentInfo(),
                  const SizedBox(height: 24),
                  _buildCoursePlansSection(coursePlanState),
                  const SizedBox(height: 24),
                  _buildClassRecordsSection(),
                  const SizedBox(height: 24),
                  _buildPaymentSection(),
                  const SizedBox(height: 24),
                  _buildAlbumsSection(albumState),
                ],
              ),
            ),
    );
  }

  /// 构建学员信息卡片
  Widget _buildStudentInfo() {
    final s = S.of(context)!;
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
              label: s.contactInfoLabel,
              value: _student!.contact,
            ),
            if (_student!.notes != null && _student!.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                icon: Icons.note,
                label: s.notesLabel,
                value: _student!.notes!,
              ),
            ],
            const SizedBox(height: 12),
            _buildInfoRow(
              icon: Icons.access_time,
              label: s.createdAtLabel,
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
    final s = S.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题行
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              s.coursePlanSectionTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton.icon(
              onPressed: _showCreateCoursePlanDialog,
              icon: const Icon(Icons.add, size: 18),
              label: Text(s.newButton),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 课程规划列表
        state.when(
          initial: () => _buildEmptyState(s.noCoursePlansMessage),
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
              return _buildEmptyState(s.noCoursePlansMessage);
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
    final s = S.of(context)!;
    final goalName = coursePlan.goalName ?? '';
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getGoalColor(goalName),
          child: Icon(
            _getGoalIcon(goalName),
            color: Colors.white,
          ),
        ),
        title: Text(
          goalName,
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
                  s.sessionProgressDisplay(coursePlan.completedSessions ?? 0, coursePlan.totalSessions ?? 0),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 删除按钮
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
              onPressed: () => _showDeleteCoursePlanDialog(coursePlan),
              tooltip: s.deleteCoursePlanTitle,
            ),
            // 进入详情箭头
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CoursePlanPage(
                coursePlanId: coursePlan.id,
              ),
            ),
          ).then((_) {
            // 返回时刷新课程规划数据
            ref.read(coursePlanNotifierProvider.notifier).fetchByStudentId(widget.studentId);
          });
        },
      ),
    );
  }

  /// 构建上课记录部分
  Widget _buildClassRecordsSection() {
    final s = S.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.classRecordsSectionTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _loadClassRecords(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ));
            }
            final records = snapshot.data ?? [];
            if (records.isEmpty) {
              return _buildEmptyState(s.noClassRecordsMessage);
            }
            return Column(
              children: records.map((record) {
                final startTime = DateTime.parse(record['start_time'] as String);
                final endTime = DateTime.parse(record['end_time'] as String);
                final typeName = record['course_type_name'] as String? ?? s.unknown;
                final status = record['status'] as String? ?? 'scheduled';
                final attendance = record['my_attendance'] as String?;
                final classId = record['id'] as int;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(
                      status == 'completed' ? Icons.check_circle : Icons.schedule,
                      color: status == 'completed' ? Colors.green : Colors.blue,
                    ),
                    title: Text(typeName),
                    subtitle: Text(
                      '${startTime.month}/${startTime.day} ${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}-${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
                    ),
                    trailing: attendance != null
                        ? Text(_attendanceLabel(attendance), style: TextStyle(
                            fontSize: 12, color: _attendanceColor(attendance)))
                        : null,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ScheduledClassDetailPage(classId: classId),
                        ),
                      ).then((_) => setState(() {}));
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  /// 构建付费记录部分
  Widget _buildPaymentSection() {
    final s = S.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(s.paymentRecordsSectionTitle, style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            )),
            TextButton.icon(
              icon: const Icon(Icons.add, size: 18),
              label: Text(s.addPaymentButton),
              onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => StudentPaymentPage(studentId: widget.studentId))),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: ref.read(paymentRepositoryProvider).getByStudentId(widget.studentId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final payments = snapshot.data ?? [];
            if (payments.isEmpty) {
              return _buildEmptyState(s.noPaymentRecordsMessage);
            }
            final totalAmount = payments.fold<double>(0, (sum, p) => sum + ((p['amount'] as num?)?.toDouble() ?? 0));
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(s.totalPaymentLabel(totalAmount.toStringAsFixed(2)),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                ...payments.map((payment) {
                  final paidAt = DateTime.parse(payment['paid_at'] as String);
                  final amount = (payment['amount'] as num?)?.toDouble() ?? 0;
                  final desc = payment['description'] as String?;
                  final typeName = payment['course_type_name'] as String?;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.payment, color: Colors.green),
                      title: Text(desc ?? typeName ?? '付费'),
                      subtitle: Text('${paidAt.year}-${paidAt.month.toString().padLeft(2, '0')}-${paidAt.day.toString().padLeft(2, '0')}'),
                      trailing: Text('¥${amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> _loadClassRecords() async {
    final db = ref.read(databaseProvider);
    final repo = ScheduledClassRepository(database: db);
    return await repo.getByStudentId(widget.studentId, limit: 20);
  }

  String _attendanceLabel(String attendance) {
    final s = S.of(context)!;
    switch (attendance) {
      case 'present': return s.attendancePresent;
      case 'absent': return s.attendanceAbsent;
      case 'late': return s.attendanceLate;
      default: return s.attendancePending;
    }
  }

  Color _attendanceColor(String attendance) {
    switch (attendance) {
      case 'present': return Colors.green;
      case 'absent': return Colors.red;
      case 'late': return Colors.orange;
      default: return Colors.grey;
    }
  }

  /// 构建相册部分
  Widget _buildAlbumsSection(AlbumState state) {
    final s = S.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题行
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              s.albumsSectionTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton.icon(
              onPressed: _showCreateAlbumDialog,
              icon: const Icon(Icons.add, size: 18),
              label: Text(s.newButton),
            ),
          ],
        ),
        const SizedBox(height: 12),
        state.when(
          initial: () => _buildEmptyState(s.noAlbumsMessage),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stackTrace) => _buildErrorState(error),
          data: (albums, selectedStudentId) {
            final studentAlbums = albums
                .where((album) => album.studentId == widget.studentId)
                .toList();

            if (studentAlbums.isEmpty) {
              return _buildEmptyState(s.noAlbumsMessage);
            }

            return Column(
              children: studentAlbums.map((album) {
                return _buildAlbumCard(album);
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  /// 构建相册卡片
  Widget _buildAlbumCard(Album album) {
    final s = S.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.teal,
          child: Icon(
            Icons.photo_library,
            color: Colors.white,
          ),
        ),
        title: Text(
          album.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (album.notes != null && album.notes!.isNotEmpty)
              Text(
                album.notes!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.photo,
                  size: 14,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(width: 4),
                Text(
                  s.photoCountDisplay(album.photoCount),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
              onPressed: () => _showDeleteAlbumDialog(album),
              tooltip: s.deleteAlbumTitle,
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AlbumDetailPage(
                albumId: album.id,
                albumName: album.name,
                albumNotes: album.notes,
              ),
            ),
          ).then((_) {
            ref.read(albumNotifierProvider.notifier).fetchByStudentId(widget.studentId);
          });
        },
      ),
    );
  }

  /// 显示删除相册确认对话框
  Future<void> _showDeleteAlbumDialog(Album album) async {
    return showDialog(
      context: context,
      builder: (context) {
        final s = S.of(context)!;
        return AlertDialog(
          icon: const Icon(Icons.warning, color: Colors.red, size: 48),
          title: Text(s.deleteAlbumTitle),
          content: Text(
            s.confirmDeleteAlbumMessage(album.name),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(s.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await _deleteAlbum(album);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(s.btnConfirmDelete),
            ),
          ],
        );
      },
    );
  }

  /// 删除相册
  Future<void> _deleteAlbum(Album album) async {
    try {
      final notifier = ref.read(albumNotifierProvider.notifier);
      final success = await notifier.delete(album.id);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)!.albumDeleted)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)!.deleteAlbumFailed(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 显示删除课程规划确认对话框
  Future<void> _showDeleteCoursePlanDialog(CoursePlan coursePlan) async {
    return showDialog(
      context: context,
      builder: (context) {
        final s = S.of(context)!;
        return AlertDialog(
          icon: const Icon(Icons.warning, color: Colors.red, size: 48),
          title: Text(s.deleteCoursePlanTitle),
          content: Text(
            s.confirmDeleteCoursePlanMessage(coursePlan.goalName ?? ''),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(s.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await _deleteCoursePlan(coursePlan.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(s.btnConfirmDelete),
            ),
          ],
        );
      },
    );
  }

  /// 删除课程规划
  Future<void> _deleteCoursePlan(int coursePlanId) async {
    try {
      final notifier = ref.read(coursePlanNotifierProvider.notifier);
      final success = await notifier.delete(coursePlanId);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)!.coursePlanDeleted)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)!.deleteAlbumFailed(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
    final s = S.of(context)!;
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
            s.loadingFailedMessage,
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

  /// 通用颜色列表（基于目标名称哈希分配，不依赖具体目标名称）
  static const _goalColors = [
    Colors.blue,
    Colors.purple,
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.green,
    Colors.red,
    Colors.amber,
    Colors.indigo,
    Colors.cyan,
  ];

  static const _goalIcons = [
    Icons.flag,
    Icons.star,
    Icons.favorite,
    Icons.local_fire_department,
    Icons.emoji_events,
    Icons.psychology,
    Icons.trending_up,
    Icons.lightbulb,
    Icons.rocket_launch,
    Icons.diamond,
  ];

  /// 根据课程目标名称哈希获取颜色
  Color _getGoalColor(String goal) {
    if (goal.isEmpty) return Colors.grey;
    final index = goal.hashCode.abs() % _goalColors.length;
    return _goalColors[index];
  }

  /// 根据课程目标名称哈希获取图标
  IconData _getGoalIcon(String goal) {
    if (goal.isEmpty) return Icons.event_note;
    final index = goal.hashCode.abs() % _goalIcons.length;
    return _goalIcons[index];
  }

  /// 根据完成率获取颜色
  Color _getCompletionRateColor(double rate) {
    if (rate >= 1.0) return Colors.green;
    if (rate >= 0.5) return Colors.orange;
    return Colors.grey;
  }
}
