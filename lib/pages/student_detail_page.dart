import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/course_plan_provider.dart';
import 'package:student_manager/providers/album_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'create_course_plan_dialog.dart';
import 'create_album_dialog.dart';
import 'course_plan_page.dart';
import 'album_detail_page.dart';

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
          const SnackBar(content: Text('相册已创建')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final coursePlanState = ref.watch(coursePlanNotifierProvider);
    final albumState = ref.watch(albumNotifierProvider);

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
                  const SizedBox(height: 24),
                  // 相册列表
                  _buildAlbumsSection(albumState),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 删除按钮
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
              onPressed: () => _showDeleteCoursePlanDialog(coursePlan),
              tooltip: '删除课程规划',
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

  /// 构建相册部分
  Widget _buildAlbumsSection(AlbumState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题行
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '相册',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton.icon(
              onPressed: _showCreateAlbumDialog,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('新建'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        state.when(
          initial: () => _buildEmptyState('暂无相册'),
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
              return _buildEmptyState('暂无相册');
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
                  '${album.photoCount} 张照片',
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
              tooltip: '删除相册',
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
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('删除相册'),
        content: Text(
          '确定要删除相册「${album.name}」吗？\n\n'
          '删除后将同时删除所有照片，此操作不可恢复。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
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
            child: const Text('确认删除'),
          ),
        ],
      ),
    );
  }

  /// 删除相册
  Future<void> _deleteAlbum(Album album) async {
    try {
      final notifier = ref.read(albumNotifierProvider.notifier);
      final success = await notifier.delete(album.id);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('相册已删除')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('删除失败：$e'),
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
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('删除课程规划'),
        content: Text(
          '确定要删除「${coursePlan.goalName ?? ""}」吗？\n\n'
          '删除后将同时删除该规划下的所有课时和训练记录，此操作不可恢复。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
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
            child: const Text('确认删除'),
          ),
        ],
      ),
    );
  }

  /// 删除课程规划
  Future<void> _deleteCoursePlan(int coursePlanId) async {
    try {
      final notifier = ref.read(coursePlanNotifierProvider.notifier);
      final success = await notifier.delete(coursePlanId);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('课程规划已删除')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('删除失败：$e'),
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
