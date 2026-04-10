import 'package:sqflite/sqflite.dart';

/// 通用基础数据仓库（动作、器械、工具共用）
class ItemRepository {
  final Database database;
  final String tableName;

  /// [tableName] 应为 'actions'、'equipments' 或 'tools'
  ItemRepository({required this.database, required this.tableName});

  /// 获取所有未弃用项
  Future<List<Map<String, dynamic>>> getAll() async {
    return await database.query(
      tableName,
      where: 'is_deprecated = ?',
      whereArgs: [0],
      orderBy: 'name ASC',
    );
  }

  /// 获取所有项（包括弃用）
  Future<List<Map<String, dynamic>>> getAllWithDeprecated() async {
    return await database.query(
      tableName,
      orderBy: 'is_deprecated ASC, name ASC',
    );
  }

  /// 根据ID获取
  Future<Map<String, dynamic>?> getById(int id) async {
    final results = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// 创建
  Future<int> create(String name) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert(tableName, {
      'name': name,
      'is_deprecated': 0,
      'created_at': now,
      'updated_at': now,
    });
  }

  /// 更新名称
  Future<bool> update(int id, String name) async {
    final count = await database.update(
      tableName,
      {
        'name': name,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 切换弃用状态
  Future<bool> toggleDeprecated(int id, bool isDeprecated) async {
    final count = await database.update(
      tableName,
      {
        'is_deprecated': isDeprecated ? 1 : 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 检查被引用次数
  /// [foreignKey] 应为 'action_id'、'equipment_id' 或 'tool_id'
  Future<int> checkUsage(int id, String foreignKey) async {
    final results = await database.query(
      'training_blocks',
      where: '$foreignKey = ?',
      whereArgs: [id],
    );
    return results.length;
  }

  /// 删除
  Future<bool> delete(int id) async {
    final count = await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 检查名称是否存在
  Future<bool> checkNameExists(String name, {int? excludeId}) async {
    final results = await database.query(
      tableName,
      where: 'name = ? ${excludeId != null ? 'AND id != ?' : ''}',
      whereArgs: excludeId != null ? [name, excludeId] : [name],
      limit: 1,
    );
    return results.isNotEmpty;
  }
}
