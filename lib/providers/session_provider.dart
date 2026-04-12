import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'states.dart';
import 'student_provider.dart';
import '../database/session_repository.dart';
import '../database/training_block_repository.dart';

part 'session_provider.g.dart';

/// ============================================
/// SessionRepository Provider
/// ============================================

@riverpod
SessionRepository sessionRepository(SessionRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return SessionRepository(database: database);
}

/// ============================================
/// TrainingBlockRepository Provider
/// ============================================

@riverpod
TrainingBlockRepository trainingBlockRepository(TrainingBlockRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return TrainingBlockRepository(database: database);
}

/// ============================================
/// Session Notifier
/// ============================================

@riverpod
class SessionNotifier extends _$SessionNotifier {
  late final Database _database;
  late final SessionRepository _sessionRepository;
  late final TrainingBlockRepository _trainingBlockRepository;

  @override
  SessionState build() {
    _database = ref.watch(databaseProvider);
    _sessionRepository = ref.watch(sessionRepositoryProvider);
    _trainingBlockRepository = ref.watch(trainingBlockRepositoryProvider);
    return const SessionState.initial();
  }

  /// ============================================
  /// 查询指定课程规划的所有课时
  /// ============================================

  Future<void> fetchByCoursePlanId(int coursePlanId) async {
    state = SessionState.loading();

    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        'sessions',
        where: 'course_plan_id = ?',
        whereArgs: [coursePlanId],
        orderBy: 'session_number ASC',
      );

      final sessions = await Future.wait(
        maps.map((map) async {
          final session = Session.fromMap(map);
          return await _enrichSession(session);
        }),
      );

