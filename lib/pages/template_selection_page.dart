import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/utils/template_loader.dart';
import 'student_list_page.dart';

/// 模板选择页
class TemplateSelectionPage extends ConsumerStatefulWidget {
  final bool isSwitching;

  const TemplateSelectionPage({super.key, this.isSwitching = false});

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
    setState(() => _isApplying = true);
    try {
      final db = ref.read(databaseProvider);
      if (widget.isSwitching) {
        await TemplateLoader.switchTemplate(db, template.id);
      } else {
        await TemplateLoader.applyTemplate(db, template.id);
      }
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const StudentListPage()),
        );
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
        title: const Text('选择教学模板'),
        automaticallyImplyLeading: false,
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
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.0,
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
    return Card(
      child: InkWell(
        onTap: _isApplying ? null : () => _selectTemplate(template),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIcon(template.icon),
                size: 36,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                template.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
