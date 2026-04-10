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

  /// 获取所有课程目标配置
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

  /// 获取配置详情（含 sessions + training blocks）
  Future<GoalConfig?> fetchDetail(int id) async {
    try {
      final map = await _repository.fetchGoalConfigDetail(id);
      if (map == null) return null;

      final config = GoalConfig.fromMap(map);

      final sessions = (map['sessions'] as List).map((s) {
        final session = GoalConfigSession.fromMap(s as Map<String, dynamic>);

        final blocks = (s['training_blocks'] as List).map((b) {
          final block = GoalConfigTrainingBlock.fromMap(b as Map<String, dynamic>);
          return block.copyWith(
            action: b['action_name'] != null
                ? Action(
                    id: b['action_id'] as int? ?? 0,
                    name: b['action_name'] as String,
                    isDeprecated: (b['action_deprecated'] as int? ?? 0) == 1,
                    createdAt: block.createdAt,
                    updatedAt: block.updatedAt,
                  )
                : null,
            equipment: b['equipment_name'] != null
                ? Equipment(
                    id: b['equipment_id'] as int? ?? 0,
                    name: b['equipment_name'] as String,
                    isDeprecated: (b['equipment_deprecated'] as int? ?? 0) == 1,
                    createdAt: block.createdAt,
                    updatedAt: block.updatedAt,
                  )
                : null,
            tool: b['tool_name'] != null
                ? Tool(
                    id: b['tool_id'] as int? ?? 0,
                    name: b['tool_name'] as String,
                    isDeprecated: (b['tool_deprecated'] as int? ?? 0) == 1,
                    createdAt: block.createdAt,
                    updatedAt: block.updatedAt,
                  )
                : null,
          );
        }).toList();

        return session.copyWith(trainingBlocks: blocks);
      }).toList();

      return config.copyWith(sessions: sessions);
    } catch (e) {
      return null;
    }
  }

  /// 新增或更新配置
  Future<int> upsertConfig({
    required String goal,
    String? blueprint,
  }) async {
    final id = await _repository.upsertGoalConfig(goal, blueprint);
    await fetchAll();
    return id;
  }

  /// 删除配置
  Future<void> deleteConfig(int id) async {
    await _repository.deleteGoalConfig(id);
    await fetchAll();
  }

  /// 清理空配置：蓝图为空且无课时模板时，删除整条记录
  /// 返回 true 表示已删除，false 表示保留
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

  /// 新增课时模板
  Future<int> addSession({
    required int goalConfigId,
    required int sessionNumber,
  }) async {
    return await _repository.addGoalConfigSession(goalConfigId, sessionNumber);
  }

  /// 删除课时模板
  Future<void> deleteSession(int id) async {
    await _repository.deleteGoalConfigSession(id);
  }

  /// 新增训练块模板
  Future<int> addBlock({
    required int goalConfigSessionId,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
    bool isCustom = false,
  }) async {
    final maxOrder = await _repository.getMaxSortOrder(goalConfigSessionId);
    return await _repository.addGoalConfigTrainingBlock(
      goalConfigSessionId: goalConfigSessionId,
      actionId: actionId,
      equipmentId: equipmentId,
      toolId: toolId,
      reps: reps,
      sets: sets,
      duration: duration,
      intensity: intensity,
      notes: notes,
      isCustom: isCustom,
      sortOrder: maxOrder + 1,
    );
  }

  /// 更新训练块模板
  Future<void> updateBlock({
    required int id,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
    bool? isCustom,
  }) async {
    await _repository.updateGoalConfigTrainingBlock(
      id: id,
      actionId: actionId,
      equipmentId: equipmentId,
      toolId: toolId,
      reps: reps,
      sets: sets,
      duration: duration,
      intensity: intensity,
      notes: notes,
      isCustom: isCustom,
    );
  }

  /// 删除训练块模板
  Future<void> deleteBlock(int id) async {
    await _repository.deleteGoalConfigTrainingBlock(id);
  }

  /// 调整训练块模板排序
  Future<void> reorderBlock({
    required int blockId,
    required int newSortOrder,
  }) async {
    await _repository.reorderGoalConfigTrainingBlock(
      blockId: blockId,
      newSortOrder: newSortOrder,
    );
  }
}