      state = SessionState.data(
        sessions: sessions,
        selectedSession: null,
        coursePlanId: coursePlanId,
      );
    } catch (e, stackTrace) {
      state = SessionState.error(e, stackTrace);
    }
  }

  /// ============================================
  /// 添加课时
  /// ============================================

  Future<int?> addSession({
    required int coursePlanId,
  }) async {
    try {
      final sessionId = await _sessionRepository.addSession(
        planId: coursePlanId,
      );

      // 重新加载课时列表
      await fetchByCoursePlanId(coursePlanId);

      return sessionId;
    } catch (e, stackTrace) {
      state = SessionState.error(e, stackTrace);
      return null;
    }
  }

  /// ============================================
  /// 批量添加课时
  /// ============================================

  Future<List<int>?> addSessionsBatch({
    required int coursePlanId,
    required int count,
  }) async {
    try {
      final sessionIds = await _sessionRepository.addSessionsBatch(
        planId: coursePlanId,
        count: count,
      );

      // 重新加载
      await fetchByCoursePlanId(coursePlanId);

      return sessionIds;
    } catch (e, stackTrace) {
      state = SessionState.error(e, stackTrace);
      return null;
    }
  }

  /// ============================================
  /// 在指定位置插入课时
  /// ============================================

  Future<int?> insertSessionAt({
    required int coursePlanId,
    required int position,
  }) async {
    try {
      final sessionId = await _sessionRepository.insertSessionAt(
        planId: coursePlanId,
        position: position,
      );

      // 重新加载
      await fetchByCoursePlanId(coursePlanId);

      return sessionId;
    } catch (e, stackTrace) {
      state = SessionState.error(e, stackTrace);
      return null;
    }
  }

  /// ============================================
  /// 更新课时
  /// ============================================

  Future<bool> updateSession({
    required int sessionId,
    DateTime? scheduledTime,
    SessionStatus? status,
    int? durationOverride,
    bool clearDurationOverride = false,
  }) async {
    try {
      final count = await _sessionRepository.updateSession(
        sessionId: sessionId,
        scheduledTime: scheduledTime?.toIso8601String(),
        status: status?.value,
        durationOverride: durationOverride,
        clearDurationOverride: clearDurationOverride,
      );

      if (count > 0) {
        // 乐观更新状态
        state.when(
          initial: () => state = const SessionState.initial(),
          loading: () => state = const SessionState.loading(),
          error: (error, stackTrace) => state = SessionState.error(error, stackTrace),
          data: (sessions, selectedSession, coursePlanId) {
            final updatedSessions = sessions.map((s) {
              if (s.id == sessionId) {
                return s.copyWith(
                  scheduledTime: scheduledTime ?? s.scheduledTime,
                  status: status ?? s.status,
                  durationOverride: clearDurationOverride ? null : (durationOverride ?? s.durationOverride),
                  updatedAt: DateTime.now(),
                );
              }
              return s;
            }).toList();

            // 如果更新的是选中的课时，也更新选中状态
            Session? updatedSelected = selectedSession;
            if (selectedSession?.id == sessionId) {
              updatedSelected = updatedSessions.firstWhere((s) => s.id == sessionId);
            }

            state = SessionState.data(
              sessions: updatedSessions,
              selectedSession: updatedSelected,
              coursePlanId: coursePlanId,
            );
          },
        );

        return true;
      }

      return false;
    } catch (e, stackTrace) {
      state = SessionState.error(e, stackTrace);
      return false;
    }
  }

  /// ============================================
  /// 移动课时位置
  /// ============================================

  Future<bool> moveSession({
    required int sessionId,
    required int newPosition,
  }) async {
    try {
      await _sessionRepository.moveSession(
        sessionId: sessionId,
        newPosition: newPosition,
      );

      // 重新加载
      state.when(
        initial: () => state = const SessionState.initial(),
        loading: () => state = const SessionState.loading(),
        error: (error, stackTrace) => state = SessionState.error(error, stackTrace),
        data: (sessions, selectedSession, coursePlanId) async {
          if (coursePlanId != null) {
            await fetchByCoursePlanId(coursePlanId);
          }
        },
      );

      return true;
    } catch (e, stackTrace) {
      state = SessionState.error(e, stackTrace);
      return false;
    }
  }

  /// ============================================
  /// 删除课时
  /// ============================================

  Future<bool> deleteSession({
    required int sessionId,
  }) async {
    try {
      await _sessionRepository.deleteSession(
        sessionId: sessionId,
      );

      // 从状态中移除
      state.when(
        initial: () => state = const SessionState.initial(),
        loading: () => state = const SessionState.loading(),
        error: (error, stackTrace) => state = SessionState.error(error, stackTrace),
        data: (sessions, selectedSession, coursePlanId) {
          final updatedSessions = sessions.where((s) => s.id != sessionId).toList();

          state = SessionState.data(
            sessions: updatedSessions,
            selectedSession: selectedSession?.id == sessionId
                ? null
                : selectedSession,
            coursePlanId: coursePlanId,
          );
        },
      );

      return true;
    } catch (e, stackTrace) {
      state = SessionState.error(e, stackTrace);
      return false;
    }
  }

  /// ============================================
  /// 选择课时
  /// ============================================

  void selectSession(int? id) {
    state.when(
      initial: () => state = const SessionState.initial(),
      loading: () => state = const SessionState.loading(),
      error: (error, stackTrace) => state = SessionState.error(error, stackTrace),
      data: (sessions, selectedSession, coursePlanId) {
        if (id == null) {
          state = SessionState.data(
            sessions: sessions,
            selectedSession: null,
            coursePlanId: coursePlanId,
          );
          return;
        }

        final selected = sessions.firstWhere(
          (session) => session.id == id,
          orElse: () => throw ArgumentError('Session not found: $id'),
        );

        state = SessionState.data(
          sessions: sessions,
          selectedSession: selected,
          coursePlanId: coursePlanId,
        );
      },
    );
  }

  /// ============================================
  /// 根据课时 ID 获取详情（含训练块）
  /// ============================================

  Future<Session?> getDetailById(int sessionId) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        'sessions',
        where: 'id = ?',
        whereArgs: [sessionId],
        limit: 1,
      );

      if (maps.isEmpty) return null;

      final session = Session.fromMap(maps.first);
      return await _enrichSession(session, includeTrainingBlocks: true);
    } catch (e) {
      return null;
    }
  }

  /// ============================================
  /// 丰富课时数据（关联查询）
  /// ============================================

  Future<Session> _enrichSession(
    Session session, {
    bool includeTrainingBlocks = false,
  }) async {
    List<TrainingBlock>? trainingBlocks;

    if (includeTrainingBlocks) {
      final List<Map<String, dynamic>> blockMaps = await _database.rawQuery('''
        SELECT
          tb.*,
          a.name as action_name,
          a.is_deprecated as action_deprecated,
          e.name as equipment_name,
          e.is_deprecated as equipment_deprecated,
          t.name as tool_name,
          t.is_deprecated as tool_deprecated
        FROM training_blocks tb
        LEFT JOIN actions a ON tb.action_id = a.id
        LEFT JOIN equipments e ON tb.equipment_id = e.id
        LEFT JOIN tools t ON tb.tool_id = t.id
        WHERE tb.session_id = ?
        ORDER BY tb.sort_order ASC
      ''', [session.id]);

      trainingBlocks = blockMaps.map((map) {
        final block = TrainingBlock.fromMap(map);
        return block.copyWith(
          action: map['action_name'] != null
              ? Action(
                  id: map['action_id'] as int? ?? 0,
                  name: map['action_name'] as String,
                  isDeprecated: (map['action_deprecated'] as int? ?? 0) == 1,
                  createdAt: block.createdAt,
                  updatedAt: block.updatedAt,
                )
              : null,
          equipment: map['equipment_name'] != null
              ? Equipment(
                  id: map['equipment_id'] as int? ?? 0,
                  name: map['equipment_name'] as String,
                  isDeprecated: (map['equipment_deprecated'] as int? ?? 0) == 1,
                  createdAt: block.createdAt,
                  updatedAt: block.updatedAt,
                )
              : null,
          tool: map['tool_name'] != null
              ? Tool(
                  id: map['tool_id'] as int? ?? 0,
                  name: map['tool_name'] as String,
                  isDeprecated: (map['tool_deprecated'] as int? ?? 0) == 1,
                  createdAt: block.createdAt,
                  updatedAt: block.updatedAt,
                )
              : null,
        );
      }).toList();
    }

    return session.copyWith(trainingBlocks: trainingBlocks);
  }

  /// ============================================
  /// 重置状态
  /// ============================================

  void reset() {
    state = const SessionState.initial();
  }
}

