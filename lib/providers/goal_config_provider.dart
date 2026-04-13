import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'states.dart';
import 'student_provider.dart';
import '../database/course_plan_repository.dart';

part 'goal_config_provider.g.dart';

/// ============================================
/// CoursePlanRepository Provider
/// ============================================

@riverpod
CoursePlanRepository coursePlanRepository(CoursePlanRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return CoursePlanRepository(database: database);
}

/// ============================================
/// GoalConfig Notifier
/// ============================================

@riverpod
class GoalConfigNotifier extends _$GoalConfigNotifier {
  late final CoursePlanRepository _repository;

  @override
  GoalConfigState build() {
    _repository = ref.watch(coursePlanRepositoryProvider);
    return const GoalConfigState.initial();
  }

  Future<void> fetchAll() async {
    state = const GoalConfigState.loading();

    try {
      final maps = await _repository.fetchAllGoalConfigs();
      final configs = maps.map((map) => GoalConfig.fromMap(map)).toList();
      state = GoalConfigState.data(goalConfigs: configs);
    } catch (e, stackTrace) {
      state = GoalConfigState.error(e, stackTrace);
    }
  }

  Future<GoalConfig?> fetchDetail(int id) async {
    try {
      final map = await _repository.fetchGoalConfigDetail(id);
      if (map == null) return null;

      final config = GoalConfig.fromMap(map);

      final sessions = (map['sessions'] as List).map((s) {
        final session = GoalConfigSession.fromMap(s as Map<String, dynamic>);

        final blocks = (s['content_blocks'] as List).map((b) {
          final blockMap = b as Map<String, dynamic>;
          final block = GoalConfigContentBlock.fromMap(blockMap);
          final valuesList = blockMap['values'] as List;
          final values = <int, String>{};
          for (final v in valuesList) {
            values[v['content_field_id'] as int] = v['value'] as String? ?? '';
          }
          return block.copyWith(values: values);
        }).toList();

        return session.copyWith(contentBlocks: blocks);
      }).toList();

      return config.copyWith(sessions: sessions);
    } catch (e) {
      return null;
    }
  }

  Future<int> upsertConfig({
    required int goalId,
    String? blueprint,
  }) async {
    final id = await _repository.upsertGoalConfig(goalId, blueprint);
    await fetchAll();
    return id;
  }

  Future<void> deleteConfig(int id) async {
    await _repository.deleteGoalConfig(id);
    await fetchAll();
  }

  Future<bool> cleanIfEmpty(int goalConfigId) async {
    final detail = await fetchDetail(goalConfigId);
    if (detail == null) return true;

    final hasBlueprint = detail.blueprint != null && detail.blueprint!.trim().isNotEmpty;
    final hasSessions = detail.sessions != null && detail.sessions!.isNotEmpty;

    if (!hasBlueprint && !hasSessions) {
      await deleteConfig(goalConfigId);
      return true;
    }
    return false;
  }

  Future<int> addSession({
    required int goalConfigId,
    required int sessionNumber,
  }) async {
    return await _repository.addGoalConfigSession(goalConfigId, sessionNumber);
  }

  Future<void> deleteSession(int id) async {
    await _repository.deleteGoalConfigSession(id);
  }

  /// 新增内容块模板
  Future<int> addBlock({
    required int goalConfigSessionId,
    required Map<int, String> values,
  }) async {
    final maxOrder = await _repository.getMaxSortOrder(goalConfigSessionId);
    return await _repository.addGoalConfigContentBlock(
      goalConfigSessionId: goalConfigSessionId,
      values: values,
    );
  }

  /// 更新内容块模板
  Future<void> updateBlock({
    required int id,
    required Map<int, String> values,
  }) async {
    await _repository.updateGoalConfigContentBlock(id: id, values: values);
  }

  /// 删除内容块模板
  Future<void> deleteBlock(int id) async {
    await _repository.deleteGoalConfigContentBlock(id);
  }

  /// 调整内容块模板排序
  Future<void> reorderBlock({
    required int blockId,
    required int newSortOrder,
  }) async {
    await _repository.reorderGoalConfigContentBlock(
      blockId: blockId,
      newSortOrder: newSortOrder,
    );
  }
}
