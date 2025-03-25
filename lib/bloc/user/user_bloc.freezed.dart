// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllUsers,
    required TResult Function(String userId) fetchUserById,
    required TResult Function(UserModel user) createUser,
    required TResult Function(UserModel user) updateUser,
    required TResult Function(String userId) deleteUser,
    required TResult Function(String manv) fetchUserByManv,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllUsers,
    TResult? Function(String userId)? fetchUserById,
    TResult? Function(UserModel user)? createUser,
    TResult? Function(UserModel user)? updateUser,
    TResult? Function(String userId)? deleteUser,
    TResult? Function(String manv)? fetchUserByManv,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllUsers,
    TResult Function(String userId)? fetchUserById,
    TResult Function(UserModel user)? createUser,
    TResult Function(UserModel user)? updateUser,
    TResult Function(String userId)? deleteUser,
    TResult Function(String manv)? fetchUserByManv,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAllUsers value) fetchAllUsers,
    required TResult Function(FetchUserById value) fetchUserById,
    required TResult Function(CreateUser value) createUser,
    required TResult Function(UpdateUser value) updateUser,
    required TResult Function(DeleteUser value) deleteUser,
    required TResult Function(FetchUserByManv value) fetchUserByManv,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAllUsers value)? fetchAllUsers,
    TResult? Function(FetchUserById value)? fetchUserById,
    TResult? Function(CreateUser value)? createUser,
    TResult? Function(UpdateUser value)? updateUser,
    TResult? Function(DeleteUser value)? deleteUser,
    TResult? Function(FetchUserByManv value)? fetchUserByManv,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAllUsers value)? fetchAllUsers,
    TResult Function(FetchUserById value)? fetchUserById,
    TResult Function(CreateUser value)? createUser,
    TResult Function(UpdateUser value)? updateUser,
    TResult Function(DeleteUser value)? deleteUser,
    TResult Function(FetchUserByManv value)? fetchUserByManv,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEventCopyWith<$Res> {
  factory $UserEventCopyWith(UserEvent value, $Res Function(UserEvent) then) =
      _$UserEventCopyWithImpl<$Res, UserEvent>;
}

/// @nodoc
class _$UserEventCopyWithImpl<$Res, $Val extends UserEvent>
    implements $UserEventCopyWith<$Res> {
  _$UserEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchAllUsersImplCopyWith<$Res> {
  factory _$$FetchAllUsersImplCopyWith(
          _$FetchAllUsersImpl value, $Res Function(_$FetchAllUsersImpl) then) =
      __$$FetchAllUsersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchAllUsersImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$FetchAllUsersImpl>
    implements _$$FetchAllUsersImplCopyWith<$Res> {
  __$$FetchAllUsersImplCopyWithImpl(
      _$FetchAllUsersImpl _value, $Res Function(_$FetchAllUsersImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FetchAllUsersImpl implements FetchAllUsers {
  const _$FetchAllUsersImpl();

  @override
  String toString() {
    return 'UserEvent.fetchAllUsers()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FetchAllUsersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllUsers,
    required TResult Function(String userId) fetchUserById,
    required TResult Function(UserModel user) createUser,
    required TResult Function(UserModel user) updateUser,
    required TResult Function(String userId) deleteUser,
    required TResult Function(String manv) fetchUserByManv,
  }) {
    return fetchAllUsers();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllUsers,
    TResult? Function(String userId)? fetchUserById,
    TResult? Function(UserModel user)? createUser,
    TResult? Function(UserModel user)? updateUser,
    TResult? Function(String userId)? deleteUser,
    TResult? Function(String manv)? fetchUserByManv,
  }) {
    return fetchAllUsers?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllUsers,
    TResult Function(String userId)? fetchUserById,
    TResult Function(UserModel user)? createUser,
    TResult Function(UserModel user)? updateUser,
    TResult Function(String userId)? deleteUser,
    TResult Function(String manv)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (fetchAllUsers != null) {
      return fetchAllUsers();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAllUsers value) fetchAllUsers,
    required TResult Function(FetchUserById value) fetchUserById,
    required TResult Function(CreateUser value) createUser,
    required TResult Function(UpdateUser value) updateUser,
    required TResult Function(DeleteUser value) deleteUser,
    required TResult Function(FetchUserByManv value) fetchUserByManv,
  }) {
    return fetchAllUsers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAllUsers value)? fetchAllUsers,
    TResult? Function(FetchUserById value)? fetchUserById,
    TResult? Function(CreateUser value)? createUser,
    TResult? Function(UpdateUser value)? updateUser,
    TResult? Function(DeleteUser value)? deleteUser,
    TResult? Function(FetchUserByManv value)? fetchUserByManv,
  }) {
    return fetchAllUsers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAllUsers value)? fetchAllUsers,
    TResult Function(FetchUserById value)? fetchUserById,
    TResult Function(CreateUser value)? createUser,
    TResult Function(UpdateUser value)? updateUser,
    TResult Function(DeleteUser value)? deleteUser,
    TResult Function(FetchUserByManv value)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (fetchAllUsers != null) {
      return fetchAllUsers(this);
    }
    return orElse();
  }
}

