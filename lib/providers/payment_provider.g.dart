// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paymentRepositoryHash() => r'bdf89fbb5d37a25548bd0bbe5d32dca75be22085';

/// ============================================
/// PaymentRepository Provider
/// ============================================
///
/// Copied from [paymentRepository].
@ProviderFor(paymentRepository)
final paymentRepositoryProvider = Provider<PaymentRepository>.internal(
  paymentRepository,
  name: r'paymentRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PaymentRepositoryRef = ProviderRef<PaymentRepository>;
String _$paymentNotifierHash() => r'c3d285a9ef3fdf4e7a150b0b8844cffb6654a1b5';

/// ============================================
/// PaymentNotifier
/// ============================================
///
/// Copied from [PaymentNotifier].
@ProviderFor(PaymentNotifier)
final paymentNotifierProvider =
    NotifierProvider<PaymentNotifier, PaymentState>.internal(
      PaymentNotifier.new,
      name: r'paymentNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$paymentNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PaymentNotifier = Notifier<PaymentState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
