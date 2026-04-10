// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeGoalsHash() => r'79884d6b49b3763740a3cc927f9346b345546d3e';

/// 获取所有未弃用的目标（供创建/编辑规划时选择用）
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
