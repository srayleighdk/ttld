// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bhtn_khoadaotao_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BhtnKhoadaotao _$BhtnKhoadaotaoFromJson(Map<String, dynamic> json) {
  return _BhtnKhoadaotao.fromJson(json);
}

/// @nodoc
mixin _$BhtnKhoadaotao {
  @JsonKey(name: 'IdKhoadaotao')
  int? get idKhoadaotao => throw _privateConstructorUsedError;
  @JsonKey(name: 'Idcosodaotao')
  int? get idcosodaotao => throw _privateConstructorUsedError;
  @JsonKey(name: 'Name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'IDBhtn')
  String? get idBhtn => throw _privateConstructorUsedError;
  @JsonKey(name: 'Hocphi')
  double? get hocphi => throw _privateConstructorUsedError;
  @JsonKey(name: 'Sothangdaotao')
  double? get sothangdaotao => throw _privateConstructorUsedError;
  @JsonKey(name: 'DisplayOrder')
  int? get displayOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'Status')
  bool? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'PortalID')
  int? get portalId => throw _privateConstructorUsedError;
  @JsonKey(name: 'Updated')
  DateTime? get updated => throw _privateConstructorUsedError;
  @JsonKey(name: 'IsDeleted')
  bool? get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this BhtnKhoadaotao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BhtnKhoadaotao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BhtnKhoadaotaoCopyWith<BhtnKhoadaotao> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BhtnKhoadaotaoCopyWith<$Res> {
  factory $BhtnKhoadaotaoCopyWith(
          BhtnKhoadaotao value, $Res Function(BhtnKhoadaotao) then) =
      _$BhtnKhoadaotaoCopyWithImpl<$Res, BhtnKhoadaotao>;
  @useResult
  $Res call(
      {@JsonKey(name: 'IdKhoadaotao') int? idKhoadaotao,
      @JsonKey(name: 'Idcosodaotao') int? idcosodaotao,
      @JsonKey(name: 'Name') String? name,
      @JsonKey(name: 'IDBhtn') String? idBhtn,
      @JsonKey(name: 'Hocphi') double? hocphi,
      @JsonKey(name: 'Sothangdaotao') double? sothangdaotao,
      @JsonKey(name: 'DisplayOrder') int? displayOrder,
      @JsonKey(name: 'Status') bool? status,
      @JsonKey(name: 'PortalID') int? portalId,
      @JsonKey(name: 'Updated') DateTime? updated,
      @JsonKey(name: 'IsDeleted') bool? isDeleted});
}

/// @nodoc
class _$BhtnKhoadaotaoCopyWithImpl<$Res, $Val extends BhtnKhoadaotao>
    implements $BhtnKhoadaotaoCopyWith<$Res> {
  _$BhtnKhoadaotaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BhtnKhoadaotao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idKhoadaotao = freezed,
    Object? idcosodaotao = freezed,
    Object? name = freezed,
    Object? idBhtn = freezed,
    Object? hocphi = freezed,
    Object? sothangdaotao = freezed,
    Object? displayOrder = freezed,
    Object? status = freezed,
    Object? portalId = freezed,
    Object? updated = freezed,
    Object? isDeleted = freezed,
  }) {
    return _then(_value.copyWith(
      idKhoadaotao: freezed == idKhoadaotao
          ? _value.idKhoadaotao
          : idKhoadaotao // ignore: cast_nullable_to_non_nullable
              as int?,
      idcosodaotao: freezed == idcosodaotao
          ? _value.idcosodaotao
          : idcosodaotao // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      idBhtn: freezed == idBhtn
          ? _value.idBhtn
          : idBhtn // ignore: cast_nullable_to_non_nullable
              as String?,
      hocphi: freezed == hocphi
          ? _value.hocphi
          : hocphi // ignore: cast_nullable_to_non_nullable
              as double?,
      sothangdaotao: freezed == sothangdaotao
          ? _value.sothangdaotao
          : sothangdaotao // ignore: cast_nullable_to_non_nullable
              as double?,
      displayOrder: freezed == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      portalId: freezed == portalId
          ? _value.portalId
          : portalId // ignore: cast_nullable_to_non_nullable
              as int?,
      updated: freezed == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BhtnKhoadaotaoImplCopyWith<$Res>
    implements $BhtnKhoadaotaoCopyWith<$Res> {
  factory _$$BhtnKhoadaotaoImplCopyWith(_$BhtnKhoadaotaoImpl value,
          $Res Function(_$BhtnKhoadaotaoImpl) then) =
      __$$BhtnKhoadaotaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'IdKhoadaotao') int? idKhoadaotao,
      @JsonKey(name: 'Idcosodaotao') int? idcosodaotao,
      @JsonKey(name: 'Name') String? name,
      @JsonKey(name: 'IDBhtn') String? idBhtn,
      @JsonKey(name: 'Hocphi') double? hocphi,
      @JsonKey(name: 'Sothangdaotao') double? sothangdaotao,
      @JsonKey(name: 'DisplayOrder') int? displayOrder,
      @JsonKey(name: 'Status') bool? status,
      @JsonKey(name: 'PortalID') int? portalId,
      @JsonKey(name: 'Updated') DateTime? updated,
      @JsonKey(name: 'IsDeleted') bool? isDeleted});
}

