import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'states.dart';
import 'student_provider.dart';
import '../database/payment_repository.dart';

part 'payment_provider.g.dart';

/// ============================================
/// PaymentRepository Provider
/// ============================================

@Riverpod(keepAlive: true)
PaymentRepository paymentRepository(PaymentRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return PaymentRepository(database: database);
}

/// ============================================
/// PaymentNotifier
/// ============================================

@Riverpod(keepAlive: true)
class PaymentNotifier extends _$PaymentNotifier {
  late final PaymentRepository _repository;

  @override
  PaymentState build() {
    _repository = ref.watch(paymentRepositoryProvider);
    return const PaymentState.initial();
  }

  /// 按学员查询付费记录
  Future<void> fetchByStudentId(int studentId) async {
    state = const PaymentState.loading();
    try {
      final maps = await _repository.getByStudentId(studentId);
      final payments = maps.map((m) => StudentPayment.fromMap(m)).toList();
      state = PaymentState.data(payments: payments);
    } catch (e, st) {
      state = PaymentState.error(e, st);
    }
  }

  /// 创建付费记录
  Future<int?> create({
    required int studentId,
    int? courseTypeId,
    int? coursePlanId,
    double amount = 0,
    String? description,
    CommissionType commissionType = CommissionType.none,
    double commissionValue = 0,
    required DateTime paidAt,
    String? notes,
  }) async {
    try {
      // 计算教师提成
      double commissionEarned = 0;
      if (commissionType == CommissionType.fixed) {
        commissionEarned = commissionValue;
      } else if (commissionType == CommissionType.percent) {
        commissionEarned = amount * commissionValue / 100;
      }

      final id = await _repository.create(
        studentId: studentId,
        courseTypeId: courseTypeId,
        coursePlanId: coursePlanId,
        amount: amount,
        description: description,
        commissionType: commissionType.value,
        commissionValue: commissionValue,
        commissionEarned: commissionEarned,
        paidAt: paidAt.toIso8601String(),
        notes: notes,
      );
      return id;
    } catch (e, st) {
      state = PaymentState.error(e, st);
      return null;
    }
  }

  /// 更新付费记录
  Future<bool> update({
    required int id,
    double? amount,
    String? description,
    CommissionType? commissionType,
    double? commissionValue,
    DateTime? paidAt,
    String? notes,
  }) async {
    try {
      // 如果金额或提成变了，重新计算
      double? commissionEarned;
      if (commissionType != null && commissionValue != null && amount != null) {
        if (commissionType == CommissionType.fixed) {
          commissionEarned = commissionValue;
        } else if (commissionType == CommissionType.percent) {
          commissionEarned = amount * commissionValue / 100;
        } else {
          commissionEarned = 0;
        }
      }

      final success = await _repository.update(
        id: id,
        amount: amount,
        description: description,
        commissionType: commissionType?.value,
        commissionValue: commissionValue,
        commissionEarned: commissionEarned,
        paidAt: paidAt?.toIso8601String(),
        notes: notes,
      );
      return success;
    } catch (e, st) {
      state = PaymentState.error(e, st);
      return false;
    }
  }

  /// 删除付费记录
  Future<bool> delete(int id) async {
    try {
      return await _repository.delete(id);
    } catch (e, st) {
      state = PaymentState.error(e, st);
      return false;
    }
  }

  /// 获取学员总付费金额
  Future<double> getTotalByStudent(int studentId) async {
    try {
      return await _repository.getTotalPaymentByStudent(studentId);
    } catch (e) {
      return 0;
    }
  }
}
