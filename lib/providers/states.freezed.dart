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
  int get goalId => throw _privateConstructorUsedError;
  String? get goalName => throw _privateConstructorUsedError;
  String? get blueprint => throw _privateConstructorUsedError;
  int? get defaultDuration => throw _privateConstructorUsedError;
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
    int goalId,
    String? goalName,
    String? blueprint,
    int? defaultDuration,
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
    Object? defaultDuration = freezed,
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
            defaultDuration: freezed == defaultDuration
                ? _value.defaultDuration
                : defaultDuration // ignore: cast_nullable_to_non_nullable
                      as int?,
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
    int? defaultDuration,
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
    Object? defaultDuration = freezed,
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
        defaultDuration: freezed == defaultDuration
            ? _value.defaultDuration
            : defaultDuration // ignore: cast_nullable_to_non_nullable
                  as int?,
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
    this.defaultDuration = 60,
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
  @JsonKey()
  final int? defaultDuration;
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
    return 'CoursePlan(id: $id, studentId: $studentId, goalId: $goalId, goalName: $goalName, blueprint: $blueprint, defaultDuration: $defaultDuration, createdAt: $createdAt, updatedAt: $updatedAt, student: $student, sessions: $sessions, totalSessions: $totalSessions, completedSessions: $completedSessions)';
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
            (identical(other.defaultDuration, defaultDuration) ||
                other.defaultDuration == defaultDuration) &&
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
    defaultDuration,
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
    final int? defaultDuration,
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
  int? get defaultDuration;
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
  int? get durationOverride => throw _privateConstructorUsedError;
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
    DateTime? scheduledTime,
    int? durationOverride,
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
    Object? scheduledTime = freezed,
    Object? durationOverride = freezed,
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
            scheduledTime: freezed == scheduledTime
                ? _value.scheduledTime
                : scheduledTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            durationOverride: freezed == durationOverride
                ? _value.durationOverride
                : durationOverride // ignore: cast_nullable_to_non_nullable
                      as int?,
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
    DateTime? scheduledTime,
    int? durationOverride,
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
    Object? scheduledTime = freezed,
    Object? durationOverride = freezed,
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
        scheduledTime: freezed == scheduledTime
            ? _value.scheduledTime
            : scheduledTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        durationOverride: freezed == durationOverride
            ? _value.durationOverride
            : durationOverride // ignore: cast_nullable_to_non_nullable
                  as int?,
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
    this.scheduledTime,
    this.durationOverride,
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
  final DateTime? scheduledTime;
  @override
  final int? durationOverride;
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
    return 'Session(id: $id, coursePlanId: $coursePlanId, sessionNumber: $sessionNumber, scheduledTime: $scheduledTime, durationOverride: $durationOverride, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, contentBlocks: $contentBlocks)';
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
            (identical(other.durationOverride, durationOverride) ||
                other.durationOverride == durationOverride) &&
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
    scheduledTime,
    durationOverride,
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
    final DateTime? scheduledTime,
    final int? durationOverride,
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
  DateTime? get scheduledTime;
  @override
  int? get durationOverride;
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
