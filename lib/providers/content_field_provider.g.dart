// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_field_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contentFieldRepositoryHash() =>
    r'57008946f80875250bf68c9e6458b15540caf073';

/// ============================================
/// ContentFieldRepository Provider
/// ============================================
///
/// Copied from [contentFieldRepository].
@ProviderFor(contentFieldRepository)
final contentFieldRepositoryProvider =
    AutoDisposeProvider<ContentFieldRepository>.internal(
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
typedef ContentFieldRepositoryRef =
    AutoDisposeProviderRef<ContentFieldRepository>;
String _$contentBlockRepositoryHash() =>
    r'c02c49332f469c059c5df57a65f8eebae4f479fd';

/// ============================================
/// ContentBlockRepository Provider
/// ============================================
///
/// Copied from [contentBlockRepository].
@ProviderFor(contentBlockRepository)
final contentBlockRepositoryProvider =
    AutoDisposeProvider<ContentBlockRepository>.internal(
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
typedef ContentBlockRepositoryRef =
    AutoDisposeProviderRef<ContentBlockRepository>;
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
    r'7e87dce203e43a385276dcd1ead27bbf799d3256';

/// ============================================
/// ContentFieldNotifier
/// ============================================
///
/// Copied from [ContentFieldNotifier].
@ProviderFor(ContentFieldNotifier)
final contentFieldNotifierProvider =
    AutoDisposeNotifierProvider<
      ContentFieldNotifier,
      List<ContentField>
    >.internal(
      ContentFieldNotifier.new,
      name: r'contentFieldNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contentFieldNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ContentFieldNotifier = AutoDisposeNotifier<List<ContentField>>;
String _$contentBlockNotifierHash() =>
    r'3f4c4a6664f6cc7081e0d8759934b17fd3e38c2a';

/// ============================================
/// ContentBlockNotifier
/// ============================================
///
/// Copied from [ContentBlockNotifier].
@ProviderFor(ContentBlockNotifier)
final contentBlockNotifierProvider =
    AutoDisposeNotifierProvider<ContentBlockNotifier, dynamic>.internal(
      ContentBlockNotifier.new,
      name: r'contentBlockNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contentBlockNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ContentBlockNotifier = AutoDisposeNotifier<dynamic>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
