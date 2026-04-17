import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'student_detail_page.dart';

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
      builder: (context) {
        final s = S.of(context)!;
        return AlertDialog(
          title: Text(s.btnConfirmDelete),
          content: Text(s.confirmDeleteStudentMessage(student.name)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(s.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: Text(s.btnDelete),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      final notifier = ref.read(studentNotifierProvider.notifier);
      final success = await notifier.delete(student.id);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)!.studentDeleted)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    final studentState = ref.watch(studentNotifierProvider);
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.navStudents),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                s.totalStudentsCount(ref.watch(studentCountProvider)),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          if (isIOS)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _navigateToCreate,
              tooltip: s.addStudentTooltip,
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
      floatingActionButton: isIOS
          ? null
          : FloatingActionButton(
              onPressed: _navigateToCreate,
              tooltip: s.addStudentTooltip,
              child: const Icon(Icons.add),
            ),
    );
  }

  /// 构建搜索栏
  Widget _buildSearchBar() {
    final s = S.of(context)!;
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
          hintText: s.searchStudentHint,
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
    final s = S.of(context)!;
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
            s.noStudentsDataMessage,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            s.clickToAddStudentMessage,
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
    final s = S.of(context)!;
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
            s.loadingFailedMessage,
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
            label: Text(s.retry),
          ),
        ],
      ),
    );
  }

  /// 空数据视图
  Widget _buildEmptyView(bool isSearchResult) {
    final s = S.of(context)!;
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
            isSearchResult ? s.noMatchingStudents : s.noStudentsDataMessage,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          if (isSearchResult) ...[
            const SizedBox(height: 8),
            Text(
              s.tryDifferentKeywords,
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
    final s = S.of(context)!;
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
            tooltip: s.viewCoursePlanTooltip,
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
            itemBuilder: (context) {
              final s = S.of(context)!;
              return [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      const Icon(Icons.edit, size: 20),
                      const SizedBox(width: 12),
                      Text(s.edit),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete, size: 20, color: Colors.red),
                      const SizedBox(width: 12),
                      Text(s.btnDelete, style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      onTap: () => _navigateToDetail(student.id),
    );
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
        final s = S.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.studentId != null ? s.studentUpdated : s.studentCreated),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentId != null ? s.editStudentTitle : s.addStudentTitle),
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
              child: Text(s.btnSave),
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
              decoration: InputDecoration(
                labelText: s.nameLabel,
                hintText: s.enterStudentNameHint,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return s.studentNameRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // 性别
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: InputDecoration(
                labelText: s.genderLabel,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: '男', child: Text(s.genderMale)),
                DropdownMenuItem(value: '女', child: Text(s.genderFemale)),
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
              decoration: InputDecoration(
                labelText: s.contactLabel,
                hintText: s.enterContactHint,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return s.contactRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // 备注
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: s.notesLabel,
                hintText: s.enterNotesHint,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
