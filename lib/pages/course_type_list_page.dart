import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/providers/course_type_provider.dart';
import 'course_type_form_page.dart';

/// 课程类型管理列表
class CourseTypeListPage extends ConsumerStatefulWidget {
  const CourseTypeListPage({super.key});

  @override
  ConsumerState<CourseTypeListPage> createState() => _CourseTypeListPageState();
}

class _CourseTypeListPageState extends ConsumerState<CourseTypeListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(courseTypeNotifierProvider.notifier).fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    final state = ref.watch(courseTypeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.courseTypeListPageTitle),
      ),
      body: state.when(
        initial: () => Center(child: Text(s.loading)),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(s.errorMessage(e.toString()))),
        data: (types) {
          if (types.isEmpty) {
            return Center(child: Text(s.noCourseTypesMessage));
          }
          return ListView.builder(
            itemCount: types.length,
            itemBuilder: (context, index) {
              final ct = types[index];
              return _buildCourseTypeTile(context, ct);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context),
        tooltip: s.newCourseTypeTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCourseTypeTile(BuildContext context, CourseType ct) {
    final s = S.of(context)!;
    final color = _parseColor(ct.color) ?? Theme.of(context).colorScheme.primary;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(_getIcon(ct.icon), color: color, size: 20),
        ),
        title: Row(
          children: [
            Text(ct.name),
            if (ct.isGroup) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(s.groupBadge, style: const TextStyle(fontSize: 10, color: Colors.green)),
              ),
            ],
            if (ct.isDeprecated) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(s.deprecatedBadge, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ),
            ],
          ],
        ),
        subtitle: Text(
          '${ct.defaultDuration}分钟 | 学员价 ¥${ct.defaultStudentPrice.toStringAsFixed(0)} | 课时费 ¥${ct.defaultSessionFee.toStringAsFixed(0)}',
          style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (action) => _handleAction(action, ct),
          itemBuilder: (context) => [
            PopupMenuItem(value: 'edit', child: Text(s.edit)),
            if (!ct.isDeprecated)
              PopupMenuItem(value: 'deprecate', child: Text(s.deprecateTooltip))
            else
              PopupMenuItem(value: 'restore', child: Text(s.restoreTooltip)),
          ],
        ),
      ),
    );
  }

  void _showForm(BuildContext context, [CourseType? existing]) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CourseTypeFormPage(courseType: existing)),
    ).then((_) => ref.read(courseTypeNotifierProvider.notifier).fetchAll());
  }

  Future<void> _handleAction(String action, CourseType ct) async {
    final notifier = ref.read(courseTypeNotifierProvider.notifier);
    switch (action) {
      case 'edit':
        _showForm(context, ct);
        break;
      case 'deprecate':
        await notifier.toggleDeprecated(ct.id, true);
        break;
      case 'restore':
        await notifier.toggleDeprecated(ct.id, false);
        break;
    }
  }

  IconData _getIcon(String? iconName) {
    switch (iconName) {
      case 'person': return Icons.person;
      case 'groups': return Icons.groups;
      case 'card_giftcard': return Icons.card_giftcard;
      default: return Icons.category;
    }
  }

  Color? _parseColor(String? hexColor) {
    if (hexColor == null) return null;
    try {
      final hex = hexColor.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return null;
    }
  }
}
