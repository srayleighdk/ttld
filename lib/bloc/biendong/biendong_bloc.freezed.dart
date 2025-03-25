// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biendong_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BienDongEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userId) fetchList,
    required TResult Function(NhanVien nhanVien) create,
    required TResult Function(NhanVien nhanVien) update,
    required TResult Function(String id) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userId)? fetchList,
    TResult? Function(NhanVien nhanVien)? create,
    TResult? Function(NhanVien nhanVien)? update,
    TResult? Function(String id)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userId)? fetchList,
    TResult Function(NhanVien nhanVien)? create,
    TResult Function(NhanVien nhanVien)? update,
    TResult Function(String id)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchBienDongList value) fetchList,
    required TResult Function(CreateBienDong value) create,
    required TResult Function(UpdateBienDong value) update,
    required TResult Function(DeleteBienDong value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchBienDongList value)? fetchList,
    TResult? Function(CreateBienDong value)? create,
    TResult? Function(UpdateBienDong value)? update,
    TResult? Function(DeleteBienDong value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchBienDongList value)? fetchList,
    TResult Function(CreateBienDong value)? create,
    TResult Function(UpdateBienDong value)? update,
    TResult Function(DeleteBienDong value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BienDongEventCopyWith<$Res> {
  factory $BienDongEventCopyWith(
          BienDongEvent value, $Res Function(BienDongEvent) then) =
      _$BienDongEventCopyWithImpl<$Res, BienDongEvent>;
}

/// @nodoc
class _$BienDongEventCopyWithImpl<$Res, $Val extends BienDongEvent>
    implements $BienDongEventCopyWith<$Res> {
  _$BienDongEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchBienDongListImplCopyWith<$Res> {
  factory _$$FetchBienDongListImplCopyWith(_$FetchBienDongListImpl value,
          $Res Function(_$FetchBienDongListImpl) then) =
      __$$FetchBienDongListImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? userId});
}

/// @nodoc
class __$$FetchBienDongListImplCopyWithImpl<$Res>
    extends _$BienDongEventCopyWithImpl<$Res, _$FetchBienDongListImpl>
    implements _$$FetchBienDongListImplCopyWith<$Res> {
  __$$FetchBienDongListImplCopyWithImpl(_$FetchBienDongListImpl _value,
      $Res Function(_$FetchBienDongListImpl) _then)
      : super(_value, _then);

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
  }) {
    return _then(_$FetchBienDongListImpl(
      freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FetchBienDongListImpl implements FetchBienDongList {
  const _$FetchBienDongListImpl(this.userId);

  @override
  final String? userId;

  @override
  String toString() {
    return 'BienDongEvent.fetchList(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchBienDongListImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchBienDongListImplCopyWith<_$FetchBienDongListImpl> get copyWith =>
      __$$FetchBienDongListImplCopyWithImpl<_$FetchBienDongListImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userId) fetchList,
    required TResult Function(NhanVien nhanVien) create,
    required TResult Function(NhanVien nhanVien) update,
    required TResult Function(String id) delete,
  }) {
    return fetchList(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userId)? fetchList,
    TResult? Function(NhanVien nhanVien)? create,
    TResult? Function(NhanVien nhanVien)? update,
    TResult? Function(String id)? delete,
  }) {
    return fetchList?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userId)? fetchList,
    TResult Function(NhanVien nhanVien)? create,
    TResult Function(NhanVien nhanVien)? update,
    TResult Function(String id)? delete,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchBienDongList value) fetchList,
    required TResult Function(CreateBienDong value) create,
    required TResult Function(UpdateBienDong value) update,
    required TResult Function(DeleteBienDong value) delete,
  }) {
    return fetchList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchBienDongList value)? fetchList,
    TResult? Function(CreateBienDong value)? create,
    TResult? Function(UpdateBienDong value)? update,
    TResult? Function(DeleteBienDong value)? delete,
  }) {
    return fetchList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchBienDongList value)? fetchList,
    TResult Function(CreateBienDong value)? create,
    TResult Function(UpdateBienDong value)? update,
    TResult Function(DeleteBienDong value)? delete,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList(this);
    }
    return orElse();
  }
}

abstract class FetchBienDongList implements BienDongEvent {
  const factory FetchBienDongList(final String? userId) =
      _$FetchBienDongListImpl;

