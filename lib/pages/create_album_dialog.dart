import 'package:flutter/material.dart';

/// 创建相册弹窗
class CreateAlbumDialog extends StatefulWidget {
  final int studentId;

  const CreateAlbumDialog({
    super.key,
    required this.studentId,
  });

  @override
  State<CreateAlbumDialog> createState() => _CreateAlbumDialogState();
}

class _CreateAlbumDialogState extends State<CreateAlbumDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.removeListener(() => setState(() {}));
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    if (_nameController.text.trim().isEmpty) return;

    setState(() {
      _isCreating = true;
    });

    // 返回结果给调用者处理
    Navigator.of(context).pop({
      'name': _nameController.text.trim(),
      'notes': _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新建相册'),
      content: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: '相册名称',
                hintText: '请输入相册名称',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: '备注',
                hintText: '选填',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isCreating ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _isCreating || _nameController.text.trim().isEmpty
              ? null
              : _create,
          child: _isCreating
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('创建'),
        ),
      ],
    );
  }
}

/// 显示创建相册弹窗
///
/// 返回 Map? 包含 'name' 和 'notes'，null 表示取消
Future<Map<String, dynamic>?> showCreateAlbumDialog(
  BuildContext context, {
  required int studentId,
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) => CreateAlbumDialog(studentId: studentId),
  );
}