/// @nodoc
class __$$BhtnKhoadaotaoImplCopyWithImpl<$Res>
    extends _$BhtnKhoadaotaoCopyWithImpl<$Res, _$BhtnKhoadaotaoImpl>
    implements _$$BhtnKhoadaotaoImplCopyWith<$Res> {
  __$$BhtnKhoadaotaoImplCopyWithImpl(
      _$BhtnKhoadaotaoImpl _value, $Res Function(_$BhtnKhoadaotaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of BhtnKhoadaotao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idKhoadaotao = freezed,
    Object? idcosodaotao = freezed,
    Object? name = freezed,
    Object? idBhtn = freezed,
    Object? hocphi = freezed,
    Object? sothangdaotao = freezed,
    Object? displayOrder = freezed,
    Object? status = freezed,
    Object? portalId = freezed,
    Object? updated = freezed,
    Object? isDeleted = freezed,
  }) {
    return _then(_$BhtnKhoadaotaoImpl(
      idKhoadaotao: freezed == idKhoadaotao
          ? _value.idKhoadaotao
          : idKhoadaotao // ignore: cast_nullable_to_non_nullable
              as int?,
      idcosodaotao: freezed == idcosodaotao
          ? _value.idcosodaotao
          : idcosodaotao // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      idBhtn: freezed == idBhtn
          ? _value.idBhtn
          : idBhtn // ignore: cast_nullable_to_non_nullable
              as String?,
      hocphi: freezed == hocphi
          ? _value.hocphi
          : hocphi // ignore: cast_nullable_to_non_nullable
              as double?,
      sothangdaotao: freezed == sothangdaotao
          ? _value.sothangdaotao
          : sothangdaotao // ignore: cast_nullable_to_non_nullable
              as double?,
      displayOrder: freezed == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      portalId: freezed == portalId
          ? _value.portalId
          : portalId // ignore: cast_nullable_to_non_nullable
              as int?,
      updated: freezed == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BhtnKhoadaotaoImpl extends _BhtnKhoadaotao {
  const _$BhtnKhoadaotaoImpl(
      {@JsonKey(name: 'IdKhoadaotao') this.idKhoadaotao,
      @JsonKey(name: 'Idcosodaotao') this.idcosodaotao,
      @JsonKey(name: 'Name') this.name,
      @JsonKey(name: 'IDBhtn') this.idBhtn,
      @JsonKey(name: 'Hocphi') this.hocphi,
      @JsonKey(name: 'Sothangdaotao') this.sothangdaotao,
      @JsonKey(name: 'DisplayOrder') this.displayOrder,
      @JsonKey(name: 'Status') this.status,
      @JsonKey(name: 'PortalID') this.portalId,
      @JsonKey(name: 'Updated') this.updated,
      @JsonKey(name: 'IsDeleted') this.isDeleted})
      : super._();

  factory _$BhtnKhoadaotaoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BhtnKhoadaotaoImplFromJson(json);

  @override
  @JsonKey(name: 'IdKhoadaotao')
  final int? idKhoadaotao;
  @override
  @JsonKey(name: 'Idcosodaotao')
  final int? idcosodaotao;
  @override
  @JsonKey(name: 'Name')
  final String? name;
  @override
  @JsonKey(name: 'IDBhtn')
  final String? idBhtn;
  @override
  @JsonKey(name: 'Hocphi')
  final double? hocphi;
  @override
  @JsonKey(name: 'Sothangdaotao')
  final double? sothangdaotao;
  @override
  @JsonKey(name: 'DisplayOrder')
  final int? displayOrder;
  @override
  @JsonKey(name: 'Status')
  final bool? status;
  @override
  @JsonKey(name: 'PortalID')
  final int? portalId;
  @override
  @JsonKey(name: 'Updated')
  final DateTime? updated;
  @override
  @JsonKey(name: 'IsDeleted')
  final bool? isDeleted;

  @override
  String toString() {
    return 'BhtnKhoadaotao(idKhoadaotao: $idKhoadaotao, idcosodaotao: $idcosodaotao, name: $name, idBhtn: $idBhtn, hocphi: $hocphi, sothangdaotao: $sothangdaotao, displayOrder: $displayOrder, status: $status, portalId: $portalId, updated: $updated, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BhtnKhoadaotaoImpl &&
            (identical(other.idKhoadaotao, idKhoadaotao) ||
                other.idKhoadaotao == idKhoadaotao) &&
            (identical(other.idcosodaotao, idcosodaotao) ||
                other.idcosodaotao == idcosodaotao) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.idBhtn, idBhtn) || other.idBhtn == idBhtn) &&
            (identical(other.hocphi, hocphi) || other.hocphi == hocphi) &&
            (identical(other.sothangdaotao, sothangdaotao) ||
                other.sothangdaotao == sothangdaotao) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.portalId, portalId) ||
                other.portalId == portalId) &&
            (identical(other.updated, updated) || other.updated == updated) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idKhoadaotao,
      idcosodaotao,
      name,
      idBhtn,
      hocphi,
      sothangdaotao,
      displayOrder,
      status,
      portalId,
      updated,
      isDeleted);

  /// Create a copy of BhtnKhoadaotao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BhtnKhoadaotaoImplCopyWith<_$BhtnKhoadaotaoImpl> get copyWith =>
      __$$BhtnKhoadaotaoImplCopyWithImpl<_$BhtnKhoadaotaoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BhtnKhoadaotaoImplToJson(
      this,
    );
  }
}

