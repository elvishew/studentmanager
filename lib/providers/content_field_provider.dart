import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'student_provider.dart';
import 'states.dart';
import '../database/content_field_repository.dart';
import '../database/content_block_repository.dart';

part 'content_field_provider.g.dart';

/// ============================================
/// ContentFieldRepository Provider
/// ============================================

@riverpod
ContentFieldRepository contentFieldRepository(ContentFieldRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return ContentFieldRepository(database: database);
}

/// ============================================
/// ContentBlockRepository Provider
/// ============================================

@riverpod
ContentBlockRepository contentBlockRepository(ContentBlockRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return ContentBlockRepository(database: database);
}

/// ============================================
/// ContentFieldNotifier
/// ============================================

@riverpod
class ContentFieldNotifier extends _$ContentFieldNotifier {
  late final ContentFieldRepository _repository;

  @override
  List<ContentField> build() {
    _repository = ref.read(contentFieldRepositoryProvider);
    return [];
  }

  /// 加载所有字段及选项
  Future<List<ContentField>> loadFields() async {
    final fieldsMap = await _repository.getAllFieldsWithOptions();
    final fields = fieldsMap.map((map) {
      final options = (map['options'] as List?)
          ?.map((o) => FieldOption.fromMap(o as Map<String, dynamic>))
          .toList();
      return ContentField.fromMap(map).copyWith(options: options);
    }).toList();
    state = fields;
    return fields;
  }

  /// 创建字段（重名返回 null）
  Future<int?> createField({
    required String name,
    required String fieldType,
    required bool isRequired,
  }) async {
    if (await _repository.checkFieldNameExists(name)) return null;
    final maxOrder = await _repository.getMaxSortOrder();
    return await _repository.createField(
      name: name,
      fieldType: fieldType,
      isRequired: isRequired,
      sortOrder: maxOrder + 1,
    );
  }

  /// 更新字段（重名返回 false）
  Future<bool> updateField({
    required int id,
    required String name,
    required String fieldType,
    required bool isRequired,
  }) async {
    if (await _repository.checkFieldNameExists(name, excludeId: id)) return false;
    return await _repository.updateField(
      id: id,
      name: name,
      fieldType: fieldType,
      isRequired: isRequired,
    );
  }

  /// 切换字段弃用状态
  Future<bool> toggleFieldDeprecated(int id, bool isDeprecated) async {
    return await _repository.toggleFieldDeprecated(id, isDeprecated);
  }

  /// 删除字段
  Future<bool> deleteField(int id) async {
    return await _repository.deleteField(id);
  }

  /// 上移字段
  Future<void> moveFieldUp(int index) async {
    if (index <= 0) return;
    final fields = state;
    final field = fields[index];
    final prevField = fields[index - 1];
    await _repository.reorderField(field.id, prevField.sortOrder);
    await _repository.reorderField(prevField.id, field.sortOrder);
    await loadFields();
  }

  /// 下移字段
  Future<void> moveFieldDown(int index) async {
    if (index >= state.length - 1) return;
    final fields = state;
    final field = fields[index];
    final nextField = fields[index + 1];
    await _repository.reorderField(field.id, nextField.sortOrder);
    await _repository.reorderField(nextField.id, field.sortOrder);
    await loadFields();
  }
}

/// ============================================
/// ContentBlockNotifier
/// ============================================

@riverpod
class ContentBlockNotifier extends _$ContentBlockNotifier {
  late final ContentBlockRepository _repository;

  @override
  dynamic build() {
    _repository = ref.watch(contentBlockRepositoryProvider);
    return null;
  }

  /// 添加内容块
  Future<int?> addContentBlock({
    required int sessionId,
    required Map<int, String> values,
  }) async {
    return await _repository.addContentBlock(
      sessionId: sessionId,
      values: values,
    );
  }

  /// 更新内容块
  Future<void> updateContentBlock({
    required int blockId,
    required Map<int, String> values,
  }) async {
    await _repository.updateContentBlock(blockId: blockId, values: values);
  }

  /// 删除内容块
  Future<void> deleteContentBlock(int blockId) async {
    await _repository.deleteContentBlock(blockId);
  }

  /// 重新排序内容块
  Future<void> reorderContentBlock({
    required int blockId,
    required int newSortOrder,
  }) async {
    await _repository.reorderContentBlock(
      blockId: blockId,
      newSortOrder: newSortOrder,
    );
  }
}

/// ============================================
/// 字段选项 Notifier
/// ============================================

/// 删除结果枚举
enum DeleteItemResult {
  success,
  hasReferences,
  notFound,
  error,
}

/// 基础数据状态
enum BasicItemStatus { initial, loading, data, error }

