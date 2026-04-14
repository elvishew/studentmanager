import 'package:sqflite/sqflite.dart';

/// 课程类型仓库
class CourseTypeRepository {
  final Database database;

  CourseTypeRepository({required this.database});

  /// 获取所有课程类型（未弃用，按排序号）
  Future<List<Map<String, dynamic>>> getAll() async {
    return await database.query(
      'course_types',
      where: 'is_deprecated = 0',
      orderBy: 'sort_order ASC, id ASC',
    );
  }

  /// 获取所有课程类型（包括弃用的）
  Future<List<Map<String, dynamic>>> getAllIncludingDeprecated() async {
    return await database.query(
      'course_types',
      orderBy: 'sort_order ASC, id ASC',
    );
  }

  /// 根据 ID 获取
  Future<Map<String, dynamic>?> getById(int id) async {
    final results = await database.query(
      'course_types',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// 创建课程类型
  Future<int> create({
    required String name,
    String? icon,
    String? color,
    int defaultDuration = 60,
    bool isGroup = false,
    int? maxStudents,
    double defaultStudentPrice = 0,
    double defaultSessionFee = 0,
    String defaultCommissionType = 'none',
    double defaultCommissionValue = 0,
    int sortOrder = 0,
  }) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert('course_types', {
      'name': name,
      'icon': icon,
      'color': color,
      'default_duration': defaultDuration,
      'is_group': isGroup ? 1 : 0,
      'max_students': maxStudents,
      'default_student_price': defaultStudentPrice,
      'default_session_fee': defaultSessionFee,
      'default_commission_type': defaultCommissionType,
      'default_commission_value': defaultCommissionValue,
      'sort_order': sortOrder,
      'is_deprecated': 0,
      'created_at': now,
      'updated_at': now,
    });
  }

  /// 更新课程类型
  Future<bool> update({
    required int id,
    String? name,
    String? icon,
    String? color,
    int? defaultDuration,
    bool? isGroup,
    int? maxStudents,
    double? defaultStudentPrice,
    double? defaultSessionFee,
    String? defaultCommissionType,
    double? defaultCommissionValue,
    int? sortOrder,
  }) async {
    final data = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (name != null) data['name'] = name;
    if (icon != null) data['icon'] = icon;
    if (color != null) data['color'] = color;
    if (defaultDuration != null) data['default_duration'] = defaultDuration;
    if (isGroup != null) data['is_group'] = isGroup ? 1 : 0;
    if (maxStudents != null) data['max_students'] = maxStudents;
    if (defaultStudentPrice != null) data['default_student_price'] = defaultStudentPrice;
    if (defaultSessionFee != null) data['default_session_fee'] = defaultSessionFee;
    if (defaultCommissionType != null) data['default_commission_type'] = defaultCommissionType;
    if (defaultCommissionValue != null) data['default_commission_value'] = defaultCommissionValue;
    if (sortOrder != null) data['sort_order'] = sortOrder;

    final count = await database.update(
      'course_types',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 弃用/恢复课程类型
  Future<bool> toggleDeprecated(int id, bool isDeprecated) async {
    final count = await database.update(
      'course_types',
      {
        'is_deprecated': isDeprecated ? 1 : 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 删除课程类型
  Future<bool> delete(int id) async {
    final count = await database.delete(
      'course_types',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 检查名称是否已存在
  Future<bool> checkNameExists(String name, {int? excludeId}) async {
    final results = await database.query(
      'course_types',
      where: 'name = ? ${excludeId != null ? 'AND id != ?' : ''}',
      whereArgs: excludeId != null ? [name, excludeId] : [name],
      limit: 1,
    );
    return results.isNotEmpty;
  }

  /// 获取最大排序号
  Future<int> getMaxSortOrder() async {
    final results = await database.rawQuery(
      'SELECT COALESCE(MAX(sort_order), -1) as max_order FROM course_types',
    );
    return (results.first['max_order'] as int?) ?? -1;
  }
}