  String? get userId;

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchBienDongListImplCopyWith<_$FetchBienDongListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateBienDongImplCopyWith<$Res> {
  factory _$$CreateBienDongImplCopyWith(_$CreateBienDongImpl value,
          $Res Function(_$CreateBienDongImpl) then) =
      __$$CreateBienDongImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NhanVien nhanVien});

  $NhanVienCopyWith<$Res> get nhanVien;
}

/// @nodoc
class __$$CreateBienDongImplCopyWithImpl<$Res>
    extends _$BienDongEventCopyWithImpl<$Res, _$CreateBienDongImpl>
    implements _$$CreateBienDongImplCopyWith<$Res> {
  __$$CreateBienDongImplCopyWithImpl(
      _$CreateBienDongImpl _value, $Res Function(_$CreateBienDongImpl) _then)
      : super(_value, _then);

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nhanVien = null,
  }) {
    return _then(_$CreateBienDongImpl(
      null == nhanVien
          ? _value.nhanVien
          : nhanVien // ignore: cast_nullable_to_non_nullable
              as NhanVien,
    ));
  }

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NhanVienCopyWith<$Res> get nhanVien {
    return $NhanVienCopyWith<$Res>(_value.nhanVien, (value) {
      return _then(_value.copyWith(nhanVien: value));
    });
  }
}

/// @nodoc

class _$CreateBienDongImpl implements CreateBienDong {
  const _$CreateBienDongImpl(this.nhanVien);

  @override
  final NhanVien nhanVien;

  @override
  String toString() {
    return 'BienDongEvent.create(nhanVien: $nhanVien)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateBienDongImpl &&
            (identical(other.nhanVien, nhanVien) ||
                other.nhanVien == nhanVien));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nhanVien);

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateBienDongImplCopyWith<_$CreateBienDongImpl> get copyWith =>
      __$$CreateBienDongImplCopyWithImpl<_$CreateBienDongImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userId) fetchList,
    required TResult Function(NhanVien nhanVien) create,
    required TResult Function(NhanVien nhanVien) update,
    required TResult Function(String id) delete,
  }) {
    return create(nhanVien);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userId)? fetchList,
    TResult? Function(NhanVien nhanVien)? create,
    TResult? Function(NhanVien nhanVien)? update,
    TResult? Function(String id)? delete,
  }) {
    return create?.call(nhanVien);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userId)? fetchList,
    TResult Function(NhanVien nhanVien)? create,
    TResult Function(NhanVien nhanVien)? update,
    TResult Function(String id)? delete,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(nhanVien);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchBienDongList value) fetchList,
    required TResult Function(CreateBienDong value) create,
    required TResult Function(UpdateBienDong value) update,
    required TResult Function(DeleteBienDong value) delete,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchBienDongList value)? fetchList,
    TResult? Function(CreateBienDong value)? create,
    TResult? Function(UpdateBienDong value)? update,
    TResult? Function(DeleteBienDong value)? delete,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchBienDongList value)? fetchList,
    TResult Function(CreateBienDong value)? create,
    TResult Function(UpdateBienDong value)? update,
    TResult Function(DeleteBienDong value)? delete,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }
}

abstract class CreateBienDong implements BienDongEvent {
  const factory CreateBienDong(final NhanVien nhanVien) = _$CreateBienDongImpl;

  NhanVien get nhanVien;

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateBienDongImplCopyWith<_$CreateBienDongImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateBienDongImplCopyWith<$Res> {
  factory _$$UpdateBienDongImplCopyWith(_$UpdateBienDongImpl value,
          $Res Function(_$UpdateBienDongImpl) then) =
      __$$UpdateBienDongImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NhanVien nhanVien});

  $NhanVienCopyWith<$Res> get nhanVien;
}

/// @nodoc
class __$$UpdateBienDongImplCopyWithImpl<$Res>
    extends _$BienDongEventCopyWithImpl<$Res, _$UpdateBienDongImpl>
    implements _$$UpdateBienDongImplCopyWith<$Res> {
  __$$UpdateBienDongImplCopyWithImpl(
      _$UpdateBienDongImpl _value, $Res Function(_$UpdateBienDongImpl) _then)
      : super(_value, _then);

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nhanVien = null,
  }) {
    return _then(_$UpdateBienDongImpl(
      null == nhanVien
          ? _value.nhanVien
          : nhanVien // ignore: cast_nullable_to_non_nullable
              as NhanVien,
    ));
  }

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NhanVienCopyWith<$Res> get nhanVien {
    return $NhanVienCopyWith<$Res>(_value.nhanVien, (value) {
      return _then(_value.copyWith(nhanVien: value));
    });
  }
}

