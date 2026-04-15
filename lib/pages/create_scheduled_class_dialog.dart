import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/course_type_provider.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/providers/student_provider.dart';

/// 快速排课底部面板
class CreateScheduledClassDialog extends ConsumerStatefulWidget {
  /// 预选的课程规划 session ID（从课程规划页排课时传入）
  final int? preselectedSessionId;
  /// 预选的参与学员 ID（从课程规划页排课时传入）
  final int? preselectedStudentId;
  /// 初始开始时间的小时（从日视图空白区域点击时传入）
  final int? initialStartHour;

  const CreateScheduledClassDialog({
    super.key,
    this.preselectedSessionId,
    this.preselectedStudentId,
    this.initialStartHour,
  });

  @override
  ConsumerState<CreateScheduledClassDialog> createState() => _CreateScheduledClassDialogState();
}

class _CreateScheduledClassDialogState extends ConsumerState<CreateScheduledClassDialog> {
  CourseType? _selectedCourseType;
  late DateTime _startTime;
  late DateTime _endTime;
  final List<Map<String, dynamic>> _participants = [];
  late int? _selectedSessionId;
  String? _title;
  String? _location;
  String? _notes;
  final _guestNameController = TextEditingController();
  bool _isSubmitting = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final hour = widget.initialStartHour ?? now.hour + 1;
    _startTime = DateTime(now.year, now.month, now.day, hour, 0);
    _endTime = DateTime(now.year, now.month, now.day, hour + 1, 0);
    _selectedSessionId = widget.preselectedSessionId;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        // 确保课程类型数据已加载
        ref.read(courseTypeNotifierProvider.notifier).fetchAll();
        // 如果有预选学员，自动添加为参与人
        if (widget.preselectedStudentId != null) {
          _autoAddPreselectedStudent();
        }
      });
    }
  }

  Future<void> _autoAddPreselectedStudent() async {
    final notifier = ref.read(studentNotifierProvider.notifier);
    final student = await notifier.getById(widget.preselectedStudentId!);
    if (student != null && mounted) {
      setState(() {
        _participants.add({
          'student_id': student.id,
          'guest_name': null,
          'name': student.name,
        });
      });
    }
  }

  @override
  void dispose() {
    _guestNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseTypes = ref.watch(activeCourseTypesProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    // 使用选中日期作为基础日期
    _startTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
        _startTime.hour, _startTime.minute);
    _endTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
        _endTime.hour, _endTime.minute);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 拖拽指示条
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('新建排课', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),

              // 课程类型选择
              Text('课程类型', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              if (courseTypes.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(child: SizedBox(
                    width: 20, height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: courseTypes.map((ct) {
                  final isSelected = _selectedCourseType?.id == ct.id;
                  final color = _parseColor(ct.color) ?? Theme.of(context).colorScheme.primary;
                  return ChoiceChip(
                    label: Text(ct.name),
                    selected: isSelected,
                    selectedColor: color.withOpacity(0.2),
                    side: BorderSide(color: isSelected ? color : Colors.grey),
                    onSelected: (_) {
                      setState(() {
                        _selectedCourseType = ct;
                        _endTime = _startTime.add(Duration(minutes: ct.defaultDuration));
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // 时间选择
              Row(
                children: [
                  Expanded(
                    child: _buildTimePicker('开始时间', _startTime, (time) {
                      setState(() {
                        _startTime = time;
                        if (_selectedCourseType != null) {
                          _endTime = time.add(Duration(minutes: _selectedCourseType!.defaultDuration));
                        }
                      });
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTimePicker('结束时间', _endTime, (time) {
                      setState(() => _endTime = time);
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 添加参与人
              Text('参与人', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              ..._participants.map((p) => ListTile(
                dense: true,
                leading: Icon(p['student_id'] != null ? Icons.person : Icons.person_outline),
                title: Text(p['student_id'] != null ? p['name'] ?? '' : p['guest_name'] ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () => setState(() => _participants.remove(p)),
                ),
              )),
              Row(
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.search, size: 18),
                    label: const Text('搜索学员'),
                    onPressed: _showStudentSearch,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.person_add, size: 18),
                    label: const Text('临时人员'),
                    onPressed: _showAddGuest,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 标题（可选）
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '标题（可选）',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _title = v.isEmpty ? null : v,
              ),
              const SizedBox(height: 16),

              // 地点（可选）
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '地点（可选）',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _location = v.isEmpty ? null : v,
              ),
              const SizedBox(height: 16),

              // 备注（可选）
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '备注（可选）',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                onChanged: (v) => _notes = v.isEmpty ? null : v,
              ),
              const SizedBox(height: 24),

              // 提交按钮
              FilledButton(
                onPressed: _selectedCourseType == null || _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('创建排课'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimePicker(String label, DateTime time, Function(DateTime) onChanged) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      child: InkWell(
        onTap: () async {
          final picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(time),
          );
          if (picked != null) {
            final selectedDate = ref.read(selectedDateProvider);
            onChanged(DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day,
              picked.hour, picked.minute,
            ));
          }
        },
        child: Text('${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'),
      ),
    );
  }

  void _showStudentSearch() async {
    final student = await showSearch<Student>(
      context: context,
      delegate: _StudentSearchDelegate(ref),
    );
    if (student != null) {
      setState(() {
        _participants.add({
          'student_id': student.id,
          'guest_name': null,
          'name': student.name,
        });
      });
    }
  }

  void _showAddGuest() {
    _guestNameController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加临时人员'),
        content: TextField(
          controller: _guestNameController,
          decoration: const InputDecoration(labelText: '姓名'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
          TextButton(
            onPressed: () {
              final name = _guestNameController.text.trim();
              if (name.isNotEmpty) {
                setState(() {
                  _participants.add({
                    'student_id': null,
                    'guest_name': name,
                    'name': null,
                  });
                });
              }
              Navigator.pop(context);
            },
            child: const Text('添加'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);

    try {
      final notifier = ref.read(scheduledClassNotifierProvider.notifier);
      final fee = _selectedCourseType?.defaultSessionFee ?? 0;

      final id = await notifier.createScheduledClass(
        courseTypeId: _selectedCourseType!.id,
        title: _title,
        startTime: _startTime,
        endTime: _endTime,
        sessionId: _selectedSessionId,
        location: _location,
        notes: _notes,
        teacherSessionFee: fee,
        participants: _participants,
      );

      if (mounted) {
        if (id != null) {
          Navigator.pop(context);
          // 刷新数据
          notifier.fetchByDate(ref.read(selectedDateProvider));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('创建失败'), backgroundColor: Colors.red),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Color? _parseColor(String? hexColor) {
    if (hexColor == null) return null;
    try {
      final hex = hexColor.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return null;
    }
  }
}

class _StudentSearchDelegate extends SearchDelegate<Student> {
  final WidgetRef ref;

  _StudentSearchDelegate(this.ref);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: const BackButtonIcon(), onPressed: () => close(context, Student(
      id: -1, name: '', contact: '', createdAt: DateTime.now(), updatedAt: DateTime.now(),
    )));
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    final state = ref.watch(studentNotifierProvider);
    return state.maybeWhen(
      data: (students, _, __) {
        final filtered = query.isEmpty
            ? students
            : students.where((s) => s.name.toLowerCase().contains(query.toLowerCase())).toList();
        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final student = filtered[index];
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(student.name),
              subtitle: Text(student.contact),
              onTap: () => close(context, student),
            );
          },
        );
      },
      orElse: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
