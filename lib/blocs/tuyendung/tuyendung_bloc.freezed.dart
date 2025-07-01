// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tuyendung_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TuyenDungEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? ntdId,
            String? idUv,
            int? limit,
            int? page,
            String? search,
            String? status,
            String? duyet,
            String? id)
        fetchList,
    required TResult Function(NTDTuyenDung tuyenDung) create,
    required TResult Function(NTDTuyenDung tuyenDung) update,
    required TResult Function(NTDTuyenDung tuyenDung) updateForm,
    required TResult Function(String idTuyenDung, String? userId) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult? Function(NTDTuyenDung tuyenDung)? create,
    TResult? Function(NTDTuyenDung tuyenDung)? update,
    TResult? Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult? Function(String idTuyenDung, String? userId)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult Function(NTDTuyenDung tuyenDung)? create,
    TResult Function(NTDTuyenDung tuyenDung)? update,
    TResult Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult Function(String idTuyenDung, String? userId)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchTuyenDungList value) fetchList,
    required TResult Function(CreateTuyenDung value) create,
    required TResult Function(UpdateTuyenDung value) update,
    required TResult Function(UpdateTuyenDungForm value) updateForm,
    required TResult Function(DeleteTuyenDung value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchTuyenDungList value)? fetchList,
    TResult? Function(CreateTuyenDung value)? create,
    TResult? Function(UpdateTuyenDung value)? update,
    TResult? Function(UpdateTuyenDungForm value)? updateForm,
    TResult? Function(DeleteTuyenDung value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchTuyenDungList value)? fetchList,
    TResult Function(CreateTuyenDung value)? create,
    TResult Function(UpdateTuyenDung value)? update,
    TResult Function(UpdateTuyenDungForm value)? updateForm,
    TResult Function(DeleteTuyenDung value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TuyenDungEventCopyWith<$Res> {
  factory $TuyenDungEventCopyWith(
          TuyenDungEvent value, $Res Function(TuyenDungEvent) then) =
      _$TuyenDungEventCopyWithImpl<$Res, TuyenDungEvent>;
}

/// @nodoc
class _$TuyenDungEventCopyWithImpl<$Res, $Val extends TuyenDungEvent>
    implements $TuyenDungEventCopyWith<$Res> {
  _$TuyenDungEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchTuyenDungListImplCopyWith<$Res> {
  factory _$$FetchTuyenDungListImplCopyWith(_$FetchTuyenDungListImpl value,
          $Res Function(_$FetchTuyenDungListImpl) then) =
      __$$FetchTuyenDungListImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? ntdId,
      String? idUv,
      int? limit,
      int? page,
      String? search,
      String? status,
      String? duyet,
      String? id});
}

/// @nodoc
class __$$FetchTuyenDungListImplCopyWithImpl<$Res>
    extends _$TuyenDungEventCopyWithImpl<$Res, _$FetchTuyenDungListImpl>
    implements _$$FetchTuyenDungListImplCopyWith<$Res> {
  __$$FetchTuyenDungListImplCopyWithImpl(_$FetchTuyenDungListImpl _value,
      $Res Function(_$FetchTuyenDungListImpl) _then)
      : super(_value, _then);

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ntdId = freezed,
    Object? idUv = freezed,
    Object? limit = freezed,
    Object? page = freezed,
    Object? search = freezed,
    Object? status = freezed,
    Object? duyet = freezed,
    Object? id = freezed,
  }) {
    return _then(_$FetchTuyenDungListImpl(
      freezed == ntdId
          ? _value.ntdId
          : ntdId // ignore: cast_nullable_to_non_nullable
              as String?,
      idUv: freezed == idUv
          ? _value.idUv
          : idUv // ignore: cast_nullable_to_non_nullable
              as String?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      duyet: freezed == duyet
          ? _value.duyet
          : duyet // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FetchTuyenDungListImpl implements FetchTuyenDungList {
  const _$FetchTuyenDungListImpl(this.ntdId,
      {this.idUv,
      this.limit,
      this.page,
      this.search,
      this.status,
      this.duyet,
      this.id});

  @override
  final String? ntdId;
  @override
  final String? idUv;
  @override
  final int? limit;
  @override
  final int? page;
  @override
  final String? search;
  @override
  final String? status;
  @override
  final String? duyet;
  @override
  final String? id;

  @override
  String toString() {
    return 'TuyenDungEvent.fetchList(ntdId: $ntdId, idUv: $idUv, limit: $limit, page: $page, search: $search, status: $status, duyet: $duyet, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchTuyenDungListImpl &&
            (identical(other.ntdId, ntdId) || other.ntdId == ntdId) &&
            (identical(other.idUv, idUv) || other.idUv == idUv) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.duyet, duyet) || other.duyet == duyet) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, ntdId, idUv, limit, page, search, status, duyet, id);

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchTuyenDungListImplCopyWith<_$FetchTuyenDungListImpl> get copyWith =>
      __$$FetchTuyenDungListImplCopyWithImpl<_$FetchTuyenDungListImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? ntdId,
            String? idUv,
            int? limit,
            int? page,
            String? search,
            String? status,
            String? duyet,
            String? id)
        fetchList,
    required TResult Function(NTDTuyenDung tuyenDung) create,
    required TResult Function(NTDTuyenDung tuyenDung) update,
    required TResult Function(NTDTuyenDung tuyenDung) updateForm,
    required TResult Function(String idTuyenDung, String? userId) delete,
  }) {
    return fetchList(ntdId, idUv, limit, page, search, status, duyet, id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult? Function(NTDTuyenDung tuyenDung)? create,
    TResult? Function(NTDTuyenDung tuyenDung)? update,
    TResult? Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult? Function(String idTuyenDung, String? userId)? delete,
  }) {
    return fetchList?.call(ntdId, idUv, limit, page, search, status, duyet, id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult Function(NTDTuyenDung tuyenDung)? create,
    TResult Function(NTDTuyenDung tuyenDung)? update,
    TResult Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult Function(String idTuyenDung, String? userId)? delete,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList(ntdId, idUv, limit, page, search, status, duyet, id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchTuyenDungList value) fetchList,
    required TResult Function(CreateTuyenDung value) create,
    required TResult Function(UpdateTuyenDung value) update,
    required TResult Function(UpdateTuyenDungForm value) updateForm,
    required TResult Function(DeleteTuyenDung value) delete,
  }) {
    return fetchList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchTuyenDungList value)? fetchList,
    TResult? Function(CreateTuyenDung value)? create,
    TResult? Function(UpdateTuyenDung value)? update,
    TResult? Function(UpdateTuyenDungForm value)? updateForm,
    TResult? Function(DeleteTuyenDung value)? delete,
  }) {
    return fetchList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchTuyenDungList value)? fetchList,
    TResult Function(CreateTuyenDung value)? create,
    TResult Function(UpdateTuyenDung value)? update,
    TResult Function(UpdateTuyenDungForm value)? updateForm,
    TResult Function(DeleteTuyenDung value)? delete,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList(this);
    }
    return orElse();
  }
}

