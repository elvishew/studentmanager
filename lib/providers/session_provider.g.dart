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
String _$selectedSessionHash() => r'239ce22f4e63f25fbf982979cafb5ed4f6059778';

/// ============================================
/// Session 计算属性 Provider
/// ============================================
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

/// See also [sessionCount].
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

/// See also [completedSessionCount].
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

/// See also [sessionCompletionRate].
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

/// See also [sessionStatistics].
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
String _$sessionNotifierHash() => r'1641b3b64cf3742fe3710dcdabffaa8292ee084c';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
