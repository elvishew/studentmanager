import 'package:sqflite/sqflite.dart';

/// 学员付费仓库
class PaymentRepository {
  final Database database;

  PaymentRepository({required this.database});

  /// 创建付费记录
  Future<int> create({
    required int studentId,
    int? courseTypeId,
    int? coursePlanId,
    double amount = 0,
    String? description,
    String commissionType = 'none',
    double commissionValue = 0,
    double commissionEarned = 0,
    required String paidAt,
    String? notes,
  }) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert('student_payments', {
      'student_id': studentId,
      'course_type_id': courseTypeId,
      'course_plan_id': coursePlanId,
      'amount': amount,
      'description': description,
      'commission_type': commissionType,
      'commission_value': commissionValue,
      'commission_earned': commissionEarned,
      'paid_at': paidAt,
      'notes': notes,
      'created_at': now,
      'updated_at': now,
    });
  }

  /// 更新付费记录
  Future<bool> update({
    required int id,
    double? amount,
    String? description,
    String? commissionType,
    double? commissionValue,
    double? commissionEarned,
    String? paidAt,
    String? notes,
  }) async {
    final data = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (amount != null) data['amount'] = amount;
    if (description != null) data['description'] = description;
    if (commissionType != null) data['commission_type'] = commissionType;
    if (commissionValue != null) data['commission_value'] = commissionValue;
    if (commissionEarned != null) data['commission_earned'] = commissionEarned;
    if (paidAt != null) data['paid_at'] = paidAt;
    if (notes != null) data['notes'] = notes;

    final count = await database.update(
      'student_payments',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 删除付费记录
  Future<bool> delete(int id) async {
    final count = await database.delete(
      'student_payments',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// 查询学员的付费记录
  Future<List<Map<String, dynamic>>> getByStudentId(int studentId) async {
    return await database.rawQuery('''
      SELECT sp.*, ct.name as course_type_name
      FROM student_payments sp
      LEFT JOIN course_types ct ON sp.course_type_id = ct.id
      WHERE sp.student_id = ?
      ORDER BY sp.paid_at DESC
    ''', [studentId]);
  }

  /// 查询付费记录详情
  Future<Map<String, dynamic>?> getById(int id) async {
    final results = await database.rawQuery('''
      SELECT sp.*, s.name as student_name, ct.name as course_type_name
      FROM student_payments sp
      LEFT JOIN students s ON sp.student_id = s.id
      LEFT JOIN course_types ct ON sp.course_type_id = ct.id
      WHERE sp.id = ?
    ''', [id]);
    return results.isNotEmpty ? results.first : null;
  }

  /// 按日期范围查询所有付费记录
  Future<List<Map<String, dynamic>>> getByDateRange(String startDate, String endDate) async {
    return await database.rawQuery('''
      SELECT sp.*, s.name as student_name, ct.name as course_type_name
      FROM student_payments sp
      LEFT JOIN students s ON sp.student_id = s.id
      LEFT JOIN course_types ct ON sp.course_type_id = ct.id
      WHERE sp.paid_at >= ? AND sp.paid_at < ?
      ORDER BY sp.paid_at DESC
    ''', [startDate, endDate]);
  }

  /// ============================================
  /// 统计查询
  /// ============================================

  /// 按日期范围统计学员付费总额
  Future<double> getTotalPaymentAmount(String startDate, String endDate) async {
    final results = await database.rawQuery('''
      SELECT COALESCE(SUM(amount), 0) as total FROM student_payments
      WHERE paid_at >= ? AND paid_at < ?
    ''', [startDate, endDate]);
    return (results.first['total'] as num?)?.toDouble() ?? 0;
  }

  /// 按日期范围统计教师提成总额
  Future<double> getTotalCommissionEarned(String startDate, String endDate) async {
    final results = await database.rawQuery('''
      SELECT COALESCE(SUM(commission_earned), 0) as total FROM student_payments
      WHERE paid_at >= ? AND paid_at < ?
    ''', [startDate, endDate]);
    return (results.first['total'] as num?)?.toDouble() ?? 0;
  }

  /// 统计学员总付费金额
  Future<double> getTotalPaymentByStudent(int studentId) async {
    final results = await database.rawQuery('''
      SELECT COALESCE(SUM(amount), 0) as total FROM student_payments
      WHERE student_id = ?
    ''', [studentId]);
    return (results.first['total'] as num?)?.toDouble() ?? 0;
  }

  /// 按周/月统计收入趋势
  Future<List<Map<String, dynamic>>> getIncomeTrend(String startDate, String endDate, {String groupBy = 'month'}) async {
    final dateFormat = groupBy == 'week'
        ? "strftime('%Y-W%W', paid_at)"
        : "strftime('%Y-%m', paid_at)";

    return await database.rawQuery('''
      SELECT
        $dateFormat as label,
        COALESCE(SUM(commission_earned), 0) as commission_income
      FROM student_payments
      WHERE paid_at >= ? AND paid_at < ?
      GROUP BY $dateFormat
      ORDER BY label ASC
    ''', [startDate, endDate]);
  }
}
