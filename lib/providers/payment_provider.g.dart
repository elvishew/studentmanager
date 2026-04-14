// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paymentRepositoryHash() => r'bba797898edbde8c47917433ea4e4d2914a38284';

/// ============================================
/// PaymentRepository Provider
/// ============================================
///
/// Copied from [paymentRepository].
@ProviderFor(paymentRepository)
final paymentRepositoryProvider =
    AutoDisposeProvider<PaymentRepository>.internal(
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
typedef PaymentRepositoryRef = AutoDisposeProviderRef<PaymentRepository>;
String _$paymentNotifierHash() => r'845f922f8c267d31bd9e5508d13803cf3efec3d0';

/// ============================================
/// PaymentNotifier
/// ============================================
///
/// Copied from [PaymentNotifier].
@ProviderFor(PaymentNotifier)
final paymentNotifierProvider =
    AutoDisposeNotifierProvider<PaymentNotifier, PaymentState>.internal(
      PaymentNotifier.new,
      name: r'paymentNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$paymentNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PaymentNotifier = AutoDisposeNotifier<PaymentState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
