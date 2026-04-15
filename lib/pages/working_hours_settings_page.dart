import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/settings_provider.dart';

class WorkingHoursSettingsPage extends ConsumerStatefulWidget {
  const WorkingHoursSettingsPage({super.key});

  @override
  ConsumerState<WorkingHoursSettingsPage> createState() =>
      _WorkingHoursSettingsPageState();
}

class _WorkingHoursSettingsPageState
    extends ConsumerState<WorkingHoursSettingsPage> {
  bool _enabled = false;
  List<TimeSegment> _segments = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadSettings());
  }

  Future<void> _loadSettings() async {
    final notifier = ref.read(workingHoursNotifierProvider.notifier);
    final enabled = await notifier.getSavedEnabled();
    final segments = await notifier.getSavedSegments();
    if (!mounted) return;
    setState(() {
      _enabled = enabled;
      _segments = segments.isEmpty ? [const TimeSegment(start: 8, end: 18)] : segments;
      _loaded = true;
    });
  }

  Future<void> _save() async {
    final notifier = ref.read(workingHoursNotifierProvider.notifier);
    if (_enabled) {
      await notifier.setWorkingHours(_segments);
    } else {
      // 保存配置但禁用
      await notifier.setEnabled(false);
    }
  }

  void _onEnabledChanged(bool value) {
    setState(() => _enabled = value);
    _save();
  }

  void _addSegment() {
    setState(() {
      _segments.add(const TimeSegment(start: 14, end: 18));
    });
    _save();
  }

  void _removeSegment(int index) {
    setState(() {
      _segments.removeAt(index);
    });
    _save();
  }

  void _updateSegmentStart(int index, int value) {
    setState(() {
      _segments[index] = TimeSegment(start: value, end: _segments[index].end);
    });
    _save();
  }

  void _updateSegmentEnd(int index, int value) {
    setState(() {
      _segments[index] = TimeSegment(start: _segments[index].start, end: value);
    });
    _save();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('课表设置')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('自定义工作时间'),
            subtitle: const Text('启用后日视图仅显示配置的时段'),
            value: _enabled,
            onChanged: _onEnabledChanged,
          ),
          const Divider(),
          if (_enabled) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                children: [
                  Text(
                    '工作时段',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _segments.length < 5 ? _addSegment : null,
                    tooltip: '添加时段',
                  ),
                ],
              ),
            ),
            ...List.generate(_segments.length, (index) {
              final seg = _segments[index];
              return _buildSegmentRow(context, index, seg);
            }),
            if (_segments.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Text('暂无时段，点击 + 添加', textAlign: TextAlign.center),
              ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildSegmentRow(BuildContext context, int index, TimeSegment seg) {
    return Dismissible(
      key: ValueKey('segment_$index'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _removeSegment(index),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red.withOpacity(0.1),
        child: const Icon(Icons.delete, color: Colors.red),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          children: [
            Text('时段 ${index + 1}', style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButton<int>(
                value: seg.start,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                items: List.generate(24, (h) {
                  return DropdownMenuItem(
                    value: h,
                    child: Text('${h.toString().padLeft(2, '0')}:00'),
                  );
                }),
                onChanged: (v) {
                  if (v != null) _updateSegmentStart(index, v);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('—'),
            ),
            Expanded(
              child: DropdownButton<int>(
                value: seg.end,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                items: List.generate(24, (h) {
                  final end = h + 1;
                  return DropdownMenuItem(
                    value: end,
                    child: Text('${end.toString().padLeft(2, '0')}:00'),
                  );
                }),
                onChanged: (v) {
                  if (v != null) _updateSegmentEnd(index, v);
                },
              ),
            ),
            if (_segments.length > 1)
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => _removeSegment(index),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
          ],
        ),
      ),
    );
  }
}