class FieldOptionItem {
  final int id;
  final String name;
  final bool isDeprecated;

  const FieldOptionItem({
    required this.id,
    required this.name,
    required this.isDeprecated,
  });
}

class FieldOptionState {
  final BasicItemStatus status;
  final List<FieldOptionItem> items;
  final String searchQuery;
  final Object? error;
  final StackTrace? stackTrace;

  const FieldOptionState({
    this.status = BasicItemStatus.initial,
    this.items = const [],
    this.searchQuery = '',
    this.error,
    this.stackTrace,
  });

  FieldOptionState copyWith({
    BasicItemStatus? status,
    List<FieldOptionItem>? items,
    String? searchQuery,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return FieldOptionState(
      status: status ?? this.status,
      items: items ?? this.items,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

class FieldOptionNotifier extends StateNotifier<FieldOptionState> {
  final ContentFieldRepository repository;
  final int fieldId;

  FieldOptionNotifier({
    required this.repository,
    required this.fieldId,
  }) : super(const FieldOptionState());

  Future<void> fetchAll() async {
    state = state.copyWith(status: BasicItemStatus.loading);
    try {
      final maps = await repository.getFieldOptions(fieldId);
      final items = maps.map((m) => FieldOptionItem(
        id: m['id'] as int,
        name: m['value'] as String,
        isDeprecated: (m['is_deprecated'] ?? 0) == 1,
      )).toList();
      state = FieldOptionState(status: BasicItemStatus.data, items: items);
    } catch (e, st) {
      state = FieldOptionState(status: BasicItemStatus.error, error: e, stackTrace: st);
    }
  }

  void search(String query) {
    if (state.status != BasicItemStatus.data) return;
    final filtered = query.isEmpty
        ? state.items
        : state.items.where((i) => i.name.toLowerCase().contains(query.toLowerCase())).toList();
    state = state.copyWith(searchQuery: query, items: filtered);
  }

  Future<void> fetchAllAndSearch(String query) async {
    state = state.copyWith(status: BasicItemStatus.loading);
    try {
      final maps = await repository.getFieldOptions(fieldId);
      var items = maps.map((m) => FieldOptionItem(
        id: m['id'] as int,
        name: m['value'] as String,
        isDeprecated: (m['is_deprecated'] ?? 0) == 1,
      )).toList();
      if (query.isNotEmpty) {
        items = items.where((i) => i.name.toLowerCase().contains(query.toLowerCase())).toList();
      }
      state = FieldOptionState(status: BasicItemStatus.data, items: items, searchQuery: query);
    } catch (e, st) {
      state = FieldOptionState(status: BasicItemStatus.error, error: e, stackTrace: st);
    }
  }

  Future<int?> create(String name) async {
    try {
      if (await repository.checkOptionNameExists(fieldId, name)) return null;
      return await repository.createOption(contentFieldId: fieldId, value: name);
    } catch (_) {
      return null;
    }
  }

  Future<bool> update(int id, String name) async {
    try {
      if (await repository.checkOptionNameExists(fieldId, name, excludeId: id)) return false;
      return await repository.updateOption(id: id, value: name);
    } catch (_) {
      return false;
    }
  }

  Future<bool> toggleDeprecated(int id, bool isDeprecated) async {
    try {
      return await repository.toggleOptionDeprecated(id, isDeprecated);
    } catch (_) {
      return false;
    }
  }

  Future<DeleteItemResult> delete(int id) async {
    try {
      final item = await repository.getOptionById(id);
      if (item == null) return DeleteItemResult.notFound;
      final usageCount = await repository.checkOptionUsage(id);
      if (usageCount > 0) return DeleteItemResult.hasReferences;
      final success = await repository.deleteOption(id);
      return success ? DeleteItemResult.success : DeleteItemResult.error;
    } catch (_) {
      return DeleteItemResult.error;
    }
  }

  Future<bool> checkNameExists(String name, {int? excludeId}) async {
    return await repository.checkOptionNameExists(fieldId, name, excludeId: excludeId);
  }
}

/// ============================================
/// 课程目标 Notifier (moved from item_provider)
/// ============================================

class GoalItem extends FieldOptionItem {
  const GoalItem({
    required super.id,
    required super.name,
    required super.isDeprecated,
  });
}

class GoalItemState {
  final BasicItemStatus status;
  final List<GoalItem> items;
  final String searchQuery;
  final Object? error;
  final StackTrace? stackTrace;

  const GoalItemState({
    this.status = BasicItemStatus.initial,
    this.items = const [],
    this.searchQuery = '',
    this.error,
    this.stackTrace,
  });

  GoalItemState copyWith({
    BasicItemStatus? status,
    List<GoalItem>? items,
    String? searchQuery,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return GoalItemState(
      status: status ?? this.status,
      items: items ?? this.items,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

class GoalItemNotifier extends StateNotifier<GoalItemState> {
  final Database _db;

  GoalItemNotifier({required Database db}) : _db = db, super(const GoalItemState());

  Future<void> fetchAll() async {
    state = state.copyWith(status: BasicItemStatus.loading);
    try {
      final maps = await _db.query(
        'course_goals',
        orderBy: 'is_deprecated ASC, name ASC',
      );
      final items = maps
          .map((m) => GoalItem(
                id: m['id'] as int,
                name: m['name'] as String,
                isDeprecated: (m['is_deprecated'] ?? 0) == 1,
              ))
          .toList();
      state = GoalItemState(status: BasicItemStatus.data, items: items);
    } catch (e, st) {
      state = GoalItemState(status: BasicItemStatus.error, error: e, stackTrace: st);
    }
  }

  void search(String query) {
    if (state.status != BasicItemStatus.data) return;
    final filtered = query.isEmpty
        ? state.items
        : state.items.where((i) => i.name.toLowerCase().contains(query.toLowerCase())).toList();
    state = state.copyWith(searchQuery: query, items: filtered);
  }

  Future<void> fetchAllAndSearch(String query) async {
    state = state.copyWith(status: BasicItemStatus.loading);
    try {
      final maps = await _db.query(
        'course_goals',
        orderBy: 'is_deprecated ASC, name ASC',
      );
      var items = maps
          .map((m) => GoalItem(
                id: m['id'] as int,
                name: m['name'] as String,
                isDeprecated: (m['is_deprecated'] ?? 0) == 1,
              ))
          .toList();
      if (query.isNotEmpty) {
        items = items.where((i) => i.name.toLowerCase().contains(query.toLowerCase())).toList();
      }
      state = GoalItemState(status: BasicItemStatus.data, items: items, searchQuery: query);
    } catch (e, st) {
      state = GoalItemState(status: BasicItemStatus.error, error: e, stackTrace: st);
    }
  }

  Future<int?> create(String name) async {
    try {
      final existing = await _db.query(
        'course_goals',
        where: 'name = ?',
        whereArgs: [name],
        limit: 1,
      );
      if (existing.isNotEmpty) return null;
      final now = DateTime.now().toIso8601String();
      return await _db.insert('course_goals', {
        'name': name,
        'is_deprecated': 0,
        'created_at': now,
        'updated_at': now,
      });
    } catch (_) {
      return null;
    }
  }

  Future<bool> update(int id, String name) async {
    try {
      final existing = await _db.query(
        'course_goals',
        where: 'name = ? AND id != ?',
        whereArgs: [name, id],
        limit: 1,
      );
      if (existing.isNotEmpty) return false;
      final count = await _db.update(
        'course_goals',
        {'name': name, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [id],
      );
      return count > 0;
    } catch (_) {
      return false;
    }
  }

  Future<bool> toggleDeprecated(int id, bool isDeprecated) async {
    try {
      final count = await _db.update(
        'course_goals',
        {'is_deprecated': isDeprecated ? 1 : 0, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [id],
      );
      return count > 0;
    } catch (_) {
      return false;
    }
  }

  Future<int> checkUsage(int id) async {
    final results = await _db.query(
      'course_plans',
      where: 'goal_id = ?',
      whereArgs: [id],
    );
    return results.length;
  }

  Future<DeleteItemResult> delete(int id) async {
    try {
      final item = await _db.query(
        'course_goals',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (item.isEmpty) return DeleteItemResult.notFound;
      final usageCount = await checkUsage(id);
      if (usageCount > 0) return DeleteItemResult.hasReferences;
      final count = await _db.delete('course_goals', where: 'id = ?', whereArgs: [id]);
      return count > 0 ? DeleteItemResult.success : DeleteItemResult.error;
    } catch (_) {
      return DeleteItemResult.error;
    }
  }
}

/// 课程目标 Provider
final goalNotifierProvider = StateNotifierProvider.autoDispose<GoalItemNotifier, GoalItemState>((ref) {
  final db = ref.watch(databaseProvider);
  return GoalItemNotifier(db: db);
});

/// 获取所有未弃用的目标
@riverpod
Future<List<GoalItem>> activeGoals(ActiveGoalsRef ref) async {
  final db = ref.watch(databaseProvider);
  final maps = await db.query(
    'course_goals',
    where: 'is_deprecated = ?',
    whereArgs: [0],
    orderBy: 'name ASC',
  );
  return maps
      .map((m) => GoalItem(
            id: m['id'] as int,
            name: m['name'] as String,
            isDeprecated: false,
          ))
      .toList();
}
