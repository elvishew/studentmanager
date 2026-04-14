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
  List<Student> get filteredStudents;
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
mixin _$CourseTypeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CourseType> courseTypes) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CourseType> courseTypes)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CourseType> courseTypes)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseTypeInitial value) initial,
    required TResult Function(_CourseTypeLoading value) loading,
    required TResult Function(_CourseTypeData value) data,
    required TResult Function(_CourseTypeError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseTypeInitial value)? initial,
    TResult? Function(_CourseTypeLoading value)? loading,
    TResult? Function(_CourseTypeData value)? data,
    TResult? Function(_CourseTypeError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseTypeInitial value)? initial,
    TResult Function(_CourseTypeLoading value)? loading,
    TResult Function(_CourseTypeData value)? data,
    TResult Function(_CourseTypeError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseTypeStateCopyWith<$Res> {
  factory $CourseTypeStateCopyWith(
    CourseTypeState value,
    $Res Function(CourseTypeState) then,
  ) = _$CourseTypeStateCopyWithImpl<$Res, CourseTypeState>;
}

/// @nodoc
class _$CourseTypeStateCopyWithImpl<$Res, $Val extends CourseTypeState>
    implements $CourseTypeStateCopyWith<$Res> {
  _$CourseTypeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseTypeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CourseTypeInitialImplCopyWith<$Res> {
  factory _$$CourseTypeInitialImplCopyWith(
    _$CourseTypeInitialImpl value,
    $Res Function(_$CourseTypeInitialImpl) then,
  ) = __$$CourseTypeInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CourseTypeInitialImplCopyWithImpl<$Res>
    extends _$CourseTypeStateCopyWithImpl<$Res, _$CourseTypeInitialImpl>
    implements _$$CourseTypeInitialImplCopyWith<$Res> {
  __$$CourseTypeInitialImplCopyWithImpl(
    _$CourseTypeInitialImpl _value,
    $Res Function(_$CourseTypeInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseTypeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CourseTypeInitialImpl implements _CourseTypeInitial {
  const _$CourseTypeInitialImpl();

  @override
  String toString() {
    return 'CourseTypeState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CourseTypeInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CourseType> courseTypes) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CourseType> courseTypes)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CourseType> courseTypes)? data,
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
    required TResult Function(_CourseTypeInitial value) initial,
    required TResult Function(_CourseTypeLoading value) loading,
    required TResult Function(_CourseTypeData value) data,
    required TResult Function(_CourseTypeError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseTypeInitial value)? initial,
    TResult? Function(_CourseTypeLoading value)? loading,
    TResult? Function(_CourseTypeData value)? data,
    TResult? Function(_CourseTypeError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseTypeInitial value)? initial,
    TResult Function(_CourseTypeLoading value)? loading,
    TResult Function(_CourseTypeData value)? data,
    TResult Function(_CourseTypeError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _CourseTypeInitial implements CourseTypeState {
  const factory _CourseTypeInitial() = _$CourseTypeInitialImpl;
}

/// @nodoc
abstract class _$$CourseTypeLoadingImplCopyWith<$Res> {
  factory _$$CourseTypeLoadingImplCopyWith(
    _$CourseTypeLoadingImpl value,
    $Res Function(_$CourseTypeLoadingImpl) then,
  ) = __$$CourseTypeLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CourseTypeLoadingImplCopyWithImpl<$Res>
    extends _$CourseTypeStateCopyWithImpl<$Res, _$CourseTypeLoadingImpl>
    implements _$$CourseTypeLoadingImplCopyWith<$Res> {
  __$$CourseTypeLoadingImplCopyWithImpl(
    _$CourseTypeLoadingImpl _value,
    $Res Function(_$CourseTypeLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseTypeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CourseTypeLoadingImpl implements _CourseTypeLoading {
  const _$CourseTypeLoadingImpl();

  @override
  String toString() {
    return 'CourseTypeState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CourseTypeLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CourseType> courseTypes) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CourseType> courseTypes)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CourseType> courseTypes)? data,
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
    required TResult Function(_CourseTypeInitial value) initial,
    required TResult Function(_CourseTypeLoading value) loading,
    required TResult Function(_CourseTypeData value) data,
    required TResult Function(_CourseTypeError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseTypeInitial value)? initial,
    TResult? Function(_CourseTypeLoading value)? loading,
    TResult? Function(_CourseTypeData value)? data,
    TResult? Function(_CourseTypeError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseTypeInitial value)? initial,
    TResult Function(_CourseTypeLoading value)? loading,
    TResult Function(_CourseTypeData value)? data,
    TResult Function(_CourseTypeError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _CourseTypeLoading implements CourseTypeState {
  const factory _CourseTypeLoading() = _$CourseTypeLoadingImpl;
}

/// @nodoc
abstract class _$$CourseTypeDataImplCopyWith<$Res> {
  factory _$$CourseTypeDataImplCopyWith(
    _$CourseTypeDataImpl value,
    $Res Function(_$CourseTypeDataImpl) then,
  ) = __$$CourseTypeDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CourseType> courseTypes});
}

/// @nodoc
class __$$CourseTypeDataImplCopyWithImpl<$Res>
    extends _$CourseTypeStateCopyWithImpl<$Res, _$CourseTypeDataImpl>
    implements _$$CourseTypeDataImplCopyWith<$Res> {
  __$$CourseTypeDataImplCopyWithImpl(
    _$CourseTypeDataImpl _value,
    $Res Function(_$CourseTypeDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseTypeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? courseTypes = null}) {
    return _then(
      _$CourseTypeDataImpl(
        courseTypes: null == courseTypes
            ? _value._courseTypes
            : courseTypes // ignore: cast_nullable_to_non_nullable
                  as List<CourseType>,
      ),
    );
  }
}

/// @nodoc

class _$CourseTypeDataImpl implements _CourseTypeData {
  const _$CourseTypeDataImpl({required final List<CourseType> courseTypes})
    : _courseTypes = courseTypes;

  final List<CourseType> _courseTypes;
  @override
  List<CourseType> get courseTypes {
    if (_courseTypes is EqualUnmodifiableListView) return _courseTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courseTypes);
  }

  @override
  String toString() {
    return 'CourseTypeState.data(courseTypes: $courseTypes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseTypeDataImpl &&
            const DeepCollectionEquality().equals(
              other._courseTypes,
              _courseTypes,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_courseTypes),
  );

  /// Create a copy of CourseTypeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseTypeDataImplCopyWith<_$CourseTypeDataImpl> get copyWith =>
      __$$CourseTypeDataImplCopyWithImpl<_$CourseTypeDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CourseType> courseTypes) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return data(courseTypes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CourseType> courseTypes)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return data?.call(courseTypes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CourseType> courseTypes)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(courseTypes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseTypeInitial value) initial,
    required TResult Function(_CourseTypeLoading value) loading,
    required TResult Function(_CourseTypeData value) data,
    required TResult Function(_CourseTypeError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseTypeInitial value)? initial,
    TResult? Function(_CourseTypeLoading value)? loading,
    TResult? Function(_CourseTypeData value)? data,
    TResult? Function(_CourseTypeError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseTypeInitial value)? initial,
    TResult Function(_CourseTypeLoading value)? loading,
    TResult Function(_CourseTypeData value)? data,
    TResult Function(_CourseTypeError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _CourseTypeData implements CourseTypeState {
  const factory _CourseTypeData({required final List<CourseType> courseTypes}) =
      _$CourseTypeDataImpl;

  List<CourseType> get courseTypes;

  /// Create a copy of CourseTypeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseTypeDataImplCopyWith<_$CourseTypeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CourseTypeErrorImplCopyWith<$Res> {
  factory _$$CourseTypeErrorImplCopyWith(
    _$CourseTypeErrorImpl value,
    $Res Function(_$CourseTypeErrorImpl) then,
  ) = __$$CourseTypeErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class __$$CourseTypeErrorImplCopyWithImpl<$Res>
    extends _$CourseTypeStateCopyWithImpl<$Res, _$CourseTypeErrorImpl>
    implements _$$CourseTypeErrorImplCopyWith<$Res> {
  __$$CourseTypeErrorImplCopyWithImpl(
    _$CourseTypeErrorImpl _value,
    $Res Function(_$CourseTypeErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseTypeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? stackTrace = null}) {
    return _then(
      _$CourseTypeErrorImpl(
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

class _$CourseTypeErrorImpl implements _CourseTypeError {
  const _$CourseTypeErrorImpl(this.error, this.stackTrace);

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'CourseTypeState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseTypeErrorImpl &&
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

  /// Create a copy of CourseTypeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseTypeErrorImplCopyWith<_$CourseTypeErrorImpl> get copyWith =>
      __$$CourseTypeErrorImplCopyWithImpl<_$CourseTypeErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CourseType> courseTypes) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CourseType> courseTypes)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return error?.call(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CourseType> courseTypes)? data,
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
    required TResult Function(_CourseTypeInitial value) initial,
    required TResult Function(_CourseTypeLoading value) loading,
    required TResult Function(_CourseTypeData value) data,
    required TResult Function(_CourseTypeError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseTypeInitial value)? initial,
    TResult? Function(_CourseTypeLoading value)? loading,
    TResult? Function(_CourseTypeData value)? data,
    TResult? Function(_CourseTypeError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseTypeInitial value)? initial,
    TResult Function(_CourseTypeLoading value)? loading,
    TResult Function(_CourseTypeData value)? data,
    TResult Function(_CourseTypeError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _CourseTypeError implements CourseTypeState {
  const factory _CourseTypeError(
    final Object error,
    final StackTrace stackTrace,
  ) = _$CourseTypeErrorImpl;

  Object get error;
  StackTrace get stackTrace;

  /// Create a copy of CourseTypeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseTypeErrorImplCopyWith<_$CourseTypeErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CourseType {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  int get defaultDuration => throw _privateConstructorUsedError;
  bool get isGroup => throw _privateConstructorUsedError;
  int? get maxStudents => throw _privateConstructorUsedError;
  double get defaultStudentPrice => throw _privateConstructorUsedError;
  double get defaultSessionFee => throw _privateConstructorUsedError;
  CommissionType get defaultCommissionType =>
      throw _privateConstructorUsedError;
  double get defaultCommissionValue => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of CourseType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseTypeCopyWith<CourseType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseTypeCopyWith<$Res> {
  factory $CourseTypeCopyWith(
    CourseType value,
    $Res Function(CourseType) then,
  ) = _$CourseTypeCopyWithImpl<$Res, CourseType>;
  @useResult
  $Res call({
    int id,
    String name,
    String? icon,
    String? color,
    int defaultDuration,
    bool isGroup,
    int? maxStudents,
    double defaultStudentPrice,
    double defaultSessionFee,
    CommissionType defaultCommissionType,
    double defaultCommissionValue,
    int sortOrder,
    bool isDeprecated,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$CourseTypeCopyWithImpl<$Res, $Val extends CourseType>
    implements $CourseTypeCopyWith<$Res> {
  _$CourseTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = freezed,
    Object? color = freezed,
    Object? defaultDuration = null,
    Object? isGroup = null,
    Object? maxStudents = freezed,
    Object? defaultStudentPrice = null,
    Object? defaultSessionFee = null,
    Object? defaultCommissionType = null,
    Object? defaultCommissionValue = null,
    Object? sortOrder = null,
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
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
            defaultDuration: null == defaultDuration
                ? _value.defaultDuration
                : defaultDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            isGroup: null == isGroup
                ? _value.isGroup
                : isGroup // ignore: cast_nullable_to_non_nullable
                      as bool,
            maxStudents: freezed == maxStudents
                ? _value.maxStudents
                : maxStudents // ignore: cast_nullable_to_non_nullable
                      as int?,
            defaultStudentPrice: null == defaultStudentPrice
                ? _value.defaultStudentPrice
                : defaultStudentPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            defaultSessionFee: null == defaultSessionFee
                ? _value.defaultSessionFee
                : defaultSessionFee // ignore: cast_nullable_to_non_nullable
                      as double,
            defaultCommissionType: null == defaultCommissionType
                ? _value.defaultCommissionType
                : defaultCommissionType // ignore: cast_nullable_to_non_nullable
                      as CommissionType,
            defaultCommissionValue: null == defaultCommissionValue
                ? _value.defaultCommissionValue
                : defaultCommissionValue // ignore: cast_nullable_to_non_nullable
                      as double,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$CourseTypeImplCopyWith<$Res>
    implements $CourseTypeCopyWith<$Res> {
  factory _$$CourseTypeImplCopyWith(
    _$CourseTypeImpl value,
    $Res Function(_$CourseTypeImpl) then,
  ) = __$$CourseTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? icon,
    String? color,
    int defaultDuration,
    bool isGroup,
    int? maxStudents,
    double defaultStudentPrice,
    double defaultSessionFee,
    CommissionType defaultCommissionType,
    double defaultCommissionValue,
    int sortOrder,
    bool isDeprecated,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$CourseTypeImplCopyWithImpl<$Res>
    extends _$CourseTypeCopyWithImpl<$Res, _$CourseTypeImpl>
    implements _$$CourseTypeImplCopyWith<$Res> {
  __$$CourseTypeImplCopyWithImpl(
    _$CourseTypeImpl _value,
    $Res Function(_$CourseTypeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = freezed,
    Object? color = freezed,
    Object? defaultDuration = null,
    Object? isGroup = null,
    Object? maxStudents = freezed,
    Object? defaultStudentPrice = null,
    Object? defaultSessionFee = null,
    Object? defaultCommissionType = null,
    Object? defaultCommissionValue = null,
    Object? sortOrder = null,
    Object? isDeprecated = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$CourseTypeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
        defaultDuration: null == defaultDuration
            ? _value.defaultDuration
            : defaultDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        isGroup: null == isGroup
            ? _value.isGroup
            : isGroup // ignore: cast_nullable_to_non_nullable
                  as bool,
        maxStudents: freezed == maxStudents
            ? _value.maxStudents
            : maxStudents // ignore: cast_nullable_to_non_nullable
                  as int?,
        defaultStudentPrice: null == defaultStudentPrice
            ? _value.defaultStudentPrice
            : defaultStudentPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        defaultSessionFee: null == defaultSessionFee
            ? _value.defaultSessionFee
            : defaultSessionFee // ignore: cast_nullable_to_non_nullable
                  as double,
        defaultCommissionType: null == defaultCommissionType
            ? _value.defaultCommissionType
            : defaultCommissionType // ignore: cast_nullable_to_non_nullable
                  as CommissionType,
        defaultCommissionValue: null == defaultCommissionValue
            ? _value.defaultCommissionValue
            : defaultCommissionValue // ignore: cast_nullable_to_non_nullable
                  as double,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
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

class _$CourseTypeImpl extends _CourseType {
  const _$CourseTypeImpl({
    required this.id,
    required this.name,
    this.icon,
    this.color,
    this.defaultDuration = 60,
    this.isGroup = false,
    this.maxStudents,
    this.defaultStudentPrice = 0,
    this.defaultSessionFee = 0,
    this.defaultCommissionType = CommissionType.none,
    this.defaultCommissionValue = 0,
    this.sortOrder = 0,
    this.isDeprecated = false,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  @override
  final int id;
  @override
  final String name;
  @override
  final String? icon;
  @override
  final String? color;
  @override
  @JsonKey()
  final int defaultDuration;
  @override
  @JsonKey()
  final bool isGroup;
  @override
  final int? maxStudents;
  @override
  @JsonKey()
  final double defaultStudentPrice;
  @override
  @JsonKey()
  final double defaultSessionFee;
  @override
  @JsonKey()
  final CommissionType defaultCommissionType;
  @override
  @JsonKey()
  final double defaultCommissionValue;
  @override
  @JsonKey()
  final int sortOrder;
  @override
  @JsonKey()
  final bool isDeprecated;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CourseType(id: $id, name: $name, icon: $icon, color: $color, defaultDuration: $defaultDuration, isGroup: $isGroup, maxStudents: $maxStudents, defaultStudentPrice: $defaultStudentPrice, defaultSessionFee: $defaultSessionFee, defaultCommissionType: $defaultCommissionType, defaultCommissionValue: $defaultCommissionValue, sortOrder: $sortOrder, isDeprecated: $isDeprecated, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.defaultDuration, defaultDuration) ||
                other.defaultDuration == defaultDuration) &&
            (identical(other.isGroup, isGroup) || other.isGroup == isGroup) &&
            (identical(other.maxStudents, maxStudents) ||
                other.maxStudents == maxStudents) &&
            (identical(other.defaultStudentPrice, defaultStudentPrice) ||
                other.defaultStudentPrice == defaultStudentPrice) &&
            (identical(other.defaultSessionFee, defaultSessionFee) ||
                other.defaultSessionFee == defaultSessionFee) &&
            (identical(other.defaultCommissionType, defaultCommissionType) ||
                other.defaultCommissionType == defaultCommissionType) &&
            (identical(other.defaultCommissionValue, defaultCommissionValue) ||
                other.defaultCommissionValue == defaultCommissionValue) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
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
    icon,
    color,
    defaultDuration,
    isGroup,
    maxStudents,
    defaultStudentPrice,
    defaultSessionFee,
    defaultCommissionType,
    defaultCommissionValue,
    sortOrder,
    isDeprecated,
    createdAt,
    updatedAt,
  );

  /// Create a copy of CourseType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseTypeImplCopyWith<_$CourseTypeImpl> get copyWith =>
      __$$CourseTypeImplCopyWithImpl<_$CourseTypeImpl>(this, _$identity);
}

abstract class _CourseType extends CourseType {
  const factory _CourseType({
    required final int id,
    required final String name,
    final String? icon,
    final String? color,
    final int defaultDuration,
    final bool isGroup,
    final int? maxStudents,
    final double defaultStudentPrice,
    final double defaultSessionFee,
    final CommissionType defaultCommissionType,
    final double defaultCommissionValue,
    final int sortOrder,
    final bool isDeprecated,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$CourseTypeImpl;
  const _CourseType._() : super._();

  @override
  int get id;
  @override
  String get name;
  @override
  String? get icon;
  @override
  String? get color;
  @override
  int get defaultDuration;
  @override
  bool get isGroup;
  @override
  int? get maxStudents;
  @override
  double get defaultStudentPrice;
  @override
  double get defaultSessionFee;
  @override
  CommissionType get defaultCommissionType;
  @override
  double get defaultCommissionValue;
  @override
  int get sortOrder;
  @override
  bool get isDeprecated;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of CourseType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseTypeImplCopyWith<_$CourseTypeImpl> get copyWith =>
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
  CoursePlan? get selectedCoursePlan;
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
  int get goalId => throw _privateConstructorUsedError;
  String? get goalName => throw _privateConstructorUsedError;
  String? get blueprint => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  Student? get student => throw _privateConstructorUsedError;
  List<Session>? get sessions => throw _privateConstructorUsedError;
  int? get totalSessions => throw _privateConstructorUsedError;
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
    int goalId,
    String? goalName,
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
    Object? goalId = null,
    Object? goalName = freezed,
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
            goalId: null == goalId
                ? _value.goalId
                : goalId // ignore: cast_nullable_to_non_nullable
                      as int,
            goalName: freezed == goalName
                ? _value.goalName
                : goalName // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    int goalId,
    String? goalName,
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
    Object? goalId = null,
    Object? goalName = freezed,
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
        goalId: null == goalId
            ? _value.goalId
            : goalId // ignore: cast_nullable_to_non_nullable
                  as int,
        goalName: freezed == goalName
            ? _value.goalName
            : goalName // ignore: cast_nullable_to_non_nullable
                  as String?,
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
    required this.goalId,
    this.goalName,
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
  final int goalId;
  @override
  final String? goalName;
  @override
  final String? blueprint;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final Student? student;
  final List<Session>? _sessions;
  @override
  List<Session>? get sessions {
    final value = _sessions;
    if (value == null) return null;
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? totalSessions;
  @override
  final int? completedSessions;

  @override
  String toString() {
    return 'CoursePlan(id: $id, studentId: $studentId, goalId: $goalId, goalName: $goalName, blueprint: $blueprint, createdAt: $createdAt, updatedAt: $updatedAt, student: $student, sessions: $sessions, totalSessions: $totalSessions, completedSessions: $completedSessions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursePlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.goalName, goalName) ||
                other.goalName == goalName) &&
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
    goalId,
    goalName,
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
    required final int goalId,
    final String? goalName,
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
  int get goalId;
  @override
  String? get goalName;
  @override
  String? get blueprint;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  Student? get student;
  @override
  List<Session>? get sessions;
  @override
  int? get totalSessions;
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
  Session? get selectedSession;
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
  SessionStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<ContentBlock>? get contentBlocks => throw _privateConstructorUsedError;

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
    SessionStatus status,
    DateTime createdAt,
    DateTime updatedAt,
    List<ContentBlock>? contentBlocks,
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
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? contentBlocks = freezed,
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
            contentBlocks: freezed == contentBlocks
                ? _value.contentBlocks
                : contentBlocks // ignore: cast_nullable_to_non_nullable
                      as List<ContentBlock>?,
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
    SessionStatus status,
    DateTime createdAt,
    DateTime updatedAt,
    List<ContentBlock>? contentBlocks,
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
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? contentBlocks = freezed,
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
        contentBlocks: freezed == contentBlocks
            ? _value._contentBlocks
            : contentBlocks // ignore: cast_nullable_to_non_nullable
                  as List<ContentBlock>?,
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
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    final List<ContentBlock>? contentBlocks,
  }) : _contentBlocks = contentBlocks,
       super._();

  @override
  final int id;
  @override
  final int coursePlanId;
  @override
  final int sessionNumber;
  @override
  final SessionStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<ContentBlock>? _contentBlocks;
  @override
  List<ContentBlock>? get contentBlocks {
    final value = _contentBlocks;
    if (value == null) return null;
    if (_contentBlocks is EqualUnmodifiableListView) return _contentBlocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Session(id: $id, coursePlanId: $coursePlanId, sessionNumber: $sessionNumber, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, contentBlocks: $contentBlocks)';
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
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other._contentBlocks,
              _contentBlocks,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    coursePlanId,
    sessionNumber,
    status,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_contentBlocks),
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
    required final SessionStatus status,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final List<ContentBlock>? contentBlocks,
  }) = _$SessionImpl;
  const _Session._() : super._();

  @override
  int get id;
  @override
  int get coursePlanId;
  @override
  int get sessionNumber;
  @override
  SessionStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<ContentBlock>? get contentBlocks;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ScheduledClassState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ScheduledClassInitial value) initial,
    required TResult Function(_ScheduledClassLoading value) loading,
    required TResult Function(_ScheduledClassData value) data,
    required TResult Function(_ScheduledClassError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ScheduledClassInitial value)? initial,
    TResult? Function(_ScheduledClassLoading value)? loading,
    TResult? Function(_ScheduledClassData value)? data,
    TResult? Function(_ScheduledClassError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScheduledClassInitial value)? initial,
    TResult Function(_ScheduledClassLoading value)? loading,
    TResult Function(_ScheduledClassData value)? data,
    TResult Function(_ScheduledClassError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduledClassStateCopyWith<$Res> {
  factory $ScheduledClassStateCopyWith(
    ScheduledClassState value,
    $Res Function(ScheduledClassState) then,
  ) = _$ScheduledClassStateCopyWithImpl<$Res, ScheduledClassState>;
}

/// @nodoc
class _$ScheduledClassStateCopyWithImpl<$Res, $Val extends ScheduledClassState>
    implements $ScheduledClassStateCopyWith<$Res> {
  _$ScheduledClassStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduledClassState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ScheduledClassInitialImplCopyWith<$Res> {
  factory _$$ScheduledClassInitialImplCopyWith(
    _$ScheduledClassInitialImpl value,
    $Res Function(_$ScheduledClassInitialImpl) then,
  ) = __$$ScheduledClassInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScheduledClassInitialImplCopyWithImpl<$Res>
    extends _$ScheduledClassStateCopyWithImpl<$Res, _$ScheduledClassInitialImpl>
    implements _$$ScheduledClassInitialImplCopyWith<$Res> {
  __$$ScheduledClassInitialImplCopyWithImpl(
    _$ScheduledClassInitialImpl _value,
    $Res Function(_$ScheduledClassInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduledClassState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ScheduledClassInitialImpl implements _ScheduledClassInitial {
  const _$ScheduledClassInitialImpl();

  @override
  String toString() {
    return 'ScheduledClassState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledClassInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
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
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
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
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
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
    required TResult Function(_ScheduledClassInitial value) initial,
    required TResult Function(_ScheduledClassLoading value) loading,
    required TResult Function(_ScheduledClassData value) data,
    required TResult Function(_ScheduledClassError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ScheduledClassInitial value)? initial,
    TResult? Function(_ScheduledClassLoading value)? loading,
    TResult? Function(_ScheduledClassData value)? data,
    TResult? Function(_ScheduledClassError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScheduledClassInitial value)? initial,
    TResult Function(_ScheduledClassLoading value)? loading,
    TResult Function(_ScheduledClassData value)? data,
    TResult Function(_ScheduledClassError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ScheduledClassInitial implements ScheduledClassState {
  const factory _ScheduledClassInitial() = _$ScheduledClassInitialImpl;
}

/// @nodoc
abstract class _$$ScheduledClassLoadingImplCopyWith<$Res> {
  factory _$$ScheduledClassLoadingImplCopyWith(
    _$ScheduledClassLoadingImpl value,
    $Res Function(_$ScheduledClassLoadingImpl) then,
  ) = __$$ScheduledClassLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScheduledClassLoadingImplCopyWithImpl<$Res>
    extends _$ScheduledClassStateCopyWithImpl<$Res, _$ScheduledClassLoadingImpl>
    implements _$$ScheduledClassLoadingImplCopyWith<$Res> {
  __$$ScheduledClassLoadingImplCopyWithImpl(
    _$ScheduledClassLoadingImpl _value,
    $Res Function(_$ScheduledClassLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduledClassState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ScheduledClassLoadingImpl implements _ScheduledClassLoading {
  const _$ScheduledClassLoadingImpl();

  @override
  String toString() {
    return 'ScheduledClassState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledClassLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
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
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
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
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
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
    required TResult Function(_ScheduledClassInitial value) initial,
    required TResult Function(_ScheduledClassLoading value) loading,
    required TResult Function(_ScheduledClassData value) data,
    required TResult Function(_ScheduledClassError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ScheduledClassInitial value)? initial,
    TResult? Function(_ScheduledClassLoading value)? loading,
    TResult? Function(_ScheduledClassData value)? data,
    TResult? Function(_ScheduledClassError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScheduledClassInitial value)? initial,
    TResult Function(_ScheduledClassLoading value)? loading,
    TResult Function(_ScheduledClassData value)? data,
    TResult Function(_ScheduledClassError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ScheduledClassLoading implements ScheduledClassState {
  const factory _ScheduledClassLoading() = _$ScheduledClassLoadingImpl;
}

/// @nodoc
abstract class _$$ScheduledClassDataImplCopyWith<$Res> {
  factory _$$ScheduledClassDataImplCopyWith(
    _$ScheduledClassDataImpl value,
    $Res Function(_$ScheduledClassDataImpl) then,
  ) = __$$ScheduledClassDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<ScheduledClass> scheduledClasses,
    ScheduledClass? selectedClass,
  });

  $ScheduledClassCopyWith<$Res>? get selectedClass;
}

/// @nodoc
class __$$ScheduledClassDataImplCopyWithImpl<$Res>
    extends _$ScheduledClassStateCopyWithImpl<$Res, _$ScheduledClassDataImpl>
    implements _$$ScheduledClassDataImplCopyWith<$Res> {
  __$$ScheduledClassDataImplCopyWithImpl(
    _$ScheduledClassDataImpl _value,
    $Res Function(_$ScheduledClassDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduledClassState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduledClasses = null,
    Object? selectedClass = freezed,
  }) {
    return _then(
      _$ScheduledClassDataImpl(
        scheduledClasses: null == scheduledClasses
            ? _value._scheduledClasses
            : scheduledClasses // ignore: cast_nullable_to_non_nullable
                  as List<ScheduledClass>,
        selectedClass: freezed == selectedClass
            ? _value.selectedClass
            : selectedClass // ignore: cast_nullable_to_non_nullable
                  as ScheduledClass?,
      ),
    );
  }

  /// Create a copy of ScheduledClassState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScheduledClassCopyWith<$Res>? get selectedClass {
    if (_value.selectedClass == null) {
      return null;
    }

    return $ScheduledClassCopyWith<$Res>(_value.selectedClass!, (value) {
      return _then(_value.copyWith(selectedClass: value));
    });
  }
}

/// @nodoc

class _$ScheduledClassDataImpl implements _ScheduledClassData {
  const _$ScheduledClassDataImpl({
    required final List<ScheduledClass> scheduledClasses,
    this.selectedClass,
  }) : _scheduledClasses = scheduledClasses;

  final List<ScheduledClass> _scheduledClasses;
  @override
  List<ScheduledClass> get scheduledClasses {
    if (_scheduledClasses is EqualUnmodifiableListView)
      return _scheduledClasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scheduledClasses);
  }

  @override
  final ScheduledClass? selectedClass;

  @override
  String toString() {
    return 'ScheduledClassState.data(scheduledClasses: $scheduledClasses, selectedClass: $selectedClass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledClassDataImpl &&
            const DeepCollectionEquality().equals(
              other._scheduledClasses,
              _scheduledClasses,
            ) &&
            (identical(other.selectedClass, selectedClass) ||
                other.selectedClass == selectedClass));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_scheduledClasses),
    selectedClass,
  );

  /// Create a copy of ScheduledClassState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduledClassDataImplCopyWith<_$ScheduledClassDataImpl> get copyWith =>
      __$$ScheduledClassDataImplCopyWithImpl<_$ScheduledClassDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
    )
    data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return data(scheduledClasses, selectedClass);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
    )?
    data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return data?.call(scheduledClasses, selectedClass);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
    )?
    data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(scheduledClasses, selectedClass);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ScheduledClassInitial value) initial,
    required TResult Function(_ScheduledClassLoading value) loading,
    required TResult Function(_ScheduledClassData value) data,
    required TResult Function(_ScheduledClassError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ScheduledClassInitial value)? initial,
    TResult? Function(_ScheduledClassLoading value)? loading,
    TResult? Function(_ScheduledClassData value)? data,
    TResult? Function(_ScheduledClassError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScheduledClassInitial value)? initial,
    TResult Function(_ScheduledClassLoading value)? loading,
    TResult Function(_ScheduledClassData value)? data,
    TResult Function(_ScheduledClassError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _ScheduledClassData implements ScheduledClassState {
  const factory _ScheduledClassData({
    required final List<ScheduledClass> scheduledClasses,
    final ScheduledClass? selectedClass,
  }) = _$ScheduledClassDataImpl;

  List<ScheduledClass> get scheduledClasses;
  ScheduledClass? get selectedClass;

  /// Create a copy of ScheduledClassState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduledClassDataImplCopyWith<_$ScheduledClassDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ScheduledClassErrorImplCopyWith<$Res> {
  factory _$$ScheduledClassErrorImplCopyWith(
    _$ScheduledClassErrorImpl value,
    $Res Function(_$ScheduledClassErrorImpl) then,
  ) = __$$ScheduledClassErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class __$$ScheduledClassErrorImplCopyWithImpl<$Res>
    extends _$ScheduledClassStateCopyWithImpl<$Res, _$ScheduledClassErrorImpl>
    implements _$$ScheduledClassErrorImplCopyWith<$Res> {
  __$$ScheduledClassErrorImplCopyWithImpl(
    _$ScheduledClassErrorImpl _value,
    $Res Function(_$ScheduledClassErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduledClassState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? stackTrace = null}) {
    return _then(
      _$ScheduledClassErrorImpl(
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

class _$ScheduledClassErrorImpl implements _ScheduledClassError {
  const _$ScheduledClassErrorImpl(this.error, this.stackTrace);

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'ScheduledClassState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledClassErrorImpl &&
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

  /// Create a copy of ScheduledClassState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduledClassErrorImplCopyWith<_$ScheduledClassErrorImpl> get copyWith =>
      __$$ScheduledClassErrorImplCopyWithImpl<_$ScheduledClassErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
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
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
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
      List<ScheduledClass> scheduledClasses,
      ScheduledClass? selectedClass,
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
    required TResult Function(_ScheduledClassInitial value) initial,
    required TResult Function(_ScheduledClassLoading value) loading,
    required TResult Function(_ScheduledClassData value) data,
    required TResult Function(_ScheduledClassError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ScheduledClassInitial value)? initial,
    TResult? Function(_ScheduledClassLoading value)? loading,
    TResult? Function(_ScheduledClassData value)? data,
    TResult? Function(_ScheduledClassError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScheduledClassInitial value)? initial,
    TResult Function(_ScheduledClassLoading value)? loading,
    TResult Function(_ScheduledClassData value)? data,
    TResult Function(_ScheduledClassError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ScheduledClassError implements ScheduledClassState {
  const factory _ScheduledClassError(
    final Object error,
    final StackTrace stackTrace,
  ) = _$ScheduledClassErrorImpl;

  Object get error;
  StackTrace get stackTrace;

  /// Create a copy of ScheduledClassState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduledClassErrorImplCopyWith<_$ScheduledClassErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ScheduledClass {
  int get id => throw _privateConstructorUsedError;
  int get courseTypeId => throw _privateConstructorUsedError;
  String? get courseTypeName => throw _privateConstructorUsedError;
  String? get courseTypeColor => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  ScheduledClassStatus get status => throw _privateConstructorUsedError;
  int? get sessionId => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  double get teacherSessionFee => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<ClassParticipant>? get participants =>
      throw _privateConstructorUsedError;
  CourseType? get courseType => throw _privateConstructorUsedError;

  /// Create a copy of ScheduledClass
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduledClassCopyWith<ScheduledClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduledClassCopyWith<$Res> {
  factory $ScheduledClassCopyWith(
    ScheduledClass value,
    $Res Function(ScheduledClass) then,
  ) = _$ScheduledClassCopyWithImpl<$Res, ScheduledClass>;
  @useResult
  $Res call({
    int id,
    int courseTypeId,
    String? courseTypeName,
    String? courseTypeColor,
    String? title,
    DateTime startTime,
    DateTime endTime,
    ScheduledClassStatus status,
    int? sessionId,
    String? location,
    String? notes,
    double teacherSessionFee,
    DateTime createdAt,
    DateTime updatedAt,
    List<ClassParticipant>? participants,
    CourseType? courseType,
  });

  $CourseTypeCopyWith<$Res>? get courseType;
}

/// @nodoc
class _$ScheduledClassCopyWithImpl<$Res, $Val extends ScheduledClass>
    implements $ScheduledClassCopyWith<$Res> {
  _$ScheduledClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduledClass
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseTypeId = null,
    Object? courseTypeName = freezed,
    Object? courseTypeColor = freezed,
    Object? title = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? sessionId = freezed,
    Object? location = freezed,
    Object? notes = freezed,
    Object? teacherSessionFee = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? participants = freezed,
    Object? courseType = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            courseTypeId: null == courseTypeId
                ? _value.courseTypeId
                : courseTypeId // ignore: cast_nullable_to_non_nullable
                      as int,
            courseTypeName: freezed == courseTypeName
                ? _value.courseTypeName
                : courseTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            courseTypeColor: freezed == courseTypeColor
                ? _value.courseTypeColor
                : courseTypeColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ScheduledClassStatus,
            sessionId: freezed == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as int?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            teacherSessionFee: null == teacherSessionFee
                ? _value.teacherSessionFee
                : teacherSessionFee // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            participants: freezed == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as List<ClassParticipant>?,
            courseType: freezed == courseType
                ? _value.courseType
                : courseType // ignore: cast_nullable_to_non_nullable
                      as CourseType?,
          )
          as $Val,
    );
  }

  /// Create a copy of ScheduledClass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseTypeCopyWith<$Res>? get courseType {
    if (_value.courseType == null) {
      return null;
    }

    return $CourseTypeCopyWith<$Res>(_value.courseType!, (value) {
      return _then(_value.copyWith(courseType: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScheduledClassImplCopyWith<$Res>
    implements $ScheduledClassCopyWith<$Res> {
  factory _$$ScheduledClassImplCopyWith(
    _$ScheduledClassImpl value,
    $Res Function(_$ScheduledClassImpl) then,
  ) = __$$ScheduledClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int courseTypeId,
    String? courseTypeName,
    String? courseTypeColor,
    String? title,
    DateTime startTime,
    DateTime endTime,
    ScheduledClassStatus status,
    int? sessionId,
    String? location,
    String? notes,
    double teacherSessionFee,
    DateTime createdAt,
    DateTime updatedAt,
    List<ClassParticipant>? participants,
    CourseType? courseType,
  });

  @override
  $CourseTypeCopyWith<$Res>? get courseType;
}

/// @nodoc
class __$$ScheduledClassImplCopyWithImpl<$Res>
    extends _$ScheduledClassCopyWithImpl<$Res, _$ScheduledClassImpl>
    implements _$$ScheduledClassImplCopyWith<$Res> {
  __$$ScheduledClassImplCopyWithImpl(
    _$ScheduledClassImpl _value,
    $Res Function(_$ScheduledClassImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduledClass
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseTypeId = null,
    Object? courseTypeName = freezed,
    Object? courseTypeColor = freezed,
    Object? title = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? sessionId = freezed,
    Object? location = freezed,
    Object? notes = freezed,
    Object? teacherSessionFee = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? participants = freezed,
    Object? courseType = freezed,
  }) {
    return _then(
      _$ScheduledClassImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        courseTypeId: null == courseTypeId
            ? _value.courseTypeId
            : courseTypeId // ignore: cast_nullable_to_non_nullable
                  as int,
        courseTypeName: freezed == courseTypeName
            ? _value.courseTypeName
            : courseTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        courseTypeColor: freezed == courseTypeColor
            ? _value.courseTypeColor
            : courseTypeColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ScheduledClassStatus,
        sessionId: freezed == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as int?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        teacherSessionFee: null == teacherSessionFee
            ? _value.teacherSessionFee
            : teacherSessionFee // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        participants: freezed == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as List<ClassParticipant>?,
        courseType: freezed == courseType
            ? _value.courseType
            : courseType // ignore: cast_nullable_to_non_nullable
                  as CourseType?,
      ),
    );
  }
}

/// @nodoc

class _$ScheduledClassImpl extends _ScheduledClass {
  const _$ScheduledClassImpl({
    required this.id,
    required this.courseTypeId,
    this.courseTypeName,
    this.courseTypeColor,
    this.title,
    required this.startTime,
    required this.endTime,
    this.status = ScheduledClassStatus.scheduled,
    this.sessionId,
    this.location,
    this.notes,
    this.teacherSessionFee = 0,
    required this.createdAt,
    required this.updatedAt,
    final List<ClassParticipant>? participants,
    this.courseType,
  }) : _participants = participants,
       super._();

  @override
  final int id;
  @override
  final int courseTypeId;
  @override
  final String? courseTypeName;
  @override
  final String? courseTypeColor;
  @override
  final String? title;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  @JsonKey()
  final ScheduledClassStatus status;
  @override
  final int? sessionId;
  @override
  final String? location;
  @override
  final String? notes;
  @override
  @JsonKey()
  final double teacherSessionFee;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<ClassParticipant>? _participants;
  @override
  List<ClassParticipant>? get participants {
    final value = _participants;
    if (value == null) return null;
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final CourseType? courseType;

  @override
  String toString() {
    return 'ScheduledClass(id: $id, courseTypeId: $courseTypeId, courseTypeName: $courseTypeName, courseTypeColor: $courseTypeColor, title: $title, startTime: $startTime, endTime: $endTime, status: $status, sessionId: $sessionId, location: $location, notes: $notes, teacherSessionFee: $teacherSessionFee, createdAt: $createdAt, updatedAt: $updatedAt, participants: $participants, courseType: $courseType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledClassImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseTypeId, courseTypeId) ||
                other.courseTypeId == courseTypeId) &&
            (identical(other.courseTypeName, courseTypeName) ||
                other.courseTypeName == courseTypeName) &&
            (identical(other.courseTypeColor, courseTypeColor) ||
                other.courseTypeColor == courseTypeColor) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.teacherSessionFee, teacherSessionFee) ||
                other.teacherSessionFee == teacherSessionFee) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    courseTypeId,
    courseTypeName,
    courseTypeColor,
    title,
    startTime,
    endTime,
    status,
    sessionId,
    location,
    notes,
    teacherSessionFee,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_participants),
    courseType,
  );

  /// Create a copy of ScheduledClass
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduledClassImplCopyWith<_$ScheduledClassImpl> get copyWith =>
      __$$ScheduledClassImplCopyWithImpl<_$ScheduledClassImpl>(
        this,
        _$identity,
      );
}

abstract class _ScheduledClass extends ScheduledClass {
  const factory _ScheduledClass({
    required final int id,
    required final int courseTypeId,
    final String? courseTypeName,
    final String? courseTypeColor,
    final String? title,
    required final DateTime startTime,
    required final DateTime endTime,
    final ScheduledClassStatus status,
    final int? sessionId,
    final String? location,
    final String? notes,
    final double teacherSessionFee,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final List<ClassParticipant>? participants,
    final CourseType? courseType,
  }) = _$ScheduledClassImpl;
  const _ScheduledClass._() : super._();

  @override
  int get id;
  @override
  int get courseTypeId;
  @override
  String? get courseTypeName;
  @override
  String? get courseTypeColor;
  @override
  String? get title;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  ScheduledClassStatus get status;
  @override
  int? get sessionId;
  @override
  String? get location;
  @override
  String? get notes;
  @override
  double get teacherSessionFee;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<ClassParticipant>? get participants;
  @override
  CourseType? get courseType;

  /// Create a copy of ScheduledClass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduledClassImplCopyWith<_$ScheduledClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClassParticipant {
  int get id => throw _privateConstructorUsedError;
  int get scheduledClassId => throw _privateConstructorUsedError;
  int? get studentId => throw _privateConstructorUsedError;
  String? get guestName => throw _privateConstructorUsedError;
  AttendanceStatus get attendance => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get studentName => throw _privateConstructorUsedError;

  /// Create a copy of ClassParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassParticipantCopyWith<ClassParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassParticipantCopyWith<$Res> {
  factory $ClassParticipantCopyWith(
    ClassParticipant value,
    $Res Function(ClassParticipant) then,
  ) = _$ClassParticipantCopyWithImpl<$Res, ClassParticipant>;
  @useResult
  $Res call({
    int id,
    int scheduledClassId,
    int? studentId,
    String? guestName,
    AttendanceStatus attendance,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
    String? studentName,
  });
}

/// @nodoc
class _$ClassParticipantCopyWithImpl<$Res, $Val extends ClassParticipant>
    implements $ClassParticipantCopyWith<$Res> {
  _$ClassParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduledClassId = null,
    Object? studentId = freezed,
    Object? guestName = freezed,
    Object? attendance = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? studentName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            scheduledClassId: null == scheduledClassId
                ? _value.scheduledClassId
                : scheduledClassId // ignore: cast_nullable_to_non_nullable
                      as int,
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            guestName: freezed == guestName
                ? _value.guestName
                : guestName // ignore: cast_nullable_to_non_nullable
                      as String?,
            attendance: null == attendance
                ? _value.attendance
                : attendance // ignore: cast_nullable_to_non_nullable
                      as AttendanceStatus,
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
            studentName: freezed == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassParticipantImplCopyWith<$Res>
    implements $ClassParticipantCopyWith<$Res> {
  factory _$$ClassParticipantImplCopyWith(
    _$ClassParticipantImpl value,
    $Res Function(_$ClassParticipantImpl) then,
  ) = __$$ClassParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int scheduledClassId,
    int? studentId,
    String? guestName,
    AttendanceStatus attendance,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
    String? studentName,
  });
}

/// @nodoc
class __$$ClassParticipantImplCopyWithImpl<$Res>
    extends _$ClassParticipantCopyWithImpl<$Res, _$ClassParticipantImpl>
    implements _$$ClassParticipantImplCopyWith<$Res> {
  __$$ClassParticipantImplCopyWithImpl(
    _$ClassParticipantImpl _value,
    $Res Function(_$ClassParticipantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduledClassId = null,
    Object? studentId = freezed,
    Object? guestName = freezed,
    Object? attendance = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? studentName = freezed,
  }) {
    return _then(
      _$ClassParticipantImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduledClassId: null == scheduledClassId
            ? _value.scheduledClassId
            : scheduledClassId // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        guestName: freezed == guestName
            ? _value.guestName
            : guestName // ignore: cast_nullable_to_non_nullable
                  as String?,
        attendance: null == attendance
            ? _value.attendance
            : attendance // ignore: cast_nullable_to_non_nullable
                  as AttendanceStatus,
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
        studentName: freezed == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ClassParticipantImpl extends _ClassParticipant {
  const _$ClassParticipantImpl({
    required this.id,
    required this.scheduledClassId,
    this.studentId,
    this.guestName,
    this.attendance = AttendanceStatus.pending,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.studentName,
  }) : super._();

  @override
  final int id;
  @override
  final int scheduledClassId;
  @override
  final int? studentId;
  @override
  final String? guestName;
  @override
  @JsonKey()
  final AttendanceStatus attendance;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? studentName;

  @override
  String toString() {
    return 'ClassParticipant(id: $id, scheduledClassId: $scheduledClassId, studentId: $studentId, guestName: $guestName, attendance: $attendance, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, studentName: $studentName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassParticipantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scheduledClassId, scheduledClassId) ||
                other.scheduledClassId == scheduledClassId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.guestName, guestName) ||
                other.guestName == guestName) &&
            (identical(other.attendance, attendance) ||
                other.attendance == attendance) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    scheduledClassId,
    studentId,
    guestName,
    attendance,
    notes,
    createdAt,
    updatedAt,
    studentName,
  );

  /// Create a copy of ClassParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassParticipantImplCopyWith<_$ClassParticipantImpl> get copyWith =>
      __$$ClassParticipantImplCopyWithImpl<_$ClassParticipantImpl>(
        this,
        _$identity,
      );
}

abstract class _ClassParticipant extends ClassParticipant {
  const factory _ClassParticipant({
    required final int id,
    required final int scheduledClassId,
    final int? studentId,
    final String? guestName,
    final AttendanceStatus attendance,
    final String? notes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final String? studentName,
  }) = _$ClassParticipantImpl;
  const _ClassParticipant._() : super._();

  @override
  int get id;
  @override
  int get scheduledClassId;
  @override
  int? get studentId;
  @override
  String? get guestName;
  @override
  AttendanceStatus get attendance;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get studentName;

  /// Create a copy of ClassParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassParticipantImplCopyWith<_$ClassParticipantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaymentState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StudentPayment> payments) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StudentPayment> payments)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StudentPayment> payments)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentInitial value) initial,
    required TResult Function(_PaymentLoading value) loading,
    required TResult Function(_PaymentData value) data,
    required TResult Function(_PaymentError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentInitial value)? initial,
    TResult? Function(_PaymentLoading value)? loading,
    TResult? Function(_PaymentData value)? data,
    TResult? Function(_PaymentError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentInitial value)? initial,
    TResult Function(_PaymentLoading value)? loading,
    TResult Function(_PaymentData value)? data,
    TResult Function(_PaymentError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentStateCopyWith<$Res> {
  factory $PaymentStateCopyWith(
    PaymentState value,
    $Res Function(PaymentState) then,
  ) = _$PaymentStateCopyWithImpl<$Res, PaymentState>;
}

/// @nodoc
class _$PaymentStateCopyWithImpl<$Res, $Val extends PaymentState>
    implements $PaymentStateCopyWith<$Res> {
  _$PaymentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PaymentInitialImplCopyWith<$Res> {
  factory _$$PaymentInitialImplCopyWith(
    _$PaymentInitialImpl value,
    $Res Function(_$PaymentInitialImpl) then,
  ) = __$$PaymentInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PaymentInitialImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$PaymentInitialImpl>
    implements _$$PaymentInitialImplCopyWith<$Res> {
  __$$PaymentInitialImplCopyWithImpl(
    _$PaymentInitialImpl _value,
    $Res Function(_$PaymentInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PaymentInitialImpl implements _PaymentInitial {
  const _$PaymentInitialImpl();

  @override
  String toString() {
    return 'PaymentState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PaymentInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StudentPayment> payments) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StudentPayment> payments)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StudentPayment> payments)? data,
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
    required TResult Function(_PaymentInitial value) initial,
    required TResult Function(_PaymentLoading value) loading,
    required TResult Function(_PaymentData value) data,
    required TResult Function(_PaymentError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentInitial value)? initial,
    TResult? Function(_PaymentLoading value)? loading,
    TResult? Function(_PaymentData value)? data,
    TResult? Function(_PaymentError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentInitial value)? initial,
    TResult Function(_PaymentLoading value)? loading,
    TResult Function(_PaymentData value)? data,
    TResult Function(_PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _PaymentInitial implements PaymentState {
  const factory _PaymentInitial() = _$PaymentInitialImpl;
}

/// @nodoc
abstract class _$$PaymentLoadingImplCopyWith<$Res> {
  factory _$$PaymentLoadingImplCopyWith(
    _$PaymentLoadingImpl value,
    $Res Function(_$PaymentLoadingImpl) then,
  ) = __$$PaymentLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PaymentLoadingImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$PaymentLoadingImpl>
    implements _$$PaymentLoadingImplCopyWith<$Res> {
  __$$PaymentLoadingImplCopyWithImpl(
    _$PaymentLoadingImpl _value,
    $Res Function(_$PaymentLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PaymentLoadingImpl implements _PaymentLoading {
  const _$PaymentLoadingImpl();

  @override
  String toString() {
    return 'PaymentState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PaymentLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StudentPayment> payments) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StudentPayment> payments)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StudentPayment> payments)? data,
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
    required TResult Function(_PaymentInitial value) initial,
    required TResult Function(_PaymentLoading value) loading,
    required TResult Function(_PaymentData value) data,
    required TResult Function(_PaymentError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentInitial value)? initial,
    TResult? Function(_PaymentLoading value)? loading,
    TResult? Function(_PaymentData value)? data,
    TResult? Function(_PaymentError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentInitial value)? initial,
    TResult Function(_PaymentLoading value)? loading,
    TResult Function(_PaymentData value)? data,
    TResult Function(_PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _PaymentLoading implements PaymentState {
  const factory _PaymentLoading() = _$PaymentLoadingImpl;
}

/// @nodoc
abstract class _$$PaymentDataImplCopyWith<$Res> {
  factory _$$PaymentDataImplCopyWith(
    _$PaymentDataImpl value,
    $Res Function(_$PaymentDataImpl) then,
  ) = __$$PaymentDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<StudentPayment> payments});
}

/// @nodoc
class __$$PaymentDataImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$PaymentDataImpl>
    implements _$$PaymentDataImplCopyWith<$Res> {
  __$$PaymentDataImplCopyWithImpl(
    _$PaymentDataImpl _value,
    $Res Function(_$PaymentDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? payments = null}) {
    return _then(
      _$PaymentDataImpl(
        payments: null == payments
            ? _value._payments
            : payments // ignore: cast_nullable_to_non_nullable
                  as List<StudentPayment>,
      ),
    );
  }
}

/// @nodoc

class _$PaymentDataImpl implements _PaymentData {
  const _$PaymentDataImpl({required final List<StudentPayment> payments})
    : _payments = payments;

  final List<StudentPayment> _payments;
  @override
  List<StudentPayment> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  String toString() {
    return 'PaymentState.data(payments: $payments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentDataImpl &&
            const DeepCollectionEquality().equals(other._payments, _payments));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_payments));

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentDataImplCopyWith<_$PaymentDataImpl> get copyWith =>
      __$$PaymentDataImplCopyWithImpl<_$PaymentDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StudentPayment> payments) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return data(payments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StudentPayment> payments)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return data?.call(payments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StudentPayment> payments)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(payments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentInitial value) initial,
    required TResult Function(_PaymentLoading value) loading,
    required TResult Function(_PaymentData value) data,
    required TResult Function(_PaymentError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentInitial value)? initial,
    TResult? Function(_PaymentLoading value)? loading,
    TResult? Function(_PaymentData value)? data,
    TResult? Function(_PaymentError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentInitial value)? initial,
    TResult Function(_PaymentLoading value)? loading,
    TResult Function(_PaymentData value)? data,
    TResult Function(_PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _PaymentData implements PaymentState {
  const factory _PaymentData({required final List<StudentPayment> payments}) =
      _$PaymentDataImpl;

  List<StudentPayment> get payments;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentDataImplCopyWith<_$PaymentDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentErrorImplCopyWith<$Res> {
  factory _$$PaymentErrorImplCopyWith(
    _$PaymentErrorImpl value,
    $Res Function(_$PaymentErrorImpl) then,
  ) = __$$PaymentErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class __$$PaymentErrorImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$PaymentErrorImpl>
    implements _$$PaymentErrorImplCopyWith<$Res> {
  __$$PaymentErrorImplCopyWithImpl(
    _$PaymentErrorImpl _value,
    $Res Function(_$PaymentErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? stackTrace = null}) {
    return _then(
      _$PaymentErrorImpl(
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

class _$PaymentErrorImpl implements _PaymentError {
  const _$PaymentErrorImpl(this.error, this.stackTrace);

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'PaymentState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentErrorImpl &&
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

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentErrorImplCopyWith<_$PaymentErrorImpl> get copyWith =>
      __$$PaymentErrorImplCopyWithImpl<_$PaymentErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StudentPayment> payments) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StudentPayment> payments)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return error?.call(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StudentPayment> payments)? data,
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
    required TResult Function(_PaymentInitial value) initial,
    required TResult Function(_PaymentLoading value) loading,
    required TResult Function(_PaymentData value) data,
    required TResult Function(_PaymentError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentInitial value)? initial,
    TResult? Function(_PaymentLoading value)? loading,
    TResult? Function(_PaymentData value)? data,
    TResult? Function(_PaymentError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentInitial value)? initial,
    TResult Function(_PaymentLoading value)? loading,
    TResult Function(_PaymentData value)? data,
    TResult Function(_PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _PaymentError implements PaymentState {
  const factory _PaymentError(final Object error, final StackTrace stackTrace) =
      _$PaymentErrorImpl;

  Object get error;
  StackTrace get stackTrace;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentErrorImplCopyWith<_$PaymentErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StudentPayment {
  int get id => throw _privateConstructorUsedError;
  int get studentId => throw _privateConstructorUsedError;
  int? get courseTypeId => throw _privateConstructorUsedError;
  int? get coursePlanId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  CommissionType get commissionType => throw _privateConstructorUsedError;
  double get commissionValue => throw _privateConstructorUsedError;
  double get commissionEarned => throw _privateConstructorUsedError;
  DateTime get paidAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get studentName => throw _privateConstructorUsedError;
  String? get courseTypeName => throw _privateConstructorUsedError;

  /// Create a copy of StudentPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentPaymentCopyWith<StudentPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentPaymentCopyWith<$Res> {
  factory $StudentPaymentCopyWith(
    StudentPayment value,
    $Res Function(StudentPayment) then,
  ) = _$StudentPaymentCopyWithImpl<$Res, StudentPayment>;
  @useResult
  $Res call({
    int id,
    int studentId,
    int? courseTypeId,
    int? coursePlanId,
    double amount,
    String? description,
    CommissionType commissionType,
    double commissionValue,
    double commissionEarned,
    DateTime paidAt,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
    String? studentName,
    String? courseTypeName,
  });
}

/// @nodoc
class _$StudentPaymentCopyWithImpl<$Res, $Val extends StudentPayment>
    implements $StudentPaymentCopyWith<$Res> {
  _$StudentPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? courseTypeId = freezed,
    Object? coursePlanId = freezed,
    Object? amount = null,
    Object? description = freezed,
    Object? commissionType = null,
    Object? commissionValue = null,
    Object? commissionEarned = null,
    Object? paidAt = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? studentName = freezed,
    Object? courseTypeName = freezed,
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
            courseTypeId: freezed == courseTypeId
                ? _value.courseTypeId
                : courseTypeId // ignore: cast_nullable_to_non_nullable
                      as int?,
            coursePlanId: freezed == coursePlanId
                ? _value.coursePlanId
                : coursePlanId // ignore: cast_nullable_to_non_nullable
                      as int?,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            commissionType: null == commissionType
                ? _value.commissionType
                : commissionType // ignore: cast_nullable_to_non_nullable
                      as CommissionType,
            commissionValue: null == commissionValue
                ? _value.commissionValue
                : commissionValue // ignore: cast_nullable_to_non_nullable
                      as double,
            commissionEarned: null == commissionEarned
                ? _value.commissionEarned
                : commissionEarned // ignore: cast_nullable_to_non_nullable
                      as double,
            paidAt: null == paidAt
                ? _value.paidAt
                : paidAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
            studentName: freezed == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            courseTypeName: freezed == courseTypeName
                ? _value.courseTypeName
                : courseTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudentPaymentImplCopyWith<$Res>
    implements $StudentPaymentCopyWith<$Res> {
  factory _$$StudentPaymentImplCopyWith(
    _$StudentPaymentImpl value,
    $Res Function(_$StudentPaymentImpl) then,
  ) = __$$StudentPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int studentId,
    int? courseTypeId,
    int? coursePlanId,
    double amount,
    String? description,
    CommissionType commissionType,
    double commissionValue,
    double commissionEarned,
    DateTime paidAt,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
    String? studentName,
    String? courseTypeName,
  });
}

/// @nodoc
class __$$StudentPaymentImplCopyWithImpl<$Res>
    extends _$StudentPaymentCopyWithImpl<$Res, _$StudentPaymentImpl>
    implements _$$StudentPaymentImplCopyWith<$Res> {
  __$$StudentPaymentImplCopyWithImpl(
    _$StudentPaymentImpl _value,
    $Res Function(_$StudentPaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? courseTypeId = freezed,
    Object? coursePlanId = freezed,
    Object? amount = null,
    Object? description = freezed,
    Object? commissionType = null,
    Object? commissionValue = null,
    Object? commissionEarned = null,
    Object? paidAt = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? studentName = freezed,
    Object? courseTypeName = freezed,
  }) {
    return _then(
      _$StudentPaymentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        courseTypeId: freezed == courseTypeId
            ? _value.courseTypeId
            : courseTypeId // ignore: cast_nullable_to_non_nullable
                  as int?,
        coursePlanId: freezed == coursePlanId
            ? _value.coursePlanId
            : coursePlanId // ignore: cast_nullable_to_non_nullable
                  as int?,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        commissionType: null == commissionType
            ? _value.commissionType
            : commissionType // ignore: cast_nullable_to_non_nullable
                  as CommissionType,
        commissionValue: null == commissionValue
            ? _value.commissionValue
            : commissionValue // ignore: cast_nullable_to_non_nullable
                  as double,
        commissionEarned: null == commissionEarned
            ? _value.commissionEarned
            : commissionEarned // ignore: cast_nullable_to_non_nullable
                  as double,
        paidAt: null == paidAt
            ? _value.paidAt
            : paidAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
        studentName: freezed == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        courseTypeName: freezed == courseTypeName
            ? _value.courseTypeName
            : courseTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$StudentPaymentImpl extends _StudentPayment {
  const _$StudentPaymentImpl({
    required this.id,
    required this.studentId,
    this.courseTypeId,
    this.coursePlanId,
    this.amount = 0,
    this.description,
    this.commissionType = CommissionType.none,
    this.commissionValue = 0,
    this.commissionEarned = 0,
    required this.paidAt,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.studentName,
    this.courseTypeName,
  }) : super._();

  @override
  final int id;
  @override
  final int studentId;
  @override
  final int? courseTypeId;
  @override
  final int? coursePlanId;
  @override
  @JsonKey()
  final double amount;
  @override
  final String? description;
  @override
  @JsonKey()
  final CommissionType commissionType;
  @override
  @JsonKey()
  final double commissionValue;
  @override
  @JsonKey()
  final double commissionEarned;
  @override
  final DateTime paidAt;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? studentName;
  @override
  final String? courseTypeName;

  @override
  String toString() {
    return 'StudentPayment(id: $id, studentId: $studentId, courseTypeId: $courseTypeId, coursePlanId: $coursePlanId, amount: $amount, description: $description, commissionType: $commissionType, commissionValue: $commissionValue, commissionEarned: $commissionEarned, paidAt: $paidAt, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, studentName: $studentName, courseTypeName: $courseTypeName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentPaymentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.courseTypeId, courseTypeId) ||
                other.courseTypeId == courseTypeId) &&
            (identical(other.coursePlanId, coursePlanId) ||
                other.coursePlanId == coursePlanId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.commissionType, commissionType) ||
                other.commissionType == commissionType) &&
            (identical(other.commissionValue, commissionValue) ||
                other.commissionValue == commissionValue) &&
            (identical(other.commissionEarned, commissionEarned) ||
                other.commissionEarned == commissionEarned) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.courseTypeName, courseTypeName) ||
                other.courseTypeName == courseTypeName));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    studentId,
    courseTypeId,
    coursePlanId,
    amount,
    description,
    commissionType,
    commissionValue,
    commissionEarned,
    paidAt,
    notes,
    createdAt,
    updatedAt,
    studentName,
    courseTypeName,
  );

  /// Create a copy of StudentPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentPaymentImplCopyWith<_$StudentPaymentImpl> get copyWith =>
      __$$StudentPaymentImplCopyWithImpl<_$StudentPaymentImpl>(
        this,
        _$identity,
      );
}

abstract class _StudentPayment extends StudentPayment {
  const factory _StudentPayment({
    required final int id,
    required final int studentId,
    final int? courseTypeId,
    final int? coursePlanId,
    final double amount,
    final String? description,
    final CommissionType commissionType,
    final double commissionValue,
    final double commissionEarned,
    required final DateTime paidAt,
    final String? notes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final String? studentName,
    final String? courseTypeName,
  }) = _$StudentPaymentImpl;
  const _StudentPayment._() : super._();

  @override
  int get id;
  @override
  int get studentId;
  @override
  int? get courseTypeId;
  @override
  int? get coursePlanId;
  @override
  double get amount;
  @override
  String? get description;
  @override
  CommissionType get commissionType;
  @override
  double get commissionValue;
  @override
  double get commissionEarned;
  @override
  DateTime get paidAt;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get studentName;
  @override
  String? get courseTypeName;

  /// Create a copy of StudentPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentPaymentImplCopyWith<_$StudentPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ContentField {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  FieldType get fieldType => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<FieldOption>? get options => throw _privateConstructorUsedError;

  /// Create a copy of ContentField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentFieldCopyWith<ContentField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentFieldCopyWith<$Res> {
  factory $ContentFieldCopyWith(
    ContentField value,
    $Res Function(ContentField) then,
  ) = _$ContentFieldCopyWithImpl<$Res, ContentField>;
  @useResult
  $Res call({
    int id,
    String name,
    FieldType fieldType,
    bool isRequired,
    int sortOrder,
    bool isDeprecated,
    DateTime createdAt,
    DateTime updatedAt,
    List<FieldOption>? options,
  });
}

/// @nodoc
class _$ContentFieldCopyWithImpl<$Res, $Val extends ContentField>
    implements $ContentFieldCopyWith<$Res> {
  _$ContentFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fieldType = null,
    Object? isRequired = null,
    Object? sortOrder = null,
    Object? isDeprecated = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? options = freezed,
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
            fieldType: null == fieldType
                ? _value.fieldType
                : fieldType // ignore: cast_nullable_to_non_nullable
                      as FieldType,
            isRequired: null == isRequired
                ? _value.isRequired
                : isRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
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
            options: freezed == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<FieldOption>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContentFieldImplCopyWith<$Res>
    implements $ContentFieldCopyWith<$Res> {
  factory _$$ContentFieldImplCopyWith(
    _$ContentFieldImpl value,
    $Res Function(_$ContentFieldImpl) then,
  ) = __$$ContentFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    FieldType fieldType,
    bool isRequired,
    int sortOrder,
    bool isDeprecated,
    DateTime createdAt,
    DateTime updatedAt,
    List<FieldOption>? options,
  });
}

/// @nodoc
class __$$ContentFieldImplCopyWithImpl<$Res>
    extends _$ContentFieldCopyWithImpl<$Res, _$ContentFieldImpl>
    implements _$$ContentFieldImplCopyWith<$Res> {
  __$$ContentFieldImplCopyWithImpl(
    _$ContentFieldImpl _value,
    $Res Function(_$ContentFieldImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContentField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fieldType = null,
    Object? isRequired = null,
    Object? sortOrder = null,
    Object? isDeprecated = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? options = freezed,
  }) {
    return _then(
      _$ContentFieldImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        fieldType: null == fieldType
            ? _value.fieldType
            : fieldType // ignore: cast_nullable_to_non_nullable
                  as FieldType,
        isRequired: null == isRequired
            ? _value.isRequired
            : isRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
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
        options: freezed == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<FieldOption>?,
      ),
    );
  }
}

/// @nodoc

class _$ContentFieldImpl extends _ContentField {
  const _$ContentFieldImpl({
    required this.id,
    required this.name,
    required this.fieldType,
    this.isRequired = false,
    required this.sortOrder,
    this.isDeprecated = false,
    required this.createdAt,
    required this.updatedAt,
    final List<FieldOption>? options,
  }) : _options = options,
       super._();

  @override
  final int id;
  @override
  final String name;
  @override
  final FieldType fieldType;
  @override
  @JsonKey()
  final bool isRequired;
  @override
  final int sortOrder;
  @override
  @JsonKey()
  final bool isDeprecated;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<FieldOption>? _options;
  @override
  List<FieldOption>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ContentField(id: $id, name: $name, fieldType: $fieldType, isRequired: $isRequired, sortOrder: $sortOrder, isDeprecated: $isDeprecated, createdAt: $createdAt, updatedAt: $updatedAt, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentFieldImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fieldType, fieldType) ||
                other.fieldType == fieldType) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    fieldType,
    isRequired,
    sortOrder,
    isDeprecated,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_options),
  );

  /// Create a copy of ContentField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentFieldImplCopyWith<_$ContentFieldImpl> get copyWith =>
      __$$ContentFieldImplCopyWithImpl<_$ContentFieldImpl>(this, _$identity);
}

abstract class _ContentField extends ContentField {
  const factory _ContentField({
    required final int id,
    required final String name,
    required final FieldType fieldType,
    final bool isRequired,
    required final int sortOrder,
    final bool isDeprecated,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final List<FieldOption>? options,
  }) = _$ContentFieldImpl;
  const _ContentField._() : super._();

  @override
  int get id;
  @override
  String get name;
  @override
  FieldType get fieldType;
  @override
  bool get isRequired;
  @override
  int get sortOrder;
  @override
  bool get isDeprecated;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<FieldOption>? get options;

  /// Create a copy of ContentField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentFieldImplCopyWith<_$ContentFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FieldOption {
  int get id => throw _privateConstructorUsedError;
  int get contentFieldId => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of FieldOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FieldOptionCopyWith<FieldOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldOptionCopyWith<$Res> {
  factory $FieldOptionCopyWith(
    FieldOption value,
    $Res Function(FieldOption) then,
  ) = _$FieldOptionCopyWithImpl<$Res, FieldOption>;
  @useResult
  $Res call({
    int id,
    int contentFieldId,
    String value,
    bool isDeprecated,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$FieldOptionCopyWithImpl<$Res, $Val extends FieldOption>
    implements $FieldOptionCopyWith<$Res> {
  _$FieldOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FieldOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contentFieldId = null,
    Object? value = null,
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
            contentFieldId: null == contentFieldId
                ? _value.contentFieldId
                : contentFieldId // ignore: cast_nullable_to_non_nullable
                      as int,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
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
abstract class _$$FieldOptionImplCopyWith<$Res>
    implements $FieldOptionCopyWith<$Res> {
  factory _$$FieldOptionImplCopyWith(
    _$FieldOptionImpl value,
    $Res Function(_$FieldOptionImpl) then,
  ) = __$$FieldOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int contentFieldId,
    String value,
    bool isDeprecated,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$FieldOptionImplCopyWithImpl<$Res>
    extends _$FieldOptionCopyWithImpl<$Res, _$FieldOptionImpl>
    implements _$$FieldOptionImplCopyWith<$Res> {
  __$$FieldOptionImplCopyWithImpl(
    _$FieldOptionImpl _value,
    $Res Function(_$FieldOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FieldOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contentFieldId = null,
    Object? value = null,
    Object? isDeprecated = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$FieldOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        contentFieldId: null == contentFieldId
            ? _value.contentFieldId
            : contentFieldId // ignore: cast_nullable_to_non_nullable
                  as int,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
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

class _$FieldOptionImpl extends _FieldOption {
  const _$FieldOptionImpl({
    required this.id,
    required this.contentFieldId,
    required this.value,
    this.isDeprecated = false,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  @override
  final int id;
  @override
  final int contentFieldId;
  @override
  final String value;
  @override
  @JsonKey()
  final bool isDeprecated;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'FieldOption(id: $id, contentFieldId: $contentFieldId, value: $value, isDeprecated: $isDeprecated, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contentFieldId, contentFieldId) ||
                other.contentFieldId == contentFieldId) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    contentFieldId,
    value,
    isDeprecated,
    createdAt,
    updatedAt,
  );

  /// Create a copy of FieldOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldOptionImplCopyWith<_$FieldOptionImpl> get copyWith =>
      __$$FieldOptionImplCopyWithImpl<_$FieldOptionImpl>(this, _$identity);
}

abstract class _FieldOption extends FieldOption {
  const factory _FieldOption({
    required final int id,
    required final int contentFieldId,
    required final String value,
    final bool isDeprecated,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$FieldOptionImpl;
  const _FieldOption._() : super._();

  @override
  int get id;
  @override
  int get contentFieldId;
  @override
  String get value;
  @override
  bool get isDeprecated;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of FieldOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FieldOptionImplCopyWith<_$FieldOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ContentBlock {
  int get id => throw _privateConstructorUsedError;
  int get sessionId => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  Map<int, String> get values => throw _privateConstructorUsedError;

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentBlockCopyWith<ContentBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentBlockCopyWith<$Res> {
  factory $ContentBlockCopyWith(
    ContentBlock value,
    $Res Function(ContentBlock) then,
  ) = _$ContentBlockCopyWithImpl<$Res, ContentBlock>;
  @useResult
  $Res call({
    int id,
    int sessionId,
    int sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
    Map<int, String> values,
  });
}

/// @nodoc
class _$ContentBlockCopyWithImpl<$Res, $Val extends ContentBlock>
    implements $ContentBlockCopyWith<$Res> {
  _$ContentBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? values = null,
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
            values: null == values
                ? _value.values
                : values // ignore: cast_nullable_to_non_nullable
                      as Map<int, String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContentBlockImplCopyWith<$Res>
    implements $ContentBlockCopyWith<$Res> {
  factory _$$ContentBlockImplCopyWith(
    _$ContentBlockImpl value,
    $Res Function(_$ContentBlockImpl) then,
  ) = __$$ContentBlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int sessionId,
    int sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
    Map<int, String> values,
  });
}

/// @nodoc
class __$$ContentBlockImplCopyWithImpl<$Res>
    extends _$ContentBlockCopyWithImpl<$Res, _$ContentBlockImpl>
    implements _$$ContentBlockImplCopyWith<$Res> {
  __$$ContentBlockImplCopyWithImpl(
    _$ContentBlockImpl _value,
    $Res Function(_$ContentBlockImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? values = null,
  }) {
    return _then(
      _$ContentBlockImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as int,
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
        values: null == values
            ? _value._values
            : values // ignore: cast_nullable_to_non_nullable
                  as Map<int, String>,
      ),
    );
  }
}

/// @nodoc

class _$ContentBlockImpl extends _ContentBlock {
  const _$ContentBlockImpl({
    required this.id,
    required this.sessionId,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    final Map<int, String> values = const {},
  }) : _values = values,
       super._();

  @override
  final int id;
  @override
  final int sessionId;
  @override
  final int sortOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final Map<int, String> _values;
  @override
  @JsonKey()
  Map<int, String> get values {
    if (_values is EqualUnmodifiableMapView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_values);
  }

  @override
  String toString() {
    return 'ContentBlock(id: $id, sessionId: $sessionId, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt, values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentBlockImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sessionId,
    sortOrder,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_values),
  );

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentBlockImplCopyWith<_$ContentBlockImpl> get copyWith =>
      __$$ContentBlockImplCopyWithImpl<_$ContentBlockImpl>(this, _$identity);
}

abstract class _ContentBlock extends ContentBlock {
  const factory _ContentBlock({
    required final int id,
    required final int sessionId,
    required final int sortOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final Map<int, String> values,
  }) = _$ContentBlockImpl;
  const _ContentBlock._() : super._();

  @override
  int get id;
  @override
  int get sessionId;
  @override
  int get sortOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  Map<int, String> get values;

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentBlockImplCopyWith<_$ContentBlockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GoalConfigState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GoalConfig> goalConfigs) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GoalConfig> goalConfigs)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GoalConfig> goalConfigs)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoalConfigInitial value) initial,
    required TResult Function(_GoalConfigLoading value) loading,
    required TResult Function(_GoalConfigData value) data,
    required TResult Function(_GoalConfigError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoalConfigInitial value)? initial,
    TResult? Function(_GoalConfigLoading value)? loading,
    TResult? Function(_GoalConfigData value)? data,
    TResult? Function(_GoalConfigError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoalConfigInitial value)? initial,
    TResult Function(_GoalConfigLoading value)? loading,
    TResult Function(_GoalConfigData value)? data,
    TResult Function(_GoalConfigError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalConfigStateCopyWith<$Res> {
  factory $GoalConfigStateCopyWith(
    GoalConfigState value,
    $Res Function(GoalConfigState) then,
  ) = _$GoalConfigStateCopyWithImpl<$Res, GoalConfigState>;
}

/// @nodoc
class _$GoalConfigStateCopyWithImpl<$Res, $Val extends GoalConfigState>
    implements $GoalConfigStateCopyWith<$Res> {
  _$GoalConfigStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoalConfigState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GoalConfigInitialImplCopyWith<$Res> {
  factory _$$GoalConfigInitialImplCopyWith(
    _$GoalConfigInitialImpl value,
    $Res Function(_$GoalConfigInitialImpl) then,
  ) = __$$GoalConfigInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GoalConfigInitialImplCopyWithImpl<$Res>
    extends _$GoalConfigStateCopyWithImpl<$Res, _$GoalConfigInitialImpl>
    implements _$$GoalConfigInitialImplCopyWith<$Res> {
  __$$GoalConfigInitialImplCopyWithImpl(
    _$GoalConfigInitialImpl _value,
    $Res Function(_$GoalConfigInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalConfigState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GoalConfigInitialImpl implements _GoalConfigInitial {
  const _$GoalConfigInitialImpl();

  @override
  String toString() {
    return 'GoalConfigState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GoalConfigInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GoalConfig> goalConfigs) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GoalConfig> goalConfigs)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GoalConfig> goalConfigs)? data,
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
    required TResult Function(_GoalConfigInitial value) initial,
    required TResult Function(_GoalConfigLoading value) loading,
    required TResult Function(_GoalConfigData value) data,
    required TResult Function(_GoalConfigError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoalConfigInitial value)? initial,
    TResult? Function(_GoalConfigLoading value)? loading,
    TResult? Function(_GoalConfigData value)? data,
    TResult? Function(_GoalConfigError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoalConfigInitial value)? initial,
    TResult Function(_GoalConfigLoading value)? loading,
    TResult Function(_GoalConfigData value)? data,
    TResult Function(_GoalConfigError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _GoalConfigInitial implements GoalConfigState {
  const factory _GoalConfigInitial() = _$GoalConfigInitialImpl;
}

/// @nodoc
abstract class _$$GoalConfigLoadingImplCopyWith<$Res> {
  factory _$$GoalConfigLoadingImplCopyWith(
    _$GoalConfigLoadingImpl value,
    $Res Function(_$GoalConfigLoadingImpl) then,
  ) = __$$GoalConfigLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GoalConfigLoadingImplCopyWithImpl<$Res>
    extends _$GoalConfigStateCopyWithImpl<$Res, _$GoalConfigLoadingImpl>
    implements _$$GoalConfigLoadingImplCopyWith<$Res> {
  __$$GoalConfigLoadingImplCopyWithImpl(
    _$GoalConfigLoadingImpl _value,
    $Res Function(_$GoalConfigLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalConfigState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GoalConfigLoadingImpl implements _GoalConfigLoading {
  const _$GoalConfigLoadingImpl();

  @override
  String toString() {
    return 'GoalConfigState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GoalConfigLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GoalConfig> goalConfigs) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GoalConfig> goalConfigs)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GoalConfig> goalConfigs)? data,
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
    required TResult Function(_GoalConfigInitial value) initial,
    required TResult Function(_GoalConfigLoading value) loading,
    required TResult Function(_GoalConfigData value) data,
    required TResult Function(_GoalConfigError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoalConfigInitial value)? initial,
    TResult? Function(_GoalConfigLoading value)? loading,
    TResult? Function(_GoalConfigData value)? data,
    TResult? Function(_GoalConfigError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoalConfigInitial value)? initial,
    TResult Function(_GoalConfigLoading value)? loading,
    TResult Function(_GoalConfigData value)? data,
    TResult Function(_GoalConfigError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _GoalConfigLoading implements GoalConfigState {
  const factory _GoalConfigLoading() = _$GoalConfigLoadingImpl;
}

/// @nodoc
abstract class _$$GoalConfigDataImplCopyWith<$Res> {
  factory _$$GoalConfigDataImplCopyWith(
    _$GoalConfigDataImpl value,
    $Res Function(_$GoalConfigDataImpl) then,
  ) = __$$GoalConfigDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<GoalConfig> goalConfigs});
}

/// @nodoc
class __$$GoalConfigDataImplCopyWithImpl<$Res>
    extends _$GoalConfigStateCopyWithImpl<$Res, _$GoalConfigDataImpl>
    implements _$$GoalConfigDataImplCopyWith<$Res> {
  __$$GoalConfigDataImplCopyWithImpl(
    _$GoalConfigDataImpl _value,
    $Res Function(_$GoalConfigDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalConfigState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? goalConfigs = null}) {
    return _then(
      _$GoalConfigDataImpl(
        goalConfigs: null == goalConfigs
            ? _value._goalConfigs
            : goalConfigs // ignore: cast_nullable_to_non_nullable
                  as List<GoalConfig>,
      ),
    );
  }
}

/// @nodoc

class _$GoalConfigDataImpl implements _GoalConfigData {
  const _$GoalConfigDataImpl({required final List<GoalConfig> goalConfigs})
    : _goalConfigs = goalConfigs;

  final List<GoalConfig> _goalConfigs;
  @override
  List<GoalConfig> get goalConfigs {
    if (_goalConfigs is EqualUnmodifiableListView) return _goalConfigs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goalConfigs);
  }

  @override
  String toString() {
    return 'GoalConfigState.data(goalConfigs: $goalConfigs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalConfigDataImpl &&
            const DeepCollectionEquality().equals(
              other._goalConfigs,
              _goalConfigs,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_goalConfigs),
  );

  /// Create a copy of GoalConfigState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalConfigDataImplCopyWith<_$GoalConfigDataImpl> get copyWith =>
      __$$GoalConfigDataImplCopyWithImpl<_$GoalConfigDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GoalConfig> goalConfigs) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return data(goalConfigs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GoalConfig> goalConfigs)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return data?.call(goalConfigs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GoalConfig> goalConfigs)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(goalConfigs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoalConfigInitial value) initial,
    required TResult Function(_GoalConfigLoading value) loading,
    required TResult Function(_GoalConfigData value) data,
    required TResult Function(_GoalConfigError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoalConfigInitial value)? initial,
    TResult? Function(_GoalConfigLoading value)? loading,
    TResult? Function(_GoalConfigData value)? data,
    TResult? Function(_GoalConfigError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoalConfigInitial value)? initial,
    TResult Function(_GoalConfigLoading value)? loading,
    TResult Function(_GoalConfigData value)? data,
    TResult Function(_GoalConfigError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _GoalConfigData implements GoalConfigState {
  const factory _GoalConfigData({required final List<GoalConfig> goalConfigs}) =
      _$GoalConfigDataImpl;

  List<GoalConfig> get goalConfigs;

  /// Create a copy of GoalConfigState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalConfigDataImplCopyWith<_$GoalConfigDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GoalConfigErrorImplCopyWith<$Res> {
  factory _$$GoalConfigErrorImplCopyWith(
    _$GoalConfigErrorImpl value,
    $Res Function(_$GoalConfigErrorImpl) then,
  ) = __$$GoalConfigErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class __$$GoalConfigErrorImplCopyWithImpl<$Res>
    extends _$GoalConfigStateCopyWithImpl<$Res, _$GoalConfigErrorImpl>
    implements _$$GoalConfigErrorImplCopyWith<$Res> {
  __$$GoalConfigErrorImplCopyWithImpl(
    _$GoalConfigErrorImpl _value,
    $Res Function(_$GoalConfigErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalConfigState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? stackTrace = null}) {
    return _then(
      _$GoalConfigErrorImpl(
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

class _$GoalConfigErrorImpl implements _GoalConfigError {
  const _$GoalConfigErrorImpl(this.error, this.stackTrace);

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'GoalConfigState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalConfigErrorImpl &&
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

  /// Create a copy of GoalConfigState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalConfigErrorImplCopyWith<_$GoalConfigErrorImpl> get copyWith =>
      __$$GoalConfigErrorImplCopyWithImpl<_$GoalConfigErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GoalConfig> goalConfigs) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GoalConfig> goalConfigs)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return error?.call(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GoalConfig> goalConfigs)? data,
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
    required TResult Function(_GoalConfigInitial value) initial,
    required TResult Function(_GoalConfigLoading value) loading,
    required TResult Function(_GoalConfigData value) data,
    required TResult Function(_GoalConfigError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoalConfigInitial value)? initial,
    TResult? Function(_GoalConfigLoading value)? loading,
    TResult? Function(_GoalConfigData value)? data,
    TResult? Function(_GoalConfigError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoalConfigInitial value)? initial,
    TResult Function(_GoalConfigLoading value)? loading,
    TResult Function(_GoalConfigData value)? data,
    TResult Function(_GoalConfigError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _GoalConfigError implements GoalConfigState {
  const factory _GoalConfigError(
    final Object error,
    final StackTrace stackTrace,
  ) = _$GoalConfigErrorImpl;

  Object get error;
  StackTrace get stackTrace;

  /// Create a copy of GoalConfigState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalConfigErrorImplCopyWith<_$GoalConfigErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GoalConfig {
  int get id => throw _privateConstructorUsedError;
  int get goalId => throw _privateConstructorUsedError;
  String? get goalName => throw _privateConstructorUsedError;
  String? get blueprint => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<GoalConfigSession>? get sessions => throw _privateConstructorUsedError;
  int get sessionCount => throw _privateConstructorUsedError;

  /// Create a copy of GoalConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalConfigCopyWith<GoalConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalConfigCopyWith<$Res> {
  factory $GoalConfigCopyWith(
    GoalConfig value,
    $Res Function(GoalConfig) then,
  ) = _$GoalConfigCopyWithImpl<$Res, GoalConfig>;
  @useResult
  $Res call({
    int id,
    int goalId,
    String? goalName,
    String? blueprint,
    DateTime createdAt,
    DateTime updatedAt,
    List<GoalConfigSession>? sessions,
    int sessionCount,
  });
}

/// @nodoc
class _$GoalConfigCopyWithImpl<$Res, $Val extends GoalConfig>
    implements $GoalConfigCopyWith<$Res> {
  _$GoalConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoalConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalId = null,
    Object? goalName = freezed,
    Object? blueprint = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sessions = freezed,
    Object? sessionCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            goalId: null == goalId
                ? _value.goalId
                : goalId // ignore: cast_nullable_to_non_nullable
                      as int,
            goalName: freezed == goalName
                ? _value.goalName
                : goalName // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            sessions: freezed == sessions
                ? _value.sessions
                : sessions // ignore: cast_nullable_to_non_nullable
                      as List<GoalConfigSession>?,
            sessionCount: null == sessionCount
                ? _value.sessionCount
                : sessionCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoalConfigImplCopyWith<$Res>
    implements $GoalConfigCopyWith<$Res> {
  factory _$$GoalConfigImplCopyWith(
    _$GoalConfigImpl value,
    $Res Function(_$GoalConfigImpl) then,
  ) = __$$GoalConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int goalId,
    String? goalName,
    String? blueprint,
    DateTime createdAt,
    DateTime updatedAt,
    List<GoalConfigSession>? sessions,
    int sessionCount,
  });
}

/// @nodoc
class __$$GoalConfigImplCopyWithImpl<$Res>
    extends _$GoalConfigCopyWithImpl<$Res, _$GoalConfigImpl>
    implements _$$GoalConfigImplCopyWith<$Res> {
  __$$GoalConfigImplCopyWithImpl(
    _$GoalConfigImpl _value,
    $Res Function(_$GoalConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalId = null,
    Object? goalName = freezed,
    Object? blueprint = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sessions = freezed,
    Object? sessionCount = null,
  }) {
    return _then(
      _$GoalConfigImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        goalId: null == goalId
            ? _value.goalId
            : goalId // ignore: cast_nullable_to_non_nullable
                  as int,
        goalName: freezed == goalName
            ? _value.goalName
            : goalName // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        sessions: freezed == sessions
            ? _value._sessions
            : sessions // ignore: cast_nullable_to_non_nullable
                  as List<GoalConfigSession>?,
        sessionCount: null == sessionCount
            ? _value.sessionCount
            : sessionCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$GoalConfigImpl extends _GoalConfig {
  const _$GoalConfigImpl({
    required this.id,
    required this.goalId,
    this.goalName,
    this.blueprint,
    required this.createdAt,
    required this.updatedAt,
    final List<GoalConfigSession>? sessions,
    this.sessionCount = 0,
  }) : _sessions = sessions,
       super._();

  @override
  final int id;
  @override
  final int goalId;
  @override
  final String? goalName;
  @override
  final String? blueprint;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<GoalConfigSession>? _sessions;
  @override
  List<GoalConfigSession>? get sessions {
    final value = _sessions;
    if (value == null) return null;
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int sessionCount;

  @override
  String toString() {
    return 'GoalConfig(id: $id, goalId: $goalId, goalName: $goalName, blueprint: $blueprint, createdAt: $createdAt, updatedAt: $updatedAt, sessions: $sessions, sessionCount: $sessionCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.goalName, goalName) ||
                other.goalName == goalName) &&
            (identical(other.blueprint, blueprint) ||
                other.blueprint == blueprint) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._sessions, _sessions) &&
            (identical(other.sessionCount, sessionCount) ||
                other.sessionCount == sessionCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    goalId,
    goalName,
    blueprint,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_sessions),
    sessionCount,
  );

  /// Create a copy of GoalConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalConfigImplCopyWith<_$GoalConfigImpl> get copyWith =>
      __$$GoalConfigImplCopyWithImpl<_$GoalConfigImpl>(this, _$identity);
}

abstract class _GoalConfig extends GoalConfig {
  const factory _GoalConfig({
    required final int id,
    required final int goalId,
    final String? goalName,
    final String? blueprint,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final List<GoalConfigSession>? sessions,
    final int sessionCount,
  }) = _$GoalConfigImpl;
  const _GoalConfig._() : super._();

  @override
  int get id;
  @override
  int get goalId;
  @override
  String? get goalName;
  @override
  String? get blueprint;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<GoalConfigSession>? get sessions;
  @override
  int get sessionCount;

  /// Create a copy of GoalConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalConfigImplCopyWith<_$GoalConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GoalConfigSession {
  int get id => throw _privateConstructorUsedError;
  int get goalConfigId => throw _privateConstructorUsedError;
  int get sessionNumber => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<GoalConfigContentBlock>? get contentBlocks =>
      throw _privateConstructorUsedError;

  /// Create a copy of GoalConfigSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalConfigSessionCopyWith<GoalConfigSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalConfigSessionCopyWith<$Res> {
  factory $GoalConfigSessionCopyWith(
    GoalConfigSession value,
    $Res Function(GoalConfigSession) then,
  ) = _$GoalConfigSessionCopyWithImpl<$Res, GoalConfigSession>;
  @useResult
  $Res call({
    int id,
    int goalConfigId,
    int sessionNumber,
    DateTime createdAt,
    DateTime updatedAt,
    List<GoalConfigContentBlock>? contentBlocks,
  });
}

/// @nodoc
class _$GoalConfigSessionCopyWithImpl<$Res, $Val extends GoalConfigSession>
    implements $GoalConfigSessionCopyWith<$Res> {
  _$GoalConfigSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoalConfigSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalConfigId = null,
    Object? sessionNumber = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? contentBlocks = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            goalConfigId: null == goalConfigId
                ? _value.goalConfigId
                : goalConfigId // ignore: cast_nullable_to_non_nullable
                      as int,
            sessionNumber: null == sessionNumber
                ? _value.sessionNumber
                : sessionNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            contentBlocks: freezed == contentBlocks
                ? _value.contentBlocks
                : contentBlocks // ignore: cast_nullable_to_non_nullable
                      as List<GoalConfigContentBlock>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoalConfigSessionImplCopyWith<$Res>
    implements $GoalConfigSessionCopyWith<$Res> {
  factory _$$GoalConfigSessionImplCopyWith(
    _$GoalConfigSessionImpl value,
    $Res Function(_$GoalConfigSessionImpl) then,
  ) = __$$GoalConfigSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int goalConfigId,
    int sessionNumber,
    DateTime createdAt,
    DateTime updatedAt,
    List<GoalConfigContentBlock>? contentBlocks,
  });
}

/// @nodoc
class __$$GoalConfigSessionImplCopyWithImpl<$Res>
    extends _$GoalConfigSessionCopyWithImpl<$Res, _$GoalConfigSessionImpl>
    implements _$$GoalConfigSessionImplCopyWith<$Res> {
  __$$GoalConfigSessionImplCopyWithImpl(
    _$GoalConfigSessionImpl _value,
    $Res Function(_$GoalConfigSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalConfigSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalConfigId = null,
    Object? sessionNumber = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? contentBlocks = freezed,
  }) {
    return _then(
      _$GoalConfigSessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        goalConfigId: null == goalConfigId
            ? _value.goalConfigId
            : goalConfigId // ignore: cast_nullable_to_non_nullable
                  as int,
        sessionNumber: null == sessionNumber
            ? _value.sessionNumber
            : sessionNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        contentBlocks: freezed == contentBlocks
            ? _value._contentBlocks
            : contentBlocks // ignore: cast_nullable_to_non_nullable
                  as List<GoalConfigContentBlock>?,
      ),
    );
  }
}

/// @nodoc

class _$GoalConfigSessionImpl extends _GoalConfigSession {
  const _$GoalConfigSessionImpl({
    required this.id,
    required this.goalConfigId,
    required this.sessionNumber,
    required this.createdAt,
    required this.updatedAt,
    final List<GoalConfigContentBlock>? contentBlocks,
  }) : _contentBlocks = contentBlocks,
       super._();

  @override
  final int id;
  @override
  final int goalConfigId;
  @override
  final int sessionNumber;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<GoalConfigContentBlock>? _contentBlocks;
  @override
  List<GoalConfigContentBlock>? get contentBlocks {
    final value = _contentBlocks;
    if (value == null) return null;
    if (_contentBlocks is EqualUnmodifiableListView) return _contentBlocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GoalConfigSession(id: $id, goalConfigId: $goalConfigId, sessionNumber: $sessionNumber, createdAt: $createdAt, updatedAt: $updatedAt, contentBlocks: $contentBlocks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalConfigSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.goalConfigId, goalConfigId) ||
                other.goalConfigId == goalConfigId) &&
            (identical(other.sessionNumber, sessionNumber) ||
                other.sessionNumber == sessionNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other._contentBlocks,
              _contentBlocks,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    goalConfigId,
    sessionNumber,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_contentBlocks),
  );

  /// Create a copy of GoalConfigSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalConfigSessionImplCopyWith<_$GoalConfigSessionImpl> get copyWith =>
      __$$GoalConfigSessionImplCopyWithImpl<_$GoalConfigSessionImpl>(
        this,
        _$identity,
      );
}

abstract class _GoalConfigSession extends GoalConfigSession {
  const factory _GoalConfigSession({
    required final int id,
    required final int goalConfigId,
    required final int sessionNumber,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final List<GoalConfigContentBlock>? contentBlocks,
  }) = _$GoalConfigSessionImpl;
  const _GoalConfigSession._() : super._();

  @override
  int get id;
  @override
  int get goalConfigId;
  @override
  int get sessionNumber;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<GoalConfigContentBlock>? get contentBlocks;

  /// Create a copy of GoalConfigSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalConfigSessionImplCopyWith<_$GoalConfigSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GoalConfigContentBlock {
  int get id => throw _privateConstructorUsedError;
  int get goalConfigSessionId => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  Map<int, String> get values => throw _privateConstructorUsedError;

  /// Create a copy of GoalConfigContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalConfigContentBlockCopyWith<GoalConfigContentBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalConfigContentBlockCopyWith<$Res> {
  factory $GoalConfigContentBlockCopyWith(
    GoalConfigContentBlock value,
    $Res Function(GoalConfigContentBlock) then,
  ) = _$GoalConfigContentBlockCopyWithImpl<$Res, GoalConfigContentBlock>;
  @useResult
  $Res call({
    int id,
    int goalConfigSessionId,
    int sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
    Map<int, String> values,
  });
}

/// @nodoc
class _$GoalConfigContentBlockCopyWithImpl<
  $Res,
  $Val extends GoalConfigContentBlock
>
    implements $GoalConfigContentBlockCopyWith<$Res> {
  _$GoalConfigContentBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoalConfigContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalConfigSessionId = null,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? values = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            goalConfigSessionId: null == goalConfigSessionId
                ? _value.goalConfigSessionId
                : goalConfigSessionId // ignore: cast_nullable_to_non_nullable
                      as int,
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
            values: null == values
                ? _value.values
                : values // ignore: cast_nullable_to_non_nullable
                      as Map<int, String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoalConfigContentBlockImplCopyWith<$Res>
    implements $GoalConfigContentBlockCopyWith<$Res> {
  factory _$$GoalConfigContentBlockImplCopyWith(
    _$GoalConfigContentBlockImpl value,
    $Res Function(_$GoalConfigContentBlockImpl) then,
  ) = __$$GoalConfigContentBlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int goalConfigSessionId,
    int sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
    Map<int, String> values,
  });
}

/// @nodoc
class __$$GoalConfigContentBlockImplCopyWithImpl<$Res>
    extends
        _$GoalConfigContentBlockCopyWithImpl<$Res, _$GoalConfigContentBlockImpl>
    implements _$$GoalConfigContentBlockImplCopyWith<$Res> {
  __$$GoalConfigContentBlockImplCopyWithImpl(
    _$GoalConfigContentBlockImpl _value,
    $Res Function(_$GoalConfigContentBlockImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalConfigContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalConfigSessionId = null,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? values = null,
  }) {
    return _then(
      _$GoalConfigContentBlockImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        goalConfigSessionId: null == goalConfigSessionId
            ? _value.goalConfigSessionId
            : goalConfigSessionId // ignore: cast_nullable_to_non_nullable
                  as int,
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
        values: null == values
            ? _value._values
            : values // ignore: cast_nullable_to_non_nullable
                  as Map<int, String>,
      ),
    );
  }
}

/// @nodoc

class _$GoalConfigContentBlockImpl extends _GoalConfigContentBlock {
  const _$GoalConfigContentBlockImpl({
    required this.id,
    required this.goalConfigSessionId,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    final Map<int, String> values = const {},
  }) : _values = values,
       super._();

  @override
  final int id;
  @override
  final int goalConfigSessionId;
  @override
  final int sortOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final Map<int, String> _values;
  @override
  @JsonKey()
  Map<int, String> get values {
    if (_values is EqualUnmodifiableMapView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_values);
  }

  @override
  String toString() {
    return 'GoalConfigContentBlock(id: $id, goalConfigSessionId: $goalConfigSessionId, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt, values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalConfigContentBlockImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.goalConfigSessionId, goalConfigSessionId) ||
                other.goalConfigSessionId == goalConfigSessionId) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    goalConfigSessionId,
    sortOrder,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_values),
  );

  /// Create a copy of GoalConfigContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalConfigContentBlockImplCopyWith<_$GoalConfigContentBlockImpl>
  get copyWith =>
      __$$GoalConfigContentBlockImplCopyWithImpl<_$GoalConfigContentBlockImpl>(
        this,
        _$identity,
      );
}

abstract class _GoalConfigContentBlock extends GoalConfigContentBlock {
  const factory _GoalConfigContentBlock({
    required final int id,
    required final int goalConfigSessionId,
    required final int sortOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final Map<int, String> values,
  }) = _$GoalConfigContentBlockImpl;
  const _GoalConfigContentBlock._() : super._();

  @override
  int get id;
  @override
  int get goalConfigSessionId;
  @override
  int get sortOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  Map<int, String> get values;

  /// Create a copy of GoalConfigContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalConfigContentBlockImplCopyWith<_$GoalConfigContentBlockImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AlbumState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Album> albums, int? selectedStudentId) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Album> albums, int? selectedStudentId)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Album> albums, int? selectedStudentId)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AlbumInitial value) initial,
    required TResult Function(_AlbumLoading value) loading,
    required TResult Function(_AlbumData value) data,
    required TResult Function(_AlbumError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlbumInitial value)? initial,
    TResult? Function(_AlbumLoading value)? loading,
    TResult? Function(_AlbumData value)? data,
    TResult? Function(_AlbumError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlbumInitial value)? initial,
    TResult Function(_AlbumLoading value)? loading,
    TResult Function(_AlbumData value)? data,
    TResult Function(_AlbumError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumStateCopyWith<$Res> {
  factory $AlbumStateCopyWith(
    AlbumState value,
    $Res Function(AlbumState) then,
  ) = _$AlbumStateCopyWithImpl<$Res, AlbumState>;
}

/// @nodoc
class _$AlbumStateCopyWithImpl<$Res, $Val extends AlbumState>
    implements $AlbumStateCopyWith<$Res> {
  _$AlbumStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlbumState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AlbumInitialImplCopyWith<$Res> {
  factory _$$AlbumInitialImplCopyWith(
    _$AlbumInitialImpl value,
    $Res Function(_$AlbumInitialImpl) then,
  ) = __$$AlbumInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AlbumInitialImplCopyWithImpl<$Res>
    extends _$AlbumStateCopyWithImpl<$Res, _$AlbumInitialImpl>
    implements _$$AlbumInitialImplCopyWith<$Res> {
  __$$AlbumInitialImplCopyWithImpl(
    _$AlbumInitialImpl _value,
    $Res Function(_$AlbumInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlbumState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AlbumInitialImpl implements _AlbumInitial {
  const _$AlbumInitialImpl();

  @override
  String toString() {
    return 'AlbumState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AlbumInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Album> albums, int? selectedStudentId) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Album> albums, int? selectedStudentId)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Album> albums, int? selectedStudentId)? data,
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
    required TResult Function(_AlbumInitial value) initial,
    required TResult Function(_AlbumLoading value) loading,
    required TResult Function(_AlbumData value) data,
    required TResult Function(_AlbumError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlbumInitial value)? initial,
    TResult? Function(_AlbumLoading value)? loading,
    TResult? Function(_AlbumData value)? data,
    TResult? Function(_AlbumError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlbumInitial value)? initial,
    TResult Function(_AlbumLoading value)? loading,
    TResult Function(_AlbumData value)? data,
    TResult Function(_AlbumError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _AlbumInitial implements AlbumState {
  const factory _AlbumInitial() = _$AlbumInitialImpl;
}

/// @nodoc
abstract class _$$AlbumLoadingImplCopyWith<$Res> {
  factory _$$AlbumLoadingImplCopyWith(
    _$AlbumLoadingImpl value,
    $Res Function(_$AlbumLoadingImpl) then,
  ) = __$$AlbumLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AlbumLoadingImplCopyWithImpl<$Res>
    extends _$AlbumStateCopyWithImpl<$Res, _$AlbumLoadingImpl>
    implements _$$AlbumLoadingImplCopyWith<$Res> {
  __$$AlbumLoadingImplCopyWithImpl(
    _$AlbumLoadingImpl _value,
    $Res Function(_$AlbumLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlbumState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AlbumLoadingImpl implements _AlbumLoading {
  const _$AlbumLoadingImpl();

  @override
  String toString() {
    return 'AlbumState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AlbumLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Album> albums, int? selectedStudentId) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Album> albums, int? selectedStudentId)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Album> albums, int? selectedStudentId)? data,
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
    required TResult Function(_AlbumInitial value) initial,
    required TResult Function(_AlbumLoading value) loading,
    required TResult Function(_AlbumData value) data,
    required TResult Function(_AlbumError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlbumInitial value)? initial,
    TResult? Function(_AlbumLoading value)? loading,
    TResult? Function(_AlbumData value)? data,
    TResult? Function(_AlbumError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlbumInitial value)? initial,
    TResult Function(_AlbumLoading value)? loading,
    TResult Function(_AlbumData value)? data,
    TResult Function(_AlbumError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AlbumLoading implements AlbumState {
  const factory _AlbumLoading() = _$AlbumLoadingImpl;
}

/// @nodoc
abstract class _$$AlbumDataImplCopyWith<$Res> {
  factory _$$AlbumDataImplCopyWith(
    _$AlbumDataImpl value,
    $Res Function(_$AlbumDataImpl) then,
  ) = __$$AlbumDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Album> albums, int? selectedStudentId});
}

/// @nodoc
class __$$AlbumDataImplCopyWithImpl<$Res>
    extends _$AlbumStateCopyWithImpl<$Res, _$AlbumDataImpl>
    implements _$$AlbumDataImplCopyWith<$Res> {
  __$$AlbumDataImplCopyWithImpl(
    _$AlbumDataImpl _value,
    $Res Function(_$AlbumDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlbumState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? albums = null, Object? selectedStudentId = freezed}) {
    return _then(
      _$AlbumDataImpl(
        albums: null == albums
            ? _value._albums
            : albums // ignore: cast_nullable_to_non_nullable
                  as List<Album>,
        selectedStudentId: freezed == selectedStudentId
            ? _value.selectedStudentId
            : selectedStudentId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$AlbumDataImpl implements _AlbumData {
  const _$AlbumDataImpl({
    required final List<Album> albums,
    this.selectedStudentId = null,
  }) : _albums = albums;

  final List<Album> _albums;
  @override
  List<Album> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

  @override
  @JsonKey()
  final int? selectedStudentId;

  @override
  String toString() {
    return 'AlbumState.data(albums: $albums, selectedStudentId: $selectedStudentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumDataImpl &&
            const DeepCollectionEquality().equals(other._albums, _albums) &&
            (identical(other.selectedStudentId, selectedStudentId) ||
                other.selectedStudentId == selectedStudentId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_albums),
    selectedStudentId,
  );

  /// Create a copy of AlbumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumDataImplCopyWith<_$AlbumDataImpl> get copyWith =>
      __$$AlbumDataImplCopyWithImpl<_$AlbumDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Album> albums, int? selectedStudentId) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return data(albums, selectedStudentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Album> albums, int? selectedStudentId)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return data?.call(albums, selectedStudentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Album> albums, int? selectedStudentId)? data,
    TResult Function(Object error, StackTrace stackTrace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(albums, selectedStudentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AlbumInitial value) initial,
    required TResult Function(_AlbumLoading value) loading,
    required TResult Function(_AlbumData value) data,
    required TResult Function(_AlbumError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlbumInitial value)? initial,
    TResult? Function(_AlbumLoading value)? loading,
    TResult? Function(_AlbumData value)? data,
    TResult? Function(_AlbumError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlbumInitial value)? initial,
    TResult Function(_AlbumLoading value)? loading,
    TResult Function(_AlbumData value)? data,
    TResult Function(_AlbumError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _AlbumData implements AlbumState {
  const factory _AlbumData({
    required final List<Album> albums,
    final int? selectedStudentId,
  }) = _$AlbumDataImpl;

  List<Album> get albums;
  int? get selectedStudentId;

  /// Create a copy of AlbumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlbumDataImplCopyWith<_$AlbumDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AlbumErrorImplCopyWith<$Res> {
  factory _$$AlbumErrorImplCopyWith(
    _$AlbumErrorImpl value,
    $Res Function(_$AlbumErrorImpl) then,
  ) = __$$AlbumErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class __$$AlbumErrorImplCopyWithImpl<$Res>
    extends _$AlbumStateCopyWithImpl<$Res, _$AlbumErrorImpl>
    implements _$$AlbumErrorImplCopyWith<$Res> {
  __$$AlbumErrorImplCopyWithImpl(
    _$AlbumErrorImpl _value,
    $Res Function(_$AlbumErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlbumState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? stackTrace = null}) {
    return _then(
      _$AlbumErrorImpl(
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

class _$AlbumErrorImpl implements _AlbumError {
  const _$AlbumErrorImpl(this.error, this.stackTrace);

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'AlbumState.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumErrorImpl &&
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

  /// Create a copy of AlbumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumErrorImplCopyWith<_$AlbumErrorImpl> get copyWith =>
      __$$AlbumErrorImplCopyWithImpl<_$AlbumErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Album> albums, int? selectedStudentId) data,
    required TResult Function(Object error, StackTrace stackTrace) error,
  }) {
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Album> albums, int? selectedStudentId)? data,
    TResult? Function(Object error, StackTrace stackTrace)? error,
  }) {
    return error?.call(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Album> albums, int? selectedStudentId)? data,
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
    required TResult Function(_AlbumInitial value) initial,
    required TResult Function(_AlbumLoading value) loading,
    required TResult Function(_AlbumData value) data,
    required TResult Function(_AlbumError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlbumInitial value)? initial,
    TResult? Function(_AlbumLoading value)? loading,
    TResult? Function(_AlbumData value)? data,
    TResult? Function(_AlbumError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlbumInitial value)? initial,
    TResult Function(_AlbumLoading value)? loading,
    TResult Function(_AlbumData value)? data,
    TResult Function(_AlbumError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AlbumError implements AlbumState {
  const factory _AlbumError(final Object error, final StackTrace stackTrace) =
      _$AlbumErrorImpl;

  Object get error;
  StackTrace get stackTrace;

  /// Create a copy of AlbumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlbumErrorImplCopyWith<_$AlbumErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Album {
  int get id => throw _privateConstructorUsedError;
  int get studentId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  int get photoCount => throw _privateConstructorUsedError;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlbumCopyWith<Album> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumCopyWith<$Res> {
  factory $AlbumCopyWith(Album value, $Res Function(Album) then) =
      _$AlbumCopyWithImpl<$Res, Album>;
  @useResult
  $Res call({
    int id,
    int studentId,
    String name,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
    int photoCount,
  });
}

/// @nodoc
class _$AlbumCopyWithImpl<$Res, $Val extends Album>
    implements $AlbumCopyWith<$Res> {
  _$AlbumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? name = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? photoCount = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
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
            photoCount: null == photoCount
                ? _value.photoCount
                : photoCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AlbumImplCopyWith<$Res> implements $AlbumCopyWith<$Res> {
  factory _$$AlbumImplCopyWith(
    _$AlbumImpl value,
    $Res Function(_$AlbumImpl) then,
  ) = __$$AlbumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int studentId,
    String name,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
    int photoCount,
  });
}

/// @nodoc
class __$$AlbumImplCopyWithImpl<$Res>
    extends _$AlbumCopyWithImpl<$Res, _$AlbumImpl>
    implements _$$AlbumImplCopyWith<$Res> {
  __$$AlbumImplCopyWithImpl(
    _$AlbumImpl _value,
    $Res Function(_$AlbumImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? name = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? photoCount = null,
  }) {
    return _then(
      _$AlbumImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
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
        photoCount: null == photoCount
            ? _value.photoCount
            : photoCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$AlbumImpl extends _Album {
  const _$AlbumImpl({
    required this.id,
    required this.studentId,
    required this.name,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.photoCount = 0,
  }) : super._();

  @override
  final int id;
  @override
  final int studentId;
  @override
  final String name;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final int photoCount;

  @override
  String toString() {
    return 'Album(id: $id, studentId: $studentId, name: $name, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, photoCount: $photoCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.photoCount, photoCount) ||
                other.photoCount == photoCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    studentId,
    name,
    notes,
    createdAt,
    updatedAt,
    photoCount,
  );

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumImplCopyWith<_$AlbumImpl> get copyWith =>
      __$$AlbumImplCopyWithImpl<_$AlbumImpl>(this, _$identity);
}

abstract class _Album extends Album {
  const factory _Album({
    required final int id,
    required final int studentId,
    required final String name,
    final String? notes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final int photoCount,
  }) = _$AlbumImpl;
  const _Album._() : super._();

  @override
  int get id;
  @override
  int get studentId;
  @override
  String get name;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  int get photoCount;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlbumImplCopyWith<_$AlbumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AlbumPhoto {
  int get id => throw _privateConstructorUsedError;
  int get albumId => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of AlbumPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlbumPhotoCopyWith<AlbumPhoto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumPhotoCopyWith<$Res> {
  factory $AlbumPhotoCopyWith(
    AlbumPhoto value,
    $Res Function(AlbumPhoto) then,
  ) = _$AlbumPhotoCopyWithImpl<$Res, AlbumPhoto>;
  @useResult
  $Res call({
    int id,
    int albumId,
    String filePath,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$AlbumPhotoCopyWithImpl<$Res, $Val extends AlbumPhoto>
    implements $AlbumPhotoCopyWith<$Res> {
  _$AlbumPhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlbumPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? albumId = null,
    Object? filePath = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            albumId: null == albumId
                ? _value.albumId
                : albumId // ignore: cast_nullable_to_non_nullable
                      as int,
            filePath: null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
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
abstract class _$$AlbumPhotoImplCopyWith<$Res>
    implements $AlbumPhotoCopyWith<$Res> {
  factory _$$AlbumPhotoImplCopyWith(
    _$AlbumPhotoImpl value,
    $Res Function(_$AlbumPhotoImpl) then,
  ) = __$$AlbumPhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int albumId,
    String filePath,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$AlbumPhotoImplCopyWithImpl<$Res>
    extends _$AlbumPhotoCopyWithImpl<$Res, _$AlbumPhotoImpl>
    implements _$$AlbumPhotoImplCopyWith<$Res> {
  __$$AlbumPhotoImplCopyWithImpl(
    _$AlbumPhotoImpl _value,
    $Res Function(_$AlbumPhotoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlbumPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? albumId = null,
    Object? filePath = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AlbumPhotoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        albumId: null == albumId
            ? _value.albumId
            : albumId // ignore: cast_nullable_to_non_nullable
                  as int,
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
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

class _$AlbumPhotoImpl extends _AlbumPhoto {
  const _$AlbumPhotoImpl({
    required this.id,
    required this.albumId,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  @override
  final int id;
  @override
  final int albumId;
  @override
  final String filePath;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'AlbumPhoto(id: $id, albumId: $albumId, filePath: $filePath, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumPhotoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.albumId, albumId) || other.albumId == albumId) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, albumId, filePath, createdAt, updatedAt);

  /// Create a copy of AlbumPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumPhotoImplCopyWith<_$AlbumPhotoImpl> get copyWith =>
      __$$AlbumPhotoImplCopyWithImpl<_$AlbumPhotoImpl>(this, _$identity);
}

abstract class _AlbumPhoto extends AlbumPhoto {
  const factory _AlbumPhoto({
    required final int id,
    required final int albumId,
    required final String filePath,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$AlbumPhotoImpl;
  const _AlbumPhoto._() : super._();

  @override
  int get id;
  @override
  int get albumId;
  @override
  String get filePath;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of AlbumPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlbumPhotoImplCopyWith<_$AlbumPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
