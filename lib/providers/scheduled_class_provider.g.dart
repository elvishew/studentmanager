// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_class_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scheduledClassRepositoryHash() =>
    r'70fed5a195b6974fb1899b8bf788147b593cf8ab';

/// ============================================
/// ScheduledClassRepository Provider
/// ============================================
///
/// Copied from [scheduledClassRepository].
@ProviderFor(scheduledClassRepository)
final scheduledClassRepositoryProvider =
    Provider<ScheduledClassRepository>.internal(
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
typedef ScheduledClassRepositoryRef = ProviderRef<ScheduledClassRepository>;
String _$scheduledClassNotifierHash() =>
    r'152a128b3fcb27dfb1a85e3ddaa84049664a4948';

/// ============================================
/// ScheduledClassNotifier
/// ============================================
///
/// Copied from [ScheduledClassNotifier].
@ProviderFor(ScheduledClassNotifier)
final scheduledClassNotifierProvider =
    NotifierProvider<ScheduledClassNotifier, ScheduledClassState>.internal(
      ScheduledClassNotifier.new,
      name: r'scheduledClassNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scheduledClassNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScheduledClassNotifier = Notifier<ScheduledClassState>;
String _$selectedDateHash() => r'6c5aaff4ab7a60d19b71fad710e7ae68079b053d';

/// ============================================
/// 计算属性
/// ============================================
/// 选中日期
///
/// Copied from [SelectedDate].
@ProviderFor(SelectedDate)
final selectedDateProvider = NotifierProvider<SelectedDate, DateTime>.internal(
  SelectedDate.new,
  name: r'selectedDateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedDateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedDate = Notifier<DateTime>;
String _$scheduleViewHash() => r'80e3b2de4b056a11ed2d5461e1fefd4f83505369';

/// See also [ScheduleView].
@ProviderFor(ScheduleView)
final scheduleViewProvider =
    NotifierProvider<ScheduleView, ScheduleViewMode>.internal(
      ScheduleView.new,
      name: r'scheduleViewProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scheduleViewHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScheduleView = Notifier<ScheduleViewMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
