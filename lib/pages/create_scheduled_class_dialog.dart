import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/course_type_provider.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/providers/student_provider.dart';

/// 快速排课底部面板（新建/编辑共用）
class CreateScheduledClassDialog extends ConsumerStatefulWidget {
  /// 预选的课程规划 session ID（从课程规划页排课时传入）
  final int? preselectedSessionId;
  /// 预选的参与学员 ID（从课程规划页排课时传入）
  final int? preselectedStudentId;
  /// 初始开始时间的小时（从日视图空白区域点击时传入）
  final int? initialStartHour;
  /// 编辑模式：排课 ID
  final int? editingClassId;
  /// 编辑模式：排课详情数据
  final Map<String, dynamic>? editingData;

  const CreateScheduledClassDialog({
    super.key,
    this.preselectedSessionId,
    this.preselectedStudentId,
    this.initialStartHour,
    this.editingClassId,
    this.editingData,
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
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isSubmitting = false;
  bool _initialized = false;
  String? _validationError;

  bool get isEditing => widget.editingClassId != null;

  /// 当前课程类型的参与人上限（null 表示不限制）
  int? get _maxParticipants {
    if (_selectedCourseType == null) return null;
    if (_selectedCourseType!.isGroup) return _selectedCourseType!.maxStudents;
    return 1; // 一对一
  }

  /// 是否还能添加参与人
  bool get _canAddParticipant {
    if (_maxParticipants == null) return true;
    return _participants.length < _maxParticipants!;
  }

  /// 已完成的排课：锁定课程类型、时间、参与人（仅允许编辑标题/地点/备注）
  bool get _isLocked => isEditing && widget.editingData?['status'] == 'completed';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final hour = widget.initialStartHour ?? now.hour + 1;
    _startTime = DateTime(now.year, now.month, now.day, hour, 0);
    _endTime = DateTime(now.year, now.month, now.day, hour + 1, 0);
    _selectedSessionId = widget.preselectedSessionId;

    // 编辑模式预填数据
    if (isEditing && widget.editingData != null) {
      final data = widget.editingData!;
      _startTime = DateTime.parse(data['start_time'] as String);
      _endTime = DateTime.parse(data['end_time'] as String);
      _selectedSessionId = data['session_id'] as int?;
      _title = data['title'] as String?;
      _location = data['location'] as String?;
      _notes = data['notes'] as String?;
      _titleController.text = _title ?? '';
      _locationController.text = _location ?? '';
      _notesController.text = _notes ?? '';

      final participants = data['participants'] as List? ?? [];
      for (final p in participants) {
        _participants.add({
          'student_id': p['student_id'] as int?,
          'guest_name': p['guest_name'] as String?,
          'name': p['student_name'] as String? ?? p['guest_name'] as String?,
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        // 确保课程类型数据已加载
        await ref.read(courseTypeNotifierProvider.notifier).fetchAll();
        // 编辑模式：匹配课程类型
        if (isEditing && widget.editingData != null) {
          final courseTypeId = widget.editingData!['course_type_id'] as int?;
          if (courseTypeId != null) {
            final courseTypes = ref.read(activeCourseTypesProvider);
            final match = courseTypes.where((ct) => ct.id == courseTypeId).firstOrNull;
            if (match != null) {
              setState(() => _selectedCourseType = match);
            }
          }
        }
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
    _titleController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseTypes = ref.watch(activeCourseTypesProvider);

    // 新建模式：使用日历选中日期作为基础日期；编辑模式：保留原始日期
    if (!isEditing) {
      final selectedDate = ref.watch(selectedDateProvider);
      _startTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
          _startTime.hour, _startTime.minute);
      _endTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
          _endTime.hour, _endTime.minute);
    }

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
              Text(isEditing ? '编辑排课' : '新建排课', style: Theme.of(context).textTheme.titleLarge),
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
                    onSelected: _isLocked ? null : (_) {
                      // 切换类型时校验参与人数量
                      int? newMax;
                      if (ct.isGroup) {
                        newMax = ct.maxStudents;
                      } else {
                        newMax = 1;
                      }
                      if (newMax != null && _participants.length > newMax) {
                        setState(() => _validationError = '参与人已超过「${ct.name}」的上限（最多 $newMax 人），请先移除多余参与人');
                        return;
                      }
                      setState(() {
                        _selectedCourseType = ct;
                        _endTime = _startTime.add(Duration(minutes: ct.defaultDuration));
                        _validationError = null;
                      });
                    },
                  );
                }).toList(),
              ),
              if (_validationError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(_validationError!, style: TextStyle(
                    color: Theme.of(context).colorScheme.error, fontSize: 13,
                  )),
                ),
              const SizedBox(height: 16),

