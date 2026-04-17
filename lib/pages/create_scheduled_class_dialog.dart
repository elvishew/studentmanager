import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/course_type_provider.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/settings_provider.dart';
import 'package:student_manager/utils/working_hours_utils.dart';
import 'package:student_manager/l10n/app_localizations.dart';


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
  late DateTime _selectedDate;
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

    if (isEditing && widget.editingData != null) {
      // 编辑模式：保留原始日期
      final data = widget.editingData!;
      _startTime = DateTime.parse(data['start_time'] as String);
      _endTime = DateTime.parse(data['end_time'] as String);
      _selectedDate = DateTime(_startTime.year, _startTime.month, _startTime.day);
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
    } else {
      // 新建模式：使用日历选中日期
      _selectedDate = DateTime(now.year, now.month, now.day); // will be updated in didChangeDependencies
      _startTime = DateTime(now.year, now.month, now.day, hour, 0);
      _endTime = DateTime(now.year, now.month, now.day, hour + 1, 0);
      _selectedSessionId = widget.preselectedSessionId;
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

        // 新建模式：用 selectedDateProvider 的日期覆盖 _selectedDate
        if (!isEditing) {
          final selectedDate = ref.read(selectedDateProvider);
          setState(() {
            _selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
            _startTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
                _startTime.hour, _startTime.minute);
            _endTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
                _endTime.hour, _endTime.minute);
          });
        }

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
    final s = S.of(context)!;
    final courseTypes = ref.watch(activeCourseTypesProvider);

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
              Text(isEditing ? s.editScheduledClass : s.createScheduledClass, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),

              // 课程类型选择
              Text(s.courseTypeLabel, style: Theme.of(context).textTheme.titleSmall),
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
                        setState(() => _validationError = s.participantOverflow(ct.name, newMax!));
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

              // 日期选择
              if (_isLocked) ...[
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: s.dateLabel,
                    border: const OutlineInputBorder(),
                  ),
                  child: Text(_formatDate(context, _selectedDate)),
                ),
              ] else ...[
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDate = DateTime(picked.year, picked.month, picked.day);
                        _startTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
                            _startTime.hour, _startTime.minute);
                        _endTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
                            _endTime.hour, _endTime.minute);
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: s.dateLabel,
                      border: const OutlineInputBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDate(context, _selectedDate)),
                        const Icon(Icons.calendar_today, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),

              // 时间选择
              if (_isLocked) ...[
                Row(
                  children: [
                    Expanded(
                      child: InputDecorator(
                        decoration: InputDecoration(labelText: s.startTimeLabel, border: const OutlineInputBorder()),
                        child: Text('${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputDecorator(
                        decoration: InputDecoration(labelText: s.endTimeLabel, border: const OutlineInputBorder()),
                        child: Text('${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}'),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: _buildTimePicker(s.startTimeLabel, _startTime, (time) {
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
                      child: _buildTimePicker(s.endTimeLabel, _endTime, (time) {
                        setState(() => _endTime = time);
                      }),
                    ),
                  ],
                ),
              ],
              if (!_isLocked) ...[
                Builder(builder: (context) {
                  final warning = _workingHoursWarningText(context);
                  if (warning == null) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      warning,
                      style: TextStyle(fontSize: 12, color: Colors.amber[800]),
                    ),
                  );
                }),
              ],
              const SizedBox(height: 16),

              // 参与人
              Text(s.participantsLabel, style: Theme.of(context).textTheme.titleSmall),
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
                      label: Text(_canAddParticipant ? s.searchStudents : s.participantsFull),
                      onPressed: _canAddParticipant ? _showStudentSearch : null,
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.person_add, size: 18),
                      label: Text(s.temporaryPerson),
                      onPressed: _canAddParticipant ? _showAddGuest : null,
                    ),
                  ],
                ),
              const SizedBox(height: 16),

              // 标题（可选）
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: s.titleOptionalLabel,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (v) => _title = v.isEmpty ? null : v,
              ),
              const SizedBox(height: 16),

              // 地点（可选）
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: s.locationOptionalLabel,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (v) => _location = v.isEmpty ? null : v,
              ),
              const SizedBox(height: 16),

              // 备注（可选）
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: s.notesOptionalLabel,
                  border: const OutlineInputBorder(),
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
                      : Text(isEditing ? s.btnSave : s.createScheduledClass),
                ),
              ),
              if (!_isSubmitting && (_selectedCourseType == null || _participants.isEmpty))
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Center(
                    child: Text(
                      s.pleaseSelectCourseTypeAndParticipant,
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
            onChanged(DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day,
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
    final s = S.of(context)!;
    _guestNameController.clear();
    String? errorText;
    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(s.addTemporaryPerson),
          content: TextField(
            controller: _guestNameController,
            decoration: InputDecoration(
              labelText: s.guestNameLabel,
              errorText: errorText,
            ),
            autofocus: true,
            onChanged: (_) {
              // 输入变化时清除错误提示
              if (errorText != null) {
                setDialogState(() => errorText = null);
              }
            },
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text(s.btnCancel)),
            ListenableBuilder(
              listenable: _guestNameController,
              builder: (context, _) {
                final name = _guestNameController.text.trim();
                return TextButton(
                  onPressed: name.isEmpty ? null : () {
                    // 检查：同名临时人员已存在
                    final hasDuplicateGuest = _participants.any(
                      (p) => p['student_id'] == null && p['guest_name'] == name,
                    );
                    if (hasDuplicateGuest) {
                      setDialogState(() => errorText = s.guestAlreadyAdded);
                      return;
                    }
                    // 检查：与已添加的正式学员同名
                    final hasSameNameStudent = _participants.any(
                      (p) => p['student_id'] != null && p['name'] == name,
                    );
                    if (hasSameNameStudent) {
                      Navigator.pop(dialogContext);
                      _confirmAddDuplicateNameGuest(name);
                      return;
                    }
                    setState(() {
                      _participants.add({
                        'student_id': null,
                        'guest_name': name,
                        'name': null,
                      });
                      _validationError = null;
                    });
                    Navigator.pop(dialogContext);
                  },
                  child: Text(s.btnAdd),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 确认添加与正式学员同名的临时人员
  void _confirmAddDuplicateNameGuest(String name) {
    final s = S.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.duplicateNameTitle),
        content: Text(s.duplicateNameConfirm(name)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(s.btnCancel)),
          TextButton(
            onPressed: () {
              setState(() {
                _participants.add({
                  'student_id': null,
                  'guest_name': name,
                  'name': null,
                });
                _validationError = null;
              });
              Navigator.pop(context);
            },
            child: Text(s.confirmAddDuplicate),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final s = S.of(context)!;
    if (_isSubmitting) return;

    // 校验参与人
    if (_participants.isEmpty) {
      setState(() => _validationError = s.atLeastOneParticipant);
      return;
    }
    if (_maxParticipants != null && _participants.length > _maxParticipants!) {
      setState(() => _validationError = s.participantOverflow(_selectedCourseType!.name, _maxParticipants!));
      return;
    }

    // 工作时间校验确认
    final segments = ref.read(workingHoursNotifierProvider);
    if (segments.isNotEmpty) {
      final startH = _startTime.hour + _startTime.minute / 60;
      final endH = _endTime.hour + _endTime.minute / 60;
      if (!isClassInWorkingHours(startH, endH, segments)) {
        final confirmed = await _showWorkingHoursConfirmDialog(segments);
        if (!confirmed) return;
      }
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
              SnackBar(content: Text(s.saveFailed), backgroundColor: Colors.red),
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
            notifier.fetchByDate(_selectedDate);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(s.createFailed), backgroundColor: Colors.red),
            );
          }
        }
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String _fmtTime(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  String _formatDate(BuildContext context, DateTime date) {
    final s = S.of(context)!;
    final weekdays = [
      s.rangeWeekdayMon, s.rangeWeekdayTue, s.rangeWeekdayWed,
      s.rangeWeekdayThu, s.rangeWeekdayFri, s.rangeWeekdaySat, s.rangeWeekdaySun,
    ];
    return s.dateFormatFull(date.year, date.month, date.day, weekdays[date.weekday - 1]);
  }

  String? _workingHoursWarningText(BuildContext context) {
    final s = S.of(context)!;
    final segments = ref.read(workingHoursNotifierProvider);
    if (segments.isEmpty) return null;
    final startH = _startTime.hour + _startTime.minute / 60;
    final endH = _endTime.hour + _endTime.minute / 60;
    if (isClassInWorkingHours(startH, endH, segments)) return null;
    return '\u26A0 ${_fmtTime(_startTime)}-${_fmtTime(_endTime)} '
        '${s.workingHoursWarningMessage(_fmtTime(_startTime), _fmtTime(_endTime), formatSegments(segments))}';
  }

  Future<bool> _showWorkingHoursConfirmDialog(List<TimeSegment> segments) async {
    final s = S.of(context)!;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.workingHoursWarningTitle),
        content: Text(
          s.workingHoursWarningMessage(_fmtTime(_startTime), _fmtTime(_endTime), formatSegments(segments)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(s.goBackToEdit),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(s.confirmScheduleOutsideHours),
          ),
        ],
      ),
    );
    return result ?? false;
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
    final s = S.of(context)!;
    final state = ref.watch(studentNotifierProvider);
    return state.maybeWhen(
      data: (students, _, __) {
        final filtered = students
            .where((s) => !existingStudentIds.contains(s.id))
            .where((s) => query.isEmpty || s.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (filtered.isEmpty) {
          return Center(child: Text(s.noStudentsToAdd));
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