abstract class FetchTuyenDungList implements TuyenDungEvent {
  const factory FetchTuyenDungList(final String? ntdId,
      {final String? idUv,
      final int? limit,
      final int? page,
      final String? search,
      final String? status,
      final String? duyet,
      final String? id}) = _$FetchTuyenDungListImpl;

  String? get ntdId;
  String? get idUv;
  int? get limit;
  int? get page;
  String? get search;
  String? get status;
  String? get duyet;
  String? get id;

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchTuyenDungListImplCopyWith<_$FetchTuyenDungListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateTuyenDungImplCopyWith<$Res> {
  factory _$$CreateTuyenDungImplCopyWith(_$CreateTuyenDungImpl value,
          $Res Function(_$CreateTuyenDungImpl) then) =
      __$$CreateTuyenDungImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NTDTuyenDung tuyenDung});

  $NTDTuyenDungCopyWith<$Res> get tuyenDung;
}

/// @nodoc
class __$$CreateTuyenDungImplCopyWithImpl<$Res>
    extends _$TuyenDungEventCopyWithImpl<$Res, _$CreateTuyenDungImpl>
    implements _$$CreateTuyenDungImplCopyWith<$Res> {
  __$$CreateTuyenDungImplCopyWithImpl(
      _$CreateTuyenDungImpl _value, $Res Function(_$CreateTuyenDungImpl) _then)
      : super(_value, _then);

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tuyenDung = null,
  }) {
    return _then(_$CreateTuyenDungImpl(
      null == tuyenDung
          ? _value.tuyenDung
          : tuyenDung // ignore: cast_nullable_to_non_nullable
              as NTDTuyenDung,
    ));
  }

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NTDTuyenDungCopyWith<$Res> get tuyenDung {
    return $NTDTuyenDungCopyWith<$Res>(_value.tuyenDung, (value) {
      return _then(_value.copyWith(tuyenDung: value));
    });
  }
}

/// @nodoc

class _$CreateTuyenDungImpl implements CreateTuyenDung {
  const _$CreateTuyenDungImpl(this.tuyenDung);

  @override
  final NTDTuyenDung tuyenDung;

