import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/item_repository.dart';
import '../providers/student_provider.dart';

/// 通用基础数据表单页（器械、工具共用）
class BasicItemFormPage extends ConsumerStatefulWidget {
  final int? itemId;
  final String title;
  final String fieldLabel;
  final String fieldHint;
  final String duplicateHint;
  final String tableName;

  const BasicItemFormPage({
    super.key,
    this.itemId,
    required this.title,
    required this.fieldLabel,
    required this.fieldHint,
    required this.duplicateHint,
    required this.tableName,
  });

  @override
  ConsumerState<BasicItemFormPage> createState() => _BasicItemFormPageState();
}

class _BasicItemFormPageState extends ConsumerState<BasicItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  late final ItemRepository _repository;
  bool _initialized = false;

  bool _isSaving = false;
  bool _isLoading = false;
  String? _existingName;
  bool _isCheckingName = false;
  bool? _nameIsAvailable;

  bool get _isBatchMode => widget.itemId == null && _nameController.text.contains(',');

  /// 解析逗号分隔的名称列表（去空格、去重）
  List<String> _parseNames(String text) {
    return text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList();
  }

  @override
  void initState() {
    super.initState();
    // repository 在 build 中初始化（需要 ref）
    if (widget.itemId != null) {
      // 标记需要加载
      _isLoading = true;
    }
  }

  void _initRepository() {
    final db = ref.read(databaseProvider);
    _repository = ItemRepository(database: db, tableName: widget.tableName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadItem() async {
    final item = await _repository.getById(widget.itemId!);
    if (item != null && mounted) {
      setState(() {
        _nameController.text = item['name'] as String;
        _existingName = item['name'] as String;
        _nameIsAvailable = true;
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() { _isLoading = false; });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('数据不存在'), backgroundColor: Colors.red),
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> _checkNameAvailability(String text) async {
    if (text.trim().isEmpty) {
      setState(() { _nameIsAvailable = null; });
      return;
    }
    if (widget.itemId != null && text.trim() == _existingName) {
      setState(() { _nameIsAvailable = true; });
      return;
    }
    setState(() { _isCheckingName = true; });
    try {
      if (_isBatchMode) {
        final names = _parseNames(text);
        for (final name in names) {
          if (await _repository.checkNameExists(name)) {
            if (mounted) {
              setState(() { _isCheckingName = false; _nameIsAvailable = false; });
            }
            return;
          }
        }
        if (mounted) {
          setState(() { _isCheckingName = false; _nameIsAvailable = true; });
        }
      } else {
        final exists = await _repository.checkNameExists(text.trim(), excludeId: widget.itemId);
        if (mounted) {
          setState(() { _isCheckingName = false; _nameIsAvailable = !exists; });
        }
      }
    } catch (_) {
      if (mounted) setState(() { _isCheckingName = false; _nameIsAvailable = null; });
    }
  }

  Widget _buildStatusHint() {
    // 批量模式提示
    if (_isBatchMode && _nameIsAvailable != false) {
      final names = _parseNames(_nameController.text);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isCheckingName)
            Row(children: [
              SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange)),
              const SizedBox(width: 6),
              const Text('正在验证...', style: TextStyle(fontSize: 12, color: Colors.orange)),
            ])
          else if (_nameIsAvailable == true)
            const Row(children: [
              Icon(Icons.check_circle, size: 14, color: Colors.green),
              SizedBox(width: 6),
              Text('所有名称可用', style: TextStyle(fontSize: 12, color: Colors.green)),
            ]),
          const SizedBox(height: 4),
          Text(
            '批量模式：将创建 ${names.length} 个${widget.fieldLabel}',
            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      );
    }
    if (_isCheckingName) {
      return Row(children: [
        SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange)),
        const SizedBox(width: 6),
        const Text('正在验证...', style: TextStyle(fontSize: 12, color: Colors.orange)),
      ]);
    }
    if (_nameIsAvailable == true) {
      return const Row(children: [
        Icon(Icons.check_circle, size: 14, color: Colors.green),
        SizedBox(width: 6),
        Text('名称可用', style: TextStyle(fontSize: 12, color: Colors.green)),
      ]);
    }
    if (_nameIsAvailable == false) {
      return Row(children: [
        const Icon(Icons.error, size: 14, color: Colors.red),
        const SizedBox(width: 6),
        Text('名称已存在', style: TextStyle(fontSize: 12, color: Colors.red)),
      ]);
    }
    return Row(children: [
      Icon(Icons.info_outline, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
      const SizedBox(width: 6),
      Text('${widget.fieldLabel}不能重复', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
    ]);
  }

  Future<void> _performSave(String name) async {
    setState(() { _isSaving = true; });
    try {
      bool success;
      if (widget.itemId == null) {
        final id = await _repository.create(name);
        success = id > 0;
      } else {
        success = await _repository.update(widget.itemId!, name);
      }
      if (mounted) {
        setState(() { _isSaving = false; });
        if (success) {
          Navigator.of(context).pop();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(widget.itemId != null ? '已更新' : '已创建')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('保存失败'), backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() { _isSaving = false; });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final text = _nameController.text.trim();

    // 编辑模式
    if (widget.itemId != null) {
      if (text == _existingName) {
        await _performSave(text);
        return;
      }
      final exists = await _repository.checkNameExists(text, excludeId: widget.itemId);
      if (exists) {
        setState(() { _nameIsAvailable = false; });
        HapticFeedback.mediumImpact();
        return;
      }
      setState(() { _nameIsAvailable = true; });
      await _performSave(text);
      return;
    }

    // 新建模式
    if (_isBatchMode) {
      await _performBatchSave(_parseNames(text));
    } else {
      final exists = await _repository.checkNameExists(text);
      if (exists) {
        setState(() { _nameIsAvailable = false; });
        HapticFeedback.mediumImpact();
        return;
      }
      setState(() { _nameIsAvailable = true; });
      await _performSave(text);
    }
  }

  Future<void> _performBatchSave(List<String> names) async {
    setState(() { _isSaving = true; });
    try {
      int created = 0;
      int skipped = 0;
      for (final name in names) {
        if (await _repository.checkNameExists(name)) {
          skipped++;
          continue;
        }
        final id = await _repository.create(name);
        if (id > 0) created++;
      }
      if (mounted) {
        setState(() { _isSaving = false; });
        Navigator.of(context).pop();
        if (mounted) {
          final msg = skipped > 0
              ? '已创建 $created 项，跳过 $skipped 个重复项'
              : '已创建 $created 项';
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() { _isSaving = false; });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('批量创建失败: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      _initialized = true;
      _initRepository();
      if (widget.itemId != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _loadItem());
      }
    }

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemId != null ? '编辑${widget.title}' : '新建${widget.title}'),
        actions: [
          if (_isSaving)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
              ),
            )
          else
            TextButton(
              onPressed: _nameIsAvailable == false ? null : _save,
              child: const Text('保存'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: widget.fieldLabel,
                    hintText: widget.itemId == null
                        ? '${widget.fieldHint}（多个可用英文逗号隔开）'
                        : widget.fieldHint,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      if (_nameController.text == value && mounted) _checkNameAvailability(value);
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return '请输入${widget.fieldLabel}';
                    return null;
                  },
                  autofocus: widget.itemId == null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildStatusHint(),
          ],
        ),
      ),
    );
  }
}