abstract class FetchAllUsers implements UserEvent {
  const factory FetchAllUsers() = _$FetchAllUsersImpl;
}

/// @nodoc
abstract class _$$FetchUserByIdImplCopyWith<$Res> {
  factory _$$FetchUserByIdImplCopyWith(
          _$FetchUserByIdImpl value, $Res Function(_$FetchUserByIdImpl) then) =
      __$$FetchUserByIdImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$FetchUserByIdImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$FetchUserByIdImpl>
    implements _$$FetchUserByIdImplCopyWith<$Res> {
  __$$FetchUserByIdImplCopyWithImpl(
      _$FetchUserByIdImpl _value, $Res Function(_$FetchUserByIdImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$FetchUserByIdImpl(
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchUserByIdImpl implements FetchUserById {
  const _$FetchUserByIdImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'UserEvent.fetchUserById(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchUserByIdImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchUserByIdImplCopyWith<_$FetchUserByIdImpl> get copyWith =>
      __$$FetchUserByIdImplCopyWithImpl<_$FetchUserByIdImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllUsers,
    required TResult Function(String userId) fetchUserById,
    required TResult Function(UserModel user) createUser,
    required TResult Function(UserModel user) updateUser,
    required TResult Function(String userId) deleteUser,
    required TResult Function(String manv) fetchUserByManv,
  }) {
    return fetchUserById(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllUsers,
    TResult? Function(String userId)? fetchUserById,
    TResult? Function(UserModel user)? createUser,
    TResult? Function(UserModel user)? updateUser,
    TResult? Function(String userId)? deleteUser,
    TResult? Function(String manv)? fetchUserByManv,
  }) {
    return fetchUserById?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllUsers,
    TResult Function(String userId)? fetchUserById,
    TResult Function(UserModel user)? createUser,
    TResult Function(UserModel user)? updateUser,
    TResult Function(String userId)? deleteUser,
    TResult Function(String manv)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (fetchUserById != null) {
      return fetchUserById(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAllUsers value) fetchAllUsers,
    required TResult Function(FetchUserById value) fetchUserById,
    required TResult Function(CreateUser value) createUser,
    required TResult Function(UpdateUser value) updateUser,
    required TResult Function(DeleteUser value) deleteUser,
    required TResult Function(FetchUserByManv value) fetchUserByManv,
  }) {
    return fetchUserById(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAllUsers value)? fetchAllUsers,
    TResult? Function(FetchUserById value)? fetchUserById,
    TResult? Function(CreateUser value)? createUser,
    TResult? Function(UpdateUser value)? updateUser,
    TResult? Function(DeleteUser value)? deleteUser,
    TResult? Function(FetchUserByManv value)? fetchUserByManv,
  }) {
    return fetchUserById?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAllUsers value)? fetchAllUsers,
    TResult Function(FetchUserById value)? fetchUserById,
    TResult Function(CreateUser value)? createUser,
    TResult Function(UpdateUser value)? updateUser,
    TResult Function(DeleteUser value)? deleteUser,
    TResult Function(FetchUserByManv value)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (fetchUserById != null) {
      return fetchUserById(this);
    }
    return orElse();
  }
}

abstract class FetchUserById implements UserEvent {
  const factory FetchUserById(final String userId) = _$FetchUserByIdImpl;

  String get userId;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchUserByIdImplCopyWith<_$FetchUserByIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateUserImplCopyWith<$Res> {
  factory _$$CreateUserImplCopyWith(
          _$CreateUserImpl value, $Res Function(_$CreateUserImpl) then) =
      __$$CreateUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel user});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$CreateUserImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$CreateUserImpl>
    implements _$$CreateUserImplCopyWith<$Res> {
  __$$CreateUserImplCopyWithImpl(
      _$CreateUserImpl _value, $Res Function(_$CreateUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$CreateUserImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$CreateUserImpl implements CreateUser {
  const _$CreateUserImpl(this.user);

  @override
  final UserModel user;

  @override
  String toString() {
    return 'UserEvent.createUser(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateUserImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateUserImplCopyWith<_$CreateUserImpl> get copyWith =>
      __$$CreateUserImplCopyWithImpl<_$CreateUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllUsers,
    required TResult Function(String userId) fetchUserById,
    required TResult Function(UserModel user) createUser,
    required TResult Function(UserModel user) updateUser,
    required TResult Function(String userId) deleteUser,
    required TResult Function(String manv) fetchUserByManv,
  }) {
    return createUser(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllUsers,
    TResult? Function(String userId)? fetchUserById,
    TResult? Function(UserModel user)? createUser,
    TResult? Function(UserModel user)? updateUser,
    TResult? Function(String userId)? deleteUser,
    TResult? Function(String manv)? fetchUserByManv,
  }) {
    return createUser?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllUsers,
    TResult Function(String userId)? fetchUserById,
    TResult Function(UserModel user)? createUser,
    TResult Function(UserModel user)? updateUser,
    TResult Function(String userId)? deleteUser,
    TResult Function(String manv)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (createUser != null) {
      return createUser(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAllUsers value) fetchAllUsers,
    required TResult Function(FetchUserById value) fetchUserById,
    required TResult Function(CreateUser value) createUser,
    required TResult Function(UpdateUser value) updateUser,
    required TResult Function(DeleteUser value) deleteUser,
    required TResult Function(FetchUserByManv value) fetchUserByManv,
  }) {
    return createUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAllUsers value)? fetchAllUsers,
    TResult? Function(FetchUserById value)? fetchUserById,
    TResult? Function(CreateUser value)? createUser,
    TResult? Function(UpdateUser value)? updateUser,
    TResult? Function(DeleteUser value)? deleteUser,
    TResult? Function(FetchUserByManv value)? fetchUserByManv,
  }) {
    return createUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAllUsers value)? fetchAllUsers,
    TResult Function(FetchUserById value)? fetchUserById,
    TResult Function(CreateUser value)? createUser,
    TResult Function(UpdateUser value)? updateUser,
    TResult Function(DeleteUser value)? deleteUser,
    TResult Function(FetchUserByManv value)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (createUser != null) {
      return createUser(this);
    }
    return orElse();
  }
}

