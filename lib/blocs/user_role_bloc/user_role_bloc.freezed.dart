// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_role_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserRoleEvent {
  String get userName => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userName) loadRoles,
    required TResult Function(List<PermissionRole> roles, String userName)
        updateRoles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userName)? loadRoles,
    TResult? Function(List<PermissionRole> roles, String userName)? updateRoles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userName)? loadRoles,
    TResult Function(List<PermissionRole> roles, String userName)? updateRoles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserRoles value) loadRoles,
    required TResult Function(UpdateUserRoles value) updateRoles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserRoles value)? loadRoles,
    TResult? Function(UpdateUserRoles value)? updateRoles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserRoles value)? loadRoles,
    TResult Function(UpdateUserRoles value)? updateRoles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of UserRoleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserRoleEventCopyWith<UserRoleEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRoleEventCopyWith<$Res> {
  factory $UserRoleEventCopyWith(
          UserRoleEvent value, $Res Function(UserRoleEvent) then) =
      _$UserRoleEventCopyWithImpl<$Res, UserRoleEvent>;
  @useResult
  $Res call({String userName});
}

/// @nodoc
class _$UserRoleEventCopyWithImpl<$Res, $Val extends UserRoleEvent>
    implements $UserRoleEventCopyWith<$Res> {
  _$UserRoleEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRoleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadUserRolesImplCopyWith<$Res>
    implements $UserRoleEventCopyWith<$Res> {
  factory _$$LoadUserRolesImplCopyWith(
          _$LoadUserRolesImpl value, $Res Function(_$LoadUserRolesImpl) then) =
      __$$LoadUserRolesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userName});
}

/// @nodoc
class __$$LoadUserRolesImplCopyWithImpl<$Res>
    extends _$UserRoleEventCopyWithImpl<$Res, _$LoadUserRolesImpl>
    implements _$$LoadUserRolesImplCopyWith<$Res> {
  __$$LoadUserRolesImplCopyWithImpl(
      _$LoadUserRolesImpl _value, $Res Function(_$LoadUserRolesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRoleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
  }) {
    return _then(_$LoadUserRolesImpl(
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadUserRolesImpl implements LoadUserRoles {
  const _$LoadUserRolesImpl(this.userName);

  @override
  final String userName;

  @override
  String toString() {
    return 'UserRoleEvent.loadRoles(userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadUserRolesImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName);

  /// Create a copy of UserRoleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadUserRolesImplCopyWith<_$LoadUserRolesImpl> get copyWith =>
      __$$LoadUserRolesImplCopyWithImpl<_$LoadUserRolesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userName) loadRoles,
    required TResult Function(List<PermissionRole> roles, String userName)
        updateRoles,
  }) {
    return loadRoles(userName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userName)? loadRoles,
    TResult? Function(List<PermissionRole> roles, String userName)? updateRoles,
  }) {
    return loadRoles?.call(userName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userName)? loadRoles,
    TResult Function(List<PermissionRole> roles, String userName)? updateRoles,
    required TResult orElse(),
  }) {
    if (loadRoles != null) {
      return loadRoles(userName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserRoles value) loadRoles,
    required TResult Function(UpdateUserRoles value) updateRoles,
  }) {
    return loadRoles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserRoles value)? loadRoles,
    TResult? Function(UpdateUserRoles value)? updateRoles,
  }) {
    return loadRoles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserRoles value)? loadRoles,
    TResult Function(UpdateUserRoles value)? updateRoles,
    required TResult orElse(),
  }) {
    if (loadRoles != null) {
      return loadRoles(this);
    }
    return orElse();
  }
}

abstract class LoadUserRoles implements UserRoleEvent {
  const factory LoadUserRoles(final String userName) = _$LoadUserRolesImpl;

  @override
  String get userName;

  /// Create a copy of UserRoleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadUserRolesImplCopyWith<_$LoadUserRolesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateUserRolesImplCopyWith<$Res>
    implements $UserRoleEventCopyWith<$Res> {
  factory _$$UpdateUserRolesImplCopyWith(_$UpdateUserRolesImpl value,
          $Res Function(_$UpdateUserRolesImpl) then) =
      __$$UpdateUserRolesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PermissionRole> roles, String userName});
}

