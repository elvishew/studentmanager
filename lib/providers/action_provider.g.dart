// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$actionRepositoryHash() => r'8a8ba8f55eb6592752b94af00cdaa49b8637be87';

/// ============================================
/// Action Repository Provider
/// ============================================
///
/// Copied from [actionRepository].
@ProviderFor(actionRepository)
final actionRepositoryProvider = AutoDisposeProvider<ActionRepository>.internal(
  actionRepository,
  name: r'actionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$actionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActionRepositoryRef = AutoDisposeProviderRef<ActionRepository>;
String _$actionNotifierHash() => r'ce174fe77a30f7077f29f6221dfb7546edc929c2';

/// ============================================
/// Action Notifier
/// ============================================
///
/// Copied from [ActionNotifier].
@ProviderFor(ActionNotifier)
final actionNotifierProvider =
    AutoDisposeNotifierProvider<ActionNotifier, models.ActionState>.internal(
      ActionNotifier.new,
      name: r'actionNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$actionNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActionNotifier = AutoDisposeNotifier<models.ActionState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
