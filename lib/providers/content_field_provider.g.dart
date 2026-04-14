// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_field_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contentFieldRepositoryHash() =>
    r'781bb1623cb444835bb2c464673f74d1a3084c72';

/// ============================================
/// ContentFieldRepository Provider
/// ============================================
///
/// Copied from [contentFieldRepository].
@ProviderFor(contentFieldRepository)
final contentFieldRepositoryProvider =
    Provider<ContentFieldRepository>.internal(
      contentFieldRepository,
      name: r'contentFieldRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contentFieldRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ContentFieldRepositoryRef = ProviderRef<ContentFieldRepository>;
String _$contentBlockRepositoryHash() =>
    r'1a37b76be450a4bc3ae3511c7c9166bd6d034a2b';

/// ============================================
/// ContentBlockRepository Provider
/// ============================================
///
/// Copied from [contentBlockRepository].
@ProviderFor(contentBlockRepository)
final contentBlockRepositoryProvider =
    Provider<ContentBlockRepository>.internal(
      contentBlockRepository,
      name: r'contentBlockRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contentBlockRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ContentBlockRepositoryRef = ProviderRef<ContentBlockRepository>;
String _$activeGoalsHash() => r'b2a91319a62b320085941acbca2cbfbfe16f44d6';

/// 获取所有未弃用的目标
///
/// Copied from [activeGoals].
@ProviderFor(activeGoals)
final activeGoalsProvider = AutoDisposeFutureProvider<List<GoalItem>>.internal(
  activeGoals,
  name: r'activeGoalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeGoalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveGoalsRef = AutoDisposeFutureProviderRef<List<GoalItem>>;
String _$contentFieldNotifierHash() =>
    r'8a56afe3367054209f43a58d66ba954672228c51';

/// ============================================
/// ContentFieldNotifier
/// ============================================
///
/// Copied from [ContentFieldNotifier].
@ProviderFor(ContentFieldNotifier)
final contentFieldNotifierProvider =
    NotifierProvider<ContentFieldNotifier, List<ContentField>>.internal(
      ContentFieldNotifier.new,
      name: r'contentFieldNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contentFieldNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ContentFieldNotifier = Notifier<List<ContentField>>;
String _$contentBlockNotifierHash() =>
    r'e66ef8cf22d6e80a7f89f0f76569aad16d59372e';

/// ============================================
/// ContentBlockNotifier
/// ============================================
///
/// Copied from [ContentBlockNotifier].
@ProviderFor(ContentBlockNotifier)
final contentBlockNotifierProvider =
    NotifierProvider<ContentBlockNotifier, dynamic>.internal(
      ContentBlockNotifier.new,
      name: r'contentBlockNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contentBlockNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ContentBlockNotifier = Notifier<dynamic>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
