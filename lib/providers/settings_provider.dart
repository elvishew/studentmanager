import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'student_provider.dart';
import '../database/settings_repository.dart';

part 'settings_provider.g.dart';

/// 工作时间段
class TimeSegment {
  final int start; // 0-23
  final int end;   // 1-24

  const TimeSegment({required this.start, required this.end});

  Map<String, dynamic> toJson() => {'start': start, 'end': end};

  factory TimeSegment.fromJson(Map<String, dynamic> json) {
    return TimeSegment(
      start: json['start'] as int,
      end: json['end'] as int,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSegment && start == other.start && end == other.end;

  @override
  int get hashCode => Object.hash(start, end);
}

/// ============================================
/// SettingsRepository Provider
/// ============================================

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return SettingsRepository(database: database);
}

/// ============================================
/// WorkingHours Notifier
/// ============================================

@Riverpod(keepAlive: true)
class WorkingHoursNotifier extends _$WorkingHoursNotifier {
  late final SettingsRepository _repository;
  static const _keyWorkingHours = 'working_hours';
  static const _keyWorkingHoursEnabled = 'working_hours_enabled';

  @override
  List<TimeSegment> build() {
    _repository = ref.watch(settingsRepositoryProvider);
    // 异步加载，不阻塞 UI
    _loadFromDb();
    return [];
  }

  Future<void> _loadFromDb() async {
    final enabledStr = await _repository.get(_keyWorkingHoursEnabled);
    if (enabledStr != 'true') {
      state = [];
      return;
    }
    final jsonStr = await _repository.get(_keyWorkingHours);
    if (jsonStr == null || jsonStr.isEmpty) {
      state = [];
      return;
    }
    try {
      final list = jsonDecode(jsonStr) as List<dynamic>;
      state = list
          .map((e) => TimeSegment.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      state = [];
    }
  }

  bool get isEnabled {
    // 当 state 非空时视为启用
    return state.isNotEmpty;
  }

  Future<void> setWorkingHours(List<TimeSegment> segments) async {
    if (segments.isEmpty) {
      await _repository.set(_keyWorkingHoursEnabled, 'false');
      state = [];
    } else {
      final jsonStr = jsonEncode(segments.map((s) => s.toJson()).toList());
      await _repository.set(_keyWorkingHours, jsonStr);
      await _repository.set(_keyWorkingHoursEnabled, 'true');
      state = segments;
    }
  }

  Future<void> setEnabled(bool enabled) async {
    if (!enabled) {
      // 禁用但不删除配置，只是清空 state
      await _repository.set(_keyWorkingHoursEnabled, 'false');
      state = [];
    } else {
      // 启用：从 DB 重新加载配置
      await _repository.set(_keyWorkingHoursEnabled, 'true');
      await _loadFromDb();
    }
  }

  /// 获取保存的配置（即使禁用也返回）
  Future<List<TimeSegment>> getSavedSegments() async {
    final jsonStr = await _repository.get(_keyWorkingHours);
    if (jsonStr == null || jsonStr.isEmpty) return [];
    try {
      final list = jsonDecode(jsonStr) as List<dynamic>;
      return list
          .map((e) => TimeSegment.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<bool> getSavedEnabled() async {
    final enabledStr = await _repository.get(_keyWorkingHoursEnabled);
    return enabledStr == 'true';
  }
}
