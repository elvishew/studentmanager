// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StudentState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StudentInitial value) initial,
    required TResult Function(_StudentLoading value) loading,
    required TResult Function(_StudentData value) data,
    required TResult Function(_StudentError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StudentInitial value)? initial,
    TResult? Function(_StudentLoading value)? loading,
    TResult? Function(_StudentData value)? data,
    TResult? Function(_StudentError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StudentInitial value)? initial,
    TResult Function(_StudentLoading value)? loading,
    TResult Function(_StudentData value)? data,
    TResult Function(_StudentError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentStateCopyWith<$Res> {
  factory $StudentStateCopyWith(
    StudentState value,
    $Res Function(StudentState) then,
  ) = _$StudentStateCopyWithImpl<$Res, StudentState>;
}

/// @nodoc
class _$StudentStateCopyWithImpl<$Res, $Val extends StudentState>
    implements $StudentStateCopyWith<$Res> {
  _$StudentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StudentInitialImplCopyWith<$Res> {
  factory _$$StudentInitialImplCopyWith(
    _$StudentInitialImpl value,
    $Res Function(_$StudentInitialImpl) then,
  ) = __$$StudentInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StudentInitialImplCopyWithImpl<$Res>
    extends _$StudentStateCopyWithImpl<$Res, _$StudentInitialImpl>
    implements _$$StudentInitialImplCopyWith<$Res> {
  __$$StudentInitialImplCopyWithImpl(
    _$StudentInitialImpl _value,
    $Res Function(_$StudentInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StudentInitialImpl implements _StudentInitial {
  const _$StudentInitialImpl();

  @override
  String toString() {
    return 'StudentState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StudentInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StudentInitial value) initial,
    required TResult Function(_StudentLoading value) loading,
    required TResult Function(_StudentData value) data,
    required TResult Function(_StudentError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StudentInitial value)? initial,
    TResult? Function(_StudentLoading value)? loading,
    TResult? Function(_StudentData value)? data,
    TResult? Function(_StudentError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StudentInitial value)? initial,
    TResult Function(_StudentLoading value)? loading,
    TResult Function(_StudentData value)? data,
    TResult Function(_StudentError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _StudentInitial implements StudentState {
  const factory _StudentInitial() = _$StudentInitialImpl;
}

/// @nodoc
abstract class _$$StudentLoadingImplCopyWith<$Res> {
  factory _$$StudentLoadingImplCopyWith(
    _$StudentLoadingImpl value,
    $Res Function(_$StudentLoadingImpl) then,
  ) = __$$StudentLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StudentLoadingImplCopyWithImpl<$Res>
    extends _$StudentStateCopyWithImpl<$Res, _$StudentLoadingImpl>
    implements _$$StudentLoadingImplCopyWith<$Res> {
  __$$StudentLoadingImplCopyWithImpl(
    _$StudentLoadingImpl _value,
    $Res Function(_$StudentLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StudentLoadingImpl implements _StudentLoading {
  const _$StudentLoadingImpl();

  @override
  String toString() {
    return 'StudentState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StudentLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StudentInitial value) initial,
    required TResult Function(_StudentLoading value) loading,
    required TResult Function(_StudentData value) data,
    required TResult Function(_StudentError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StudentInitial value)? initial,
    TResult? Function(_StudentLoading value)? loading,
    TResult? Function(_StudentData value)? data,
    TResult? Function(_StudentError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StudentInitial value)? initial,
    TResult Function(_StudentLoading value)? loading,
    TResult Function(_StudentData value)? data,
    TResult Function(_StudentError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _StudentLoading implements StudentState {
  const factory _StudentLoading() = _$StudentLoadingImpl;
}

/// @nodoc
abstract class _$$StudentDataImplCopyWith<$Res> {
  factory _$$StudentDataImplCopyWith(
    _$StudentDataImpl value,
    $Res Function(_$StudentDataImpl) then,
  ) = __$$StudentDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Student> students,
    List<Student> filteredStudents,
    String searchQuery,
  });
}

/// @nodoc
class __$$StudentDataImplCopyWithImpl<$Res>
    extends _$StudentStateCopyWithImpl<$Res, _$StudentDataImpl>
    implements _$$StudentDataImplCopyWith<$Res> {
  __$$StudentDataImplCopyWithImpl(
    _$StudentDataImpl _value,
    $Res Function(_$StudentDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? students = null,
    Object? filteredStudents = null,
    Object? searchQuery = null,
  }) {
    return _then(
      _$StudentDataImpl(
        students: null == students
            ? _value._students
            : students // ignore: cast_nullable_to_non_nullable
                  as List<Student>,
        filteredStudents: null == filteredStudents
            ? _value._filteredStudents
            : filteredStudents // ignore: cast_nullable_to_non_nullable
                  as List<Student>,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$StudentDataImpl implements _StudentData {
  const _$StudentDataImpl({
    required final List<Student> students,
    required final List<Student> filteredStudents,
    this.searchQuery = '',
  }) : _students = students,
       _filteredStudents = filteredStudents;

  final List<Student> _students;
  @override
  List<Student> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  final List<Student> _filteredStudents;
  @override
  List<Student> get filteredStudents {
    if (_filteredStudents is EqualUnmodifiableListView)
      return _filteredStudents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredStudents);
  }

  // 搜索过滤后的结果
  @override
  @JsonKey()
  final String searchQuery;

  @override
  String toString() {
    return 'StudentState.data(students: $students, filteredStudents: $filteredStudents, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentDataImpl &&
            const DeepCollectionEquality().equals(other._students, _students) &&
            const DeepCollectionEquality().equals(
              other._filteredStudents,
              _filteredStudents,
            ) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_students),
    const DeepCollectionEquality().hash(_filteredStudents),
    searchQuery,
  );

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentDataImplCopyWith<_$StudentDataImpl> get copyWith =>
      __$$StudentDataImplCopyWithImpl<_$StudentDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return data(students, filteredStudents, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return data?.call(students, filteredStudents, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(students, filteredStudents, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StudentInitial value) initial,
    required TResult Function(_StudentLoading value) loading,
    required TResult Function(_StudentData value) data,
    required TResult Function(_StudentError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StudentInitial value)? initial,
    TResult? Function(_StudentLoading value)? loading,
    TResult? Function(_StudentData value)? data,
    TResult? Function(_StudentError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StudentInitial value)? initial,
    TResult Function(_StudentLoading value)? loading,
    TResult Function(_StudentData value)? data,
    TResult Function(_StudentError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _StudentData implements StudentState {
  const factory _StudentData({
    required final List<Student> students,
    required final List<Student> filteredStudents,
    final String searchQuery,
  }) = _$StudentDataImpl;

  List<Student> get students;
  List<Student> get filteredStudents; // 搜索过滤后的结果
  String get searchQuery;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentDataImplCopyWith<_$StudentDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StudentErrorImplCopyWith<$Res> {
  factory _$$StudentErrorImplCopyWith(
    _$StudentErrorImpl value,
    $Res Function(_$StudentErrorImpl) then,
  ) = __$$StudentErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class __$$StudentErrorImplCopyWithImpl<$Res>
    extends _$StudentStateCopyWithImpl<$Res, _$StudentErrorImpl>
    implements _$$StudentErrorImplCopyWith<$Res> {
  __$$StudentErrorImplCopyWithImpl(
    _$StudentErrorImpl _value,
    $Res Function(_$StudentErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? stackTrace = null}) {
    return _then(
      _$StudentErrorImpl(
        null == error ? _value.error : error,
        null == stackTrace
            ? _value.stackTrace
            : stackTrace // ignore: cast_nullable_to_non_nullable
                  as StackTrace,
      ),
    );
  }
}

/// @nodoc

class _$StudentErrorImpl implements _StudentError {
  const _$StudentErrorImpl(this.error, this.stackTrace);

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'StudentState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(error),
    stackTrace,
  );

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentErrorImplCopyWith<_$StudentErrorImpl> get copyWith =>
      __$$StudentErrorImplCopyWithImpl<_$StudentErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return error?.call(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Student> students,
      List<Student> filteredStudents,
      String searchQuery,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StudentInitial value) initial,
    required TResult Function(_StudentLoading value) loading,
    required TResult Function(_StudentData value) data,
    required TResult Function(_StudentError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StudentInitial value)? initial,
    TResult? Function(_StudentLoading value)? loading,
    TResult? Function(_StudentData value)? data,
    TResult? Function(_StudentError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StudentInitial value)? initial,
    TResult Function(_StudentLoading value)? loading,
    TResult Function(_StudentData value)? data,
    TResult Function(_StudentError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _StudentError implements StudentState {
  const factory _StudentError(final Object error, final StackTrace stackTrace) =
      _$StudentErrorImpl;

  Object get error;
  StackTrace get stackTrace;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentErrorImplCopyWith<_$StudentErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Student {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String get contact => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentCopyWith<Student> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentCopyWith<$Res> {
  factory $StudentCopyWith(Student value, $Res Function(Student) then) =
      _$StudentCopyWithImpl<$Res, Student>;
  @useResult
  $Res call({
    int id,
    String name,
    String? gender,
    String contact,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$StudentCopyWithImpl<$Res, $Val extends Student>
    implements $StudentCopyWith<$Res> {
  _$StudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gender = freezed,
    Object? contact = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            contact: null == contact
                ? _value.contact
                : contact // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudentImplCopyWith<$Res> implements $StudentCopyWith<$Res> {
  factory _$$StudentImplCopyWith(
    _$StudentImpl value,
    $Res Function(_$StudentImpl) then,
  ) = __$$StudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? gender,
    String contact,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$StudentImplCopyWithImpl<$Res>
    extends _$StudentCopyWithImpl<$Res, _$StudentImpl>
    implements _$$StudentImplCopyWith<$Res> {
  __$$StudentImplCopyWithImpl(
    _$StudentImpl _value,
    $Res Function(_$StudentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gender = freezed,
    Object? contact = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$StudentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        contact: null == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$StudentImpl extends _Student {
  const _$StudentImpl({
    required this.id,
    required this.name,
    this.gender,
    required this.contact,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  @override
  final int id;
  @override
  final String name;
  @override
  final String? gender;
  @override
  final String contact;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Student(id: $id, name: $name, gender: $gender, contact: $contact, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    gender,
    contact,
    notes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      __$$StudentImplCopyWithImpl<_$StudentImpl>(this, _$identity);
}

abstract class _Student extends Student {
  const factory _Student({
    required final int id,
    required final String name,
    final String? gender,
    required final String contact,
    final String? notes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$StudentImpl;
  const _Student._() : super._();

  @override
  int get id;
  @override
  String get name;
  @override
  String? get gender;
  @override
  String get contact;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CoursePlanState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CoursePlanInitial value) initial,
    required TResult Function(_CoursePlanLoading value) loading,
    required TResult Function(_CoursePlanData value) data,
    required TResult Function(_CoursePlanError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CoursePlanInitial value)? initial,
    TResult? Function(_CoursePlanLoading value)? loading,
    TResult? Function(_CoursePlanData value)? data,
    TResult? Function(_CoursePlanError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CoursePlanInitial value)? initial,
    TResult Function(_CoursePlanLoading value)? loading,
    TResult Function(_CoursePlanData value)? data,
    TResult Function(_CoursePlanError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoursePlanStateCopyWith<$Res> {
  factory $CoursePlanStateCopyWith(
    CoursePlanState value,
    $Res Function(CoursePlanState) then,
  ) = _$CoursePlanStateCopyWithImpl<$Res, CoursePlanState>;
}

/// @nodoc
class _$CoursePlanStateCopyWithImpl<$Res, $Val extends CoursePlanState>
    implements $CoursePlanStateCopyWith<$Res> {
  _$CoursePlanStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoursePlanState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CoursePlanInitialImplCopyWith<$Res> {
  factory _$$CoursePlanInitialImplCopyWith(
    _$CoursePlanInitialImpl value,
    $Res Function(_$CoursePlanInitialImpl) then,
  ) = __$$CoursePlanInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CoursePlanInitialImplCopyWithImpl<$Res>
    extends _$CoursePlanStateCopyWithImpl<$Res, _$CoursePlanInitialImpl>
    implements _$$CoursePlanInitialImplCopyWith<$Res> {
  __$$CoursePlanInitialImplCopyWithImpl(
    _$CoursePlanInitialImpl _value,
    $Res Function(_$CoursePlanInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoursePlanState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CoursePlanInitialImpl implements _CoursePlanInitial {
  const _$CoursePlanInitialImpl();

  @override
  String toString() {
    return 'CoursePlanState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CoursePlanInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CoursePlanInitial value) initial,
    required TResult Function(_CoursePlanLoading value) loading,
    required TResult Function(_CoursePlanData value) data,
    required TResult Function(_CoursePlanError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CoursePlanInitial value)? initial,
    TResult? Function(_CoursePlanLoading value)? loading,
    TResult? Function(_CoursePlanData value)? data,
    TResult? Function(_CoursePlanError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CoursePlanInitial value)? initial,
    TResult Function(_CoursePlanLoading value)? loading,
    TResult Function(_CoursePlanData value)? data,
    TResult Function(_CoursePlanError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _CoursePlanInitial implements CoursePlanState {
  const factory _CoursePlanInitial() = _$CoursePlanInitialImpl;
}

/// @nodoc
abstract class _$$CoursePlanLoadingImplCopyWith<$Res> {
  factory _$$CoursePlanLoadingImplCopyWith(
    _$CoursePlanLoadingImpl value,
    $Res Function(_$CoursePlanLoadingImpl) then,
  ) = __$$CoursePlanLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CoursePlanLoadingImplCopyWithImpl<$Res>
    extends _$CoursePlanStateCopyWithImpl<$Res, _$CoursePlanLoadingImpl>
    implements _$$CoursePlanLoadingImplCopyWith<$Res> {
  __$$CoursePlanLoadingImplCopyWithImpl(
    _$CoursePlanLoadingImpl _value,
    $Res Function(_$CoursePlanLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoursePlanState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CoursePlanLoadingImpl implements _CoursePlanLoading {
  const _$CoursePlanLoadingImpl();

  @override
  String toString() {
    return 'CoursePlanState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CoursePlanLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CoursePlanInitial value) initial,
    required TResult Function(_CoursePlanLoading value) loading,
    required TResult Function(_CoursePlanData value) data,
    required TResult Function(_CoursePlanError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CoursePlanInitial value)? initial,
    TResult? Function(_CoursePlanLoading value)? loading,
    TResult? Function(_CoursePlanData value)? data,
    TResult? Function(_CoursePlanError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CoursePlanInitial value)? initial,
    TResult Function(_CoursePlanLoading value)? loading,
    TResult Function(_CoursePlanData value)? data,
    TResult Function(_CoursePlanError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _CoursePlanLoading implements CoursePlanState {
  const factory _CoursePlanLoading() = _$CoursePlanLoadingImpl;
}

/// @nodoc
abstract class _$$CoursePlanDataImplCopyWith<$Res> {
  factory _$$CoursePlanDataImplCopyWith(
    _$CoursePlanDataImpl value,
    $Res Function(_$CoursePlanDataImpl) then,
  ) = __$$CoursePlanDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<CoursePlan> coursePlans,
    CoursePlan? selectedCoursePlan,
    int? selectedStudentId,
  });

  $CoursePlanCopyWith<$Res>? get selectedCoursePlan;
}

/// @nodoc
class __$$CoursePlanDataImplCopyWithImpl<$Res>
    extends _$CoursePlanStateCopyWithImpl<$Res, _$CoursePlanDataImpl>
    implements _$$CoursePlanDataImplCopyWith<$Res> {
  __$$CoursePlanDataImplCopyWithImpl(
    _$CoursePlanDataImpl _value,
    $Res Function(_$CoursePlanDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoursePlanState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coursePlans = null,
    Object? selectedCoursePlan = freezed,
    Object? selectedStudentId = freezed,
  }) {
    return _then(
      _$CoursePlanDataImpl(
        coursePlans: null == coursePlans
            ? _value._coursePlans
            : coursePlans // ignore: cast_nullable_to_non_nullable
                  as List<CoursePlan>,
        selectedCoursePlan: freezed == selectedCoursePlan
            ? _value.selectedCoursePlan
            : selectedCoursePlan // ignore: cast_nullable_to_non_nullable
                  as CoursePlan?,
        selectedStudentId: freezed == selectedStudentId
            ? _value.selectedStudentId
            : selectedStudentId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }

  /// Create a copy of CoursePlanState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoursePlanCopyWith<$Res>? get selectedCoursePlan {
    if (_value.selectedCoursePlan == null) {
      return null;
    }

    return $CoursePlanCopyWith<$Res>(_value.selectedCoursePlan!, (value) {
      return _then(_value.copyWith(selectedCoursePlan: value));
    });
  }
}

/// @nodoc

class _$CoursePlanDataImpl implements _CoursePlanData {
  const _$CoursePlanDataImpl({
    required final List<CoursePlan> coursePlans,
    this.selectedCoursePlan,
    this.selectedStudentId = null,
  }) : _coursePlans = coursePlans;

  final List<CoursePlan> _coursePlans;
  @override
  List<CoursePlan> get coursePlans {
    if (_coursePlans is EqualUnmodifiableListView) return _coursePlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coursePlans);
  }

  @override
  final CoursePlan? selectedCoursePlan;
  // 当前选中的课程规划
  @override
  @JsonKey()
  final int? selectedStudentId;

  @override
  String toString() {
    return 'CoursePlanState.data(coursePlans: $coursePlans, selectedCoursePlan: $selectedCoursePlan, selectedStudentId: $selectedStudentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursePlanDataImpl &&
            const DeepCollectionEquality().equals(
              other._coursePlans,
              _coursePlans,
            ) &&
            (identical(other.selectedCoursePlan, selectedCoursePlan) ||
                other.selectedCoursePlan == selectedCoursePlan) &&
            (identical(other.selectedStudentId, selectedStudentId) ||
                other.selectedStudentId == selectedStudentId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_coursePlans),
    selectedCoursePlan,
    selectedStudentId,
  );

  /// Create a copy of CoursePlanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoursePlanDataImplCopyWith<_$CoursePlanDataImpl> get copyWith =>
      __$$CoursePlanDataImplCopyWithImpl<_$CoursePlanDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return data(coursePlans, selectedCoursePlan, selectedStudentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return data?.call(coursePlans, selectedCoursePlan, selectedStudentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(coursePlans, selectedCoursePlan, selectedStudentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CoursePlanInitial value) initial,
    required TResult Function(_CoursePlanLoading value) loading,
    required TResult Function(_CoursePlanData value) data,
    required TResult Function(_CoursePlanError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CoursePlanInitial value)? initial,
    TResult? Function(_CoursePlanLoading value)? loading,
    TResult? Function(_CoursePlanData value)? data,
    TResult? Function(_CoursePlanError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CoursePlanInitial value)? initial,
    TResult Function(_CoursePlanLoading value)? loading,
    TResult Function(_CoursePlanData value)? data,
    TResult Function(_CoursePlanError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _CoursePlanData implements CoursePlanState {
  const factory _CoursePlanData({
    required final List<CoursePlan> coursePlans,
    final CoursePlan? selectedCoursePlan,
    final int? selectedStudentId,
  }) = _$CoursePlanDataImpl;

  List<CoursePlan> get coursePlans;
  CoursePlan? get selectedCoursePlan; // 当前选中的课程规划
  int? get selectedStudentId;

  /// Create a copy of CoursePlanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoursePlanDataImplCopyWith<_$CoursePlanDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CoursePlanErrorImplCopyWith<$Res> {
  factory _$$CoursePlanErrorImplCopyWith(
    _$CoursePlanErrorImpl value,
    $Res Function(_$CoursePlanErrorImpl) then,
  ) = __$$CoursePlanErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class __$$CoursePlanErrorImplCopyWithImpl<$Res>
    extends _$CoursePlanStateCopyWithImpl<$Res, _$CoursePlanErrorImpl>
    implements _$$CoursePlanErrorImplCopyWith<$Res> {
  __$$CoursePlanErrorImplCopyWithImpl(
    _$CoursePlanErrorImpl _value,
    $Res Function(_$CoursePlanErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoursePlanState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? stackTrace = null}) {
    return _then(
      _$CoursePlanErrorImpl(
        null == error ? _value.error : error,
        null == stackTrace
            ? _value.stackTrace
            : stackTrace // ignore: cast_nullable_to_non_nullable
                  as StackTrace,
      ),
    );
  }
}

/// @nodoc

class _$CoursePlanErrorImpl implements _CoursePlanError {
  const _$CoursePlanErrorImpl(this.error, this.stackTrace);

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'CoursePlanState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursePlanErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(error),
    stackTrace,
  );

  /// Create a copy of CoursePlanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoursePlanErrorImplCopyWith<_$CoursePlanErrorImpl> get copyWith =>
      __$$CoursePlanErrorImplCopyWithImpl<_$CoursePlanErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return error?.call(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<CoursePlan> coursePlans,
      CoursePlan? selectedCoursePlan,
      int? selectedStudentId,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CoursePlanInitial value) initial,
    required TResult Function(_CoursePlanLoading value) loading,
    required TResult Function(_CoursePlanData value) data,
    required TResult Function(_CoursePlanError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CoursePlanInitial value)? initial,
    TResult? Function(_CoursePlanLoading value)? loading,
    TResult? Function(_CoursePlanData value)? data,
    TResult? Function(_CoursePlanError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CoursePlanInitial value)? initial,
    TResult Function(_CoursePlanLoading value)? loading,
    TResult Function(_CoursePlanData value)? data,
    TResult Function(_CoursePlanError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _CoursePlanError implements CoursePlanState {
  const factory _CoursePlanError(
    final Object error,
    final StackTrace stackTrace,
  ) = _$CoursePlanErrorImpl;

  Object get error;
  StackTrace get stackTrace;

  /// Create a copy of CoursePlanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoursePlanErrorImplCopyWith<_$CoursePlanErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CoursePlan {
  int get id => throw _privateConstructorUsedError;
  int get studentId => throw _privateConstructorUsedError;
  String get goal => throw _privateConstructorUsedError;
  String? get blueprint => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  Student? get student => throw _privateConstructorUsedError; // 关联的学员信息
  List<Session>? get sessions => throw _privateConstructorUsedError; // 关联的课时列表
  int? get totalSessions => throw _privateConstructorUsedError; // 总课时数
  int? get completedSessions => throw _privateConstructorUsedError;

  /// Create a copy of CoursePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoursePlanCopyWith<CoursePlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoursePlanCopyWith<$Res> {
  factory $CoursePlanCopyWith(
    CoursePlan value,
    $Res Function(CoursePlan) then,
  ) = _$CoursePlanCopyWithImpl<$Res, CoursePlan>;
  @useResult
  $Res call({
    int id,
    int studentId,
    String goal,
    String? blueprint,
    DateTime createdAt,
    DateTime updatedAt,
    Student? student,
    List<Session>? sessions,
    int? totalSessions,
    int? completedSessions,
  });

  $StudentCopyWith<$Res>? get student;
}

/// @nodoc
class _$CoursePlanCopyWithImpl<$Res, $Val extends CoursePlan>
    implements $CoursePlanCopyWith<$Res> {
  _$CoursePlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoursePlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? goal = null,
    Object? blueprint = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? student = freezed,
    Object? sessions = freezed,
    Object? totalSessions = freezed,
    Object? completedSessions = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int,
            goal: null == goal
                ? _value.goal
                : goal // ignore: cast_nullable_to_non_nullable
                      as String,
            blueprint: freezed == blueprint
                ? _value.blueprint
                : blueprint // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            student: freezed == student
                ? _value.student
                : student // ignore: cast_nullable_to_non_nullable
                      as Student?,
            sessions: freezed == sessions
                ? _value.sessions
                : sessions // ignore: cast_nullable_to_non_nullable
                      as List<Session>?,
            totalSessions: freezed == totalSessions
                ? _value.totalSessions
                : totalSessions // ignore: cast_nullable_to_non_nullable
                      as int?,
            completedSessions: freezed == completedSessions
                ? _value.completedSessions
                : completedSessions // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of CoursePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StudentCopyWith<$Res>? get student {
    if (_value.student == null) {
      return null;
    }

    return $StudentCopyWith<$Res>(_value.student!, (value) {
      return _then(_value.copyWith(student: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CoursePlanImplCopyWith<$Res>
    implements $CoursePlanCopyWith<$Res> {
  factory _$$CoursePlanImplCopyWith(
    _$CoursePlanImpl value,
    $Res Function(_$CoursePlanImpl) then,
  ) = __$$CoursePlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int studentId,
    String goal,
    String? blueprint,
    DateTime createdAt,
    DateTime updatedAt,
    Student? student,
    List<Session>? sessions,
    int? totalSessions,
    int? completedSessions,
  });

  @override
  $StudentCopyWith<$Res>? get student;
}

/// @nodoc
class __$$CoursePlanImplCopyWithImpl<$Res>
    extends _$CoursePlanCopyWithImpl<$Res, _$CoursePlanImpl>
    implements _$$CoursePlanImplCopyWith<$Res> {
  __$$CoursePlanImplCopyWithImpl(
    _$CoursePlanImpl _value,
    $Res Function(_$CoursePlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoursePlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? goal = null,
    Object? blueprint = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? student = freezed,
    Object? sessions = freezed,
    Object? totalSessions = freezed,
    Object? completedSessions = freezed,
  }) {
    return _then(
      _$CoursePlanImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        goal: null == goal
            ? _value.goal
            : goal // ignore: cast_nullable_to_non_nullable
                  as String,
        blueprint: freezed == blueprint
            ? _value.blueprint
            : blueprint // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        student: freezed == student
            ? _value.student
            : student // ignore: cast_nullable_to_non_nullable
                  as Student?,
        sessions: freezed == sessions
            ? _value._sessions
            : sessions // ignore: cast_nullable_to_non_nullable
                  as List<Session>?,
        totalSessions: freezed == totalSessions
            ? _value.totalSessions
            : totalSessions // ignore: cast_nullable_to_non_nullable
                  as int?,
        completedSessions: freezed == completedSessions
            ? _value.completedSessions
            : completedSessions // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$CoursePlanImpl extends _CoursePlan {
  const _$CoursePlanImpl({
    required this.id,
    required this.studentId,
    required this.goal,
    this.blueprint,
    required this.createdAt,
    required this.updatedAt,
    this.student,
    final List<Session>? sessions,
    this.totalSessions,
    this.completedSessions,
  }) : _sessions = sessions,
       super._();

  @override
  final int id;
  @override
  final int studentId;
  @override
  final String goal;
  @override
  final String? blueprint;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final Student? student;
  // 关联的学员信息
  final List<Session>? _sessions;
  // 关联的学员信息
  @override
  List<Session>? get sessions {
    final value = _sessions;
    if (value == null) return null;
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // 关联的课时列表
  @override
  final int? totalSessions;
  // 总课时数
  @override
  final int? completedSessions;

  @override
  String toString() {
    return 'CoursePlan(id: $id, studentId: $studentId, goal: $goal, blueprint: $blueprint, createdAt: $createdAt, updatedAt: $updatedAt, student: $student, sessions: $sessions, totalSessions: $totalSessions, completedSessions: $completedSessions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursePlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.blueprint, blueprint) ||
                other.blueprint == blueprint) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.student, student) || other.student == student) &&
            const DeepCollectionEquality().equals(other._sessions, _sessions) &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.completedSessions, completedSessions) ||
                other.completedSessions == completedSessions));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    studentId,
    goal,
    blueprint,
    createdAt,
    updatedAt,
    student,
    const DeepCollectionEquality().hash(_sessions),
    totalSessions,
    completedSessions,
  );

  /// Create a copy of CoursePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoursePlanImplCopyWith<_$CoursePlanImpl> get copyWith =>
      __$$CoursePlanImplCopyWithImpl<_$CoursePlanImpl>(this, _$identity);
}

abstract class _CoursePlan extends CoursePlan {
  const factory _CoursePlan({
    required final int id,
    required final int studentId,
    required final String goal,
    final String? blueprint,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final Student? student,
    final List<Session>? sessions,
    final int? totalSessions,
    final int? completedSessions,
  }) = _$CoursePlanImpl;
  const _CoursePlan._() : super._();

  @override
  int get id;
  @override
  int get studentId;
  @override
  String get goal;
  @override
  String? get blueprint;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  Student? get student; // 关联的学员信息
  @override
  List<Session>? get sessions; // 关联的课时列表
  @override
  int? get totalSessions; // 总课时数
  @override
  int? get completedSessions;

  /// Create a copy of CoursePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoursePlanImplCopyWith<_$CoursePlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SessionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SessionInitial value) initial,
    required TResult Function(_SessionLoading value) loading,
    required TResult Function(_SessionData value) data,
    required TResult Function(_SessionError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SessionInitial value)? initial,
    TResult? Function(_SessionLoading value)? loading,
    TResult? Function(_SessionData value)? data,
    TResult? Function(_SessionError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SessionInitial value)? initial,
    TResult Function(_SessionLoading value)? loading,
    TResult Function(_SessionData value)? data,
    TResult Function(_SessionError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionStateCopyWith<$Res> {
  factory $SessionStateCopyWith(
    SessionState value,
    $Res Function(SessionState) then,
  ) = _$SessionStateCopyWithImpl<$Res, SessionState>;
}

/// @nodoc
class _$SessionStateCopyWithImpl<$Res, $Val extends SessionState>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SessionInitialImplCopyWith<$Res> {
  factory _$$SessionInitialImplCopyWith(
    _$SessionInitialImpl value,
    $Res Function(_$SessionInitialImpl) then,
  ) = __$$SessionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SessionInitialImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionInitialImpl>
    implements _$$SessionInitialImplCopyWith<$Res> {
  __$$SessionInitialImplCopyWithImpl(
    _$SessionInitialImpl _value,
    $Res Function(_$SessionInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SessionInitialImpl implements _SessionInitial {
  const _$SessionInitialImpl();

  @override
  String toString() {
    return 'SessionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SessionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SessionInitial value) initial,
    required TResult Function(_SessionLoading value) loading,
    required TResult Function(_SessionData value) data,
    required TResult Function(_SessionError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SessionInitial value)? initial,
    TResult? Function(_SessionLoading value)? loading,
    TResult? Function(_SessionData value)? data,
    TResult? Function(_SessionError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SessionInitial value)? initial,
    TResult Function(_SessionLoading value)? loading,
    TResult Function(_SessionData value)? data,
    TResult Function(_SessionError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _SessionInitial implements SessionState {
  const factory _SessionInitial() = _$SessionInitialImpl;
}

/// @nodoc
abstract class _$$SessionLoadingImplCopyWith<$Res> {
  factory _$$SessionLoadingImplCopyWith(
    _$SessionLoadingImpl value,
    $Res Function(_$SessionLoadingImpl) then,
  ) = __$$SessionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SessionLoadingImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionLoadingImpl>
    implements _$$SessionLoadingImplCopyWith<$Res> {
  __$$SessionLoadingImplCopyWithImpl(
    _$SessionLoadingImpl _value,
    $Res Function(_$SessionLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SessionLoadingImpl implements _SessionLoading {
  const _$SessionLoadingImpl();

  @override
  String toString() {
    return 'SessionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SessionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SessionInitial value) initial,
    required TResult Function(_SessionLoading value) loading,
    required TResult Function(_SessionData value) data,
    required TResult Function(_SessionError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SessionInitial value)? initial,
    TResult? Function(_SessionLoading value)? loading,
    TResult? Function(_SessionData value)? data,
    TResult? Function(_SessionError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SessionInitial value)? initial,
    TResult Function(_SessionLoading value)? loading,
    TResult Function(_SessionData value)? data,
    TResult Function(_SessionError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _SessionLoading implements SessionState {
  const factory _SessionLoading() = _$SessionLoadingImpl;
}

/// @nodoc
abstract class _$$SessionDataImplCopyWith<$Res> {
  factory _$$SessionDataImplCopyWith(
    _$SessionDataImpl value,
    $Res Function(_$SessionDataImpl) then,
  ) = __$$SessionDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Session> sessions,
    Session? selectedSession,
    int? coursePlanId,
  });

  $SessionCopyWith<$Res>? get selectedSession;
}

/// @nodoc
class __$$SessionDataImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionDataImpl>
    implements _$$SessionDataImplCopyWith<$Res> {
  __$$SessionDataImplCopyWithImpl(
    _$SessionDataImpl _value,
    $Res Function(_$SessionDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessions = null,
    Object? selectedSession = freezed,
    Object? coursePlanId = freezed,
  }) {
    return _then(
      _$SessionDataImpl(
        sessions: null == sessions
            ? _value._sessions
            : sessions // ignore: cast_nullable_to_non_nullable
                  as List<Session>,
        selectedSession: freezed == selectedSession
            ? _value.selectedSession
            : selectedSession // ignore: cast_nullable_to_non_nullable
                  as Session?,
        coursePlanId: freezed == coursePlanId
            ? _value.coursePlanId
            : coursePlanId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionCopyWith<$Res>? get selectedSession {
    if (_value.selectedSession == null) {
      return null;
    }

    return $SessionCopyWith<$Res>(_value.selectedSession!, (value) {
      return _then(_value.copyWith(selectedSession: value));
    });
  }
}

/// @nodoc

class _$SessionDataImpl implements _SessionData {
  const _$SessionDataImpl({
    required final List<Session> sessions,
    this.selectedSession,
    this.coursePlanId = null,
  }) : _sessions = sessions;

  final List<Session> _sessions;
  @override
  List<Session> get sessions {
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessions);
  }

  @override
  final Session? selectedSession;
  // 当前选中的课时
  @override
  @JsonKey()
  final int? coursePlanId;

  @override
  String toString() {
    return 'SessionState.data(sessions: $sessions, selectedSession: $selectedSession, coursePlanId: $coursePlanId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionDataImpl &&
            const DeepCollectionEquality().equals(other._sessions, _sessions) &&
            (identical(other.selectedSession, selectedSession) ||
                other.selectedSession == selectedSession) &&
            (identical(other.coursePlanId, coursePlanId) ||
                other.coursePlanId == coursePlanId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_sessions),
    selectedSession,
    coursePlanId,
  );

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionDataImplCopyWith<_$SessionDataImpl> get copyWith =>
      __$$SessionDataImplCopyWithImpl<_$SessionDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return data(sessions, selectedSession, coursePlanId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return data?.call(sessions, selectedSession, coursePlanId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(sessions, selectedSession, coursePlanId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SessionInitial value) initial,
    required TResult Function(_SessionLoading value) loading,
    required TResult Function(_SessionData value) data,
    required TResult Function(_SessionError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SessionInitial value)? initial,
    TResult? Function(_SessionLoading value)? loading,
    TResult? Function(_SessionData value)? data,
    TResult? Function(_SessionError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SessionInitial value)? initial,
    TResult Function(_SessionLoading value)? loading,
    TResult Function(_SessionData value)? data,
    TResult Function(_SessionError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _SessionData implements SessionState {
  const factory _SessionData({
    required final List<Session> sessions,
    final Session? selectedSession,
    final int? coursePlanId,
  }) = _$SessionDataImpl;

  List<Session> get sessions;
  Session? get selectedSession; // 当前选中的课时
  int? get coursePlanId;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionDataImplCopyWith<_$SessionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionErrorImplCopyWith<$Res> {
  factory _$$SessionErrorImplCopyWith(
    _$SessionErrorImpl value,
    $Res Function(_$SessionErrorImpl) then,
  ) = __$$SessionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class __$$SessionErrorImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionErrorImpl>
    implements _$$SessionErrorImplCopyWith<$Res> {
  __$$SessionErrorImplCopyWithImpl(
    _$SessionErrorImpl _value,
    $Res Function(_$SessionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? stackTrace = null}) {
    return _then(
      _$SessionErrorImpl(
        null == error ? _value.error : error,
        null == stackTrace
            ? _value.stackTrace
            : stackTrace // ignore: cast_nullable_to_non_nullable
                  as StackTrace,
      ),
    );
  }
}

/// @nodoc

class _$SessionErrorImpl implements _SessionError {
  const _$SessionErrorImpl(this.error, this.stackTrace);

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'SessionState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(error),
    stackTrace,
  );

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionErrorImplCopyWith<_$SessionErrorImpl> get copyWith =>
      __$$SessionErrorImplCopyWithImpl<_$SessionErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return error?.call(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Session> sessions,
      Session? selectedSession,
      int? coursePlanId,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SessionInitial value) initial,
    required TResult Function(_SessionLoading value) loading,
    required TResult Function(_SessionData value) data,
    required TResult Function(_SessionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SessionInitial value)? initial,
    TResult? Function(_SessionLoading value)? loading,
    TResult? Function(_SessionData value)? data,
    TResult? Function(_SessionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SessionInitial value)? initial,
    TResult Function(_SessionLoading value)? loading,
    TResult Function(_SessionData value)? data,
    TResult Function(_SessionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _SessionError implements SessionState {
  const factory _SessionError(final Object error, final StackTrace stackTrace) =
      _$SessionErrorImpl;

  Object get error;
  StackTrace get stackTrace;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionErrorImplCopyWith<_$SessionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Session {
  int get id => throw _privateConstructorUsedError;
  int get coursePlanId => throw _privateConstructorUsedError;
  int get sessionNumber => throw _privateConstructorUsedError;
  DateTime? get scheduledTime => throw _privateConstructorUsedError;
  SessionStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<TrainingBlock>? get trainingBlocks => throw _privateConstructorUsedError;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call({
    int id,
    int coursePlanId,
    int sessionNumber,
    DateTime? scheduledTime,
    SessionStatus status,
    DateTime createdAt,
    DateTime updatedAt,
    List<TrainingBlock>? trainingBlocks,
  });
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? coursePlanId = null,
    Object? sessionNumber = null,
    Object? scheduledTime = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? trainingBlocks = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            coursePlanId: null == coursePlanId
                ? _value.coursePlanId
                : coursePlanId // ignore: cast_nullable_to_non_nullable
                      as int,
            sessionNumber: null == sessionNumber
                ? _value.sessionNumber
                : sessionNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            scheduledTime: freezed == scheduledTime
                ? _value.scheduledTime
                : scheduledTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as SessionStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            trainingBlocks: freezed == trainingBlocks
                ? _value.trainingBlocks
                : trainingBlocks // ignore: cast_nullable_to_non_nullable
                      as List<TrainingBlock>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionImplCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$SessionImplCopyWith(
    _$SessionImpl value,
    $Res Function(_$SessionImpl) then,
  ) = __$$SessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int coursePlanId,
    int sessionNumber,
    DateTime? scheduledTime,
    SessionStatus status,
    DateTime createdAt,
    DateTime updatedAt,
    List<TrainingBlock>? trainingBlocks,
  });
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
    _$SessionImpl _value,
    $Res Function(_$SessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? coursePlanId = null,
    Object? sessionNumber = null,
    Object? scheduledTime = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? trainingBlocks = freezed,
  }) {
    return _then(
      _$SessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        coursePlanId: null == coursePlanId
            ? _value.coursePlanId
            : coursePlanId // ignore: cast_nullable_to_non_nullable
                  as int,
        sessionNumber: null == sessionNumber
            ? _value.sessionNumber
            : sessionNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduledTime: freezed == scheduledTime
            ? _value.scheduledTime
            : scheduledTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SessionStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        trainingBlocks: freezed == trainingBlocks
            ? _value._trainingBlocks
            : trainingBlocks // ignore: cast_nullable_to_non_nullable
                  as List<TrainingBlock>?,
      ),
    );
  }
}

/// @nodoc

class _$SessionImpl extends _Session {
  const _$SessionImpl({
    required this.id,
    required this.coursePlanId,
    required this.sessionNumber,
    this.scheduledTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    final List<TrainingBlock>? trainingBlocks,
  }) : _trainingBlocks = trainingBlocks,
       super._();

  @override
  final int id;
  @override
  final int coursePlanId;
  @override
  final int sessionNumber;
  @override
  final DateTime? scheduledTime;
  @override
  final SessionStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<TrainingBlock>? _trainingBlocks;
  @override
  List<TrainingBlock>? get trainingBlocks {
    final value = _trainingBlocks;
    if (value == null) return null;
    if (_trainingBlocks is EqualUnmodifiableListView) return _trainingBlocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Session(id: $id, coursePlanId: $coursePlanId, sessionNumber: $sessionNumber, scheduledTime: $scheduledTime, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, trainingBlocks: $trainingBlocks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.coursePlanId, coursePlanId) ||
                other.coursePlanId == coursePlanId) &&
            (identical(other.sessionNumber, sessionNumber) ||
                other.sessionNumber == sessionNumber) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other._trainingBlocks,
              _trainingBlocks,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    coursePlanId,
    sessionNumber,
    scheduledTime,
    status,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_trainingBlocks),
  );

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      __$$SessionImplCopyWithImpl<_$SessionImpl>(this, _$identity);
}

abstract class _Session extends Session {
  const factory _Session({
    required final int id,
    required final int coursePlanId,
    required final int sessionNumber,
    final DateTime? scheduledTime,
    required final SessionStatus status,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final List<TrainingBlock>? trainingBlocks,
  }) = _$SessionImpl;
  const _Session._() : super._();

  @override
  int get id;
  @override
  int get coursePlanId;
  @override
  int get sessionNumber;
  @override
  DateTime? get scheduledTime;
  @override
  SessionStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<TrainingBlock>? get trainingBlocks;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TrainingBlock {
  int get id => throw _privateConstructorUsedError;
  int get sessionId => throw _privateConstructorUsedError;
  int? get actionId => throw _privateConstructorUsedError;
  int? get equipmentId => throw _privateConstructorUsedError;
  int? get toolId => throw _privateConstructorUsedError;
  String? get reps => throw _privateConstructorUsedError;
  String? get sets => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  String? get intensity => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool get isCustom => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  Action? get action => throw _privateConstructorUsedError; // 关联的动作
  Equipment? get equipment => throw _privateConstructorUsedError; // 关联的器械
  Tool? get tool => throw _privateConstructorUsedError;

  /// Create a copy of TrainingBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingBlockCopyWith<TrainingBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingBlockCopyWith<$Res> {
  factory $TrainingBlockCopyWith(
    TrainingBlock value,
    $Res Function(TrainingBlock) then,
  ) = _$TrainingBlockCopyWithImpl<$Res, TrainingBlock>;
  @useResult
  $Res call({
    int id,
    int sessionId,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
    bool isCustom,
    int sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
    Action? action,
    Equipment? equipment,
    Tool? tool,
  });

  $ActionCopyWith<$Res>? get action;
  $EquipmentCopyWith<$Res>? get equipment;
  $ToolCopyWith<$Res>? get tool;
}

/// @nodoc
class _$TrainingBlockCopyWithImpl<$Res, $Val extends TrainingBlock>
    implements $TrainingBlockCopyWith<$Res> {
  _$TrainingBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? actionId = freezed,
    Object? equipmentId = freezed,
    Object? toolId = freezed,
    Object? reps = freezed,
    Object? sets = freezed,
    Object? duration = freezed,
    Object? intensity = freezed,
    Object? notes = freezed,
    Object? isCustom = null,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? action = freezed,
    Object? equipment = freezed,
    Object? tool = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as int,
            actionId: freezed == actionId
                ? _value.actionId
                : actionId // ignore: cast_nullable_to_non_nullable
                      as int?,
            equipmentId: freezed == equipmentId
                ? _value.equipmentId
                : equipmentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            toolId: freezed == toolId
                ? _value.toolId
                : toolId // ignore: cast_nullable_to_non_nullable
                      as int?,
            reps: freezed == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as String?,
            sets: freezed == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as String?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String?,
            intensity: freezed == intensity
                ? _value.intensity
                : intensity // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCustom: null == isCustom
                ? _value.isCustom
                : isCustom // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            action: freezed == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as Action?,
            equipment: freezed == equipment
                ? _value.equipment
                : equipment // ignore: cast_nullable_to_non_nullable
                      as Equipment?,
            tool: freezed == tool
                ? _value.tool
                : tool // ignore: cast_nullable_to_non_nullable
                      as Tool?,
          )
          as $Val,
    );
  }

  /// Create a copy of TrainingBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActionCopyWith<$Res>? get action {
    if (_value.action == null) {
      return null;
    }

    return $ActionCopyWith<$Res>(_value.action!, (value) {
      return _then(_value.copyWith(action: value) as $Val);
    });
  }

  /// Create a copy of TrainingBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EquipmentCopyWith<$Res>? get equipment {
    if (_value.equipment == null) {
      return null;
    }

    return $EquipmentCopyWith<$Res>(_value.equipment!, (value) {
      return _then(_value.copyWith(equipment: value) as $Val);
    });
  }

  /// Create a copy of TrainingBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ToolCopyWith<$Res>? get tool {
    if (_value.tool == null) {
      return null;
    }

    return $ToolCopyWith<$Res>(_value.tool!, (value) {
      return _then(_value.copyWith(tool: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TrainingBlockImplCopyWith<$Res>
    implements $TrainingBlockCopyWith<$Res> {
  factory _$$TrainingBlockImplCopyWith(
    _$TrainingBlockImpl value,
    $Res Function(_$TrainingBlockImpl) then,
  ) = __$$TrainingBlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int sessionId,
    int? actionId,
    int? equipmentId,
    int? toolId,
    String? reps,
    String? sets,
    String? duration,
    String? intensity,
    String? notes,
    bool isCustom,
    int sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
    Action? action,
    Equipment? equipment,
    Tool? tool,
  });

  @override
  $ActionCopyWith<$Res>? get action;
  @override
  $EquipmentCopyWith<$Res>? get equipment;
  @override
  $ToolCopyWith<$Res>? get tool;
}

/// @nodoc
class __$$TrainingBlockImplCopyWithImpl<$Res>
    extends _$TrainingBlockCopyWithImpl<$Res, _$TrainingBlockImpl>
    implements _$$TrainingBlockImplCopyWith<$Res> {
  __$$TrainingBlockImplCopyWithImpl(
    _$TrainingBlockImpl _value,
    $Res Function(_$TrainingBlockImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrainingBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? actionId = freezed,
    Object? equipmentId = freezed,
    Object? toolId = freezed,
    Object? reps = freezed,
    Object? sets = freezed,
    Object? duration = freezed,
    Object? intensity = freezed,
    Object? notes = freezed,
    Object? isCustom = null,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? action = freezed,
    Object? equipment = freezed,
    Object? tool = freezed,
  }) {
    return _then(
      _$TrainingBlockImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as int,
        actionId: freezed == actionId
            ? _value.actionId
            : actionId // ignore: cast_nullable_to_non_nullable
                  as int?,
        equipmentId: freezed == equipmentId
            ? _value.equipmentId
            : equipmentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        toolId: freezed == toolId
            ? _value.toolId
            : toolId // ignore: cast_nullable_to_non_nullable
                  as int?,
        reps: freezed == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as String?,
        sets: freezed == sets
            ? _value.sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as String?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String?,
        intensity: freezed == intensity
            ? _value.intensity
            : intensity // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCustom: null == isCustom
            ? _value.isCustom
            : isCustom // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        action: freezed == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as Action?,
        equipment: freezed == equipment
            ? _value.equipment
            : equipment // ignore: cast_nullable_to_non_nullable
                  as Equipment?,
        tool: freezed == tool
            ? _value.tool
            : tool // ignore: cast_nullable_to_non_nullable
                  as Tool?,
      ),
    );
  }
}

/// @nodoc

class _$TrainingBlockImpl extends _TrainingBlock {
  const _$TrainingBlockImpl({
    required this.id,
    required this.sessionId,
    this.actionId,
    this.equipmentId,
    this.toolId,
    this.reps,
    this.sets,
    this.duration,
    this.intensity,
    this.notes,
    required this.isCustom,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    this.action,
    this.equipment,
    this.tool,
  }) : super._();

  @override
  final int id;
  @override
  final int sessionId;
  @override
  final int? actionId;
  @override
  final int? equipmentId;
  @override
  final int? toolId;
  @override
  final String? reps;
  @override
  final String? sets;
  @override
  final String? duration;
  @override
  final String? intensity;
  @override
  final String? notes;
  @override
  final bool isCustom;
  @override
  final int sortOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final Action? action;
  // 关联的动作
  @override
  final Equipment? equipment;
  // 关联的器械
  @override
  final Tool? tool;

  @override
  String toString() {
    return 'TrainingBlock(id: $id, sessionId: $sessionId, actionId: $actionId, equipmentId: $equipmentId, toolId: $toolId, reps: $reps, sets: $sets, duration: $duration, intensity: $intensity, notes: $notes, isCustom: $isCustom, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt, action: $action, equipment: $equipment, tool: $tool)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingBlockImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.actionId, actionId) ||
                other.actionId == actionId) &&
            (identical(other.equipmentId, equipmentId) ||
                other.equipmentId == equipmentId) &&
            (identical(other.toolId, toolId) || other.toolId == toolId) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.sets, sets) || other.sets == sets) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.tool, tool) || other.tool == tool));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sessionId,
    actionId,
    equipmentId,
    toolId,
    reps,
    sets,
    duration,
    intensity,
    notes,
    isCustom,
    sortOrder,
    createdAt,
    updatedAt,
    action,
    equipment,
    tool,
  );

  /// Create a copy of TrainingBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingBlockImplCopyWith<_$TrainingBlockImpl> get copyWith =>
      __$$TrainingBlockImplCopyWithImpl<_$TrainingBlockImpl>(this, _$identity);
}

abstract class _TrainingBlock extends TrainingBlock {
  const factory _TrainingBlock({
    required final int id,
    required final int sessionId,
    final int? actionId,
    final int? equipmentId,
    final int? toolId,
    final String? reps,
    final String? sets,
    final String? duration,
    final String? intensity,
    final String? notes,
    required final bool isCustom,
    required final int sortOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final Action? action,
    final Equipment? equipment,
    final Tool? tool,
  }) = _$TrainingBlockImpl;
  const _TrainingBlock._() : super._();

  @override
  int get id;
  @override
  int get sessionId;
  @override
  int? get actionId;
  @override
  int? get equipmentId;
  @override
  int? get toolId;
  @override
  String? get reps;
  @override
  String? get sets;
  @override
  String? get duration;
  @override
  String? get intensity;
  @override
  String? get notes;
  @override
  bool get isCustom;
  @override
  int get sortOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  Action? get action; // 关联的动作
  @override
  Equipment? get equipment; // 关联的器械
  @override
  Tool? get tool;

  /// Create a copy of TrainingBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingBlockImplCopyWith<_$TrainingBlockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Action {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionCopyWith<Action> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionCopyWith<$Res> {
  factory $ActionCopyWith(Action value, $Res Function(Action) then) =
      _$ActionCopyWithImpl<$Res, Action>;
  @useResult
  $Res call({
    int id,
    String name,
    bool isDeprecated,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$ActionCopyWithImpl<$Res, $Val extends Action>
    implements $ActionCopyWith<$Res> {
  _$ActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isDeprecated = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            isDeprecated: null == isDeprecated
                ? _value.isDeprecated
                : isDeprecated // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActionImplCopyWith<$Res> implements $ActionCopyWith<$Res> {
  factory _$$ActionImplCopyWith(
    _$ActionImpl value,
    $Res Function(_$ActionImpl) then,
  ) = __$$ActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    bool isDeprecated,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$ActionImplCopyWithImpl<$Res>
    extends _$ActionCopyWithImpl<$Res, _$ActionImpl>
    implements _$$ActionImplCopyWith<$Res> {
  __$$ActionImplCopyWithImpl(
    _$ActionImpl _value,
    $Res Function(_$ActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isDeprecated = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ActionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        isDeprecated: null == isDeprecated
            ? _value.isDeprecated
            : isDeprecated // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$ActionImpl extends _Action {
  const _$ActionImpl({
    required this.id,
    required this.name,
    required this.isDeprecated,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  @override
  final int id;
  @override
  final String name;
  @override
  final bool isDeprecated;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Action(id: $id, name: $name, isDeprecated: $isDeprecated, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, isDeprecated, createdAt, updatedAt);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionImplCopyWith<_$ActionImpl> get copyWith =>
      __$$ActionImplCopyWithImpl<_$ActionImpl>(this, _$identity);
}

abstract class _Action extends Action {
  const factory _Action({
    required final int id,
    required final String name,
    required final bool isDeprecated,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$ActionImpl;
  const _Action._() : super._();

  @override
  int get id;
  @override
  String get name;
  @override
  bool get isDeprecated;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionImplCopyWith<_$ActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Action> actions, String searchQuery) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Action> actions, String searchQuery)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Action> actions, String searchQuery)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ActionInitial value) initial,
    required TResult Function(_ActionLoading value) loading,
    required TResult Function(_ActionData value) data,
    required TResult Function(_ActionError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ActionInitial value)? initial,
    TResult? Function(_ActionLoading value)? loading,
    TResult? Function(_ActionData value)? data,
    TResult? Function(_ActionError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ActionInitial value)? initial,
    TResult Function(_ActionLoading value)? loading,
    TResult Function(_ActionData value)? data,
    TResult Function(_ActionError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionStateCopyWith<$Res> {
  factory $ActionStateCopyWith(
    ActionState value,
    $Res Function(ActionState) then,
  ) = _$ActionStateCopyWithImpl<$Res, ActionState>;
}

/// @nodoc
class _$ActionStateCopyWithImpl<$Res, $Val extends ActionState>
    implements $ActionStateCopyWith<$Res> {
  _$ActionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ActionInitialImplCopyWith<$Res> {
  factory _$$ActionInitialImplCopyWith(
    _$ActionInitialImpl value,
    $Res Function(_$ActionInitialImpl) then,
  ) = __$$ActionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActionInitialImplCopyWithImpl<$Res>
    extends _$ActionStateCopyWithImpl<$Res, _$ActionInitialImpl>
    implements _$$ActionInitialImplCopyWith<$Res> {
  __$$ActionInitialImplCopyWithImpl(
    _$ActionInitialImpl _value,
    $Res Function(_$ActionInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ActionInitialImpl implements _ActionInitial {
  const _$ActionInitialImpl();

  @override
  String toString() {
    return 'ActionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Action> actions, String searchQuery) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Action> actions, String searchQuery)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Action> actions, String searchQuery)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ActionInitial value) initial,
    required TResult Function(_ActionLoading value) loading,
    required TResult Function(_ActionData value) data,
    required TResult Function(_ActionError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ActionInitial value)? initial,
    TResult? Function(_ActionLoading value)? loading,
    TResult? Function(_ActionData value)? data,
    TResult? Function(_ActionError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ActionInitial value)? initial,
    TResult Function(_ActionLoading value)? loading,
    TResult Function(_ActionData value)? data,
    TResult Function(_ActionError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ActionInitial implements ActionState {
  const factory _ActionInitial() = _$ActionInitialImpl;
}

/// @nodoc
abstract class _$$ActionLoadingImplCopyWith<$Res> {
  factory _$$ActionLoadingImplCopyWith(
    _$ActionLoadingImpl value,
    $Res Function(_$ActionLoadingImpl) then,
  ) = __$$ActionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActionLoadingImplCopyWithImpl<$Res>
    extends _$ActionStateCopyWithImpl<$Res, _$ActionLoadingImpl>
    implements _$$ActionLoadingImplCopyWith<$Res> {
  __$$ActionLoadingImplCopyWithImpl(
    _$ActionLoadingImpl _value,
    $Res Function(_$ActionLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ActionLoadingImpl implements _ActionLoading {
  const _$ActionLoadingImpl();

  @override
  String toString() {
    return 'ActionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Action> actions, String searchQuery) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Action> actions, String searchQuery)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Action> actions, String searchQuery)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ActionInitial value) initial,
    required TResult Function(_ActionLoading value) loading,
    required TResult Function(_ActionData value) data,
    required TResult Function(_ActionError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ActionInitial value)? initial,
    TResult? Function(_ActionLoading value)? loading,
    TResult? Function(_ActionData value)? data,
    TResult? Function(_ActionError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ActionInitial value)? initial,
    TResult Function(_ActionLoading value)? loading,
    TResult Function(_ActionData value)? data,
    TResult Function(_ActionError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ActionLoading implements ActionState {
  const factory _ActionLoading() = _$ActionLoadingImpl;
}

/// @nodoc
abstract class _$$ActionDataImplCopyWith<$Res> {
  factory _$$ActionDataImplCopyWith(
    _$ActionDataImpl value,
    $Res Function(_$ActionDataImpl) then,
  ) = __$$ActionDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Action> actions, String searchQuery});
}

/// @nodoc
class __$$ActionDataImplCopyWithImpl<$Res>
    extends _$ActionStateCopyWithImpl<$Res, _$ActionDataImpl>
    implements _$$ActionDataImplCopyWith<$Res> {
  __$$ActionDataImplCopyWithImpl(
    _$ActionDataImpl _value,
    $Res Function(_$ActionDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? actions = null, Object? searchQuery = null}) {
    return _then(
      _$ActionDataImpl(
        actions: null == actions
            ? _value._actions
            : actions // ignore: cast_nullable_to_non_nullable
                  as List<Action>,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ActionDataImpl implements _ActionData {
  const _$ActionDataImpl({
    required final List<Action> actions,
    this.searchQuery = '',
  }) : _actions = actions;

  final List<Action> _actions;
  @override
  List<Action> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  @override
  @JsonKey()
  final String searchQuery;

  @override
  String toString() {
    return 'ActionState.data(actions: $actions, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionDataImpl &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_actions),
    searchQuery,
  );

  /// Create a copy of ActionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionDataImplCopyWith<_$ActionDataImpl> get copyWith =>
      __$$ActionDataImplCopyWithImpl<_$ActionDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Action> actions, String searchQuery) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return data(actions, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Action> actions, String searchQuery)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return data?.call(actions, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Action> actions, String searchQuery)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(actions, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ActionInitial value) initial,
    required TResult Function(_ActionLoading value) loading,
    required TResult Function(_ActionData value) data,
    required TResult Function(_ActionError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ActionInitial value)? initial,
    TResult? Function(_ActionLoading value)? loading,
    TResult? Function(_ActionData value)? data,
    TResult? Function(_ActionError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ActionInitial value)? initial,
    TResult Function(_ActionLoading value)? loading,
    TResult Function(_ActionData value)? data,
    TResult Function(_ActionError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _ActionData implements ActionState {
  const factory _ActionData({
    required final List<Action> actions,
    final String searchQuery,
  }) = _$ActionDataImpl;

  List<Action> get actions;
  String get searchQuery;

  /// Create a copy of ActionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionDataImplCopyWith<_$ActionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActionErrorImplCopyWith<$Res> {
  factory _$$ActionErrorImplCopyWith(
    _$ActionErrorImpl value,
    $Res Function(_$ActionErrorImpl) then,
  ) = __$$ActionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class __$$ActionErrorImplCopyWithImpl<$Res>
    extends _$ActionStateCopyWithImpl<$Res, _$ActionErrorImpl>
    implements _$$ActionErrorImplCopyWith<$Res> {
  __$$ActionErrorImplCopyWithImpl(
    _$ActionErrorImpl _value,
    $Res Function(_$ActionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? stackTrace = null}) {
    return _then(
      _$ActionErrorImpl(
        null == error ? _value.error : error,
        null == stackTrace
            ? _value.stackTrace
            : stackTrace // ignore: cast_nullable_to_non_nullable
                  as StackTrace,
      ),
    );
  }
}

/// @nodoc

class _$ActionErrorImpl implements _ActionError {
  const _$ActionErrorImpl(this.error, this.stackTrace);

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'ActionState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(error),
    stackTrace,
  );

  /// Create a copy of ActionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionErrorImplCopyWith<_$ActionErrorImpl> get copyWith =>
      __$$ActionErrorImplCopyWithImpl<_$ActionErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Action> actions, String searchQuery) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Action> actions, String searchQuery)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return error?.call(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Action> actions, String searchQuery)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ActionInitial value) initial,
    required TResult Function(_ActionLoading value) loading,
    required TResult Function(_ActionData value) data,
    required TResult Function(_ActionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ActionInitial value)? initial,
    TResult? Function(_ActionLoading value)? loading,
    TResult? Function(_ActionData value)? data,
    TResult? Function(_ActionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ActionInitial value)? initial,
    TResult Function(_ActionLoading value)? loading,
    TResult Function(_ActionData value)? data,
    TResult Function(_ActionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ActionError implements ActionState {
  const factory _ActionError(final Object error, final StackTrace stackTrace) =
      _$ActionErrorImpl;

  Object get error;
  StackTrace get stackTrace;

  /// Create a copy of ActionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionErrorImplCopyWith<_$ActionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Equipment {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Equipment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EquipmentCopyWith<Equipment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EquipmentCopyWith<$Res> {
  factory $EquipmentCopyWith(Equipment value, $Res Function(Equipment) then) =
      _$EquipmentCopyWithImpl<$Res, Equipment>;
  @useResult
  $Res call({int id, String name, DateTime createdAt, DateTime updatedAt});
}

/// @nodoc
class _$EquipmentCopyWithImpl<$Res, $Val extends Equipment>
    implements $EquipmentCopyWith<$Res> {
  _$EquipmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Equipment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EquipmentImplCopyWith<$Res>
    implements $EquipmentCopyWith<$Res> {
  factory _$$EquipmentImplCopyWith(
    _$EquipmentImpl value,
    $Res Function(_$EquipmentImpl) then,
  ) = __$$EquipmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, DateTime createdAt, DateTime updatedAt});
}

/// @nodoc
class __$$EquipmentImplCopyWithImpl<$Res>
    extends _$EquipmentCopyWithImpl<$Res, _$EquipmentImpl>
    implements _$$EquipmentImplCopyWith<$Res> {
  __$$EquipmentImplCopyWithImpl(
    _$EquipmentImpl _value,
    $Res Function(_$EquipmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Equipment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$EquipmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$EquipmentImpl extends _Equipment {
  const _$EquipmentImpl({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  @override
  final int id;
  @override
  final String name;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Equipment(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EquipmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, createdAt, updatedAt);

  /// Create a copy of Equipment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EquipmentImplCopyWith<_$EquipmentImpl> get copyWith =>
      __$$EquipmentImplCopyWithImpl<_$EquipmentImpl>(this, _$identity);
}

abstract class _Equipment extends Equipment {
  const factory _Equipment({
    required final int id,
    required final String name,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$EquipmentImpl;
  const _Equipment._() : super._();

  @override
  int get id;
  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Equipment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EquipmentImplCopyWith<_$EquipmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Tool {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ToolCopyWith<Tool> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolCopyWith<$Res> {
  factory $ToolCopyWith(Tool value, $Res Function(Tool) then) =
      _$ToolCopyWithImpl<$Res, Tool>;
  @useResult
  $Res call({int id, String name, DateTime createdAt, DateTime updatedAt});
}

/// @nodoc
class _$ToolCopyWithImpl<$Res, $Val extends Tool>
    implements $ToolCopyWith<$Res> {
  _$ToolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$ToolImplCopyWith(
    _$ToolImpl value,
    $Res Function(_$ToolImpl) then,
  ) = __$$ToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, DateTime createdAt, DateTime updatedAt});
}

/// @nodoc
class __$$ToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$ToolImpl>
    implements _$$ToolImplCopyWith<$Res> {
  __$$ToolImplCopyWithImpl(_$ToolImpl _value, $Res Function(_$ToolImpl) _then)
    : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ToolImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$ToolImpl extends _Tool {
  const _$ToolImpl({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  @override
  final int id;
  @override
  final String name;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Tool(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, createdAt, updatedAt);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolImplCopyWith<_$ToolImpl> get copyWith =>
      __$$ToolImplCopyWithImpl<_$ToolImpl>(this, _$identity);
}

abstract class _Tool extends Tool {
  const factory _Tool({
    required final int id,
    required final String name,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$ToolImpl;
  const _Tool._() : super._();

  @override
  int get id;
  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToolImplCopyWith<_$ToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
