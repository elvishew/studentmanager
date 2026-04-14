// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statisticsDataHash() => r'f73e3cffed03febff35ae33ed3d5d7d5cc90f0aa';

/// ============================================
/// 统计数据 Provider
/// ============================================
///
/// Copied from [statisticsData].
@ProviderFor(statisticsData)
final statisticsDataProvider =
    AutoDisposeFutureProvider<StatisticsData>.internal(
      statisticsData,
      name: r'statisticsDataProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$statisticsDataHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatisticsDataRef = AutoDisposeFutureProviderRef<StatisticsData>;
String _$statisticsDateRangeHash() =>
    r'95c04fc7ba5d81eea8fbf20293463242ea8e8213';

/// ============================================
/// 统计时间范围 Provider
/// ============================================
///
/// Copied from [StatisticsDateRange].
@ProviderFor(StatisticsDateRange)
final statisticsDateRangeProvider =
    NotifierProvider<StatisticsDateRange, DateTimeRange>.internal(
      StatisticsDateRange.new,
      name: r'statisticsDateRangeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$statisticsDateRangeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StatisticsDateRange = Notifier<DateTimeRange>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
