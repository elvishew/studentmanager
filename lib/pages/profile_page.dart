import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/utils/template_loader.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'course_type_list_page.dart';
import 'content_field_list_page.dart';
import 'goal_list_page.dart';
import 'goal_config_list_page.dart';
import 'template_selection_page.dart';
import 'working_hours_settings_page.dart';

/// 我的 Tab
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的')),
      body: ListView(
        children: [
          // 基础数据管理
          _buildSectionHeader(context, '基础数据管理'),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('课程类型管理'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CourseTypeListPage())),
          ),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('教学内容字段'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ContentFieldListPage())),
          ),
          ListTile(
            leading: const Icon(Icons.flag),
            title: const Text('课程目标管理'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const GoalListPage())),
          ),
          ListTile(
            leading: const Icon(Icons.settings_suggest),
            title: const Text('课程目标配置'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const GoalConfigListPage())),
          ),

          const Divider(),

          // 教学模板
          _buildSectionHeader(context, '教学模板'),
          FutureBuilder<String?>(
            future: TemplateLoader.getSelectedTemplate(ref.read(databaseProvider)),
            builder: (context, snapshot) {
              final templateId = snapshot.data;
              return ListTile(
                leading: const Icon(Icons.description),
                title: const Text('当前模板'),
                subtitle: FutureBuilder<String>(
                  future: templateId != null
                      ? TemplateLoader.getTemplateName(templateId)
                      : Future.value('未选择'),
                  builder: (context, nameSnapshot) =>
                      Text(nameSnapshot.data ?? '未选择'),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showTemplateSwitch(context, templateId),
              );
            },
          ),

          const Divider(),

          // 课表设置
          _buildSectionHeader(context, '课表设置'),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('工作时间'),
            subtitle: const Text('设置日视图显示的时段'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const WorkingHoursSettingsPage())),
          ),

          const Divider(),

          // 关于
          _buildSectionHeader(context, '关于'),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('版本'),
            trailing: Text('v3.0.0'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showTemplateSwitch(BuildContext context, String? currentTemplateId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TemplateSelectionPage(
        isSwitching: true,
        currentTemplateId: currentTemplateId,
      )),
    );
  }
}