abstract class CreateUser implements UserEvent {
  const factory CreateUser(final UserModel user) = _$CreateUserImpl;

  UserModel get user;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateUserImplCopyWith<_$CreateUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateUserImplCopyWith<$Res> {
  factory _$$UpdateUserImplCopyWith(
          _$UpdateUserImpl value, $Res Function(_$UpdateUserImpl) then) =
      __$$UpdateUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel user});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$UpdateUserImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$UpdateUserImpl>
    implements _$$UpdateUserImplCopyWith<$Res> {
  __$$UpdateUserImplCopyWithImpl(
      _$UpdateUserImpl _value, $Res Function(_$UpdateUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$UpdateUserImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$UpdateUserImpl implements UpdateUser {
  const _$UpdateUserImpl(this.user);

  @override
  final UserModel user;

  @override
  String toString() {
    return 'UserEvent.updateUser(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateUserImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateUserImplCopyWith<_$UpdateUserImpl> get copyWith =>
      __$$UpdateUserImplCopyWithImpl<_$UpdateUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllUsers,
    required TResult Function(String userId) fetchUserById,
    required TResult Function(UserModel user) createUser,
    required TResult Function(UserModel user) updateUser,
    required TResult Function(String userId) deleteUser,
    required TResult Function(String manv) fetchUserByManv,
  }) {
    return updateUser(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllUsers,
    TResult? Function(String userId)? fetchUserById,
    TResult? Function(UserModel user)? createUser,
    TResult? Function(UserModel user)? updateUser,
    TResult? Function(String userId)? deleteUser,
    TResult? Function(String manv)? fetchUserByManv,
  }) {
    return updateUser?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllUsers,
    TResult Function(String userId)? fetchUserById,
    TResult Function(UserModel user)? createUser,
    TResult Function(UserModel user)? updateUser,
    TResult Function(String userId)? deleteUser,
    TResult Function(String manv)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (updateUser != null) {
      return updateUser(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAllUsers value) fetchAllUsers,
    required TResult Function(FetchUserById value) fetchUserById,
    required TResult Function(CreateUser value) createUser,
    required TResult Function(UpdateUser value) updateUser,
    required TResult Function(DeleteUser value) deleteUser,
    required TResult Function(FetchUserByManv value) fetchUserByManv,
  }) {
    return updateUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAllUsers value)? fetchAllUsers,
    TResult? Function(FetchUserById value)? fetchUserById,
    TResult? Function(CreateUser value)? createUser,
    TResult? Function(UpdateUser value)? updateUser,
    TResult? Function(DeleteUser value)? deleteUser,
    TResult? Function(FetchUserByManv value)? fetchUserByManv,
  }) {
    return updateUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAllUsers value)? fetchAllUsers,
    TResult Function(FetchUserById value)? fetchUserById,
    TResult Function(CreateUser value)? createUser,
    TResult Function(UpdateUser value)? updateUser,
    TResult Function(DeleteUser value)? deleteUser,
    TResult Function(FetchUserByManv value)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (updateUser != null) {
      return updateUser(this);
    }
    return orElse();
  }
}

abstract class UpdateUser implements UserEvent {
  const factory UpdateUser(final UserModel user) = _$UpdateUserImpl;

