import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'student_provider.dart';
import 'states.dart' as models;
import '../database/action_repository.dart';

part 'action_provider.g.dart';

/// 删除动作结果枚举
enum DeleteActionResult {
  success,           // 删除成功
  hasReferences,     // 有引用，建议弃用
  notFound,          // 动作不存在
  error,             // 其他错误
}

/// ============================================
/// Action Repository Provider
/// ============================================

@riverpod
ActionRepository actionRepository(ActionRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return ActionRepository(database: database);
}

/// ============================================
/// Action Notifier
/// ============================================

@riverpod
class ActionNotifier extends _$ActionNotifier {
  late final ActionRepository _repository;

  @override
  models.ActionState build() {
    _repository = ref.watch(actionRepositoryProvider);
    return const models.ActionState.initial();
  }

  /// ============================================
  /// 获取所有动作（管理页面用，包含弃用）
  /// ============================================

  Future<void> fetchAll() async {
    state = const models.ActionState.loading();

    try {
      final maps = await _repository.getAllWithDeprecated();
      final actions = maps.map((map) => models.Action.fromMap(map)).toList();

      state = models.ActionState.data(
        actions: actions,
        searchQuery: '',
      );
    } catch (e, stackTrace) {
      state = models.ActionState.error(e, stackTrace);
    }
  }

  /// 获取未弃用动作（训练块选择用）
  Future<void> fetchActive() async {
    state = const models.ActionState.loading();

    try {
      final maps = await _repository.getAll();
      final actions = maps.map((map) => models.Action.fromMap(map)).toList();

      state = models.ActionState.data(
        actions: actions,
        searchQuery: '',
      );
    } catch (e, stackTrace) {
      state = models.ActionState.error(e, stackTrace);
    }
  }

  /// 搜索动作
  void search(String query) {
    state.maybeWhen(
      data: (actions, searchQuery) {
        state = models.ActionState.data(
          actions: actions,
          searchQuery: query,
        );
      },
      orElse: () {},
    );
  }

  /// 创建动作
  Future<int?> create(String name) async {
    try {
      // 检查名称是否已存在
      final exists = await _repository.checkNameExists(name);
      if (exists) {
        return null;
      }

      final id = await _repository.create(name);

      // 刷新列表
      await fetchAll();

      return id;
    } catch (e) {
      return null;
    }
  }

  /// 更新动作
  Future<bool> update(int id, String name) async {
    try {
      // 检查名称是否已存在（排除自己）
      final exists = await _repository.checkNameExists(name, excludeId: id);
      if (exists) {
        return false;
      }

      final success = await _repository.update(id, name);

      // 刷新列表
      if (success) {
        await fetchAll();
      }

      return success;
    } catch (e) {
      return false;
    }
  }

  /// 切换弃用状态
  Future<bool> toggleDeprecated(int id, bool isDeprecated) async {
    try {
      final success = await _repository.toggleDeprecated(id, isDeprecated);

      // 刷新列表
      if (success) {
        await fetchAll();
      }

      return success;
    } catch (e) {
      return false;
    }
  }

  /// 删除动作（包含引用检查）
  Future<DeleteActionResult> delete(int id) async {
    try {
      // 检查动作是否存在
      final action = await _repository.getById(id);
      if (action == null) {
        return DeleteActionResult.notFound;
      }

      // 检查是否有引用
      final usageCount = await _repository.checkUsage(id);
      if (usageCount > 0) {
        return DeleteActionResult.hasReferences;
      }

      // 无引用，可以删除
      final success = await _repository.delete(id);
      if (success) {
        // 刷新列表
        await fetchAll();
        return DeleteActionResult.success;
      }

      return DeleteActionResult.error;
    } catch (e) {
      return DeleteActionResult.error;
    }
  }

  /// 检查动作名称是否存在
  Future<bool> checkNameExists(String name, {int? excludeId}) async {
    return await _repository.checkNameExists(name, excludeId: excludeId);
  }

  /// 检查动作是否被引用
  Future<int> checkUsage(int actionId) async {
    return await _repository.checkUsage(actionId);
  }
}