/// @nodoc

class _$UpdateBienDongImpl implements UpdateBienDong {
  const _$UpdateBienDongImpl(this.nhanVien);

  @override
  final NhanVien nhanVien;

  @override
  String toString() {
    return 'BienDongEvent.update(nhanVien: $nhanVien)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBienDongImpl &&
            (identical(other.nhanVien, nhanVien) ||
                other.nhanVien == nhanVien));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nhanVien);

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBienDongImplCopyWith<_$UpdateBienDongImpl> get copyWith =>
      __$$UpdateBienDongImplCopyWithImpl<_$UpdateBienDongImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userId) fetchList,
    required TResult Function(NhanVien nhanVien) create,
    required TResult Function(NhanVien nhanVien) update,
    required TResult Function(String id) delete,
  }) {
    return update(nhanVien);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userId)? fetchList,
    TResult? Function(NhanVien nhanVien)? create,
    TResult? Function(NhanVien nhanVien)? update,
    TResult? Function(String id)? delete,
  }) {
    return update?.call(nhanVien);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userId)? fetchList,
    TResult Function(NhanVien nhanVien)? create,
    TResult Function(NhanVien nhanVien)? update,
    TResult Function(String id)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(nhanVien);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchBienDongList value) fetchList,
    required TResult Function(CreateBienDong value) create,
    required TResult Function(UpdateBienDong value) update,
    required TResult Function(DeleteBienDong value) delete,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchBienDongList value)? fetchList,
    TResult? Function(CreateBienDong value)? create,
    TResult? Function(UpdateBienDong value)? update,
    TResult? Function(DeleteBienDong value)? delete,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchBienDongList value)? fetchList,
    TResult Function(CreateBienDong value)? create,
    TResult Function(UpdateBienDong value)? update,
    TResult Function(DeleteBienDong value)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class UpdateBienDong implements BienDongEvent {
  const factory UpdateBienDong(final NhanVien nhanVien) = _$UpdateBienDongImpl;

  NhanVien get nhanVien;

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBienDongImplCopyWith<_$UpdateBienDongImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteBienDongImplCopyWith<$Res> {
  factory _$$DeleteBienDongImplCopyWith(_$DeleteBienDongImpl value,
          $Res Function(_$DeleteBienDongImpl) then) =
      __$$DeleteBienDongImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteBienDongImplCopyWithImpl<$Res>
    extends _$BienDongEventCopyWithImpl<$Res, _$DeleteBienDongImpl>
    implements _$$DeleteBienDongImplCopyWith<$Res> {
  __$$DeleteBienDongImplCopyWithImpl(
      _$DeleteBienDongImpl _value, $Res Function(_$DeleteBienDongImpl) _then)
      : super(_value, _then);

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$DeleteBienDongImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteBienDongImpl implements DeleteBienDong {
  const _$DeleteBienDongImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'BienDongEvent.delete(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteBienDongImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteBienDongImplCopyWith<_$DeleteBienDongImpl> get copyWith =>
      __$$DeleteBienDongImplCopyWithImpl<_$DeleteBienDongImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userId) fetchList,
    required TResult Function(NhanVien nhanVien) create,
    required TResult Function(NhanVien nhanVien) update,
    required TResult Function(String id) delete,
  }) {
    return delete(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userId)? fetchList,
    TResult? Function(NhanVien nhanVien)? create,
    TResult? Function(NhanVien nhanVien)? update,
    TResult? Function(String id)? delete,
  }) {
    return delete?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userId)? fetchList,
    TResult Function(NhanVien nhanVien)? create,
    TResult Function(NhanVien nhanVien)? update,
    TResult Function(String id)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchBienDongList value) fetchList,
    required TResult Function(CreateBienDong value) create,
    required TResult Function(UpdateBienDong value) update,
    required TResult Function(DeleteBienDong value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchBienDongList value)? fetchList,
    TResult? Function(CreateBienDong value)? create,
    TResult? Function(UpdateBienDong value)? update,
    TResult? Function(DeleteBienDong value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchBienDongList value)? fetchList,
    TResult Function(CreateBienDong value)? create,
    TResult Function(UpdateBienDong value)? update,
    TResult Function(DeleteBienDong value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class DeleteBienDong implements BienDongEvent {
  const factory DeleteBienDong(final String id) = _$DeleteBienDongImpl;

  String get id;

  /// Create a copy of BienDongEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteBienDongImplCopyWith<_$DeleteBienDongImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BienDongState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NhanVien> nhanVienList) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NhanVien> nhanVienList)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NhanVien> nhanVienList)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BienDongInitial value) initial,
    required TResult Function(BienDongLoading value) loading,
    required TResult Function(BienDongLoaded value) loaded,
    required TResult Function(BienDongError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BienDongInitial value)? initial,
    TResult? Function(BienDongLoading value)? loading,
    TResult? Function(BienDongLoaded value)? loaded,
    TResult? Function(BienDongError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BienDongInitial value)? initial,
    TResult Function(BienDongLoading value)? loading,
    TResult Function(BienDongLoaded value)? loaded,
    TResult Function(BienDongError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BienDongStateCopyWith<$Res> {
  factory $BienDongStateCopyWith(
          BienDongState value, $Res Function(BienDongState) then) =
      _$BienDongStateCopyWithImpl<$Res, BienDongState>;
}

/// @nodoc
class _$BienDongStateCopyWithImpl<$Res, $Val extends BienDongState>
    implements $BienDongStateCopyWith<$Res> {
  _$BienDongStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BienDongState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BienDongInitialImplCopyWith<$Res> {
  factory _$$BienDongInitialImplCopyWith(_$BienDongInitialImpl value,
          $Res Function(_$BienDongInitialImpl) then) =
      __$$BienDongInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BienDongInitialImplCopyWithImpl<$Res>
    extends _$BienDongStateCopyWithImpl<$Res, _$BienDongInitialImpl>
    implements _$$BienDongInitialImplCopyWith<$Res> {
  __$$BienDongInitialImplCopyWithImpl(
      _$BienDongInitialImpl _value, $Res Function(_$BienDongInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of BienDongState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BienDongInitialImpl implements BienDongInitial {
  const _$BienDongInitialImpl();

  @override
  String toString() {
    return 'BienDongState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BienDongInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NhanVien> nhanVienList) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NhanVien> nhanVienList)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NhanVien> nhanVienList)? loaded,
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
    required TResult Function(BienDongInitial value) initial,
    required TResult Function(BienDongLoading value) loading,
    required TResult Function(BienDongLoaded value) loaded,
    required TResult Function(BienDongError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BienDongInitial value)? initial,
    TResult? Function(BienDongLoading value)? loading,
    TResult? Function(BienDongLoaded value)? loaded,
    TResult? Function(BienDongError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BienDongInitial value)? initial,
    TResult Function(BienDongLoading value)? loading,
    TResult Function(BienDongLoaded value)? loaded,
    TResult Function(BienDongError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BienDongInitial implements BienDongState {
  const factory BienDongInitial() = _$BienDongInitialImpl;
}

/// @nodoc
abstract class _$$BienDongLoadingImplCopyWith<$Res> {
  factory _$$BienDongLoadingImplCopyWith(_$BienDongLoadingImpl value,
          $Res Function(_$BienDongLoadingImpl) then) =
      __$$BienDongLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BienDongLoadingImplCopyWithImpl<$Res>
    extends _$BienDongStateCopyWithImpl<$Res, _$BienDongLoadingImpl>
    implements _$$BienDongLoadingImplCopyWith<$Res> {
  __$$BienDongLoadingImplCopyWithImpl(
      _$BienDongLoadingImpl _value, $Res Function(_$BienDongLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of BienDongState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BienDongLoadingImpl implements BienDongLoading {
  const _$BienDongLoadingImpl();

  @override
  String toString() {
    return 'BienDongState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BienDongLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NhanVien> nhanVienList) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NhanVien> nhanVienList)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NhanVien> nhanVienList)? loaded,
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
    required TResult Function(BienDongInitial value) initial,
    required TResult Function(BienDongLoading value) loading,
    required TResult Function(BienDongLoaded value) loaded,
    required TResult Function(BienDongError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BienDongInitial value)? initial,
    TResult? Function(BienDongLoading value)? loading,
    TResult? Function(BienDongLoaded value)? loaded,
    TResult? Function(BienDongError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BienDongInitial value)? initial,
    TResult Function(BienDongLoading value)? loading,
    TResult Function(BienDongLoaded value)? loaded,
    TResult Function(BienDongError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BienDongLoading implements BienDongState {
  const factory BienDongLoading() = _$BienDongLoadingImpl;
}

/// @nodoc
abstract class _$$BienDongLoadedImplCopyWith<$Res> {
  factory _$$BienDongLoadedImplCopyWith(_$BienDongLoadedImpl value,
          $Res Function(_$BienDongLoadedImpl) then) =
      __$$BienDongLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<NhanVien> nhanVienList});
}

/// @nodoc
class __$$BienDongLoadedImplCopyWithImpl<$Res>
    extends _$BienDongStateCopyWithImpl<$Res, _$BienDongLoadedImpl>
    implements _$$BienDongLoadedImplCopyWith<$Res> {
  __$$BienDongLoadedImplCopyWithImpl(
      _$BienDongLoadedImpl _value, $Res Function(_$BienDongLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of BienDongState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nhanVienList = null,
  }) {
    return _then(_$BienDongLoadedImpl(
      null == nhanVienList
          ? _value._nhanVienList
          : nhanVienList // ignore: cast_nullable_to_non_nullable
              as List<NhanVien>,
    ));
  }
}

/// @nodoc

class _$BienDongLoadedImpl implements BienDongLoaded {
  const _$BienDongLoadedImpl(final List<NhanVien> nhanVienList)
      : _nhanVienList = nhanVienList;

  final List<NhanVien> _nhanVienList;
  @override
  List<NhanVien> get nhanVienList {
    if (_nhanVienList is EqualUnmodifiableListView) return _nhanVienList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nhanVienList);
  }

  @override
  String toString() {
    return 'BienDongState.loaded(nhanVienList: $nhanVienList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BienDongLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._nhanVienList, _nhanVienList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_nhanVienList));

  /// Create a copy of BienDongState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BienDongLoadedImplCopyWith<_$BienDongLoadedImpl> get copyWith =>
      __$$BienDongLoadedImplCopyWithImpl<_$BienDongLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NhanVien> nhanVienList) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(nhanVienList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NhanVien> nhanVienList)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(nhanVienList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NhanVien> nhanVienList)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(nhanVienList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BienDongInitial value) initial,
    required TResult Function(BienDongLoading value) loading,
    required TResult Function(BienDongLoaded value) loaded,
    required TResult Function(BienDongError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BienDongInitial value)? initial,
    TResult? Function(BienDongLoading value)? loading,
    TResult? Function(BienDongLoaded value)? loaded,
    TResult? Function(BienDongError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BienDongInitial value)? initial,
    TResult Function(BienDongLoading value)? loading,
    TResult Function(BienDongLoaded value)? loaded,
    TResult Function(BienDongError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BienDongLoaded implements BienDongState {
  const factory BienDongLoaded(final List<NhanVien> nhanVienList) =
      _$BienDongLoadedImpl;

  List<NhanVien> get nhanVienList;

  /// Create a copy of BienDongState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BienDongLoadedImplCopyWith<_$BienDongLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BienDongErrorImplCopyWith<$Res> {
  factory _$$BienDongErrorImplCopyWith(
          _$BienDongErrorImpl value, $Res Function(_$BienDongErrorImpl) then) =
      __$$BienDongErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BienDongErrorImplCopyWithImpl<$Res>
    extends _$BienDongStateCopyWithImpl<$Res, _$BienDongErrorImpl>
    implements _$$BienDongErrorImplCopyWith<$Res> {
  __$$BienDongErrorImplCopyWithImpl(
      _$BienDongErrorImpl _value, $Res Function(_$BienDongErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of BienDongState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$BienDongErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BienDongErrorImpl implements BienDongError {
  const _$BienDongErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BienDongState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BienDongErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BienDongState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BienDongErrorImplCopyWith<_$BienDongErrorImpl> get copyWith =>
      __$$BienDongErrorImplCopyWithImpl<_$BienDongErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NhanVien> nhanVienList) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NhanVien> nhanVienList)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NhanVien> nhanVienList)? loaded,
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
    required TResult Function(BienDongInitial value) initial,
    required TResult Function(BienDongLoading value) loading,
    required TResult Function(BienDongLoaded value) loaded,
    required TResult Function(BienDongError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BienDongInitial value)? initial,
    TResult? Function(BienDongLoading value)? loading,
    TResult? Function(BienDongLoaded value)? loaded,
    TResult? Function(BienDongError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BienDongInitial value)? initial,
    TResult Function(BienDongLoading value)? loading,
    TResult Function(BienDongLoaded value)? loaded,
    TResult Function(BienDongError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BienDongError implements BienDongState {
  const factory BienDongError(final String message) = _$BienDongErrorImpl;

  String get message;

  /// Create a copy of BienDongState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BienDongErrorImplCopyWith<_$BienDongErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
