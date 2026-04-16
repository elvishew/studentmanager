// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsRepositoryHash() =>
    r'dda4a4197d6bedcfee0e7bbfc70392d8df4fc436';

/// ============================================
/// SettingsRepository Provider
/// ============================================
///
/// Copied from [settingsRepository].
@ProviderFor(settingsRepository)
final settingsRepositoryProvider = Provider<SettingsRepository>.internal(
  settingsRepository,
  name: r'settingsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsRepositoryRef = ProviderRef<SettingsRepository>;
String _$workingHoursNotifierHash() =>
    r'3dc8cf8926fb85d0ab4766aa63a870b4525de123';

/// ============================================
/// WorkingHours Notifier
/// ============================================
///
/// Copied from [WorkingHoursNotifier].
@ProviderFor(WorkingHoursNotifier)
final workingHoursNotifierProvider =
    NotifierProvider<WorkingHoursNotifier, List<TimeSegment>>.internal(
      WorkingHoursNotifier.new,
      name: r'workingHoursNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$workingHoursNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WorkingHoursNotifier = Notifier<List<TimeSegment>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
