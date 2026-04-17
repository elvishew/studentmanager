import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/utils/template_loader.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/l10n/app_localizations.dart';
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
    final s = S.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(s.profilePageTitle)),
      body: ListView(
        children: [
          // 基础数据管理
          _buildSectionHeader(context, s.basicDataManagementSection),
          ListTile(
            leading: const Icon(Icons.category),
            title: Text(s.courseTypeManagementTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CourseTypeListPage())),
          ),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: Text(s.contentFieldManagementTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ContentFieldListPage())),
          ),
          ListTile(
            leading: const Icon(Icons.flag),
            title: Text(s.goalManagementTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const GoalListPage())),
          ),
          ListTile(
            leading: const Icon(Icons.settings_suggest),
            title: Text(s.goalConfigManagementTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const GoalConfigListPage())),
          ),

          const Divider(),

          // 教学模板
          _buildSectionHeader(context, s.teachingTemplateSection),
          FutureBuilder<String?>(
            future: TemplateLoader.getSelectedTemplate(ref.read(databaseProvider)),
            builder: (context, snapshot) {
              final templateId = snapshot.data;
              return ListTile(
                leading: const Icon(Icons.description),
                title: Text(s.currentTemplateTitle),
                subtitle: FutureBuilder<String>(
                  future: templateId != null
                      ? TemplateLoader.getTemplateName(templateId)
                      : Future.value(s.noTemplateSelected),
                  builder: (context, nameSnapshot) =>
                      Text(nameSnapshot.data ?? s.noTemplateSelected),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showTemplateSwitch(context, templateId),
              );
            },
          ),

          const Divider(),

          // 课表设置
          _buildSectionHeader(context, s.scheduleSettingsSection),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: Text(s.workingHoursTitle),
            subtitle: Text(s.workingHoursDescription),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const WorkingHoursSettingsPage())),
          ),

          const Divider(),

          // 关于
          _buildSectionHeader(context, s.aboutSection),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(s.versionLabel),
            trailing: const Text('v3.0.0'),
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
