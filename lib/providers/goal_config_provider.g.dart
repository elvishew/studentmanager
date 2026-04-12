// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$coursePlanRepositoryHash() =>
    r'f76613d4323b3910d30cfa9fd3af3092880f8a22';

/// ============================================
/// CoursePlanRepository Provider
/// ============================================
///
/// Copied from [coursePlanRepository].
@ProviderFor(coursePlanRepository)
final coursePlanRepositoryProvider =
    AutoDisposeProvider<CoursePlanRepository>.internal(
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
typedef CoursePlanRepositoryRef = AutoDisposeProviderRef<CoursePlanRepository>;
String _$goalConfigNotifierHash() =>
    r'70317b42bb375458f548d7edaee6177b945cf398';

/// ============================================
/// GoalConfig Notifier
/// ============================================
///
/// Copied from [GoalConfigNotifier].
@ProviderFor(GoalConfigNotifier)
final goalConfigNotifierProvider =
    AutoDisposeNotifierProvider<GoalConfigNotifier, GoalConfigState>.internal(
      GoalConfigNotifier.new,
      name: r'goalConfigNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$goalConfigNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GoalConfigNotifier = AutoDisposeNotifier<GoalConfigState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