  @override
  String toString() {
    return 'TuyenDungEvent.create(tuyenDung: $tuyenDung)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTuyenDungImpl &&
            (identical(other.tuyenDung, tuyenDung) ||
                other.tuyenDung == tuyenDung));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tuyenDung);

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTuyenDungImplCopyWith<_$CreateTuyenDungImpl> get copyWith =>
      __$$CreateTuyenDungImplCopyWithImpl<_$CreateTuyenDungImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? ntdId,
            String? idUv,
            int? limit,
            int? page,
            String? search,
            String? status,
            String? duyet,
            String? id)
        fetchList,
    required TResult Function(NTDTuyenDung tuyenDung) create,
    required TResult Function(NTDTuyenDung tuyenDung) update,
    required TResult Function(NTDTuyenDung tuyenDung) updateForm,
    required TResult Function(String idTuyenDung, String? userId) delete,
  }) {
    return create(tuyenDung);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult? Function(NTDTuyenDung tuyenDung)? create,
    TResult? Function(NTDTuyenDung tuyenDung)? update,
    TResult? Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult? Function(String idTuyenDung, String? userId)? delete,
  }) {
    return create?.call(tuyenDung);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult Function(NTDTuyenDung tuyenDung)? create,
    TResult Function(NTDTuyenDung tuyenDung)? update,
    TResult Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult Function(String idTuyenDung, String? userId)? delete,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(tuyenDung);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchTuyenDungList value) fetchList,
    required TResult Function(CreateTuyenDung value) create,
    required TResult Function(UpdateTuyenDung value) update,
    required TResult Function(UpdateTuyenDungForm value) updateForm,
    required TResult Function(DeleteTuyenDung value) delete,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchTuyenDungList value)? fetchList,
    TResult? Function(CreateTuyenDung value)? create,
    TResult? Function(UpdateTuyenDung value)? update,
    TResult? Function(UpdateTuyenDungForm value)? updateForm,
    TResult? Function(DeleteTuyenDung value)? delete,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchTuyenDungList value)? fetchList,
    TResult Function(CreateTuyenDung value)? create,
    TResult Function(UpdateTuyenDung value)? update,
    TResult Function(UpdateTuyenDungForm value)? updateForm,
    TResult Function(DeleteTuyenDung value)? delete,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }
}

abstract class CreateTuyenDung implements TuyenDungEvent {
  const factory CreateTuyenDung(final NTDTuyenDung tuyenDung) =
      _$CreateTuyenDungImpl;

  NTDTuyenDung get tuyenDung;

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateTuyenDungImplCopyWith<_$CreateTuyenDungImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTuyenDungImplCopyWith<$Res> {
  factory _$$UpdateTuyenDungImplCopyWith(_$UpdateTuyenDungImpl value,
          $Res Function(_$UpdateTuyenDungImpl) then) =
      __$$UpdateTuyenDungImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NTDTuyenDung tuyenDung});

  $NTDTuyenDungCopyWith<$Res> get tuyenDung;
}

/// @nodoc
class __$$UpdateTuyenDungImplCopyWithImpl<$Res>
    extends _$TuyenDungEventCopyWithImpl<$Res, _$UpdateTuyenDungImpl>
    implements _$$UpdateTuyenDungImplCopyWith<$Res> {
  __$$UpdateTuyenDungImplCopyWithImpl(
      _$UpdateTuyenDungImpl _value, $Res Function(_$UpdateTuyenDungImpl) _then)
      : super(_value, _then);

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tuyenDung = null,
  }) {
    return _then(_$UpdateTuyenDungImpl(
      null == tuyenDung
          ? _value.tuyenDung
          : tuyenDung // ignore: cast_nullable_to_non_nullable
              as NTDTuyenDung,
    ));
  }

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NTDTuyenDungCopyWith<$Res> get tuyenDung {
    return $NTDTuyenDungCopyWith<$Res>(_value.tuyenDung, (value) {
      return _then(_value.copyWith(tuyenDung: value));
    });
  }
}

/// @nodoc

class _$UpdateTuyenDungImpl implements UpdateTuyenDung {
  const _$UpdateTuyenDungImpl(this.tuyenDung);

  @override
  final NTDTuyenDung tuyenDung;

  @override
  String toString() {
    return 'TuyenDungEvent.update(tuyenDung: $tuyenDung)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTuyenDungImpl &&
            (identical(other.tuyenDung, tuyenDung) ||
                other.tuyenDung == tuyenDung));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tuyenDung);

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTuyenDungImplCopyWith<_$UpdateTuyenDungImpl> get copyWith =>
      __$$UpdateTuyenDungImplCopyWithImpl<_$UpdateTuyenDungImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? ntdId,
            String? idUv,
            int? limit,
            int? page,
            String? search,
            String? status,
            String? duyet,
            String? id)
        fetchList,
    required TResult Function(NTDTuyenDung tuyenDung) create,
    required TResult Function(NTDTuyenDung tuyenDung) update,
    required TResult Function(NTDTuyenDung tuyenDung) updateForm,
    required TResult Function(String idTuyenDung, String? userId) delete,
  }) {
    return update(tuyenDung);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult? Function(NTDTuyenDung tuyenDung)? create,
    TResult? Function(NTDTuyenDung tuyenDung)? update,
    TResult? Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult? Function(String idTuyenDung, String? userId)? delete,
  }) {
    return update?.call(tuyenDung);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult Function(NTDTuyenDung tuyenDung)? create,
    TResult Function(NTDTuyenDung tuyenDung)? update,
    TResult Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult Function(String idTuyenDung, String? userId)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(tuyenDung);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchTuyenDungList value) fetchList,
    required TResult Function(CreateTuyenDung value) create,
    required TResult Function(UpdateTuyenDung value) update,
    required TResult Function(UpdateTuyenDungForm value) updateForm,
    required TResult Function(DeleteTuyenDung value) delete,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchTuyenDungList value)? fetchList,
    TResult? Function(CreateTuyenDung value)? create,
    TResult? Function(UpdateTuyenDung value)? update,
    TResult? Function(UpdateTuyenDungForm value)? updateForm,
    TResult? Function(DeleteTuyenDung value)? delete,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchTuyenDungList value)? fetchList,
    TResult Function(CreateTuyenDung value)? create,
    TResult Function(UpdateTuyenDung value)? update,
    TResult Function(UpdateTuyenDungForm value)? updateForm,
    TResult Function(DeleteTuyenDung value)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class UpdateTuyenDung implements TuyenDungEvent {
  const factory UpdateTuyenDung(final NTDTuyenDung tuyenDung) =
      _$UpdateTuyenDungImpl;

  NTDTuyenDung get tuyenDung;

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTuyenDungImplCopyWith<_$UpdateTuyenDungImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTuyenDungFormImplCopyWith<$Res> {
  factory _$$UpdateTuyenDungFormImplCopyWith(_$UpdateTuyenDungFormImpl value,
          $Res Function(_$UpdateTuyenDungFormImpl) then) =
      __$$UpdateTuyenDungFormImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NTDTuyenDung tuyenDung});

  $NTDTuyenDungCopyWith<$Res> get tuyenDung;
}

