import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/course_plan_provider.dart';

/// ============================================
/// 学员列表页
/// ============================================

class StudentListPage extends ConsumerStatefulWidget {
  const StudentListPage({super.key});

  @override
  ConsumerState<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends ConsumerState<StudentListPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 页面初始化时加载数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(studentNotifierProvider.notifier).fetchAll();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  /// 跳转到学员详情页
  void _navigateToDetail(int studentId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StudentDetailPage(studentId: studentId),
      ),
    );
  }

  /// 跳转到创建学员页
  void _navigateToCreate() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const StudentFormPage(),
      ),
    );
  }

  /// 显示删除确认对话框
  Future<void> _showDeleteDialog(Student student) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除学员「${student.name}」吗？\n\n删除后将同时删除该学员的所有课程规划和课时数据。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final notifier = ref.read(studentNotifierProvider.notifier);
      final success = await notifier.delete(student.id);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('学员已删除')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('学员列表'),
        actions: [
          // 显示学员总数
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                '共 ${ref.watch(studentCountProvider)} 人',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          _buildSearchBar(),
          // 列表内容
          Expanded(
            child: _buildContent(studentState),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreate,
        tooltip: '添加学员',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// 构建搜索栏
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          hintText: '搜索学员姓名、联系方式或备注',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    ref.read(studentNotifierProvider.notifier).search('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        onChanged: (query) {
          ref.read(studentNotifierProvider.notifier).search(query);
        },
      ),
    );
  }

  /// 构建内容区域
  Widget _buildContent(StudentState state) {
    return state.when(
      initial: () => _buildInitialView(),
      loading: () => _buildLoadingView(),
      error: (error, stackTrace) => _buildErrorView(error, stackTrace),
      data: (students, filtered, query) {
        if (filtered.isEmpty) {
          return _buildEmptyView(query.isNotEmpty);
        }
        return _buildListView(filtered);
      },
    );
  }

  /// 初始状态视图
  Widget _buildInitialView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无学员数据',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '点击右下角 + 按钮添加学员',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }

  /// 加载中视图
  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// 错误视图
  Widget _buildErrorView(Object error, StackTrace stackTrace) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            '加载失败',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(studentNotifierProvider.notifier).fetchAll();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('重试'),
          ),
        ],
      ),
    );
  }

  /// 空数据视图
  Widget _buildEmptyView(bool isSearchResult) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearchResult ? Icons.search_off : Icons.inbox,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            isSearchResult ? '未找到匹配的学员' : '暂无学员',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          if (isSearchResult) ...[
            const SizedBox(height: 8),
            Text(
              '尝试使用其他关键词搜索',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ],
      ),
    );
  }

  /// 列表视图
  Widget _buildListView(List<Student> students) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(studentNotifierProvider.notifier).fetchAll();
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: students.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final student = students[index];
          return _buildStudentTile(student);
        },
      ),
    );
  }

  /// 学员列表项
  Widget _buildStudentTile(Student student) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          student.name.isNotEmpty ? student.name[0] : '?',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        student.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (student.gender != null)
            Text(
              '${student.gender} · ${student.contact}',
              style: Theme.of(context).textTheme.bodySmall,
            )
          else
            Text(
              student.contact,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          if (student.notes != null && student.notes!.isNotEmpty)
            Text(
              student.notes!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 查看课程规划按钮
          IconButton(
            icon: const Icon(Icons.folder_open),
            tooltip: '查看课程规划',
            onPressed: () => _navigateToDetail(student.id),
          ),
          // 更多操作菜单
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StudentFormPage(
                        studentId: student.id,
                      ),
                    ),
                  );
                  break;
                case 'delete':
                  _showDeleteDialog(student);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 20),
                    SizedBox(width: 12),
                    Text('编辑'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 20, color: Colors.red),
                    SizedBox(width: 12),
                    Text('删除', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () => _navigateToDetail(student.id),
    );
  }
}