abstract class _BhtnKhoadaotao extends BhtnKhoadaotao {
  const factory _BhtnKhoadaotao(
          {@JsonKey(name: 'IdKhoadaotao') final int? idKhoadaotao,
          @JsonKey(name: 'Idcosodaotao') final int? idcosodaotao,
          @JsonKey(name: 'Name') final String? name,
          @JsonKey(name: 'IDBhtn') final String? idBhtn,
          @JsonKey(name: 'Hocphi') final double? hocphi,
          @JsonKey(name: 'Sothangdaotao') final double? sothangdaotao,
          @JsonKey(name: 'DisplayOrder') final int? displayOrder,
          @JsonKey(name: 'Status') final bool? status,
          @JsonKey(name: 'PortalID') final int? portalId,
          @JsonKey(name: 'Updated') final DateTime? updated,
          @JsonKey(name: 'IsDeleted') final bool? isDeleted}) =
      _$BhtnKhoadaotaoImpl;
  const _BhtnKhoadaotao._() : super._();

  factory _BhtnKhoadaotao.fromJson(Map<String, dynamic> json) =
      _$BhtnKhoadaotaoImpl.fromJson;

  @override
  @JsonKey(name: 'IdKhoadaotao')
  int? get idKhoadaotao;
  @override
  @JsonKey(name: 'Idcosodaotao')
  int? get idcosodaotao;
  @override
  @JsonKey(name: 'Name')
  String? get name;
  @override
  @JsonKey(name: 'IDBhtn')
  String? get idBhtn;
  @override
  @JsonKey(name: 'Hocphi')
  double? get hocphi;
  @override
  @JsonKey(name: 'Sothangdaotao')
  double? get sothangdaotao;
  @override
  @JsonKey(name: 'DisplayOrder')
  int? get displayOrder;
  @override
  @JsonKey(name: 'Status')
  bool? get status;
  @override
  @JsonKey(name: 'PortalID')
  int? get portalId;
  @override
  @JsonKey(name: 'Updated')
  DateTime? get updated;
  @override
  @JsonKey(name: 'IsDeleted')
  bool? get isDeleted;

  /// Create a copy of BhtnKhoadaotao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BhtnKhoadaotaoImplCopyWith<_$BhtnKhoadaotaoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