/// @nodoc
class __$$UpdateTuyenDungFormImplCopyWithImpl<$Res>
    extends _$TuyenDungEventCopyWithImpl<$Res, _$UpdateTuyenDungFormImpl>
    implements _$$UpdateTuyenDungFormImplCopyWith<$Res> {
  __$$UpdateTuyenDungFormImplCopyWithImpl(_$UpdateTuyenDungFormImpl _value,
      $Res Function(_$UpdateTuyenDungFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tuyenDung = null,
  }) {
    return _then(_$UpdateTuyenDungFormImpl(
      null == tuyenDung
          ? _value.tuyenDung
          : tuyenDung // ignore: cast_nullable_to_non_nullable
              as NTDTuyenDung,
    ));
  }

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NTDTuyenDungCopyWith<$Res> get tuyenDung {
    return $NTDTuyenDungCopyWith<$Res>(_value.tuyenDung, (value) {
      return _then(_value.copyWith(tuyenDung: value));
    });
  }
}

/// @nodoc

class _$UpdateTuyenDungFormImpl implements UpdateTuyenDungForm {
  const _$UpdateTuyenDungFormImpl(this.tuyenDung);

  @override
  final NTDTuyenDung tuyenDung;

  @override
  String toString() {
    return 'TuyenDungEvent.updateForm(tuyenDung: $tuyenDung)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTuyenDungFormImpl &&
            (identical(other.tuyenDung, tuyenDung) ||
                other.tuyenDung == tuyenDung));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tuyenDung);

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTuyenDungFormImplCopyWith<_$UpdateTuyenDungFormImpl> get copyWith =>
      __$$UpdateTuyenDungFormImplCopyWithImpl<_$UpdateTuyenDungFormImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? ntdId,
            String? idUv,
            int? limit,
            int? page,
            String? search,
            String? status,
            String? duyet,
            String? id)
        fetchList,
    required TResult Function(NTDTuyenDung tuyenDung) create,
    required TResult Function(NTDTuyenDung tuyenDung) update,
    required TResult Function(NTDTuyenDung tuyenDung) updateForm,
    required TResult Function(String idTuyenDung, String? userId) delete,
  }) {
    return updateForm(tuyenDung);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult? Function(NTDTuyenDung tuyenDung)? create,
    TResult? Function(NTDTuyenDung tuyenDung)? update,
    TResult? Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult? Function(String idTuyenDung, String? userId)? delete,
  }) {
    return updateForm?.call(tuyenDung);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult Function(NTDTuyenDung tuyenDung)? create,
    TResult Function(NTDTuyenDung tuyenDung)? update,
    TResult Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult Function(String idTuyenDung, String? userId)? delete,
    required TResult orElse(),
  }) {
    if (updateForm != null) {
      return updateForm(tuyenDung);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchTuyenDungList value) fetchList,
    required TResult Function(CreateTuyenDung value) create,
    required TResult Function(UpdateTuyenDung value) update,
    required TResult Function(UpdateTuyenDungForm value) updateForm,
    required TResult Function(DeleteTuyenDung value) delete,
  }) {
    return updateForm(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchTuyenDungList value)? fetchList,
    TResult? Function(CreateTuyenDung value)? create,
    TResult? Function(UpdateTuyenDung value)? update,
    TResult? Function(UpdateTuyenDungForm value)? updateForm,
    TResult? Function(DeleteTuyenDung value)? delete,
  }) {
    return updateForm?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchTuyenDungList value)? fetchList,
    TResult Function(CreateTuyenDung value)? create,
    TResult Function(UpdateTuyenDung value)? update,
    TResult Function(UpdateTuyenDungForm value)? updateForm,
    TResult Function(DeleteTuyenDung value)? delete,
    required TResult orElse(),
  }) {
    if (updateForm != null) {
      return updateForm(this);
    }
    return orElse();
  }
}