/// @nodoc
class __$$UpdateUserRolesImplCopyWithImpl<$Res>
    extends _$UserRoleEventCopyWithImpl<$Res, _$UpdateUserRolesImpl>
    implements _$$UpdateUserRolesImplCopyWith<$Res> {
  __$$UpdateUserRolesImplCopyWithImpl(
      _$UpdateUserRolesImpl _value, $Res Function(_$UpdateUserRolesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRoleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roles = null,
    Object? userName = null,
  }) {
    return _then(_$UpdateUserRolesImpl(
      null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PermissionRole>,
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateUserRolesImpl implements UpdateUserRoles {
  const _$UpdateUserRolesImpl(final List<PermissionRole> roles, this.userName)
      : _roles = roles;

  final List<PermissionRole> _roles;
  @override
  List<PermissionRole> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final String userName;

  @override
  String toString() {
    return 'UserRoleEvent.updateRoles(roles: $roles, userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateUserRolesImpl &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_roles), userName);

  /// Create a copy of UserRoleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateUserRolesImplCopyWith<_$UpdateUserRolesImpl> get copyWith =>
      __$$UpdateUserRolesImplCopyWithImpl<_$UpdateUserRolesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userName) loadRoles,
    required TResult Function(List<PermissionRole> roles, String userName)
        updateRoles,
  }) {
    return updateRoles(roles, userName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userName)? loadRoles,
    TResult? Function(List<PermissionRole> roles, String userName)? updateRoles,
  }) {
    return updateRoles?.call(roles, userName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userName)? loadRoles,
    TResult Function(List<PermissionRole> roles, String userName)? updateRoles,
    required TResult orElse(),
  }) {
    if (updateRoles != null) {
      return updateRoles(roles, userName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserRoles value) loadRoles,
    required TResult Function(UpdateUserRoles value) updateRoles,
  }) {
    return updateRoles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserRoles value)? loadRoles,
    TResult? Function(UpdateUserRoles value)? updateRoles,
  }) {
    return updateRoles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserRoles value)? loadRoles,
    TResult Function(UpdateUserRoles value)? updateRoles,
    required TResult orElse(),
  }) {
    if (updateRoles != null) {
      return updateRoles(this);
    }
    return orElse();
  }
}

abstract class UpdateUserRoles implements UserRoleEvent {
  const factory UpdateUserRoles(
          final List<PermissionRole> roles, final String userName) =
      _$UpdateUserRolesImpl;

  List<PermissionRole> get roles;
  @override
  String get userName;

