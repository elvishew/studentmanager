import 'package:flutter/material.dart';
import 'item_list_page.dart';
import 'item_form_page.dart';
import '../providers/item_provider.dart';

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
            onTap: () => _navigateTo(context, _buildActionListPage()),
          ),
          _buildListTile(
            icon: Icons.fitness_center,
            title: '器械管理',
            onTap: () => _navigateTo(context, _buildEquipmentListPage()),
          ),
          _buildListTile(
            icon: Icons.build,
            title: '工具管理',
            onTap: () => _navigateTo(context, _buildToolListPage()),
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

  Widget _buildActionListPage() {
    return BasicItemListPage(
      title: '动作管理',
      icon: Icons.directions_run,
      searchHint: '搜索动作名称...',
      notifierProvider: actionNotifierProvider,
      formPageBuilder: (itemId) => BasicItemFormPage(
        itemId: itemId,
        title: '动作',
        fieldLabel: '动作名称',
        fieldHint: '请输入动作名称',
        duplicateHint: '该动作名称已存在',
        tableName: 'actions',
      ),
    );
  }

  Widget _buildEquipmentListPage() {
    return BasicItemListPage(
      title: '器械管理',
      icon: Icons.fitness_center,
      searchHint: '搜索器械名称...',
      notifierProvider: equipmentNotifierProvider,
      formPageBuilder: (itemId) => BasicItemFormPage(
        itemId: itemId,
        title: '器械',
        fieldLabel: '器械名称',
        fieldHint: '请输入器械名称',
        duplicateHint: '该器械名称已存在',
        tableName: 'equipments',
      ),
    );
  }

  Widget _buildToolListPage() {
    return BasicItemListPage(
      title: '工具管理',
      icon: Icons.build,
      searchHint: '搜索工具名称...',
      notifierProvider: toolNotifierProvider,
      formPageBuilder: (itemId) => BasicItemFormPage(
        itemId: itemId,
        title: '工具',
        fieldLabel: '工具名称',
        fieldHint: '请输入工具名称',
        duplicateHint: '该工具名称已存在',
        tableName: 'tools',
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
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
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
}
