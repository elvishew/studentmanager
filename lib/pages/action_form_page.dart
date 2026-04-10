import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/action_provider.dart';

/// ============================================
/// 动作表单页（创建/编辑）
/// ============================================

class ActionFormPage extends ConsumerStatefulWidget {
  final int? actionId;

  const ActionFormPage({
    super.key,
    this.actionId,
  });

  @override
  ConsumerState<ActionFormPage> createState() => _ActionFormPageState();
}

class _ActionFormPageState extends ConsumerState<ActionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isSaving = false;
  bool _isLoading = false;
  String? _existingName; // 记录原始名称（编辑时）
  bool _isCheckingName = false; // 是否正在检查名称
  bool? _nameIsAvailable; // null=未检查, true=可用, false=不可用
  String? _nameErrorMessage; // 名称错误消息

  @override
  void initState() {
    super.initState();
    if (widget.actionId != null) {
      _loadAction();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// 检查名称是否可用（缩短防抖：200ms）
  Future<void> _checkNameAvailability(String name) async {
    if (name.trim().isEmpty) {
      setState(() {
        _nameIsAvailable = null;
        _nameErrorMessage = null;
      });
      return;
    }

    // 编辑模式：名称未改变，直接标记为可用
    if (widget.actionId != null && name.trim() == _existingName) {
      setState(() {
        _nameIsAvailable = true;
        _nameErrorMessage = null;
      });
      return;
    }

    setState(() {
      _isCheckingName = true;
      _nameErrorMessage = null;
    });

    try {
      final exists = await ref.read(actionNotifierProvider.notifier)
          .checkNameExists(name.trim(), excludeId: widget.actionId);

      if (mounted) {
        setState(() {
          _isCheckingName = false;
          _nameIsAvailable = !exists;
          if (exists) {
            _nameErrorMessage = '该动作名称已存在';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCheckingName = false;
          _nameIsAvailable = null;
        });
      }
    }
  }

  Future<void> _loadAction() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ref.read(actionRepositoryProvider);
      final actionMap = await repository.getById(widget.actionId!);

      if (actionMap != null && mounted) {
        setState(() {
          _nameController.text = actionMap['name'] as String;
          _existingName = actionMap['name'] as String; // 记录原始名称
          _nameIsAvailable = true; // 已存在的名称自然是可用的
          _isLoading = false;
        });
      } else if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('动作不存在'),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('加载失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 执行保存操作
  Future<void> _performSave(String name) async {
    setState(() {
      _isSaving = true;
    });

    try {
      bool? success;
      if (widget.actionId == null) {
        // 创建
        final id = await ref.read(actionNotifierProvider.notifier).create(name);
        success = id != null;
      } else {
        // 更新
        success = await ref.read(actionNotifierProvider.notifier)
            .update(widget.actionId!, name);
      }

      if (mounted) {
        setState(() {
          _isSaving = false;
        });

        if (success == true) {
          Navigator.of(context).pop();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.actionId != null ? '动作已更新' : '动作已创建'),
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('保存失败'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('保存失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 构建状态提示
  Widget _buildStatusHint() {
    // 检查中
    if (_isCheckingName) {
      return Row(
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange),
          ),
          const SizedBox(width: 6),
          Text(
            '正在验证...',
            style: TextStyle(fontSize: 12, color: Colors.orange),
          ),
        ],
      );
    }

    // 名称可用
    if (_nameIsAvailable == true) {
      return Row(
        children: [
          const Icon(Icons.check_circle, size: 14, color: Colors.green),
          const SizedBox(width: 6),
          Text(
            '名称可用',
            style: TextStyle(fontSize: 12, color: Colors.green),
          ),
        ],
      );
    }

    // 名称不可用
    if (_nameIsAvailable == false) {
      return Row(
        children: [
          const Icon(Icons.error, size: 14, color: Colors.red),
          const SizedBox(width: 6),
          Text(
            _nameErrorMessage ?? '该动作名称已存在',
            style: TextStyle(fontSize: 12, color: Colors.red),
          ),
        ],
      );
    }

    // 默认提示（未检查状态）
    return Row(
      children: [
        Icon(Icons.info_outline, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        Text(
          '动作名称不能重复',
          style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  /// 保存方法（包含强制同步检查）
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();

    // 编辑模式：名称未改变，直接保存（无需检查）
    if (widget.actionId != null && name == _existingName) {
      await _performSave(name);
      return;
    }

    // 🔒 强制同步检查名称（最终防线，防止竞态条件）
    final exists = await ref.read(actionNotifierProvider.notifier)
        .checkNameExists(name, excludeId: widget.actionId);

    if (exists) {
      // 名称重复，更新UI状态，显示错误
      setState(() {
        _nameIsAvailable = false;
        _nameErrorMessage = '该动作名称已存在';
      });

      // 震动反馈
      HapticFeedback.mediumImpact();
      return;
    }

    // 标记为已验证，执行保存
    setState(() {
      _nameIsAvailable = true;
    });

    await _performSave(name);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.actionId != null ? '编辑动作' : '新建动作'),
        actions: [
          if (_isSaving)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
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
            // 动作名称
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: '动作名称',
                    hintText: '请输入动作名称',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // 🔑 缩短防抖：200ms（更快响应）
                    Future.delayed(const Duration(milliseconds: 200), () {
                      if (_nameController.text == value && mounted) {
                        _checkNameAvailability(value);
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '请输入动作名称';
                    }
                    return null;
                  },
                  autofocus: widget.actionId == null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 状态提示（实时验证时显示，未检查时显示默认提示）
            _buildStatusHint(),
          ],
        ),
      ),
    );
  }
}
