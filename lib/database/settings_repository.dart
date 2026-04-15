import 'package:sqflite/sqflite.dart';

/// 通用设置仓库（key-value 读写 app_settings 表）
class SettingsRepository {
  final Database database;

  SettingsRepository({required this.database});

  Future<String?> get(String key) async {
    final results = await database.query(
      'app_settings',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );
    if (results.isEmpty) return null;
    return results.first['value'] as String?;
  }

  Future<void> set(String key, String value) async {
    final now = DateTime.now().toIso8601String();
    final existing = await database.query(
      'app_settings',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );

    if (existing.isNotEmpty) {
      await database.update(
        'app_settings',
        {'value': value, 'updated_at': now},
        where: 'key = ?',
        whereArgs: [key],
      );
    } else {
      await database.insert('app_settings', {
        'key': key,
        'value': value,
        'created_at': now,
        'updated_at': now,
      });
    }
  }

  Future<void> remove(String key) async {
    await database.delete(
      'app_settings',
      where: 'key = ?',
      whereArgs: [key],
    );
  }
}
