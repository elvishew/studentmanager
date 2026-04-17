import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/goal_config_provider.dart';
import 'package:student_manager/providers/content_field_provider.dart';
import 'package:student_manager/providers/states.dart';
import 'package:student_manager/l10n/app_localizations.dart';
import 'goal_config_detail_page.dart';

/// 课程目标默认配置列表页
class GoalConfigListPage extends ConsumerStatefulWidget {
  const GoalConfigListPage({super.key});

  @override
  ConsumerState<GoalConfigListPage> createState() => _GoalConfigListPageState();
}

class _GoalConfigListPageState extends ConsumerState<GoalConfigListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(goalConfigNotifierProvider.notifier).fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(goalConfigNotifierProvider);
    final goalsAsync = ref.watch(activeGoalsProvider);
    final theme = Theme.of(context);
    final s = S.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.goalConfigPageTitle),
      ),
      body: state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _buildErrorView(error),
        data: (goalConfigs) {
          return goalsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => _buildErrorView(e),
            data: (goals) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: goals.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  final config = goalConfigs.where((c) => c.goalId == goal.id).firstOrNull;
                  return _buildGoalTile(context, goal, config, theme);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildGoalTile(
    BuildContext context,
    GoalItem goal,
    GoalConfig? config,
    ThemeData theme,
  ) {
    final hasConfig = config != null;
    final blueprint = config?.blueprint;
    final sessionCount = config?.sessionCount ?? 0;
    final s = S.of(context)!;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: hasConfig
            ? theme.colorScheme.primary
            : theme.colorScheme.outline.withOpacity(0.3),
        child: Icon(
          Icons.flag_outlined,
          size: 20,
          color: hasConfig ? Colors.white : theme.colorScheme.outline,
        ),
      ),
      title: Text(
        goal.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasConfig) ...[
            if (blueprint != null && blueprint.isNotEmpty)
              Text(
                blueprint,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            Text(
              s.sessionTemplatesCount(sessionCount),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ] else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.outline.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                s.notConfigured,
                style: TextStyle(
                  color: theme.colorScheme.outline,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _navigateToDetail(context, goal, config),
    );
  }

  void _navigateToDetail(BuildContext context, GoalItem goal, GoalConfig? config) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoalConfigDetailPage(
          goalId: goal.id,
          goalName: goal.name,
          goalConfigId: config?.id,
        ),
      ),
    ).then((_) {
      ref.read(goalConfigNotifierProvider.notifier).fetchAll();
    });
  }

  Widget _buildErrorView(Object error) {
    final s = S.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            s.loadingFailedMessage,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(goalConfigNotifierProvider.notifier).fetchAll();
            },
            icon: const Icon(Icons.refresh),
            label: Text(s.retry),
          ),
        ],
      ),
    );
  }
}