  /// Create a copy of UserRoleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateUserRolesImplCopyWith<_$UpdateUserRolesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserRoleState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PermissionRole> roles) loaded,
    required TResult Function(List<PermissionRole> roles) updated,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PermissionRole> roles)? loaded,
    TResult? Function(List<PermissionRole> roles)? updated,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PermissionRole> roles)? loaded,
    TResult Function(List<PermissionRole> roles)? updated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRoleInitial value) initial,
    required TResult Function(UserRoleLoading value) loading,
    required TResult Function(UserRoleLoaded value) loaded,
    required TResult Function(UserRoleUpdated value) updated,
    required TResult Function(UserRoleError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserRoleInitial value)? initial,
    TResult? Function(UserRoleLoading value)? loading,
    TResult? Function(UserRoleLoaded value)? loaded,
    TResult? Function(UserRoleUpdated value)? updated,
    TResult? Function(UserRoleError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRoleInitial value)? initial,
    TResult Function(UserRoleLoading value)? loading,
    TResult Function(UserRoleLoaded value)? loaded,
    TResult Function(UserRoleUpdated value)? updated,
    TResult Function(UserRoleError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRoleStateCopyWith<$Res> {
  factory $UserRoleStateCopyWith(
          UserRoleState value, $Res Function(UserRoleState) then) =
      _$UserRoleStateCopyWithImpl<$Res, UserRoleState>;
}

/// @nodoc
class _$UserRoleStateCopyWithImpl<$Res, $Val extends UserRoleState>
    implements $UserRoleStateCopyWith<$Res> {
  _$UserRoleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UserRoleInitialImplCopyWith<$Res> {
  factory _$$UserRoleInitialImplCopyWith(_$UserRoleInitialImpl value,
          $Res Function(_$UserRoleInitialImpl) then) =
      __$$UserRoleInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserRoleInitialImplCopyWithImpl<$Res>
    extends _$UserRoleStateCopyWithImpl<$Res, _$UserRoleInitialImpl>
    implements _$$UserRoleInitialImplCopyWith<$Res> {
  __$$UserRoleInitialImplCopyWithImpl(
      _$UserRoleInitialImpl _value, $Res Function(_$UserRoleInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UserRoleInitialImpl implements UserRoleInitial {
  const _$UserRoleInitialImpl();

  @override
  String toString() {
    return 'UserRoleState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserRoleInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PermissionRole> roles) loaded,
    required TResult Function(List<PermissionRole> roles) updated,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PermissionRole> roles)? loaded,
    TResult? Function(List<PermissionRole> roles)? updated,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PermissionRole> roles)? loaded,
    TResult Function(List<PermissionRole> roles)? updated,
    TResult Function(String message)? error,
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
    required TResult Function(UserRoleInitial value) initial,
    required TResult Function(UserRoleLoading value) loading,
    required TResult Function(UserRoleLoaded value) loaded,
    required TResult Function(UserRoleUpdated value) updated,
    required TResult Function(UserRoleError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserRoleInitial value)? initial,
    TResult? Function(UserRoleLoading value)? loading,
    TResult? Function(UserRoleLoaded value)? loaded,
    TResult? Function(UserRoleUpdated value)? updated,
    TResult? Function(UserRoleError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRoleInitial value)? initial,
    TResult Function(UserRoleLoading value)? loading,
    TResult Function(UserRoleLoaded value)? loaded,
    TResult Function(UserRoleUpdated value)? updated,
    TResult Function(UserRoleError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class UserRoleInitial implements UserRoleState {
  const factory UserRoleInitial() = _$UserRoleInitialImpl;
}

/// @nodoc
abstract class _$$UserRoleLoadingImplCopyWith<$Res> {
  factory _$$UserRoleLoadingImplCopyWith(_$UserRoleLoadingImpl value,
          $Res Function(_$UserRoleLoadingImpl) then) =
      __$$UserRoleLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserRoleLoadingImplCopyWithImpl<$Res>
    extends _$UserRoleStateCopyWithImpl<$Res, _$UserRoleLoadingImpl>
    implements _$$UserRoleLoadingImplCopyWith<$Res> {
  __$$UserRoleLoadingImplCopyWithImpl(
      _$UserRoleLoadingImpl _value, $Res Function(_$UserRoleLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UserRoleLoadingImpl implements UserRoleLoading {
  const _$UserRoleLoadingImpl();

  @override
  String toString() {
    return 'UserRoleState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserRoleLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PermissionRole> roles) loaded,
    required TResult Function(List<PermissionRole> roles) updated,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PermissionRole> roles)? loaded,
    TResult? Function(List<PermissionRole> roles)? updated,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PermissionRole> roles)? loaded,
    TResult Function(List<PermissionRole> roles)? updated,
    TResult Function(String message)? error,
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
    required TResult Function(UserRoleInitial value) initial,
    required TResult Function(UserRoleLoading value) loading,
    required TResult Function(UserRoleLoaded value) loaded,
    required TResult Function(UserRoleUpdated value) updated,
    required TResult Function(UserRoleError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserRoleInitial value)? initial,
    TResult? Function(UserRoleLoading value)? loading,
    TResult? Function(UserRoleLoaded value)? loaded,
    TResult? Function(UserRoleUpdated value)? updated,
    TResult? Function(UserRoleError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRoleInitial value)? initial,
    TResult Function(UserRoleLoading value)? loading,
    TResult Function(UserRoleLoaded value)? loaded,
    TResult Function(UserRoleUpdated value)? updated,
    TResult Function(UserRoleError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class UserRoleLoading implements UserRoleState {
  const factory UserRoleLoading() = _$UserRoleLoadingImpl;
}

/// @nodoc
abstract class _$$UserRoleLoadedImplCopyWith<$Res> {
  factory _$$UserRoleLoadedImplCopyWith(_$UserRoleLoadedImpl value,
          $Res Function(_$UserRoleLoadedImpl) then) =
      __$$UserRoleLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PermissionRole> roles});
}

/// @nodoc
class __$$UserRoleLoadedImplCopyWithImpl<$Res>
    extends _$UserRoleStateCopyWithImpl<$Res, _$UserRoleLoadedImpl>
    implements _$$UserRoleLoadedImplCopyWith<$Res> {
  __$$UserRoleLoadedImplCopyWithImpl(
      _$UserRoleLoadedImpl _value, $Res Function(_$UserRoleLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roles = null,
  }) {
    return _then(_$UserRoleLoadedImpl(
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PermissionRole>,
    ));
  }
}

/// @nodoc

class _$UserRoleLoadedImpl implements UserRoleLoaded {
  const _$UserRoleLoadedImpl({required final List<PermissionRole> roles})
      : _roles = roles;

  final List<PermissionRole> _roles;
  @override
  List<PermissionRole> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  String toString() {
    return 'UserRoleState.loaded(roles: $roles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRoleLoadedImpl &&
            const DeepCollectionEquality().equals(other._roles, _roles));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_roles));

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRoleLoadedImplCopyWith<_$UserRoleLoadedImpl> get copyWith =>
      __$$UserRoleLoadedImplCopyWithImpl<_$UserRoleLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PermissionRole> roles) loaded,
    required TResult Function(List<PermissionRole> roles) updated,
    required TResult Function(String message) error,
  }) {
    return loaded(roles);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PermissionRole> roles)? loaded,
    TResult? Function(List<PermissionRole> roles)? updated,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(roles);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PermissionRole> roles)? loaded,
    TResult Function(List<PermissionRole> roles)? updated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(roles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRoleInitial value) initial,
    required TResult Function(UserRoleLoading value) loading,
    required TResult Function(UserRoleLoaded value) loaded,
    required TResult Function(UserRoleUpdated value) updated,
    required TResult Function(UserRoleError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserRoleInitial value)? initial,
    TResult? Function(UserRoleLoading value)? loading,
    TResult? Function(UserRoleLoaded value)? loaded,
    TResult? Function(UserRoleUpdated value)? updated,
    TResult? Function(UserRoleError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRoleInitial value)? initial,
    TResult Function(UserRoleLoading value)? loading,
    TResult Function(UserRoleLoaded value)? loaded,
    TResult Function(UserRoleUpdated value)? updated,
    TResult Function(UserRoleError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class UserRoleLoaded implements UserRoleState {
  const factory UserRoleLoaded({required final List<PermissionRole> roles}) =
      _$UserRoleLoadedImpl;

  List<PermissionRole> get roles;

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRoleLoadedImplCopyWith<_$UserRoleLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserRoleUpdatedImplCopyWith<$Res> {
  factory _$$UserRoleUpdatedImplCopyWith(_$UserRoleUpdatedImpl value,
          $Res Function(_$UserRoleUpdatedImpl) then) =
      __$$UserRoleUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PermissionRole> roles});
}

/// @nodoc
class __$$UserRoleUpdatedImplCopyWithImpl<$Res>
    extends _$UserRoleStateCopyWithImpl<$Res, _$UserRoleUpdatedImpl>
    implements _$$UserRoleUpdatedImplCopyWith<$Res> {
  __$$UserRoleUpdatedImplCopyWithImpl(
      _$UserRoleUpdatedImpl _value, $Res Function(_$UserRoleUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roles = null,
  }) {
    return _then(_$UserRoleUpdatedImpl(
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PermissionRole>,
    ));
  }
}

/// @nodoc

class _$UserRoleUpdatedImpl implements UserRoleUpdated {
  const _$UserRoleUpdatedImpl({required final List<PermissionRole> roles})
      : _roles = roles;

  final List<PermissionRole> _roles;
  @override
  List<PermissionRole> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  String toString() {
    return 'UserRoleState.updated(roles: $roles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRoleUpdatedImpl &&
            const DeepCollectionEquality().equals(other._roles, _roles));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_roles));

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRoleUpdatedImplCopyWith<_$UserRoleUpdatedImpl> get copyWith =>
      __$$UserRoleUpdatedImplCopyWithImpl<_$UserRoleUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PermissionRole> roles) loaded,
    required TResult Function(List<PermissionRole> roles) updated,
    required TResult Function(String message) error,
  }) {
    return updated(roles);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PermissionRole> roles)? loaded,
    TResult? Function(List<PermissionRole> roles)? updated,
    TResult? Function(String message)? error,
  }) {
    return updated?.call(roles);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PermissionRole> roles)? loaded,
    TResult Function(List<PermissionRole> roles)? updated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(roles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRoleInitial value) initial,
    required TResult Function(UserRoleLoading value) loading,
    required TResult Function(UserRoleLoaded value) loaded,
    required TResult Function(UserRoleUpdated value) updated,
    required TResult Function(UserRoleError value) error,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserRoleInitial value)? initial,
    TResult? Function(UserRoleLoading value)? loading,
    TResult? Function(UserRoleLoaded value)? loaded,
    TResult? Function(UserRoleUpdated value)? updated,
    TResult? Function(UserRoleError value)? error,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRoleInitial value)? initial,
    TResult Function(UserRoleLoading value)? loading,
    TResult Function(UserRoleLoaded value)? loaded,
    TResult Function(UserRoleUpdated value)? updated,
    TResult Function(UserRoleError value)? error,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class UserRoleUpdated implements UserRoleState {
  const factory UserRoleUpdated({required final List<PermissionRole> roles}) =
      _$UserRoleUpdatedImpl;

  List<PermissionRole> get roles;

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRoleUpdatedImplCopyWith<_$UserRoleUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserRoleErrorImplCopyWith<$Res> {
  factory _$$UserRoleErrorImplCopyWith(
          _$UserRoleErrorImpl value, $Res Function(_$UserRoleErrorImpl) then) =
      __$$UserRoleErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UserRoleErrorImplCopyWithImpl<$Res>
    extends _$UserRoleStateCopyWithImpl<$Res, _$UserRoleErrorImpl>
    implements _$$UserRoleErrorImplCopyWith<$Res> {
  __$$UserRoleErrorImplCopyWithImpl(
      _$UserRoleErrorImpl _value, $Res Function(_$UserRoleErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UserRoleErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserRoleErrorImpl implements UserRoleError {
  const _$UserRoleErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'UserRoleState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRoleErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRoleErrorImplCopyWith<_$UserRoleErrorImpl> get copyWith =>
      __$$UserRoleErrorImplCopyWithImpl<_$UserRoleErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PermissionRole> roles) loaded,
    required TResult Function(List<PermissionRole> roles) updated,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PermissionRole> roles)? loaded,
    TResult? Function(List<PermissionRole> roles)? updated,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PermissionRole> roles)? loaded,
    TResult Function(List<PermissionRole> roles)? updated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRoleInitial value) initial,
    required TResult Function(UserRoleLoading value) loading,
    required TResult Function(UserRoleLoaded value) loaded,
    required TResult Function(UserRoleUpdated value) updated,
    required TResult Function(UserRoleError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserRoleInitial value)? initial,
    TResult? Function(UserRoleLoading value)? loading,
    TResult? Function(UserRoleLoaded value)? loaded,
    TResult? Function(UserRoleUpdated value)? updated,
    TResult? Function(UserRoleError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRoleInitial value)? initial,
    TResult Function(UserRoleLoading value)? loading,
    TResult Function(UserRoleLoaded value)? loaded,
    TResult Function(UserRoleUpdated value)? updated,
    TResult Function(UserRoleError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class UserRoleError implements UserRoleState {
  const factory UserRoleError({required final String message}) =
      _$UserRoleErrorImpl;

  String get message;

  /// Create a copy of UserRoleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRoleErrorImplCopyWith<_$UserRoleErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