              // 时间选择
              if (_isLocked) ...[
                Row(
                  children: [
                    Expanded(
                      child: InputDecorator(
                        decoration: const InputDecoration(labelText: '开始时间', border: OutlineInputBorder()),
                        child: Text('${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputDecorator(
                        decoration: const InputDecoration(labelText: '结束时间', border: OutlineInputBorder()),
                        child: Text('${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}'),
                      ),
                    ),
                  ],
                ),
              ] else ...[
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
              ],
              const SizedBox(height: 16),

              // 参与人
              Text('参与人', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              ..._participants.map((p) => ListTile(
                dense: true,
                leading: Icon(p['student_id'] != null ? Icons.person : Icons.person_outline),
                title: Text(p['student_id'] != null ? p['name'] ?? '' : p['guest_name'] ?? ''),
                trailing: _isLocked ? null : IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () => setState(() {
                    _participants.remove(p);
                    _validationError = null;
                  }),
                ),
              )),
              if (!_isLocked)
                Row(
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.search, size: 18),
                      label: Text(_canAddParticipant ? '搜索学员' : '人数已满'),
                      onPressed: _canAddParticipant ? _showStudentSearch : null,
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.person_add, size: 18),
                      label: const Text('临时人员'),
                      onPressed: _canAddParticipant ? _showAddGuest : null,
                    ),
                  ],
                ),
              const SizedBox(height: 16),

              // 标题（可选）
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '标题（可选）',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _title = v.isEmpty ? null : v,
              ),
              const SizedBox(height: 16),

              // 地点（可选）
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: '地点（可选）',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _location = v.isEmpty ? null : v,
              ),
              const SizedBox(height: 16),

              // 备注（可选）
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: '备注（可选）',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                onChanged: (v) => _notes = v.isEmpty ? null : v,
              ),
              const SizedBox(height: 24),

              // 提交按钮
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _selectedCourseType == null || _participants.isEmpty || _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(isEditing ? '保存' : '创建排课'),
                ),
              ),
              if (!_isSubmitting && (_selectedCourseType == null || _participants.isEmpty))
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Center(
                    child: Text(
                      '请先${[
                        if (_selectedCourseType == null) '选择课程类型',
                        if (_participants.isEmpty) '添加参与人',
                      ].join('、')}',
                      style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.outline),
                    ),
                  ),
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
            // 编辑模式用排课原始日期，新建模式用日历选中日期
            final baseDate = isEditing ? _startTime : ref.read(selectedDateProvider);
            onChanged(DateTime(
              baseDate.year, baseDate.month, baseDate.day,
              picked.hour, picked.minute,
            ));
          }
        },
        child: Text('${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'),
      ),
    );
  }

  void _showStudentSearch() async {
    final existingIds = _participants
        .where((p) => p['student_id'] != null)
        .map((p) => p['student_id'] as int)
        .toSet();
    final student = await showSearch<Student?>(
      context: context,
      delegate: _StudentSearchDelegate(ref, existingIds),
    );
    if (student != null) {
      setState(() {
        _participants.add({
          'student_id': student.id,
          'guest_name': null,
          'name': student.name,
        });
        _validationError = null;
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
                  _validationError = null;
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

    // 校验参与人
    if (_participants.isEmpty) {
      setState(() => _validationError = '请至少添加一位参与人');
      return;
    }
    if (_maxParticipants != null && _participants.length > _maxParticipants!) {
      setState(() => _validationError = '参与人数量超过「${_selectedCourseType!.name}」的上限（最多 $_maxParticipants 人）');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final notifier = ref.read(scheduledClassNotifierProvider.notifier);
      final fee = _selectedCourseType?.defaultSessionFee ?? 0;

      if (isEditing) {
        // 编辑模式
        final ok = await notifier.updateScheduledClass(
          classId: widget.editingClassId!,
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
          if (ok) {
            Navigator.pop(context, true);
            notifier.refreshAfterMutation();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('保存失败'), backgroundColor: Colors.red),
            );
          }
        }
      } else {
        // 新建模式
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
            notifier.fetchByDate(ref.read(selectedDateProvider));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('创建失败'), backgroundColor: Colors.red),
            );
          }
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

class _StudentSearchDelegate extends SearchDelegate<Student?> {
  final WidgetRef ref;
  final Set<int> existingStudentIds;

  _StudentSearchDelegate(this.ref, this.existingStudentIds);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: const BackButtonIcon(), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    final state = ref.watch(studentNotifierProvider);
    return state.maybeWhen(
      data: (students, _, __) {
        final filtered = students
            .where((s) => !existingStudentIds.contains(s.id))
            .where((s) => query.isEmpty || s.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (filtered.isEmpty) {
          return const Center(child: Text('没有可添加的学员'));
        }
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
