import 'package:sqflite/sqflite.dart';

/// 内容字段仓库
class ContentFieldRepository {
  final Database database;

  ContentFieldRepository({required this.database});

  /// 获取所有字段（按 sort_order）
  Future<List<Map<String, dynamic>>> getAllFields() async {
    return await database.query(
      'content_fields',
      orderBy: 'sort_order ASC',
    );
  }

  /// 获取所有字段（含选项）
  Future<List<Map<String, dynamic>>> getAllFieldsWithOptions() async {
    final fields = await getAllFields();
    final result = <Map<String, dynamic>>[];
    for (final field in fields) {
      final fieldId = field['id'] as int;
      final options = await database.query(
        'field_options',
        where: 'content_field_id = ? AND is_deprecated = 0',
        whereArgs: [fieldId],
        orderBy: 'value ASC',
      );
      result.add(Map<String, dynamic>.from(field)..['options'] = options);
    }
    return result;
  }

  /// 获取指定字段的选项
  Future<List<Map<String, dynamic>>> getFieldOptions(int fieldId) async {
    return await database.query(
      'field_options',
      where: 'content_field_id = ?',
      whereArgs: [fieldId],
      orderBy: 'value ASC',
    );
  }

  /// 获取指定字段的未弃用选项
  Future<List<Map<String, dynamic>>> getActiveFieldOptions(int fieldId) async {
    return await database.query(
      'field_options',
      where: 'content_field_id = ? AND is_deprecated = 0',
      whereArgs: [fieldId],
      orderBy: 'value ASC',
    );
  }

  /// 获取单个字段
  Future<Map<String, dynamic>?> getFieldById(int id) async {
    final results = await database.query(
      'content_fields',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// 创建字段
  Future<int> createField({
    required String name,
    required String fieldType,
    required bool isRequired,
    int sortOrder = 0,
  }) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert('content_fields', {
      'name': name,
      'field_type': fieldType,
      'is_required': isRequired ? 1 : 0,
      'sort_order': sortOrder,
      'is_deprecated': 0,
      'created_at': now,
      'updated_at': now,
    });
  }

  /// 更新字段
  Future<bool> updateField({
    required int id,
    required String name,
    required String fieldType,
    required bool isRequired,
  }) async {
    final count = await database.update(
      'content_fields',
      {
        'name': name,
        'field_type': fieldType,
        'is_required': isRequired ? 1 : 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 切换字段弃用状态
  Future<bool> toggleFieldDeprecated(int id, bool isDeprecated) async {
    final count = await database.update(
      'content_fields',
      {
        'is_deprecated': isDeprecated ? 1 : 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 删除字段
  Future<bool> deleteField(int id) async {
    final count = await database.delete(
      'content_fields',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 检查字段是否被内容块引用
  Future<int> checkFieldUsage(int fieldId) async {
    final results = await database.query(
      'content_block_values',
      where: 'content_field_id = ?',
      whereArgs: [fieldId],
      limit: 1,
    );
    return results.length;
  }

  /// 重新排序字段
  Future<void> reorderField(int id, int newSortOrder) async {
    await database.update(
      'content_fields',
      {
        'sort_order': newSortOrder,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 获取字段最大排序号
  Future<int> getMaxSortOrder() async {
    final results = await database.rawQuery(
      'SELECT COALESCE(MAX(sort_order), -1) as max_order FROM content_fields',
    );
    return (results.first['max_order'] as int?) ?? -1;
  }

  /// ============================================
  /// 字段选项 CRUD
  /// ============================================

  /// 创建选项
  Future<int> createOption({
    required int contentFieldId,
    required String value,
  }) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert('field_options', {
      'content_field_id': contentFieldId,
      'value': value,
      'is_deprecated': 0,
      'created_at': now,
      'updated_at': now,
    });
  }

  /// 更新选项
  Future<bool> updateOption({
    required int id,
    required String value,
  }) async {
    final count = await database.update(
      'field_options',
      {
        'value': value,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 切换选项弃用状态
  Future<bool> toggleOptionDeprecated(int id, bool isDeprecated) async {
    final count = await database.update(
      'field_options',
      {
        'is_deprecated': isDeprecated ? 1 : 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 删除选项
  Future<bool> deleteOption(int id) async {
    final count = await database.delete(
      'field_options',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 检查选项是否被引用
  Future<int> checkOptionUsage(int optionId) async {
    // 检查 content_block_values 中是否使用了这个选项值
    final option = await database.query(
      'field_options',
      where: 'id = ?',
      whereArgs: [optionId],
      limit: 1,
    );
    if (option.isEmpty) return 0;

    final value = option.first['value'] as String;
    final fieldId = option.first['content_field_id'] as int;

    final results = await database.query(
      'content_block_values',
      where: 'content_field_id = ? AND value = ?',
      whereArgs: [fieldId, value],
      limit: 1,
    );
    return results.length;
  }

  /// 检查选项名称是否已存在
  Future<bool> checkOptionNameExists(int fieldId, String value, {int? excludeId}) async {
    final results = await database.query(
      'field_options',
      where: 'content_field_id = ? AND value = ? ${excludeId != null ? 'AND id != ?' : ''}',
      whereArgs: excludeId != null ? [fieldId, value, excludeId] : [fieldId, value],
      limit: 1,
    );
    return results.isNotEmpty;
  }

  /// 获取单个选项
  Future<Map<String, dynamic>?> getOptionById(int id) async {
    final results = await database.query(
      'field_options',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }
}