/// ============================================
/// 学员详情页
/// ============================================

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
  bool _hasLoadedCoursePlans = false;

  @override
  void initState() {
    super.initState();
    _loadStudent();
  }

  Future<void> _loadStudent() async {
    final notifier = ref.read(studentNotifierProvider.notifier);
    final student = await notifier.getById(widget.studentId);
    if (mounted) {
      setState(() {
        _student = student;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_student == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('学员详情'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('学员详情'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StudentFormPage(
                    studentId: widget.studentId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 基本信息
            _buildSection(
              title: '基本信息',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('姓名', _student!.name),
                  if (_student!.gender != null) _buildInfoRow('性别', _student!.gender!),
                  _buildInfoRow('联系方式', _student!.contact),
                  if (_student!.notes != null && _student!.notes!.isNotEmpty)
                    _buildInfoRow('备注', _student!.notes!),
                  _buildInfoRow(
                    '创建时间',
                    _formatDateTime(_student!.createdAt),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 课程规划列表
            _buildCoursePlansSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursePlansSection() {
    return _buildSection(
      title: '课程规划',
      child: Consumer(
        builder: (context, ref, _) {
          final coursePlanState = ref.watch(coursePlanNotifierProvider);
          final studentId = widget.studentId;

          // 只加载一次
          if (!_hasLoadedCoursePlans) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(coursePlanNotifierProvider.notifier).fetchByStudentId(studentId);
              _hasLoadedCoursePlans = true;
            });
          }

          return coursePlanState.when(
            initial: () => const Center(child: Text('暂无课程规划')),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('加载失败: $e')),
            data: (plans, selected, filteredStudentId) {
              final studentPlans = plans.where((p) => p.studentId == studentId).toList();

              if (studentPlans.isEmpty) {
                return const Center(child: Text('暂无课程规划'));
              }

              return Column(
                children: studentPlans.map((plan) {
                  return ListTile(
                    title: Text(plan.goal),
                    subtitle: Text(
                      '完成率: ${(plan.completionRate * 100).toStringAsFixed(1)}%',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // 跳转到课程规划详情页
                      // Navigator.of(context).push(...)
                    },
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

/// ============================================
/// 学员表单页（创建/编辑）
/// ============================================

class StudentFormPage extends ConsumerStatefulWidget {
  final int? studentId;

  const StudentFormPage({
    super.key,
    this.studentId,
  });

  @override
  ConsumerState<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends ConsumerState<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedGender;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.studentId != null) {
      _loadStudent();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadStudent() async {
    final notifier = ref.read(studentNotifierProvider.notifier);
    final student = await notifier.getById(widget.studentId!);
    if (student != null && mounted) {
      setState(() {
        _nameController.text = student.name;
        _contactController.text = student.contact;
        _notesController.text = student.notes ?? '';
        _selectedGender = student.gender;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final notifier = ref.read(studentNotifierProvider.notifier);
    bool? success;

    if (widget.studentId != null) {
      // 更新
      success = await notifier.update(
        id: widget.studentId!,
        name: _nameController.text.trim(),
        gender: _selectedGender,
        contact: _contactController.text.trim(),
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
    } else {
      // 创建
      final id = await notifier.create(
        name: _nameController.text.trim(),
        gender: _selectedGender,
        contact: _contactController.text.trim(),
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      success = id != null;
    }

    if (mounted) {
      setState(() {
        _isSaving = false;
      });

      if (success == true) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.studentId != null ? '学员已更新' : '学员已创建'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentId != null ? '编辑学员' : '添加学员'),
        actions: [
          if (_isSaving)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text('保存'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // 姓名
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '姓名',
                hintText: '请输入学员姓名',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '请输入学员姓名';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // 性别
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(
                labelText: '性别',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: '男', child: Text('男')),
                DropdownMenuItem(value: '女', child: Text('女')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // 联系方式
            TextFormField(
              controller: _contactController,
              decoration: const InputDecoration(
                labelText: '联系方式',
                hintText: '请输入手机号或邮箱',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '请输入联系方式';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // 备注
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: '备注',
                hintText: '请输入备注信息（可选）',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