abstract class UpdateTuyenDungForm implements TuyenDungEvent {
  const factory UpdateTuyenDungForm(final NTDTuyenDung tuyenDung) =
      _$UpdateTuyenDungFormImpl;

  NTDTuyenDung get tuyenDung;

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTuyenDungFormImplCopyWith<_$UpdateTuyenDungFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTuyenDungImplCopyWith<$Res> {
  factory _$$DeleteTuyenDungImplCopyWith(_$DeleteTuyenDungImpl value,
          $Res Function(_$DeleteTuyenDungImpl) then) =
      __$$DeleteTuyenDungImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String idTuyenDung, String? userId});
}

/// @nodoc
class __$$DeleteTuyenDungImplCopyWithImpl<$Res>
    extends _$TuyenDungEventCopyWithImpl<$Res, _$DeleteTuyenDungImpl>
    implements _$$DeleteTuyenDungImplCopyWith<$Res> {
  __$$DeleteTuyenDungImplCopyWithImpl(
      _$DeleteTuyenDungImpl _value, $Res Function(_$DeleteTuyenDungImpl) _then)
      : super(_value, _then);

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idTuyenDung = null,
    Object? userId = freezed,
  }) {
    return _then(_$DeleteTuyenDungImpl(
      null == idTuyenDung
          ? _value.idTuyenDung
          : idTuyenDung // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DeleteTuyenDungImpl implements DeleteTuyenDung {
  const _$DeleteTuyenDungImpl(this.idTuyenDung, this.userId);

  @override
  final String idTuyenDung;
  @override
  final String? userId;

  @override
  String toString() {
    return 'TuyenDungEvent.delete(idTuyenDung: $idTuyenDung, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTuyenDungImpl &&
            (identical(other.idTuyenDung, idTuyenDung) ||
                other.idTuyenDung == idTuyenDung) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idTuyenDung, userId);

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTuyenDungImplCopyWith<_$DeleteTuyenDungImpl> get copyWith =>
      __$$DeleteTuyenDungImplCopyWithImpl<_$DeleteTuyenDungImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? ntdId,
            String? idUv,
            int? limit,
            int? page,
            String? search,
            String? status,
            String? duyet,
            String? id)
        fetchList,
    required TResult Function(NTDTuyenDung tuyenDung) create,
    required TResult Function(NTDTuyenDung tuyenDung) update,
    required TResult Function(NTDTuyenDung tuyenDung) updateForm,
    required TResult Function(String idTuyenDung, String? userId) delete,
  }) {
    return delete(idTuyenDung, userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult? Function(NTDTuyenDung tuyenDung)? create,
    TResult? Function(NTDTuyenDung tuyenDung)? update,
    TResult? Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult? Function(String idTuyenDung, String? userId)? delete,
  }) {
    return delete?.call(idTuyenDung, userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? ntdId, String? idUv, int? limit, int? page,
            String? search, String? status, String? duyet, String? id)?
        fetchList,
    TResult Function(NTDTuyenDung tuyenDung)? create,
    TResult Function(NTDTuyenDung tuyenDung)? update,
    TResult Function(NTDTuyenDung tuyenDung)? updateForm,
    TResult Function(String idTuyenDung, String? userId)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(idTuyenDung, userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchTuyenDungList value) fetchList,
    required TResult Function(CreateTuyenDung value) create,
    required TResult Function(UpdateTuyenDung value) update,
    required TResult Function(UpdateTuyenDungForm value) updateForm,
    required TResult Function(DeleteTuyenDung value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchTuyenDungList value)? fetchList,
    TResult? Function(CreateTuyenDung value)? create,
    TResult? Function(UpdateTuyenDung value)? update,
    TResult? Function(UpdateTuyenDungForm value)? updateForm,
    TResult? Function(DeleteTuyenDung value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchTuyenDungList value)? fetchList,
    TResult Function(CreateTuyenDung value)? create,
    TResult Function(UpdateTuyenDung value)? update,
    TResult Function(UpdateTuyenDungForm value)? updateForm,
    TResult Function(DeleteTuyenDung value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class DeleteTuyenDung implements TuyenDungEvent {
  const factory DeleteTuyenDung(
      final String idTuyenDung, final String? userId) = _$DeleteTuyenDungImpl;

  String get idTuyenDung;
  String? get userId;

  /// Create a copy of TuyenDungEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteTuyenDungImplCopyWith<_$DeleteTuyenDungImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TuyenDungState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(NTDTuyenDung tuyenDung, bool isValidated)
        creating,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TuyenDungInitial value) initial,
    required TResult Function(TuyenDungLoading value) loading,
    required TResult Function(TuyenDungLoaded value) loaded,
    required TResult Function(TuyenDungError value) error,
    required TResult Function(CreateTuyenDungState value) creating,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TuyenDungInitial value)? initial,
    TResult? Function(TuyenDungLoading value)? loading,
    TResult? Function(TuyenDungLoaded value)? loaded,
    TResult? Function(TuyenDungError value)? error,
    TResult? Function(CreateTuyenDungState value)? creating,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TuyenDungInitial value)? initial,
    TResult Function(TuyenDungLoading value)? loading,
    TResult Function(TuyenDungLoaded value)? loaded,
    TResult Function(TuyenDungError value)? error,
    TResult Function(CreateTuyenDungState value)? creating,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TuyenDungStateCopyWith<$Res> {
  factory $TuyenDungStateCopyWith(
          TuyenDungState value, $Res Function(TuyenDungState) then) =
      _$TuyenDungStateCopyWithImpl<$Res, TuyenDungState>;
}

