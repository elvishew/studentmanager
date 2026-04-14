// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_plan_provider.dart';

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
String _$selectedCoursePlanHash() =>
    r'5c24187d217bcf995669918d0a73b1e9882298e5';

/// ============================================
/// CoursePlan 计算属性 Provider
/// ============================================
///
/// Copied from [selectedCoursePlan].
@ProviderFor(selectedCoursePlan)
final selectedCoursePlanProvider = AutoDisposeProvider<CoursePlan?>.internal(
  selectedCoursePlan,
  name: r'selectedCoursePlanProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCoursePlanHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedCoursePlanRef = AutoDisposeProviderRef<CoursePlan?>;
String _$coursePlanCountHash() => r'7cebb9c8a4061d0344a9923fbea1bb936de08c44';

/// See also [coursePlanCount].
@ProviderFor(coursePlanCount)
final coursePlanCountProvider = AutoDisposeProvider<int>.internal(
  coursePlanCount,
  name: r'coursePlanCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$coursePlanCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CoursePlanCountRef = AutoDisposeProviderRef<int>;
String _$filteredStudentIdHash() => r'a1943cccc743e8700667bd84ba5af83e38bf700d';

/// See also [filteredStudentId].
@ProviderFor(filteredStudentId)
final filteredStudentIdProvider = AutoDisposeProvider<int?>.internal(
  filteredStudentId,
  name: r'filteredStudentIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredStudentIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredStudentIdRef = AutoDisposeProviderRef<int?>;
String _$coursePlanNotifierHash() =>
    r'7ef67a90a73eec948cf083e229c047eba1cb9cc0';

/// ============================================
/// CoursePlan Notifier
/// ============================================
///
/// Copied from [CoursePlanNotifier].
@ProviderFor(CoursePlanNotifier)
final coursePlanNotifierProvider =
    AutoDisposeNotifierProvider<CoursePlanNotifier, CoursePlanState>.internal(
      CoursePlanNotifier.new,
      name: r'coursePlanNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$coursePlanNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CoursePlanNotifier = AutoDisposeNotifier<CoursePlanState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
