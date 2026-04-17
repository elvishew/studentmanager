import 'package:flutter/material.dart';
import 'package:student_manager/l10n/app_localizations.dart';

/// 付费记录列表项
class PaymentListTile extends StatelessWidget {
  final String? description;
  final String? courseTypeName;
  final DateTime paidAt;
  final double amount;
  final double? commissionEarned;

  const PaymentListTile({
    super.key,
    this.description,
    this.courseTypeName,
    required this.paidAt,
    required this.amount,
    this.commissionEarned,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    final title = description ?? courseTypeName ?? s.paymentDefaultTitle;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE8F5E9),
          child: Icon(Icons.payment, color: Colors.green, size: 20),
        ),
        title: Text(title),
        subtitle: Text(
          '${paidAt.year}-${paidAt.month.toString().padLeft(2, '0')}-${paidAt.day.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '¥${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (commissionEarned != null && commissionEarned! > 0)
              Text(
                s.commissionDisplay(commissionEarned!.toStringAsFixed(2)),
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