  UserModel get user;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateUserImplCopyWith<_$UpdateUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteUserImplCopyWith<$Res> {
  factory _$$DeleteUserImplCopyWith(
          _$DeleteUserImpl value, $Res Function(_$DeleteUserImpl) then) =
      __$$DeleteUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$DeleteUserImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$DeleteUserImpl>
    implements _$$DeleteUserImplCopyWith<$Res> {
  __$$DeleteUserImplCopyWithImpl(
      _$DeleteUserImpl _value, $Res Function(_$DeleteUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$DeleteUserImpl(
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteUserImpl implements DeleteUser {
  const _$DeleteUserImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'UserEvent.deleteUser(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteUserImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteUserImplCopyWith<_$DeleteUserImpl> get copyWith =>
      __$$DeleteUserImplCopyWithImpl<_$DeleteUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllUsers,
    required TResult Function(String userId) fetchUserById,
    required TResult Function(UserModel user) createUser,
    required TResult Function(UserModel user) updateUser,
    required TResult Function(String userId) deleteUser,
    required TResult Function(String manv) fetchUserByManv,
  }) {
    return deleteUser(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllUsers,
    TResult? Function(String userId)? fetchUserById,
    TResult? Function(UserModel user)? createUser,
    TResult? Function(UserModel user)? updateUser,
    TResult? Function(String userId)? deleteUser,
    TResult? Function(String manv)? fetchUserByManv,
  }) {
    return deleteUser?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllUsers,
    TResult Function(String userId)? fetchUserById,
    TResult Function(UserModel user)? createUser,
    TResult Function(UserModel user)? updateUser,
    TResult Function(String userId)? deleteUser,
    TResult Function(String manv)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (deleteUser != null) {
      return deleteUser(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAllUsers value) fetchAllUsers,
    required TResult Function(FetchUserById value) fetchUserById,
    required TResult Function(CreateUser value) createUser,
    required TResult Function(UpdateUser value) updateUser,
    required TResult Function(DeleteUser value) deleteUser,
    required TResult Function(FetchUserByManv value) fetchUserByManv,
  }) {
    return deleteUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAllUsers value)? fetchAllUsers,
    TResult? Function(FetchUserById value)? fetchUserById,
    TResult? Function(CreateUser value)? createUser,
    TResult? Function(UpdateUser value)? updateUser,
    TResult? Function(DeleteUser value)? deleteUser,
    TResult? Function(FetchUserByManv value)? fetchUserByManv,
  }) {
    return deleteUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAllUsers value)? fetchAllUsers,
    TResult Function(FetchUserById value)? fetchUserById,
    TResult Function(CreateUser value)? createUser,
    TResult Function(UpdateUser value)? updateUser,
    TResult Function(DeleteUser value)? deleteUser,
    TResult Function(FetchUserByManv value)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (deleteUser != null) {
      return deleteUser(this);
    }
    return orElse();
  }
}

abstract class DeleteUser implements UserEvent {
  const factory DeleteUser(final String userId) = _$DeleteUserImpl;

  String get userId;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteUserImplCopyWith<_$DeleteUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchUserByManvImplCopyWith<$Res> {
  factory _$$FetchUserByManvImplCopyWith(_$FetchUserByManvImpl value,
          $Res Function(_$FetchUserByManvImpl) then) =
      __$$FetchUserByManvImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String manv});
}

/// @nodoc
class __$$FetchUserByManvImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$FetchUserByManvImpl>
    implements _$$FetchUserByManvImplCopyWith<$Res> {
  __$$FetchUserByManvImplCopyWithImpl(
      _$FetchUserByManvImpl _value, $Res Function(_$FetchUserByManvImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manv = null,
  }) {
    return _then(_$FetchUserByManvImpl(
      null == manv
          ? _value.manv
          : manv // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchUserByManvImpl implements FetchUserByManv {
  const _$FetchUserByManvImpl(this.manv);

  @override
  final String manv;

  @override
  String toString() {
    return 'UserEvent.fetchUserByManv(manv: $manv)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchUserByManvImpl &&
            (identical(other.manv, manv) || other.manv == manv));
  }

  @override
  int get hashCode => Object.hash(runtimeType, manv);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchUserByManvImplCopyWith<_$FetchUserByManvImpl> get copyWith =>
      __$$FetchUserByManvImplCopyWithImpl<_$FetchUserByManvImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllUsers,
    required TResult Function(String userId) fetchUserById,
    required TResult Function(UserModel user) createUser,
    required TResult Function(UserModel user) updateUser,
    required TResult Function(String userId) deleteUser,
    required TResult Function(String manv) fetchUserByManv,
  }) {
    return fetchUserByManv(manv);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllUsers,
    TResult? Function(String userId)? fetchUserById,
    TResult? Function(UserModel user)? createUser,
    TResult? Function(UserModel user)? updateUser,
    TResult? Function(String userId)? deleteUser,
    TResult? Function(String manv)? fetchUserByManv,
  }) {
    return fetchUserByManv?.call(manv);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllUsers,
    TResult Function(String userId)? fetchUserById,
    TResult Function(UserModel user)? createUser,
    TResult Function(UserModel user)? updateUser,
    TResult Function(String userId)? deleteUser,
    TResult Function(String manv)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (fetchUserByManv != null) {
      return fetchUserByManv(manv);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAllUsers value) fetchAllUsers,
    required TResult Function(FetchUserById value) fetchUserById,
    required TResult Function(CreateUser value) createUser,
    required TResult Function(UpdateUser value) updateUser,
    required TResult Function(DeleteUser value) deleteUser,
    required TResult Function(FetchUserByManv value) fetchUserByManv,
  }) {
    return fetchUserByManv(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAllUsers value)? fetchAllUsers,
    TResult? Function(FetchUserById value)? fetchUserById,
    TResult? Function(CreateUser value)? createUser,
    TResult? Function(UpdateUser value)? updateUser,
    TResult? Function(DeleteUser value)? deleteUser,
    TResult? Function(FetchUserByManv value)? fetchUserByManv,
  }) {
    return fetchUserByManv?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAllUsers value)? fetchAllUsers,
    TResult Function(FetchUserById value)? fetchUserById,
    TResult Function(CreateUser value)? createUser,
    TResult Function(UpdateUser value)? updateUser,
    TResult Function(DeleteUser value)? deleteUser,
    TResult Function(FetchUserByManv value)? fetchUserByManv,
    required TResult orElse(),
  }) {
    if (fetchUserByManv != null) {
      return fetchUserByManv(this);
    }
    return orElse();
  }
}

