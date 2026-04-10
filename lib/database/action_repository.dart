import 'package:sqflite/sqflite.dart';

/// 动作仓库
class ActionRepository {
  final Database database;

  ActionRepository({required this.database});

  /// 获取所有动作（未弃用）
  Future<List<Map<String, dynamic>>> getAll() async {
    return await database.query(
      'actions',
      where: 'is_deprecated = ?',
      whereArgs: [0],
      orderBy: 'name ASC',
    );
  }

  /// 获取所有动作（包括弃用）
  Future<List<Map<String, dynamic>>> getAllWithDeprecated() async {
    return await database.query(
      'actions',
      orderBy: 'is_deprecated ASC, name ASC',
    );
  }

  /// 根据ID获取动作
  Future<Map<String, dynamic>?> getById(int id) async {
    final results = await database.query(
      'actions',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// 创建动作
  Future<int> create(String name) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert(
      'actions',
      {
        'name': name,
        'is_deprecated': 0,
        'created_at': now,
        'updated_at': now,
      },
    );
  }

  /// 更新动作
  Future<bool> update(int id, String name) async {
    final count = await database.update(
      'actions',
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
      'actions',
      {
        'is_deprecated': isDeprecated ? 1 : 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 检查是否被引用
  Future<int> checkUsage(int actionId) async {
    final results = await database.query(
      'training_blocks',
      where: 'action_id = ?',
      whereArgs: [actionId],
    );
    return results.length;
  }

  /// 删除动作
  Future<bool> delete(int id) async {
    final count = await database.delete(
      'actions',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 检查名称是否存在（排除指定ID）
  Future<bool> checkNameExists(String name, {int? excludeId}) async {
    final results = await database.query(
      'actions',
      where: 'name = ? ${excludeId != null ? 'AND id != ?' : ''}',
      whereArgs: excludeId != null ? [name, excludeId] : [name],
      limit: 1,
    );
    return results.isNotEmpty;
  }
}
