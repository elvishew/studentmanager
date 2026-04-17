import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/settings_provider.dart';
import 'package:student_manager/l10n/app_localizations.dart';

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

    final s = S.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(s.scheduleSettingsTitle)),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(s.customWorkingHoursToggle),
            subtitle: Text(s.customWorkingHoursDescription),
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
                    s.workingHoursSectionTitle,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _segments.length < 5 ? _addSegment : null,
                    tooltip: s.addTimeSlotTooltip,
                  ),
                ],
              ),
            ),
            ...List.generate(_segments.length, (index) {
              final seg = _segments[index];
              return _buildSegmentRow(context, index, seg);
            }),
            if (_segments.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(s.noTimeSlotsMessage, textAlign: TextAlign.center),
              ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildSegmentRow(BuildContext context, int index, TimeSegment seg) {
    final s = S.of(context)!;
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
            Text(s.timeSlotNumberLabel(index + 1), style: const TextStyle(fontSize: 14)),
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