abstract class FetchUserByManv implements UserEvent {
  const factory FetchUserByManv(final String manv) = _$FetchUserByManvImpl;

  String get manv;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchUserByManvImplCopyWith<_$FetchUserByManvImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<UserModel> users) loadSuccess,
    required TResult Function(UserModel user) userLoaded,
    required TResult Function() operationSuccess,
    required TResult Function(String message) failure,
    required TResult Function() loadInProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<UserModel> users)? loadSuccess,
    TResult? Function(UserModel user)? userLoaded,
    TResult? Function()? operationSuccess,
    TResult? Function(String message)? failure,
    TResult? Function()? loadInProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<UserModel> users)? loadSuccess,
    TResult Function(UserModel user)? userLoaded,
    TResult Function()? operationSuccess,
    TResult Function(String message)? failure,
    TResult Function()? loadInProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserInitial value) initial,
    required TResult Function(UsersLoadSuccess value) loadSuccess,
    required TResult Function(UserLoadSuccess value) userLoaded,
    required TResult Function(UserOperationSuccess value) operationSuccess,
    required TResult Function(UserOperationFailure value) failure,
    required TResult Function(UsersLoadInProgress value) loadInProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserInitial value)? initial,
    TResult? Function(UsersLoadSuccess value)? loadSuccess,
    TResult? Function(UserLoadSuccess value)? userLoaded,
    TResult? Function(UserOperationSuccess value)? operationSuccess,
    TResult? Function(UserOperationFailure value)? failure,
    TResult? Function(UsersLoadInProgress value)? loadInProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserInitial value)? initial,
    TResult Function(UsersLoadSuccess value)? loadSuccess,
    TResult Function(UserLoadSuccess value)? userLoaded,
    TResult Function(UserOperationSuccess value)? operationSuccess,
    TResult Function(UserOperationFailure value)? failure,
    TResult Function(UsersLoadInProgress value)? loadInProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UserInitialImplCopyWith<$Res> {
  factory _$$UserInitialImplCopyWith(
          _$UserInitialImpl value, $Res Function(_$UserInitialImpl) then) =
      __$$UserInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserInitialImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UserInitialImpl>
    implements _$$UserInitialImplCopyWith<$Res> {
  __$$UserInitialImplCopyWithImpl(
      _$UserInitialImpl _value, $Res Function(_$UserInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UserInitialImpl implements UserInitial {
  const _$UserInitialImpl();

  @override
  String toString() {
    return 'UserState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<UserModel> users) loadSuccess,
    required TResult Function(UserModel user) userLoaded,
    required TResult Function() operationSuccess,
    required TResult Function(String message) failure,
    required TResult Function() loadInProgress,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<UserModel> users)? loadSuccess,
    TResult? Function(UserModel user)? userLoaded,
    TResult? Function()? operationSuccess,
    TResult? Function(String message)? failure,
    TResult? Function()? loadInProgress,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<UserModel> users)? loadSuccess,
    TResult Function(UserModel user)? userLoaded,
    TResult Function()? operationSuccess,
    TResult Function(String message)? failure,
    TResult Function()? loadInProgress,
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
    required TResult Function(UserInitial value) initial,
    required TResult Function(UsersLoadSuccess value) loadSuccess,
    required TResult Function(UserLoadSuccess value) userLoaded,
    required TResult Function(UserOperationSuccess value) operationSuccess,
    required TResult Function(UserOperationFailure value) failure,
    required TResult Function(UsersLoadInProgress value) loadInProgress,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserInitial value)? initial,
    TResult? Function(UsersLoadSuccess value)? loadSuccess,
    TResult? Function(UserLoadSuccess value)? userLoaded,
    TResult? Function(UserOperationSuccess value)? operationSuccess,
    TResult? Function(UserOperationFailure value)? failure,
    TResult? Function(UsersLoadInProgress value)? loadInProgress,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserInitial value)? initial,
    TResult Function(UsersLoadSuccess value)? loadSuccess,
    TResult Function(UserLoadSuccess value)? userLoaded,
    TResult Function(UserOperationSuccess value)? operationSuccess,
    TResult Function(UserOperationFailure value)? failure,
    TResult Function(UsersLoadInProgress value)? loadInProgress,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class UserInitial implements UserState {
  const factory UserInitial() = _$UserInitialImpl;
}

/// @nodoc
abstract class _$$UsersLoadSuccessImplCopyWith<$Res> {
  factory _$$UsersLoadSuccessImplCopyWith(_$UsersLoadSuccessImpl value,
          $Res Function(_$UsersLoadSuccessImpl) then) =
      __$$UsersLoadSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<UserModel> users});
}

