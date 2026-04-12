// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'5f2c763885f8a29584de88e300bde20fa026a948';

/// ============================================
/// Database Provider（依赖注入）
/// ============================================
///
/// Copied from [database].
@ProviderFor(database)
final databaseProvider = AutoDisposeProvider<Database>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseRef = AutoDisposeProviderRef<Database>;
String _$studentCountHash() => r'91d5900e04bb1e02b5fe8777bc4eb7c38cfd7f4d';

/// ============================================
/// Student 计算属性 Provider
/// ============================================
/// 学员总数
///
/// Copied from [studentCount].
@ProviderFor(studentCount)
final studentCountProvider = AutoDisposeProvider<int>.internal(
  studentCount,
  name: r'studentCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$studentCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StudentCountRef = AutoDisposeProviderRef<int>;
String _$filteredStudentsHash() => r'e23a34ce736910e92ccc748c4cb79054572a779e';

/// 过滤后的学员列表
///
/// Copied from [filteredStudents].
@ProviderFor(filteredStudents)
final filteredStudentsProvider = AutoDisposeProvider<List<Student>>.internal(
  filteredStudents,
  name: r'filteredStudentsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredStudentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredStudentsRef = AutoDisposeProviderRef<List<Student>>;
String _$studentNotifierHash() => r'd20b3ffa40179274cc183d0a571c145605266c5e';

/// ============================================
/// Student Notifier
/// ============================================
///
/// Copied from [StudentNotifier].
@ProviderFor(StudentNotifier)
final studentNotifierProvider =
    AutoDisposeNotifierProvider<StudentNotifier, StudentState>.internal(
      StudentNotifier.new,
      name: r'studentNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$studentNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StudentNotifier = AutoDisposeNotifier<StudentState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
