import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/item_repository.dart';
import 'student_provider.dart';

/// 删除结果枚举
enum DeleteItemResult {
  success,
  hasReferences,
  notFound,
  error,
}

/// 基础数据项（动作、器械、工具共用的轻量模型）
class BasicItem {
  final int id;
  final String name;
  final bool isDeprecated;

  const BasicItem({
    required this.id,
    required this.name,
    required this.isDeprecated,
  });
}

/// 基础数据状态
enum BasicItemStatus { initial, loading, data, error }

class BasicItemState {
  final BasicItemStatus status;
  final List<BasicItem> items;
  final String searchQuery;
  final Object? error;
  final StackTrace? stackTrace;

  const BasicItemState({
    this.status = BasicItemStatus.initial,
    this.items = const [],
    this.searchQuery = '',
    this.error,
    this.stackTrace,
  });

  BasicItemState copyWith({
    BasicItemStatus? status,
    List<BasicItem>? items,
    String? searchQuery,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return BasicItemState(
      status: status ?? this.status,
      items: items ?? this.items,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// 通用基础数据 Notifier
class BasicItemNotifier extends StateNotifier<BasicItemState> {
  final ItemRepository repository;
  final String foreignKey;

  BasicItemNotifier({
    required this.repository,
    required this.foreignKey,
  }) : super(const BasicItemState());

  /// 获取所有（管理页面用，包含弃用）
  Future<void> fetchAll() async {
    state = state.copyWith(status: BasicItemStatus.loading);
    try {
      final maps = await repository.getAllWithDeprecated();
      final items = maps.map((m) => BasicItem(
        id: m['id'] as int,
        name: m['name'] as String,
        isDeprecated: (m['is_deprecated'] ?? 0) == 1,
      )).toList();
      state = BasicItemState(status: BasicItemStatus.data, items: items);
    } catch (e, st) {
      state = BasicItemState(status: BasicItemStatus.error, error: e, stackTrace: st);
    }
  }

  /// 搜索
  void search(String query) {
    if (state.status != BasicItemStatus.data) return;
    final filtered = query.isEmpty
        ? state.items
        : state.items.where((i) => i.name.toLowerCase().contains(query.toLowerCase())).toList();
    state = state.copyWith(searchQuery: query, items: filtered);
  }

  /// 重新加载（搜索后需要恢复全量数据再过滤）
  Future<void> fetchAllAndSearch(String query) async {
    state = state.copyWith(status: BasicItemStatus.loading);
    try {
      final maps = await repository.getAllWithDeprecated();
      var items = maps.map((m) => BasicItem(
        id: m['id'] as int,
        name: m['name'] as String,
        isDeprecated: (m['is_deprecated'] ?? 0) == 1,
      )).toList();
      if (query.isNotEmpty) {
        items = items.where((i) => i.name.toLowerCase().contains(query.toLowerCase())).toList();
      }
      state = BasicItemState(status: BasicItemStatus.data, items: items, searchQuery: query);
    } catch (e, st) {
      state = BasicItemState(status: BasicItemStatus.error, error: e, stackTrace: st);
    }
  }

  /// 创建
  Future<int?> create(String name) async {
    try {
      if (await repository.checkNameExists(name)) return null;
      return await repository.create(name);
    } catch (_) {
      return null;
    }
  }

  /// 更新
  Future<bool> update(int id, String name) async {
    try {
      if (await repository.checkNameExists(name, excludeId: id)) return false;
      return await repository.update(id, name);
    } catch (_) {
      return false;
    }
  }

  /// 切换弃用
  Future<bool> toggleDeprecated(int id, bool isDeprecated) async {
    try {
      return await repository.toggleDeprecated(id, isDeprecated);
    } catch (_) {
      return false;
    }
  }

  /// 删除（含引用检查）
  Future<DeleteItemResult> delete(int id) async {
    try {
      final item = await repository.getById(id);
      if (item == null) return DeleteItemResult.notFound;
      final usageCount = await repository.checkUsage(id, foreignKey);
      if (usageCount > 0) return DeleteItemResult.hasReferences;
      final success = await repository.delete(id);
      return success ? DeleteItemResult.success : DeleteItemResult.error;
    } catch (_) {
      return DeleteItemResult.error;
    }
  }

  /// 检查名称是否存在
  Future<bool> checkNameExists(String name, {int? excludeId}) async {
    return await repository.checkNameExists(name, excludeId: excludeId);
  }

  /// 检查引用次数
  Future<int> checkUsage(int id) async {
    return await repository.checkUsage(id, foreignKey);
  }
}

/// Provider 工厂：为每种类型创建独立的 notifier
final equipmentNotifierProvider = StateNotifierProvider.autoDispose<BasicItemNotifier, BasicItemState>((ref) {
  final db = ref.watch(databaseProvider);
  return BasicItemNotifier(
    repository: ItemRepository(database: db, tableName: 'equipments'),
    foreignKey: 'equipment_id',
  );
});

final toolNotifierProvider = StateNotifierProvider.autoDispose<BasicItemNotifier, BasicItemState>((ref) {
  final db = ref.watch(databaseProvider);
  return BasicItemNotifier(
    repository: ItemRepository(database: db, tableName: 'tools'),
    foreignKey: 'tool_id',
  );
});
