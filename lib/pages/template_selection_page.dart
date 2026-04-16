import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/utils/template_loader.dart';
import 'main_shell_page.dart';

/// 模板选择页
class TemplateSelectionPage extends ConsumerStatefulWidget {
  final bool isSwitching;
  final String? currentTemplateId;

  const TemplateSelectionPage({super.key, this.isSwitching = false, this.currentTemplateId});

  @override
  ConsumerState<TemplateSelectionPage> createState() => _TemplateSelectionPageState();
}

class _TemplateSelectionPageState extends ConsumerState<TemplateSelectionPage> {
  List<TemplateInfo>? _templates;
  bool _isLoading = true;
  bool _isApplying = false;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    final templates = await TemplateLoader.getTemplates();
    if (mounted) {
      setState(() {
        _templates = templates;
        _isLoading = false;
      });
    }
  }

  Future<void> _selectTemplate(TemplateInfo template) async {
    // 切换模式下，点击当前模板不做任何操作
    if (widget.isSwitching && template.id == widget.currentTemplateId) return;

    // 切换模式下弹出确认弹窗
    if (widget.isSwitching) {
      final confirmed = await _showSwitchConfirmation(context, template.name);
      if (!confirmed) return;
    }

    setState(() => _isApplying = true);
    try {
      final db = ref.read(databaseProvider);
      if (widget.isSwitching) {
        await TemplateLoader.switchTemplate(db, template.id);
      } else {
        await TemplateLoader.applyTemplate(db, template.id);
      }
      if (mounted) {
        if (widget.isSwitching) {
          // 切换模式：pop 回 Profile 页
          Navigator.of(context).pop();
        } else {
          // 首次启动：替换到主页
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainShellPage()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isApplying = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('应用模板失败：$e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<bool> _showSwitchConfirmation(BuildContext context, String templateName) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认切换模板'),
        content: Text('切换到「$templateName」将清空以下数据：\n\n'
            '· 教学内容字段\n'
            '· 字段选项\n'
            '· 课程目标\n'
            '· 课程目标默认配置\n\n'
            '已有学员和课程规划不受影响，但已有内容可能无法正常显示。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('确认切换'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'fitness_center': return Icons.fitness_center;
      case 'mic': return Icons.mic;
      case 'piano': return Icons.piano;
      case 'self_improvement': return Icons.self_improvement;
      case 'music_note': return Icons.music_note;
      case 'pool': return Icons.pool;
      case 'calculate': return Icons.calculate;
      case 'translate': return Icons.translate;
      case 'palette': return Icons.palette;
      case 'extension': return Icons.extension;
      case 'sports_martial_arts': return Icons.sports_martial_arts;
      case 'edit': return Icons.edit;
      default: return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSwitching ? '切换教学模板' : '选择教学模板'),
        automaticallyImplyLeading: widget.isSwitching,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _isApplying
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('正在应用模板...'),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.isSwitching) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning_amber_rounded,
                                  color: Theme.of(context).colorScheme.error),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '切换模板将清空教学内容字段、字段选项、课程目标及其默认配置',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onErrorContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ] else ...[
                        Text(
                          '欢迎使用学员课程管理系统',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '请选择您的教学类型，系统将为您自动配置对应的内容字段和课程目标。',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: _templates?.length ?? 0,
                        itemBuilder: (context, index) {
                          final template = _templates![index];
                          return _buildTemplateCard(template);
                        },
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildTemplateCard(TemplateInfo template) {
    final isCurrent = widget.isSwitching && template.id == widget.currentTemplateId;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: isCurrent ? colorScheme.primaryContainer : null,
      shape: isCurrent
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: colorScheme.primary, width: 2),
            )
          : null,
      child: InkWell(
        onTap: _isApplying ? null : () => _selectTemplate(template),
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getIcon(template.icon),
                    size: 36,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      template.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            if (isCurrent)
              Positioned(
                top: 4,
                right: 4,
                child: Icon(Icons.check_circle, size: 18, color: colorScheme.primary),
              ),
          ],
        ),
      ),
    );
  }
}
