import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/utils/template_loader.dart';
import 'content_field_list_page.dart';
import 'goal_config_list_page.dart';
import 'goal_list_page.dart';
import 'template_selection_page.dart';

/// 系统设置主页
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('系统设置'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('基础数据管理'),
          _buildListTile(
            icon: Icons.view_list,
            title: '教学内容字段',
            subtitle: '管理教学内容表单字段',
            onTap: () => _navigateTo(context, const ContentFieldListPage()),
          ),
          _buildListTile(
            icon: Icons.flag,
            title: '课程目标管理',
            onTap: () => _navigateTo(context, const GoalListPage()),
          ),
          _buildListTile(
            icon: Icons.school,
            title: '课程目标配置',
            onTap: () => _navigateTo(context, const GoalConfigListPage()),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('系统'),
          _buildListTile(
            icon: Icons.swap_horiz,
            title: '切换教学模板',
            subtitle: '重新选择模板将清空当前字段和选项',
            onTap: () => _showSwitchTemplateDialog(context, ref),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('应用信息'),
          _buildInfoTile(
            icon: Icons.info_outline,
            title: '版本',
            trailing: 'v1.0.0',
          ),
        ],
      ),
    );
  }

  Future<void> _showSwitchTemplateDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.orange, size: 48),
        title: const Text('切换教学模板'),
        content: const Text(
          '切换模板将清空当前的教学内容字段和课程目标。\n'
          '已有的学员和课程规划数据不会受影响，但其中的教学内容可能无法正常显示。\n\n'
          '确定要继续吗？',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('确定切换'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const TemplateSelectionPage(),
        ),
      );
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12)) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      trailing: Text(
        trailing,
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
