// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionRepositoryHash() => r'14fe77eb741499c86afb3bee628038ac326affcc';

/// ============================================
/// SessionRepository Provider
/// ============================================
///
/// Copied from [sessionRepository].
@ProviderFor(sessionRepository)
final sessionRepositoryProvider =
    AutoDisposeProvider<SessionRepository>.internal(
      sessionRepository,
      name: r'sessionRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionRepositoryRef = AutoDisposeProviderRef<SessionRepository>;
String _$trainingBlockRepositoryHash() =>
    r'4c728b0e5ead9c512685c838ccde1ef82e816652';

/// ============================================
/// TrainingBlockRepository Provider
/// ============================================
///
/// Copied from [trainingBlockRepository].
@ProviderFor(trainingBlockRepository)
final trainingBlockRepositoryProvider =
    AutoDisposeProvider<TrainingBlockRepository>.internal(
      trainingBlockRepository,
      name: r'trainingBlockRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$trainingBlockRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TrainingBlockRepositoryRef =
    AutoDisposeProviderRef<TrainingBlockRepository>;
String _$selectedSessionHash() => r'239ce22f4e63f25fbf982979cafb5ed4f6059778';

/// ============================================
/// Session 计算属性 Provider
/// ============================================
/// 当前选中的课时
///
/// Copied from [selectedSession].
@ProviderFor(selectedSession)
final selectedSessionProvider = AutoDisposeProvider<Session?>.internal(
  selectedSession,
  name: r'selectedSessionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedSessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedSessionRef = AutoDisposeProviderRef<Session?>;
String _$sessionCountHash() => r'6a5d4c46d1d1794a81b0c29af3e0be5de943b8f1';

/// 课时总数
///
/// Copied from [sessionCount].
@ProviderFor(sessionCount)
final sessionCountProvider = AutoDisposeProvider<int>.internal(
  sessionCount,
  name: r'sessionCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionCountRef = AutoDisposeProviderRef<int>;
String _$completedSessionCountHash() =>
    r'8bc8635d19c0d02d4597cb1d3c2d097e2973e36d';

/// 已完成课时数
///
/// Copied from [completedSessionCount].
@ProviderFor(completedSessionCount)
final completedSessionCountProvider = AutoDisposeProvider<int>.internal(
  completedSessionCount,
  name: r'completedSessionCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$completedSessionCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CompletedSessionCountRef = AutoDisposeProviderRef<int>;
String _$sessionCompletionRateHash() =>
    r'1609f47971a5442bd35264d853190c9b3075d062';

/// 课程完成率
///
/// Copied from [sessionCompletionRate].
@ProviderFor(sessionCompletionRate)
final sessionCompletionRateProvider = AutoDisposeProvider<double>.internal(
  sessionCompletionRate,
  name: r'sessionCompletionRateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionCompletionRateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionCompletionRateRef = AutoDisposeProviderRef<double>;
String _$sessionStatisticsHash() => r'933d7f6510b425cadcb1db0c6ead6da37b06c07c';

/// 课时统计
///
/// Copied from [sessionStatistics].
@ProviderFor(sessionStatistics)
final sessionStatisticsProvider =
    AutoDisposeProvider<SessionStatistics>.internal(
      sessionStatistics,
      name: r'sessionStatisticsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionStatisticsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionStatisticsRef = AutoDisposeProviderRef<SessionStatistics>;
String _$sessionNotifierHash() => r'145fe0896db904d116fe30a8ad187fe917e31194';

/// ============================================
/// Session Notifier
/// ============================================
///
/// Copied from [SessionNotifier].
@ProviderFor(SessionNotifier)
final sessionNotifierProvider =
    AutoDisposeNotifierProvider<SessionNotifier, SessionState>.internal(
      SessionNotifier.new,
      name: r'sessionNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SessionNotifier = AutoDisposeNotifier<SessionState>;
String _$trainingBlockNotifierHash() =>
    r'b14a913245a19cb6b5173194243ef7b833636eab';

/// ============================================
/// TrainingBlockNotifier Provider
/// ============================================
///
/// Copied from [TrainingBlockNotifier].
@ProviderFor(TrainingBlockNotifier)
final trainingBlockNotifierProvider =
    AutoDisposeNotifierProvider<TrainingBlockNotifier, dynamic>.internal(
      TrainingBlockNotifier.new,
      name: r'trainingBlockNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$trainingBlockNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TrainingBlockNotifier = AutoDisposeNotifier<dynamic>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
