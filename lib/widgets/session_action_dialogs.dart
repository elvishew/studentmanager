import 'package:flutter/material.dart';

/// 显示确认操作对话框
Future<bool?> showConfirmActionDialog(
  BuildContext context, {
  required String title,
  required String content,
  String confirmText = '确认',
  bool isDangerous = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: Icon(
        Icons.warning_amber_rounded,
        color: isDangerous ? Colors.red : Colors.orange,
        size: 48,
      ),
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDangerous ? Colors.red : null,
            foregroundColor: isDangerous ? Colors.white : null,
          ),
          child: Text(confirmText),
        ),
      ],
    ),
  );
}

/// 选择日期时间
///
/// 返回选中的 DateTime 或 null
Future<DateTime?> selectDateTime(BuildContext context) async {
  // 选择日期
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(const Duration(days: 365)),
    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
  );

  if (date == null) return null;

  // 选择时间
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (time == null) return null;

  // 组合日期和时间
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}
