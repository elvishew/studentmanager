import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

/// 模板索引项
class TemplateInfo {
  final String id;
  final String name;
  final String icon;
  final String file;

  const TemplateInfo({
    required this.id,
    required this.name,
    required this.icon,
    required this.file,
  });

  factory TemplateInfo.fromJson(Map<String, dynamic> json) {
    return TemplateInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      file: json['file'] as String,
    );
  }
}

/// 内容字段定义（来自模板 JSON）
class ContentFieldDef {
  final String name;
  final String type; // 'select', 'number', 'text', 'multiline'
  final bool required;
  final int sortOrder;
  final List<String>? options;

  const ContentFieldDef({
    required this.name,
    required this.type,
    required this.required,
    required this.sortOrder,
    this.options,
  });

  factory ContentFieldDef.fromJson(Map<String, dynamic> json) {
    return ContentFieldDef(
      name: json['name'] as String,
      type: json['type'] as String,
      required: json['required'] as bool? ?? false,
      sortOrder: json['sortOrder'] as int? ?? 0,
      options: (json['options'] as List<dynamic>?)?.cast<String>(),
    );
  }
}

/// 完整模板数据
class TemplateData {
  final String id;
  final String name;
  final List<ContentFieldDef> contentFields;
  final List<String> courseGoals;

  const TemplateData({
    required this.id,
    required this.name,
    required this.contentFields,
    required this.courseGoals,
  });
}

/// 模板加载工具
class TemplateLoader {
  static List<TemplateInfo>? _cachedTemplates;

