// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_class_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scheduledClassRepositoryHash() =>
    r'd817235b28b05f5bdf6224c677b50b9b0dab815d';

/// ============================================
/// ScheduledClassRepository Provider
/// ============================================
///
/// Copied from [scheduledClassRepository].
@ProviderFor(scheduledClassRepository)
final scheduledClassRepositoryProvider =
    AutoDisposeProvider<ScheduledClassRepository>.internal(
      scheduledClassRepository,
      name: r'scheduledClassRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scheduledClassRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ScheduledClassRepositoryRef =
    AutoDisposeProviderRef<ScheduledClassRepository>;
String _$scheduledClassNotifierHash() =>
    r'b6e8cf79c66a35e8c2b9b3e7a896b8d691e64d6d';

/// ============================================
/// ScheduledClassNotifier
/// ============================================
///
/// Copied from [ScheduledClassNotifier].
@ProviderFor(ScheduledClassNotifier)
final scheduledClassNotifierProvider =
    AutoDisposeNotifierProvider<
      ScheduledClassNotifier,
      ScheduledClassState
    >.internal(
      ScheduledClassNotifier.new,
      name: r'scheduledClassNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scheduledClassNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScheduledClassNotifier = AutoDisposeNotifier<ScheduledClassState>;
String _$selectedDateHash() => r'e2247a92a2cf7027f53985680596ffb4580be458';

/// ============================================
/// 计算属性
/// ============================================
/// 选中日期
///
/// Copied from [SelectedDate].
@ProviderFor(SelectedDate)
final selectedDateProvider =
    AutoDisposeNotifierProvider<SelectedDate, DateTime>.internal(
      SelectedDate.new,
      name: r'selectedDateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedDateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedDate = AutoDisposeNotifier<DateTime>;
String _$scheduleViewHash() => r'3ed1f4e3e1592f5c32f3936d823c38487b304f1b';

/// See also [ScheduleView].
@ProviderFor(ScheduleView)
final scheduleViewProvider =
    AutoDisposeNotifierProvider<ScheduleView, ScheduleViewMode>.internal(
      ScheduleView.new,
      name: r'scheduleViewProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scheduleViewHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScheduleView = AutoDisposeNotifier<ScheduleViewMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
