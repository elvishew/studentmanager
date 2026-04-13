import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'states.dart';
import 'student_provider.dart';
import 'content_field_provider.dart';
import '../database/session_repository.dart';
import '../database/content_block_repository.dart';

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
/// Session Notifier
/// ============================================

@riverpod
class SessionNotifier extends _$SessionNotifier {
  late final Database _database;
  late final SessionRepository _sessionRepository;
  late final ContentBlockRepository _contentBlockRepository;

  @override
  SessionState build() {
    _database = ref.watch(databaseProvider);
    _sessionRepository = ref.watch(sessionRepositoryProvider);
    _contentBlockRepository = ref.watch(contentBlockRepositoryProvider);
    return const SessionState.initial();
  }

  /// 查询指定课程规划的所有课时
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

  Future<int?> addSession({
    required int coursePlanId,
  }) async {
    try {
      final sessionId = await _sessionRepository.addSession(
        planId: coursePlanId,
      );
      await fetchByCoursePlanId(coursePlanId);
      return sessionId;
    } catch (e, stackTrace) {
      state = SessionState.error(e, stackTrace);
      return null;
    }
  }

  Future<List<int>?> addSessionsBatch({
    required int coursePlanId,
    required int count,
  }) async {
    try {
      final sessionIds = await _sessionRepository.addSessionsBatch(
        planId: coursePlanId,
        count: count,
      );
      await fetchByCoursePlanId(coursePlanId);
      return sessionIds;
    } catch (e, stackTrace) {
      state = SessionState.error(e, stackTrace);
      return null;
    }
  }

  Future<int?> insertSessionAt({
    required int coursePlanId,
    required int position,
  }) async {
    try {
      final sessionId = await _sessionRepository.insertSessionAt(
        planId: coursePlanId,
        position: position,
      );
      await fetchByCoursePlanId(coursePlanId);
      return sessionId;
    } catch (e, stackTrace) {
      state = SessionState.error(e, stackTrace);
      return null;
    }
  }

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

  Future<bool> moveSession({
    required int sessionId,
    required int newPosition,
  }) async {
    try {
      await _sessionRepository.moveSession(
        sessionId: sessionId,
        newPosition: newPosition,
      );
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

  Future<bool> deleteSession({
    required int sessionId,
  }) async {
    try {
      await _sessionRepository.deleteSession(
        sessionId: sessionId,
      );
      state.when(
        initial: () => state = const SessionState.initial(),
        loading: () => state = const SessionState.loading(),
        error: (error, stackTrace) => state = SessionState.error(error, stackTrace),
        data: (sessions, selectedSession, coursePlanId) {
          final updatedSessions = sessions.where((s) => s.id != sessionId).toList();
          state = SessionState.data(
            sessions: updatedSessions,
            selectedSession: selectedSession?.id == sessionId ? null : selectedSession,
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
      return await _enrichSession(session, includeContentBlocks: true);
    } catch (e) {
      return null;
    }
  }

  Future<Session> _enrichSession(
    Session session, {
    bool includeContentBlocks = false,
  }) async {
    List<ContentBlock>? contentBlocks;

    if (includeContentBlocks) {
      final blockMaps = await _contentBlockRepository.getContentBlocksBySession(session.id);
      contentBlocks = blockMaps.map((map) {
        final valuesList = map['values'] as List;
        final values = <int, String>{};
        for (final v in valuesList) {
          values[v['content_field_id'] as int] = v['value'] as String? ?? '';
        }
        return ContentBlock.fromMap(map).copyWith(values: values);
      }).toList();
    }

    return session.copyWith(contentBlocks: contentBlocks);
  }

  void reset() {
    state = const SessionState.initial();
  }
}

/// ============================================
/// Session 计算属性 Provider
/// ============================================

@riverpod
Session? selectedSession(SelectedSessionRef ref) {
  final sessionState = ref.watch(sessionNotifierProvider);
  return sessionState.maybeWhen(
    data: (_, selected, __) => selected,
    orElse: () => null,
  );
}

@riverpod
int sessionCount(SessionCountRef ref) {
  final sessionState = ref.watch(sessionNotifierProvider);
  return sessionState.maybeWhen(
    data: (sessions, _, __) => sessions.length,
    orElse: () => 0,
  );
}

@riverpod
int completedSessionCount(CompletedSessionCountRef ref) {
  final sessionState = ref.watch(sessionNotifierProvider);
  return sessionState.maybeWhen(
    data: (sessions, _, __) => sessions.where((s) => s.status == SessionStatus.completed).length,
    orElse: () => 0,
  );
}

@riverpod
double sessionCompletionRate(SessionCompletionRateRef ref) {
  final total = ref.watch(sessionCountProvider);
  final completed = ref.watch(completedSessionCountProvider);
  if (total == 0) return 0.0;
  return completed / total;
}

@riverpod
SessionStatistics sessionStatistics(SessionStatisticsRef ref) {
  final sessionState = ref.watch(sessionNotifierProvider);

  return sessionState.when(
    initial: () => SessionStatistics(total: 0, completed: 0, pending: 0, skipped: 0, completionRate: 0.0),
    loading: () => SessionStatistics(total: 0, completed: 0, pending: 0, skipped: 0, completionRate: 0.0),
    error: (_, __) => SessionStatistics(total: 0, completed: 0, pending: 0, skipped: 0, completionRate: 0.0),
    data: (sessions, _, __) {
      final total = sessions.length;
      final completed = sessions.where((s) => s.status == SessionStatus.completed).length;
      final pending = sessions.where((s) => s.status == SessionStatus.pending).length;
      final skipped = sessions.where((s) => s.status == SessionStatus.skipped).length;
      final completionRate = total > 0 ? completed / total : 0.0;
      return SessionStatistics(total: total, completed: completed, pending: pending, skipped: skipped, completionRate: completionRate);
    },
  );
}

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