/// ============================================
/// Session 计算属性 Provider
/// ============================================

/// 当前选中的课时
@riverpod
Session? selectedSession(SelectedSessionRef ref) {
  final sessionState = ref.watch(sessionNotifierProvider);
  return sessionState.maybeWhen(
    data: (_, selected, __) => selected,
    orElse: () => null,
  );
}

/// 课时总数
@riverpod
int sessionCount(SessionCountRef ref) {
  final sessionState = ref.watch(sessionNotifierProvider);
  return sessionState.maybeWhen(
    data: (sessions, _, __) => sessions.length,
    orElse: () => 0,
  );
}

/// 已完成课时数
@riverpod
int completedSessionCount(CompletedSessionCountRef ref) {
  final sessionState = ref.watch(sessionNotifierProvider);
  return sessionState.maybeWhen(
    data: (sessions, _, __) => sessions.where((s) => s.status == SessionStatus.completed).length,
    orElse: () => 0,
  );
}

/// 课程完成率
@riverpod
double sessionCompletionRate(SessionCompletionRateRef ref) {
  final total = ref.watch(sessionCountProvider);
  final completed = ref.watch(completedSessionCountProvider);

  if (total == 0) return 0.0;
  return completed / total;
}

/// 课时统计
@riverpod
SessionStatistics sessionStatistics(SessionStatisticsRef ref) {
  final sessionState = ref.watch(sessionNotifierProvider);

  return sessionState.when(
    initial: () => SessionStatistics(
      total: 0,
      completed: 0,
      pending: 0,
      skipped: 0,
      completionRate: 0.0,
    ),
    loading: () => SessionStatistics(
      total: 0,
      completed: 0,
      pending: 0,
      skipped: 0,
      completionRate: 0.0,
    ),
    error: (_, __) => SessionStatistics(
      total: 0,
      completed: 0,
      pending: 0,
      skipped: 0,
      completionRate: 0.0,
    ),
    data: (sessions, _, __) {
      final total = sessions.length;
      final completed = sessions.where((s) => s.status == SessionStatus.completed).length;
      final pending = sessions.where((s) => s.status == SessionStatus.pending).length;
      final skipped = sessions.where((s) => s.status == SessionStatus.skipped).length;
      final completionRate = total > 0 ? completed / total : 0.0;

      return SessionStatistics(
        total: total,
        completed: completed,
        pending: pending,
        skipped: skipped,
        completionRate: completionRate,
      );
    },
  );
}

/// 课时统计数据模型
class SessionStatistics {
  final int total;
  final int completed;
  final int pending;
  final int skipped;
  final double completionRate;

  const SessionStatistics({
    required this.total,
    required this.completed,
    required this.pending,
    required this.skipped,
    required this.completionRate,
  });
}

/// ============================================
/// TrainingBlockNotifier Provider
/// ============================================

@riverpod
class TrainingBlockNotifier extends _$TrainingBlockNotifier {
  late final TrainingBlockRepository _repository;

  @override
  dynamic build() {
    _repository = ref.watch(trainingBlockRepositoryProvider);
    return null;
  }

  /// 添加训练块
  Future<int?> addTrainingBlock({
    required int sessionId,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
  }) async {
    return await _repository.addTrainingBlock(
      sessionId: sessionId,
      actionId: actionId,
      equipmentId: equipmentId,
      toolId: toolId,
      reps: reps,
      sets: sets,
      duration: duration,
      intensity: intensity,
      notes: notes,
    );
  }

  /// 更新训练块
  Future<void> updateTrainingBlock({
    required int blockId,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
  }) async {
    await _repository.updateTrainingBlock(
      blockId: blockId,
      actionId: actionId,
      equipmentId: equipmentId,
      toolId: toolId,
      reps: reps,
      sets: sets,
      duration: duration,
      intensity: intensity,
      notes: notes,
    );
  }

  /// 删除训练块
  Future<void> deleteTrainingBlock({required int blockId}) async {
    await _repository.deleteTrainingBlock(blockId: blockId);
  }

  /// 重新排序训练块
  Future<void> reorderTrainingBlock({
    required int blockId,
    required int newSortOrder,
  }) async {
    await _repository.reorderTrainingBlock(
      blockId: blockId,
      newSortOrder: newSortOrder,
    );
  }
}
