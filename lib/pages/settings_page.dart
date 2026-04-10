import 'package:flutter/material.dart';
import 'action_list_page.dart';

/// ============================================
/// 系统设置主页
/// ============================================

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('系统设置'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('基础数据管理'),
          _buildListTile(
            icon: Icons.directions_run,
            title: '动作管理',
            onTap: () => _navigateTo(context, const ActionListPage()),
          ),
          _buildListTile(
            icon: Icons.fitness_center,
            title: '器械管理',
            trailing: '即将推出',
            onTap: () => _showComingSoon(context, '器械管理'),
          ),
          _buildListTile(
            icon: Icons.build,
            title: '工具管理',
            trailing: '即将推出',
            onTap: () => _showComingSoon(context, '工具管理'),
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
    String? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing != null
          ? Text(
              trailing,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
              ),
            )
          : const Icon(Icons.chevron_right),
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
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.upcoming_outlined, size: 48),
        title: const Text('即将推出'),
        content: Text('$feature功能正在开发中，敬请期待！'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('我知道了'),
          ),
        ],
      ),
    );
  }
}