/// @nodoc
class __$$UsersLoadSuccessImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UsersLoadSuccessImpl>
    implements _$$UsersLoadSuccessImplCopyWith<$Res> {
  __$$UsersLoadSuccessImplCopyWithImpl(_$UsersLoadSuccessImpl _value,
      $Res Function(_$UsersLoadSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
  }) {
    return _then(_$UsersLoadSuccessImpl(
      null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc

class _$UsersLoadSuccessImpl implements UsersLoadSuccess {
  const _$UsersLoadSuccessImpl(final List<UserModel> users) : _users = users;

  final List<UserModel> _users;
  @override
  List<UserModel> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'UserState.loadSuccess(users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsersLoadSuccessImpl &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_users));

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsersLoadSuccessImplCopyWith<_$UsersLoadSuccessImpl> get copyWith =>
      __$$UsersLoadSuccessImplCopyWithImpl<_$UsersLoadSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<UserModel> users) loadSuccess,
    required TResult Function(UserModel user) userLoaded,
    required TResult Function() operationSuccess,
    required TResult Function(String message) failure,
    required TResult Function() loadInProgress,
  }) {
    return loadSuccess(users);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<UserModel> users)? loadSuccess,
    TResult? Function(UserModel user)? userLoaded,
    TResult? Function()? operationSuccess,
    TResult? Function(String message)? failure,
    TResult? Function()? loadInProgress,
  }) {
    return loadSuccess?.call(users);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<UserModel> users)? loadSuccess,
    TResult Function(UserModel user)? userLoaded,
    TResult Function()? operationSuccess,
    TResult Function(String message)? failure,
    TResult Function()? loadInProgress,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(users);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserInitial value) initial,
    required TResult Function(UsersLoadSuccess value) loadSuccess,
    required TResult Function(UserLoadSuccess value) userLoaded,
    required TResult Function(UserOperationSuccess value) operationSuccess,
    required TResult Function(UserOperationFailure value) failure,
    required TResult Function(UsersLoadInProgress value) loadInProgress,
  }) {
    return loadSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserInitial value)? initial,
    TResult? Function(UsersLoadSuccess value)? loadSuccess,
    TResult? Function(UserLoadSuccess value)? userLoaded,
    TResult? Function(UserOperationSuccess value)? operationSuccess,
    TResult? Function(UserOperationFailure value)? failure,
    TResult? Function(UsersLoadInProgress value)? loadInProgress,
  }) {
    return loadSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserInitial value)? initial,
    TResult Function(UsersLoadSuccess value)? loadSuccess,
    TResult Function(UserLoadSuccess value)? userLoaded,
    TResult Function(UserOperationSuccess value)? operationSuccess,
    TResult Function(UserOperationFailure value)? failure,
    TResult Function(UsersLoadInProgress value)? loadInProgress,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(this);
    }
    return orElse();
  }
}

abstract class UsersLoadSuccess implements UserState {
  const factory UsersLoadSuccess(final List<UserModel> users) =
      _$UsersLoadSuccessImpl;

  List<UserModel> get users;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsersLoadSuccessImplCopyWith<_$UsersLoadSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserLoadSuccessImplCopyWith<$Res> {
  factory _$$UserLoadSuccessImplCopyWith(_$UserLoadSuccessImpl value,
          $Res Function(_$UserLoadSuccessImpl) then) =
      __$$UserLoadSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel user});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$UserLoadSuccessImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UserLoadSuccessImpl>
    implements _$$UserLoadSuccessImplCopyWith<$Res> {
  __$$UserLoadSuccessImplCopyWithImpl(
      _$UserLoadSuccessImpl _value, $Res Function(_$UserLoadSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$UserLoadSuccessImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$UserLoadSuccessImpl implements UserLoadSuccess {
  const _$UserLoadSuccessImpl(this.user);

  @override
  final UserModel user;

  @override
  String toString() {
    return 'UserState.userLoaded(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLoadSuccessImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLoadSuccessImplCopyWith<_$UserLoadSuccessImpl> get copyWith =>
      __$$UserLoadSuccessImplCopyWithImpl<_$UserLoadSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<UserModel> users) loadSuccess,
    required TResult Function(UserModel user) userLoaded,
    required TResult Function() operationSuccess,
    required TResult Function(String message) failure,
    required TResult Function() loadInProgress,
  }) {
    return userLoaded(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<UserModel> users)? loadSuccess,
    TResult? Function(UserModel user)? userLoaded,
    TResult? Function()? operationSuccess,
    TResult? Function(String message)? failure,
    TResult? Function()? loadInProgress,
  }) {
    return userLoaded?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<UserModel> users)? loadSuccess,
    TResult Function(UserModel user)? userLoaded,
    TResult Function()? operationSuccess,
    TResult Function(String message)? failure,
    TResult Function()? loadInProgress,
    required TResult orElse(),
  }) {
    if (userLoaded != null) {
      return userLoaded(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserInitial value) initial,
    required TResult Function(UsersLoadSuccess value) loadSuccess,
    required TResult Function(UserLoadSuccess value) userLoaded,
    required TResult Function(UserOperationSuccess value) operationSuccess,
    required TResult Function(UserOperationFailure value) failure,
    required TResult Function(UsersLoadInProgress value) loadInProgress,
  }) {
    return userLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserInitial value)? initial,
    TResult? Function(UsersLoadSuccess value)? loadSuccess,
    TResult? Function(UserLoadSuccess value)? userLoaded,
    TResult? Function(UserOperationSuccess value)? operationSuccess,
    TResult? Function(UserOperationFailure value)? failure,
    TResult? Function(UsersLoadInProgress value)? loadInProgress,
  }) {
    return userLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserInitial value)? initial,
    TResult Function(UsersLoadSuccess value)? loadSuccess,
    TResult Function(UserLoadSuccess value)? userLoaded,
    TResult Function(UserOperationSuccess value)? operationSuccess,
    TResult Function(UserOperationFailure value)? failure,
    TResult Function(UsersLoadInProgress value)? loadInProgress,
    required TResult orElse(),
  }) {
    if (userLoaded != null) {
      return userLoaded(this);
    }
    return orElse();
  }
}

