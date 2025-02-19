// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tttantat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TinhTrangTanTat _$TinhTrangTanTatFromJson(Map<String, dynamic> json) {
  return _TinhTrangTanTat.fromJson(json);
}

/// @nodoc
mixin _$TinhTrangTanTat {
  @JsonKey(name: 'tantat_id')
  int get tantatId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tantat_ten')
  String get tantatTen => throw _privateConstructorUsedError;
  @JsonKey(name: 'DisplayOrder')
  int get displayOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'Status')
  bool get status => throw _privateConstructorUsedError;

  /// Serializes this TinhTrangTanTat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TinhTrangTanTat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TinhTrangTanTatCopyWith<TinhTrangTanTat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TinhTrangTanTatCopyWith<$Res> {
  factory $TinhTrangTanTatCopyWith(
          TinhTrangTanTat value, $Res Function(TinhTrangTanTat) then) =
      _$TinhTrangTanTatCopyWithImpl<$Res, TinhTrangTanTat>;
  @useResult
  $Res call(
      {@JsonKey(name: 'tantat_id') int tantatId,
      @JsonKey(name: 'tantat_ten') String tantatTen,
      @JsonKey(name: 'DisplayOrder') int displayOrder,
      @JsonKey(name: 'Status') bool status});
}

/// @nodoc
class _$TinhTrangTanTatCopyWithImpl<$Res, $Val extends TinhTrangTanTat>
    implements $TinhTrangTanTatCopyWith<$Res> {
  _$TinhTrangTanTatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TinhTrangTanTat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tantatId = null,
    Object? tantatTen = null,
    Object? displayOrder = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      tantatId: null == tantatId
          ? _value.tantatId
          : tantatId // ignore: cast_nullable_to_non_nullable
              as int,
      tantatTen: null == tantatTen
          ? _value.tantatTen
          : tantatTen // ignore: cast_nullable_to_non_nullable
              as String,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TinhTrangTanTatImplCopyWith<$Res>
    implements $TinhTrangTanTatCopyWith<$Res> {
  factory _$$TinhTrangTanTatImplCopyWith(_$TinhTrangTanTatImpl value,
          $Res Function(_$TinhTrangTanTatImpl) then) =
      __$$TinhTrangTanTatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'tantat_id') int tantatId,
      @JsonKey(name: 'tantat_ten') String tantatTen,
      @JsonKey(name: 'DisplayOrder') int displayOrder,
      @JsonKey(name: 'Status') bool status});
}

/// @nodoc
class __$$TinhTrangTanTatImplCopyWithImpl<$Res>
    extends _$TinhTrangTanTatCopyWithImpl<$Res, _$TinhTrangTanTatImpl>
    implements _$$TinhTrangTanTatImplCopyWith<$Res> {
  __$$TinhTrangTanTatImplCopyWithImpl(
      _$TinhTrangTanTatImpl _value, $Res Function(_$TinhTrangTanTatImpl) _then)
      : super(_value, _then);

  /// Create a copy of TinhTrangTanTat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tantatId = null,
    Object? tantatTen = null,
    Object? displayOrder = null,
    Object? status = null,
  }) {
    return _then(_$TinhTrangTanTatImpl(
      null == tantatId
          ? _value.tantatId
          : tantatId // ignore: cast_nullable_to_non_nullable
              as int,
      null == tantatTen
          ? _value.tantatTen
          : tantatTen // ignore: cast_nullable_to_non_nullable
              as String,
      null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TinhTrangTanTatImpl implements _TinhTrangTanTat {
  _$TinhTrangTanTatImpl(
      @JsonKey(name: 'tantat_id') this.tantatId,
      @JsonKey(name: 'tantat_ten') this.tantatTen,
      @JsonKey(name: 'DisplayOrder') this.displayOrder,
      @JsonKey(name: 'Status') this.status);

  factory _$TinhTrangTanTatImpl.fromJson(Map<String, dynamic> json) =>
      _$$TinhTrangTanTatImplFromJson(json);

  @override
  @JsonKey(name: 'tantat_id')
  final int tantatId;
  @override
  @JsonKey(name: 'tantat_ten')
  final String tantatTen;
  @override
  @JsonKey(name: 'DisplayOrder')
  final int displayOrder;
  @override
  @JsonKey(name: 'Status')
  final bool status;

  @override
  String toString() {
    return 'TinhTrangTanTat(tantatId: $tantatId, tantatTen: $tantatTen, displayOrder: $displayOrder, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinhTrangTanTatImpl &&
            (identical(other.tantatId, tantatId) ||
                other.tantatId == tantatId) &&
            (identical(other.tantatTen, tantatTen) ||
                other.tantatTen == tantatTen) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tantatId, tantatTen, displayOrder, status);

  /// Create a copy of TinhTrangTanTat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TinhTrangTanTatImplCopyWith<_$TinhTrangTanTatImpl> get copyWith =>
      __$$TinhTrangTanTatImplCopyWithImpl<_$TinhTrangTanTatImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TinhTrangTanTatImplToJson(
      this,
    );
  }
}

abstract class _TinhTrangTanTat implements TinhTrangTanTat {
  factory _TinhTrangTanTat(
      @JsonKey(name: 'tantat_id') final int tantatId,
      @JsonKey(name: 'tantat_ten') final String tantatTen,
      @JsonKey(name: 'DisplayOrder') final int displayOrder,
      @JsonKey(name: 'Status') final bool status) = _$TinhTrangTanTatImpl;

  factory _TinhTrangTanTat.fromJson(Map<String, dynamic> json) =
      _$TinhTrangTanTatImpl.fromJson;

  @override
  @JsonKey(name: 'tantat_id')
  int get tantatId;
  @override
  @JsonKey(name: 'tantat_ten')
  String get tantatTen;
  @override
  @JsonKey(name: 'DisplayOrder')
  int get displayOrder;
  @override
  @JsonKey(name: 'Status')
  bool get status;

  /// Create a copy of TinhTrangTanTat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TinhTrangTanTatImplCopyWith<_$TinhTrangTanTatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
