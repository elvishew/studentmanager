// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$albumRepositoryHash() => r'c412090434492f24180609930c29a0ca401bec84';

/// ============================================
/// AlbumRepository Provider
/// ============================================
///
/// Copied from [albumRepository].
@ProviderFor(albumRepository)
final albumRepositoryProvider = AutoDisposeProvider<AlbumRepository>.internal(
  albumRepository,
  name: r'albumRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$albumRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlbumRepositoryRef = AutoDisposeProviderRef<AlbumRepository>;
String _$albumNotifierHash() => r'58619bb08722077e28601dc4df9f57333f8612ef';

/// ============================================
/// Album Notifier
/// ============================================
///
/// Copied from [AlbumNotifier].
@ProviderFor(AlbumNotifier)
final albumNotifierProvider =
    AutoDisposeNotifierProvider<AlbumNotifier, AlbumState>.internal(
      AlbumNotifier.new,
      name: r'albumNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$albumNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AlbumNotifier = AutoDisposeNotifier<AlbumState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