abstract class UserLoadSuccess implements UserState {
  const factory UserLoadSuccess(final UserModel user) = _$UserLoadSuccessImpl;

  UserModel get user;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserLoadSuccessImplCopyWith<_$UserLoadSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserOperationSuccessImplCopyWith<$Res> {
  factory _$$UserOperationSuccessImplCopyWith(_$UserOperationSuccessImpl value,
          $Res Function(_$UserOperationSuccessImpl) then) =
      __$$UserOperationSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserOperationSuccessImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UserOperationSuccessImpl>
    implements _$$UserOperationSuccessImplCopyWith<$Res> {
  __$$UserOperationSuccessImplCopyWithImpl(_$UserOperationSuccessImpl _value,
      $Res Function(_$UserOperationSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UserOperationSuccessImpl implements UserOperationSuccess {
  const _$UserOperationSuccessImpl();

  @override
  String toString() {
    return 'UserState.operationSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserOperationSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<UserModel> users) loadSuccess,
    required TResult Function(UserModel user) userLoaded,
    required TResult Function() operationSuccess,
    required TResult Function(String message) failure,
    required TResult Function() loadInProgress,
  }) {
    return operationSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<UserModel> users)? loadSuccess,
    TResult? Function(UserModel user)? userLoaded,
    TResult? Function()? operationSuccess,
    TResult? Function(String message)? failure,
    TResult? Function()? loadInProgress,
  }) {
    return operationSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<UserModel> users)? loadSuccess,
    TResult Function(UserModel user)? userLoaded,
    TResult Function()? operationSuccess,
    TResult Function(String message)? failure,
    TResult Function()? loadInProgress,
    required TResult orElse(),
  }) {
    if (operationSuccess != null) {
      return operationSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserInitial value) initial,
    required TResult Function(UsersLoadSuccess value) loadSuccess,
    required TResult Function(UserLoadSuccess value) userLoaded,
    required TResult Function(UserOperationSuccess value) operationSuccess,
    required TResult Function(UserOperationFailure value) failure,
    required TResult Function(UsersLoadInProgress value) loadInProgress,
  }) {
    return operationSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserInitial value)? initial,
    TResult? Function(UsersLoadSuccess value)? loadSuccess,
    TResult? Function(UserLoadSuccess value)? userLoaded,
    TResult? Function(UserOperationSuccess value)? operationSuccess,
    TResult? Function(UserOperationFailure value)? failure,
    TResult? Function(UsersLoadInProgress value)? loadInProgress,
  }) {
    return operationSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserInitial value)? initial,
    TResult Function(UsersLoadSuccess value)? loadSuccess,
    TResult Function(UserLoadSuccess value)? userLoaded,
    TResult Function(UserOperationSuccess value)? operationSuccess,
    TResult Function(UserOperationFailure value)? failure,
    TResult Function(UsersLoadInProgress value)? loadInProgress,
    required TResult orElse(),
  }) {
    if (operationSuccess != null) {
      return operationSuccess(this);
    }
    return orElse();
  }
}

abstract class UserOperationSuccess implements UserState {
  const factory UserOperationSuccess() = _$UserOperationSuccessImpl;
}