  /// 获取所有可用模板列表
  static Future<List<TemplateInfo>> getTemplates() async {
    if (_cachedTemplates != null) return _cachedTemplates!;

    final jsonString = await rootBundle.loadString('assets/templates/templates.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final templates = (json['templates'] as List<dynamic>)
        .map((t) => TemplateInfo.fromJson(t as Map<String, dynamic>))
        .toList();

    _cachedTemplates = templates;
    return templates;
  }

  /// 根据模板 id 加载完整模板数据
  static Future<TemplateData> loadTemplate(String templateId) async {
    final templates = await getTemplates();
    final info = templates.firstWhere(
      (t) => t.id == templateId,
      orElse: () => throw ArgumentError('Template not found: $templateId'),
    );

    final jsonString = await rootBundle.loadString('assets/templates/${info.file}');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;

    final contentFields = (json['contentFields'] as List<dynamic>)
        .map((f) => ContentFieldDef.fromJson(f as Map<String, dynamic>))
        .toList();

    final courseGoals = (json['courseGoals'] as List<dynamic>?)
            ?.map((g) => g as String)
            .toList() ??
        [];

    return TemplateData(
      id: json['id'] as String,
      name: json['name'] as String,
      contentFields: contentFields,
      courseGoals: courseGoals,
    );
  }

  /// 将模板数据写入数据库
  static Future<void> applyTemplate(Database db, String templateId) async {
    final template = await loadTemplate(templateId);
    final now = DateTime.now().toIso8601String();

    await db.transaction((txn) async {
      // 1. 插入内容字段和选项
      for (final fieldDef in template.contentFields) {
        final fieldId = await txn.insert('content_fields', {
          'name': fieldDef.name,
          'field_type': fieldDef.type,
          'is_required': fieldDef.required ? 1 : 0,
          'sort_order': fieldDef.sortOrder,
          'is_deprecated': 0,
          'created_at': now,
          'updated_at': now,
        });

        // 插入选项（select 类型）
        if (fieldDef.options != null) {
          for (final option in fieldDef.options!) {
            await txn.insert('field_options', {
              'content_field_id': fieldId,
              'value': option,
              'is_deprecated': 0,
              'created_at': now,
              'updated_at': now,
            });
          }
        }
      }

      // 2. 插入课程目标
      for (final goal in template.courseGoals) {
        await txn.insert('course_goals', {
          'name': goal,
          'is_deprecated': 0,
          'created_at': now,
          'updated_at': now,
        });
      }

      // 3. 创建默认课程类型
      await _createDefaultCourseTypes(txn, now);

      // 4. 记录已选择的模板
      await txn.insert('app_settings', {
        'key': 'selected_template',
        'value': templateId,
        'created_at': now,
        'updated_at': now,
      });
    });
  }

  /// 检查是否已选择模板
  static Future<String?> getSelectedTemplate(Database db) async {
    final results = await db.query(
      'app_settings',
      where: 'key = ?',
      whereArgs: ['selected_template'],
      limit: 1,
    );
    if (results.isEmpty) return null;
    return results.first['value'] as String?;
  }

  /// 切换模板（清空旧数据并应用新模板）
  static Future<void> switchTemplate(Database db, String templateId) async {
    final now = DateTime.now().toIso8601String();

    await db.transaction((txn) async {
      // 删除旧的内容字段（CASCADE 会删除关联的选项和值）
      await txn.delete('content_fields');

      // 删除旧的课程目标
      await txn.delete('course_goals');

      // 删除旧的配置数据
      await txn.delete('goal_configs');

      // 应用新模板
      final template = await loadTemplate(templateId);

      for (final fieldDef in template.contentFields) {
        final fieldId = await txn.insert('content_fields', {
          'name': fieldDef.name,
          'field_type': fieldDef.type,
          'is_required': fieldDef.required ? 1 : 0,
          'sort_order': fieldDef.sortOrder,
          'is_deprecated': 0,
          'created_at': now,
          'updated_at': now,
        });

        if (fieldDef.options != null) {
          for (final option in fieldDef.options!) {
            await txn.insert('field_options', {
              'content_field_id': fieldId,
              'value': option,
              'is_deprecated': 0,
              'created_at': now,
              'updated_at': now,
            });
          }
        }
      }

      for (final goal in template.courseGoals) {
        await txn.insert('course_goals', {
          'name': goal,
          'is_deprecated': 0,
          'created_at': now,
          'updated_at': now,
        });
      }

      // 更新模板选择记录
      final existing = await txn.query(
        'app_settings',
        where: 'key = ?',
        whereArgs: ['selected_template'],
      );

      if (existing.isNotEmpty) {
        await txn.update(
          'app_settings',
          {'value': templateId, 'updated_at': now},
          where: 'key = ?',
          whereArgs: ['selected_template'],
        );
      } else {
        await txn.insert('app_settings', {
          'key': 'selected_template',
          'value': templateId,
          'created_at': now,
          'updated_at': now,
        });
      }
    });
  }

  /// 创建默认课程类型
  static Future<void> _createDefaultCourseTypes(dynamic txn, String now) async {
    final defaultTypes = [
      {
        'name': '一对一私教',
        'icon': 'person',
        'color': '#2196F3',
        'default_duration': 60,
        'is_group': 0,
        'max_students': null,
        'default_student_price': 0,
        'default_session_fee': 0,
        'default_commission_type': 'none',
        'default_commission_value': 0,
        'sort_order': 0,
      },
      {
        'name': '团课',
        'icon': 'groups',
        'color': '#4CAF50',
        'default_duration': 60,
        'is_group': 1,
        'max_students': 10,
        'default_student_price': 0,
        'default_session_fee': 0,
        'default_commission_type': 'none',
        'default_commission_value': 0,
        'sort_order': 1,
      },
      {
        'name': '体验课',
        'icon': 'card_giftcard',
        'color': '#FF9800',
        'default_duration': 30,
        'is_group': 0,
        'max_students': null,
        'default_student_price': 0,
        'default_session_fee': 0,
        'default_commission_type': 'none',
        'default_commission_value': 0,
        'sort_order': 2,
      },
    ];

    for (final type in defaultTypes) {
      await txn.insert('course_types', {
        ...type,
        'is_deprecated': 0,
        'created_at': now,
        'updated_at': now,
      });
    }
  }
}
