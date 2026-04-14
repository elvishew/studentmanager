// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$coursePlanRepositoryHash() =>
    r'154cbd8190690409744c1486373c19f0ee59ea14';

/// ============================================
/// CoursePlanRepository Provider
/// ============================================
///
/// Copied from [coursePlanRepository].
@ProviderFor(coursePlanRepository)
final coursePlanRepositoryProvider = Provider<CoursePlanRepository>.internal(
  coursePlanRepository,
  name: r'coursePlanRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$coursePlanRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CoursePlanRepositoryRef = ProviderRef<CoursePlanRepository>;
String _$goalConfigNotifierHash() =>
    r'ea7ccf845676663382d37361af9f0d52ea737ae7';

/// ============================================
/// GoalConfig Notifier
/// ============================================
///
/// Copied from [GoalConfigNotifier].
@ProviderFor(GoalConfigNotifier)
final goalConfigNotifierProvider =
    NotifierProvider<GoalConfigNotifier, GoalConfigState>.internal(
      GoalConfigNotifier.new,
      name: r'goalConfigNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$goalConfigNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GoalConfigNotifier = Notifier<GoalConfigState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
