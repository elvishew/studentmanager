// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_type_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseTypeRepositoryHash() =>
    r'decd59d39036c7f7213af7250b09ecd5350ca715';

/// ============================================
/// CourseTypeRepository Provider
/// ============================================
///
/// Copied from [courseTypeRepository].
@ProviderFor(courseTypeRepository)
final courseTypeRepositoryProvider = Provider<CourseTypeRepository>.internal(
  courseTypeRepository,
  name: r'courseTypeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseTypeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CourseTypeRepositoryRef = ProviderRef<CourseTypeRepository>;
String _$activeCourseTypesHash() => r'352b70429f6e4d926728f4991e4fb33125a87545';

/// ============================================
/// 课程类型计算属性
/// ============================================
/// 未弃用的课程类型列表
///
/// Copied from [activeCourseTypes].
@ProviderFor(activeCourseTypes)
final activeCourseTypesProvider =
    AutoDisposeProvider<List<CourseType>>.internal(
      activeCourseTypes,
      name: r'activeCourseTypesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeCourseTypesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveCourseTypesRef = AutoDisposeProviderRef<List<CourseType>>;
String _$privateCourseTypesHash() =>
    r'0b5af7734518ae4d90eac245e11a452d02aa11aa';

/// 非团课类型列表
///
/// Copied from [privateCourseTypes].
@ProviderFor(privateCourseTypes)
final privateCourseTypesProvider =
    AutoDisposeProvider<List<CourseType>>.internal(
      privateCourseTypes,
      name: r'privateCourseTypesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$privateCourseTypesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PrivateCourseTypesRef = AutoDisposeProviderRef<List<CourseType>>;
String _$groupCourseTypesHash() => r'c16ba6bbfacb6a26431100d40a4f93397e327bdc';

/// 团课类型列表
///
/// Copied from [groupCourseTypes].
@ProviderFor(groupCourseTypes)
final groupCourseTypesProvider = AutoDisposeProvider<List<CourseType>>.internal(
  groupCourseTypes,
  name: r'groupCourseTypesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groupCourseTypesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GroupCourseTypesRef = AutoDisposeProviderRef<List<CourseType>>;
String _$courseTypeNotifierHash() =>
    r'7f3447aab79fd28fc1970da5bf4826f16204a99e';

/// ============================================
/// CourseTypeNotifier
/// ============================================
///
/// Copied from [CourseTypeNotifier].
@ProviderFor(CourseTypeNotifier)
final courseTypeNotifierProvider =
    NotifierProvider<CourseTypeNotifier, CourseTypeState>.internal(
      CourseTypeNotifier.new,
      name: r'courseTypeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$courseTypeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CourseTypeNotifier = Notifier<CourseTypeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
