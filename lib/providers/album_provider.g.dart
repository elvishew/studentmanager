// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$albumRepositoryHash() => r'148010aa9b79c04f071755e5eb2f77d8ff445b6b';

/// ============================================
/// AlbumRepository Provider
/// ============================================
///
/// Copied from [albumRepository].
@ProviderFor(albumRepository)
final albumRepositoryProvider = Provider<AlbumRepository>.internal(
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
typedef AlbumRepositoryRef = ProviderRef<AlbumRepository>;
String _$albumNotifierHash() => r'b2d03cc26b864fb6e92fde9b7cad3304703ad6b1';

/// ============================================
/// Album Notifier
/// ============================================
///
/// Copied from [AlbumNotifier].
@ProviderFor(AlbumNotifier)
final albumNotifierProvider =
    NotifierProvider<AlbumNotifier, AlbumState>.internal(
      AlbumNotifier.new,
      name: r'albumNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$albumNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AlbumNotifier = Notifier<AlbumState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