/// @nodoc
class _$TuyenDungStateCopyWithImpl<$Res, $Val extends TuyenDungState>
    implements $TuyenDungStateCopyWith<$Res> {
  _$TuyenDungStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TuyenDungInitialImplCopyWith<$Res> {
  factory _$$TuyenDungInitialImplCopyWith(_$TuyenDungInitialImpl value,
          $Res Function(_$TuyenDungInitialImpl) then) =
      __$$TuyenDungInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TuyenDungInitialImplCopyWithImpl<$Res>
    extends _$TuyenDungStateCopyWithImpl<$Res, _$TuyenDungInitialImpl>
    implements _$$TuyenDungInitialImplCopyWith<$Res> {
  __$$TuyenDungInitialImplCopyWithImpl(_$TuyenDungInitialImpl _value,
      $Res Function(_$TuyenDungInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TuyenDungInitialImpl implements TuyenDungInitial {
  const _$TuyenDungInitialImpl();

  @override
  String toString() {
    return 'TuyenDungState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TuyenDungInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(NTDTuyenDung tuyenDung, bool isValidated)
        creating,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
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
    required TResult Function(TuyenDungInitial value) initial,
    required TResult Function(TuyenDungLoading value) loading,
    required TResult Function(TuyenDungLoaded value) loaded,
    required TResult Function(TuyenDungError value) error,
    required TResult Function(CreateTuyenDungState value) creating,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TuyenDungInitial value)? initial,
    TResult? Function(TuyenDungLoading value)? loading,
    TResult? Function(TuyenDungLoaded value)? loaded,
    TResult? Function(TuyenDungError value)? error,
    TResult? Function(CreateTuyenDungState value)? creating,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TuyenDungInitial value)? initial,
    TResult Function(TuyenDungLoading value)? loading,
    TResult Function(TuyenDungLoaded value)? loaded,
    TResult Function(TuyenDungError value)? error,
    TResult Function(CreateTuyenDungState value)? creating,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TuyenDungInitial implements TuyenDungState {
  const factory TuyenDungInitial() = _$TuyenDungInitialImpl;
}

/// @nodoc
abstract class _$$TuyenDungLoadingImplCopyWith<$Res> {
  factory _$$TuyenDungLoadingImplCopyWith(_$TuyenDungLoadingImpl value,
          $Res Function(_$TuyenDungLoadingImpl) then) =
      __$$TuyenDungLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TuyenDungLoadingImplCopyWithImpl<$Res>
    extends _$TuyenDungStateCopyWithImpl<$Res, _$TuyenDungLoadingImpl>
    implements _$$TuyenDungLoadingImplCopyWith<$Res> {
  __$$TuyenDungLoadingImplCopyWithImpl(_$TuyenDungLoadingImpl _value,
      $Res Function(_$TuyenDungLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TuyenDungLoadingImpl implements TuyenDungLoading {
  const _$TuyenDungLoadingImpl();

  @override
  String toString() {
    return 'TuyenDungState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TuyenDungLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(NTDTuyenDung tuyenDung, bool isValidated)
        creating,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
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
    required TResult Function(TuyenDungInitial value) initial,
    required TResult Function(TuyenDungLoading value) loading,
    required TResult Function(TuyenDungLoaded value) loaded,
    required TResult Function(TuyenDungError value) error,
    required TResult Function(CreateTuyenDungState value) creating,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TuyenDungInitial value)? initial,
    TResult? Function(TuyenDungLoading value)? loading,
    TResult? Function(TuyenDungLoaded value)? loaded,
    TResult? Function(TuyenDungError value)? error,
    TResult? Function(CreateTuyenDungState value)? creating,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TuyenDungInitial value)? initial,
    TResult Function(TuyenDungLoading value)? loading,
    TResult Function(TuyenDungLoaded value)? loaded,
    TResult Function(TuyenDungError value)? error,
    TResult Function(CreateTuyenDungState value)? creating,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TuyenDungLoading implements TuyenDungState {
  const factory TuyenDungLoading() = _$TuyenDungLoadingImpl;
}

/// @nodoc
abstract class _$$TuyenDungLoadedImplCopyWith<$Res> {
  factory _$$TuyenDungLoadedImplCopyWith(_$TuyenDungLoadedImpl value,
          $Res Function(_$TuyenDungLoadedImpl) then) =
      __$$TuyenDungLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<NTDTuyenDung> tuyenDungList,
      int currentPage,
      int totalPages,
      int totalItems,
      int limit});
}

/// @nodoc
class __$$TuyenDungLoadedImplCopyWithImpl<$Res>
    extends _$TuyenDungStateCopyWithImpl<$Res, _$TuyenDungLoadedImpl>
    implements _$$TuyenDungLoadedImplCopyWith<$Res> {
  __$$TuyenDungLoadedImplCopyWithImpl(
      _$TuyenDungLoadedImpl _value, $Res Function(_$TuyenDungLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tuyenDungList = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? totalItems = null,
    Object? limit = null,
  }) {
    return _then(_$TuyenDungLoadedImpl(
      null == tuyenDungList
          ? _value._tuyenDungList
          : tuyenDungList // ignore: cast_nullable_to_non_nullable
              as List<NTDTuyenDung>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TuyenDungLoadedImpl implements TuyenDungLoaded {
  const _$TuyenDungLoadedImpl(final List<NTDTuyenDung> tuyenDungList,
      {this.currentPage = 1,
      this.totalPages = 1,
      this.totalItems = 0,
      this.limit = 10})
      : _tuyenDungList = tuyenDungList;

  final List<NTDTuyenDung> _tuyenDungList;
  @override
  List<NTDTuyenDung> get tuyenDungList {
    if (_tuyenDungList is EqualUnmodifiableListView) return _tuyenDungList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tuyenDungList);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int totalItems;
  @override
  @JsonKey()
  final int limit;

  @override
  String toString() {
    return 'TuyenDungState.loaded(tuyenDungList: $tuyenDungList, currentPage: $currentPage, totalPages: $totalPages, totalItems: $totalItems, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TuyenDungLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._tuyenDungList, _tuyenDungList) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tuyenDungList),
      currentPage,
      totalPages,
      totalItems,
      limit);

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TuyenDungLoadedImplCopyWith<_$TuyenDungLoadedImpl> get copyWith =>
      __$$TuyenDungLoadedImplCopyWithImpl<_$TuyenDungLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(NTDTuyenDung tuyenDung, bool isValidated)
        creating,
  }) {
    return loaded(tuyenDungList, currentPage, totalPages, totalItems, limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
  }) {
    return loaded?.call(
        tuyenDungList, currentPage, totalPages, totalItems, limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(tuyenDungList, currentPage, totalPages, totalItems, limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TuyenDungInitial value) initial,
    required TResult Function(TuyenDungLoading value) loading,
    required TResult Function(TuyenDungLoaded value) loaded,
    required TResult Function(TuyenDungError value) error,
    required TResult Function(CreateTuyenDungState value) creating,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TuyenDungInitial value)? initial,
    TResult? Function(TuyenDungLoading value)? loading,
    TResult? Function(TuyenDungLoaded value)? loaded,
    TResult? Function(TuyenDungError value)? error,
    TResult? Function(CreateTuyenDungState value)? creating,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TuyenDungInitial value)? initial,
    TResult Function(TuyenDungLoading value)? loading,
    TResult Function(TuyenDungLoaded value)? loaded,
    TResult Function(TuyenDungError value)? error,
    TResult Function(CreateTuyenDungState value)? creating,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TuyenDungLoaded implements TuyenDungState {
  const factory TuyenDungLoaded(final List<NTDTuyenDung> tuyenDungList,
      {final int currentPage,
      final int totalPages,
      final int totalItems,
      final int limit}) = _$TuyenDungLoadedImpl;

  List<NTDTuyenDung> get tuyenDungList;
  int get currentPage;
  int get totalPages;
  int get totalItems;
  int get limit;

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TuyenDungLoadedImplCopyWith<_$TuyenDungLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TuyenDungErrorImplCopyWith<$Res> {
  factory _$$TuyenDungErrorImplCopyWith(_$TuyenDungErrorImpl value,
          $Res Function(_$TuyenDungErrorImpl) then) =
      __$$TuyenDungErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TuyenDungErrorImplCopyWithImpl<$Res>
    extends _$TuyenDungStateCopyWithImpl<$Res, _$TuyenDungErrorImpl>
    implements _$$TuyenDungErrorImplCopyWith<$Res> {
  __$$TuyenDungErrorImplCopyWithImpl(
      _$TuyenDungErrorImpl _value, $Res Function(_$TuyenDungErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TuyenDungErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TuyenDungErrorImpl implements TuyenDungError {
  const _$TuyenDungErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TuyenDungState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TuyenDungErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TuyenDungErrorImplCopyWith<_$TuyenDungErrorImpl> get copyWith =>
      __$$TuyenDungErrorImplCopyWithImpl<_$TuyenDungErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(NTDTuyenDung tuyenDung, bool isValidated)
        creating,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
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
    required TResult Function(TuyenDungInitial value) initial,
    required TResult Function(TuyenDungLoading value) loading,
    required TResult Function(TuyenDungLoaded value) loaded,
    required TResult Function(TuyenDungError value) error,
    required TResult Function(CreateTuyenDungState value) creating,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TuyenDungInitial value)? initial,
    TResult? Function(TuyenDungLoading value)? loading,
    TResult? Function(TuyenDungLoaded value)? loaded,
    TResult? Function(TuyenDungError value)? error,
    TResult? Function(CreateTuyenDungState value)? creating,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TuyenDungInitial value)? initial,
    TResult Function(TuyenDungLoading value)? loading,
    TResult Function(TuyenDungLoaded value)? loaded,
    TResult Function(TuyenDungError value)? error,
    TResult Function(CreateTuyenDungState value)? creating,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TuyenDungError implements TuyenDungState {
  const factory TuyenDungError(final String message) = _$TuyenDungErrorImpl;

  String get message;

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TuyenDungErrorImplCopyWith<_$TuyenDungErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateTuyenDungStateImplCopyWith<$Res> {
  factory _$$CreateTuyenDungStateImplCopyWith(_$CreateTuyenDungStateImpl value,
          $Res Function(_$CreateTuyenDungStateImpl) then) =
      __$$CreateTuyenDungStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NTDTuyenDung tuyenDung, bool isValidated});

  $NTDTuyenDungCopyWith<$Res> get tuyenDung;
}

/// @nodoc
class __$$CreateTuyenDungStateImplCopyWithImpl<$Res>
    extends _$TuyenDungStateCopyWithImpl<$Res, _$CreateTuyenDungStateImpl>
    implements _$$CreateTuyenDungStateImplCopyWith<$Res> {
  __$$CreateTuyenDungStateImplCopyWithImpl(_$CreateTuyenDungStateImpl _value,
      $Res Function(_$CreateTuyenDungStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tuyenDung = null,
    Object? isValidated = null,
  }) {
    return _then(_$CreateTuyenDungStateImpl(
      null == tuyenDung
          ? _value.tuyenDung
          : tuyenDung // ignore: cast_nullable_to_non_nullable
              as NTDTuyenDung,
      isValidated: null == isValidated
          ? _value.isValidated
          : isValidated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NTDTuyenDungCopyWith<$Res> get tuyenDung {
    return $NTDTuyenDungCopyWith<$Res>(_value.tuyenDung, (value) {
      return _then(_value.copyWith(tuyenDung: value));
    });
  }
}

/// @nodoc

class _$CreateTuyenDungStateImpl implements CreateTuyenDungState {
  const _$CreateTuyenDungStateImpl(this.tuyenDung, {this.isValidated = false});

  @override
  final NTDTuyenDung tuyenDung;
  @override
  @JsonKey()
  final bool isValidated;

  @override
  String toString() {
    return 'TuyenDungState.creating(tuyenDung: $tuyenDung, isValidated: $isValidated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTuyenDungStateImpl &&
            (identical(other.tuyenDung, tuyenDung) ||
                other.tuyenDung == tuyenDung) &&
            (identical(other.isValidated, isValidated) ||
                other.isValidated == isValidated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tuyenDung, isValidated);

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTuyenDungStateImplCopyWith<_$CreateTuyenDungStateImpl>
      get copyWith =>
          __$$CreateTuyenDungStateImplCopyWithImpl<_$CreateTuyenDungStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(NTDTuyenDung tuyenDung, bool isValidated)
        creating,
  }) {
    return creating(tuyenDung, isValidated);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
  }) {
    return creating?.call(tuyenDung, isValidated);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NTDTuyenDung> tuyenDungList, int currentPage,
            int totalPages, int totalItems, int limit)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(NTDTuyenDung tuyenDung, bool isValidated)? creating,
    required TResult orElse(),
  }) {
    if (creating != null) {
      return creating(tuyenDung, isValidated);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TuyenDungInitial value) initial,
    required TResult Function(TuyenDungLoading value) loading,
    required TResult Function(TuyenDungLoaded value) loaded,
    required TResult Function(TuyenDungError value) error,
    required TResult Function(CreateTuyenDungState value) creating,
  }) {
    return creating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TuyenDungInitial value)? initial,
    TResult? Function(TuyenDungLoading value)? loading,
    TResult? Function(TuyenDungLoaded value)? loaded,
    TResult? Function(TuyenDungError value)? error,
    TResult? Function(CreateTuyenDungState value)? creating,
  }) {
    return creating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TuyenDungInitial value)? initial,
    TResult Function(TuyenDungLoading value)? loading,
    TResult Function(TuyenDungLoaded value)? loaded,
    TResult Function(TuyenDungError value)? error,
    TResult Function(CreateTuyenDungState value)? creating,
    required TResult orElse(),
  }) {
    if (creating != null) {
      return creating(this);
    }
    return orElse();
  }
}

abstract class CreateTuyenDungState implements TuyenDungState {
  const factory CreateTuyenDungState(final NTDTuyenDung tuyenDung,
      {final bool isValidated}) = _$CreateTuyenDungStateImpl;

  NTDTuyenDung get tuyenDung;
  bool get isValidated;

  /// Create a copy of TuyenDungState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateTuyenDungStateImplCopyWith<_$CreateTuyenDungStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