/// @nodoc
abstract class _$$UserOperationFailureImplCopyWith<$Res> {
  factory _$$UserOperationFailureImplCopyWith(_$UserOperationFailureImpl value,
          $Res Function(_$UserOperationFailureImpl) then) =
      __$$UserOperationFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UserOperationFailureImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UserOperationFailureImpl>
    implements _$$UserOperationFailureImplCopyWith<$Res> {
  __$$UserOperationFailureImplCopyWithImpl(_$UserOperationFailureImpl _value,
      $Res Function(_$UserOperationFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UserOperationFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserOperationFailureImpl implements UserOperationFailure {
  const _$UserOperationFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'UserState.failure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserOperationFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserOperationFailureImplCopyWith<_$UserOperationFailureImpl>
      get copyWith =>
          __$$UserOperationFailureImplCopyWithImpl<_$UserOperationFailureImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<UserModel> users) loadSuccess,
    required TResult Function(UserModel user) userLoaded,
    required TResult Function() operationSuccess,
    required TResult Function(String message) failure,
    required TResult Function() loadInProgress,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<UserModel> users)? loadSuccess,
    TResult? Function(UserModel user)? userLoaded,
    TResult? Function()? operationSuccess,
    TResult? Function(String message)? failure,
    TResult? Function()? loadInProgress,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<UserModel> users)? loadSuccess,
    TResult Function(UserModel user)? userLoaded,
    TResult Function()? operationSuccess,
    TResult Function(String message)? failure,
    TResult Function()? loadInProgress,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserInitial value) initial,
    required TResult Function(UsersLoadSuccess value) loadSuccess,
    required TResult Function(UserLoadSuccess value) userLoaded,
    required TResult Function(UserOperationSuccess value) operationSuccess,
    required TResult Function(UserOperationFailure value) failure,
    required TResult Function(UsersLoadInProgress value) loadInProgress,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserInitial value)? initial,
    TResult? Function(UsersLoadSuccess value)? loadSuccess,
    TResult? Function(UserLoadSuccess value)? userLoaded,
    TResult? Function(UserOperationSuccess value)? operationSuccess,
    TResult? Function(UserOperationFailure value)? failure,
    TResult? Function(UsersLoadInProgress value)? loadInProgress,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserInitial value)? initial,
    TResult Function(UsersLoadSuccess value)? loadSuccess,
    TResult Function(UserLoadSuccess value)? userLoaded,
    TResult Function(UserOperationSuccess value)? operationSuccess,
    TResult Function(UserOperationFailure value)? failure,
    TResult Function(UsersLoadInProgress value)? loadInProgress,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class UserOperationFailure implements UserState {
  const factory UserOperationFailure(final String message) =
      _$UserOperationFailureImpl;

  String get message;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserOperationFailureImplCopyWith<_$UserOperationFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UsersLoadInProgressImplCopyWith<$Res> {
  factory _$$UsersLoadInProgressImplCopyWith(_$UsersLoadInProgressImpl value,
          $Res Function(_$UsersLoadInProgressImpl) then) =
      __$$UsersLoadInProgressImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UsersLoadInProgressImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UsersLoadInProgressImpl>
    implements _$$UsersLoadInProgressImplCopyWith<$Res> {
  __$$UsersLoadInProgressImplCopyWithImpl(_$UsersLoadInProgressImpl _value,
      $Res Function(_$UsersLoadInProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UsersLoadInProgressImpl implements UsersLoadInProgress {
  const _$UsersLoadInProgressImpl();

  @override
  String toString() {
    return 'UserState.loadInProgress()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsersLoadInProgressImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<UserModel> users) loadSuccess,
    required TResult Function(UserModel user) userLoaded,
    required TResult Function() operationSuccess,
    required TResult Function(String message) failure,
    required TResult Function() loadInProgress,
  }) {
    return loadInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<UserModel> users)? loadSuccess,
    TResult? Function(UserModel user)? userLoaded,
    TResult? Function()? operationSuccess,
    TResult? Function(String message)? failure,
    TResult? Function()? loadInProgress,
  }) {
    return loadInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<UserModel> users)? loadSuccess,
    TResult Function(UserModel user)? userLoaded,
    TResult Function()? operationSuccess,
    TResult Function(String message)? failure,
    TResult Function()? loadInProgress,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserInitial value) initial,
    required TResult Function(UsersLoadSuccess value) loadSuccess,
    required TResult Function(UserLoadSuccess value) userLoaded,
    required TResult Function(UserOperationSuccess value) operationSuccess,
    required TResult Function(UserOperationFailure value) failure,
    required TResult Function(UsersLoadInProgress value) loadInProgress,
  }) {
    return loadInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserInitial value)? initial,
    TResult? Function(UsersLoadSuccess value)? loadSuccess,
    TResult? Function(UserLoadSuccess value)? userLoaded,
    TResult? Function(UserOperationSuccess value)? operationSuccess,
    TResult? Function(UserOperationFailure value)? failure,
    TResult? Function(UsersLoadInProgress value)? loadInProgress,
  }) {
    return loadInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserInitial value)? initial,
    TResult Function(UsersLoadSuccess value)? loadSuccess,
    TResult Function(UserLoadSuccess value)? userLoaded,
    TResult Function(UserOperationSuccess value)? operationSuccess,
    TResult Function(UserOperationFailure value)? failure,
    TResult Function(UsersLoadInProgress value)? loadInProgress,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(this);
    }
    return orElse();
  }
}

abstract class UsersLoadInProgress implements UserState {
  const factory UsersLoadInProgress() = _$UsersLoadInProgressImpl;
}
