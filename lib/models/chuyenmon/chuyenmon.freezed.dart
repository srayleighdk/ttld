// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chuyenmon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChuyenMon _$ChuyenMonFromJson(Map<String, dynamic> json) {
  return _ChuyenMon.fromJson(json);
}

/// @nodoc
mixin _$ChuyenMon {
  @JsonKey(name: 'ma_chuyen_mon')
  int get maChuyenMon => throw _privateConstructorUsedError;
  @JsonKey(name: 'ten_chuyen_mon')
  String get tenChuyenMon => throw _privateConstructorUsedError;
  @JsonKey(name: 'DisplayOrder')
  int get displayOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'Status')
  bool get status => throw _privateConstructorUsedError;

  /// Serializes this ChuyenMon to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChuyenMon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChuyenMonCopyWith<ChuyenMon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChuyenMonCopyWith<$Res> {
  factory $ChuyenMonCopyWith(ChuyenMon value, $Res Function(ChuyenMon) then) =
      _$ChuyenMonCopyWithImpl<$Res, ChuyenMon>;
  @useResult
  $Res call(
      {@JsonKey(name: 'ma_chuyen_mon') int maChuyenMon,
      @JsonKey(name: 'ten_chuyen_mon') String tenChuyenMon,
      @JsonKey(name: 'DisplayOrder') int displayOrder,
      @JsonKey(name: 'Status') bool status});
}

/// @nodoc
class _$ChuyenMonCopyWithImpl<$Res, $Val extends ChuyenMon>
    implements $ChuyenMonCopyWith<$Res> {
  _$ChuyenMonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChuyenMon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maChuyenMon = null,
    Object? tenChuyenMon = null,
    Object? displayOrder = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      maChuyenMon: null == maChuyenMon
          ? _value.maChuyenMon
          : maChuyenMon // ignore: cast_nullable_to_non_nullable
              as int,
      tenChuyenMon: null == tenChuyenMon
          ? _value.tenChuyenMon
          : tenChuyenMon // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ChuyenMonImplCopyWith<$Res>
    implements $ChuyenMonCopyWith<$Res> {
  factory _$$ChuyenMonImplCopyWith(
          _$ChuyenMonImpl value, $Res Function(_$ChuyenMonImpl) then) =
      __$$ChuyenMonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ma_chuyen_mon') int maChuyenMon,
      @JsonKey(name: 'ten_chuyen_mon') String tenChuyenMon,
      @JsonKey(name: 'DisplayOrder') int displayOrder,
      @JsonKey(name: 'Status') bool status});
}

/// @nodoc
class __$$ChuyenMonImplCopyWithImpl<$Res>
    extends _$ChuyenMonCopyWithImpl<$Res, _$ChuyenMonImpl>
    implements _$$ChuyenMonImplCopyWith<$Res> {
  __$$ChuyenMonImplCopyWithImpl(
      _$ChuyenMonImpl _value, $Res Function(_$ChuyenMonImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChuyenMon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maChuyenMon = null,
    Object? tenChuyenMon = null,
    Object? displayOrder = null,
    Object? status = null,
  }) {
    return _then(_$ChuyenMonImpl(
      null == maChuyenMon
          ? _value.maChuyenMon
          : maChuyenMon // ignore: cast_nullable_to_non_nullable
              as int,
      null == tenChuyenMon
          ? _value.tenChuyenMon
          : tenChuyenMon // ignore: cast_nullable_to_non_nullable
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
class _$ChuyenMonImpl implements _ChuyenMon {
  _$ChuyenMonImpl(
      @JsonKey(name: 'ma_chuyen_mon') this.maChuyenMon,
      @JsonKey(name: 'ten_chuyen_mon') this.tenChuyenMon,
      @JsonKey(name: 'DisplayOrder') this.displayOrder,
      @JsonKey(name: 'Status') this.status);

  factory _$ChuyenMonImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChuyenMonImplFromJson(json);

  @override
  @JsonKey(name: 'ma_chuyen_mon')
  final int maChuyenMon;
  @override
  @JsonKey(name: 'ten_chuyen_mon')
  final String tenChuyenMon;
  @override
  @JsonKey(name: 'DisplayOrder')
  final int displayOrder;
  @override
  @JsonKey(name: 'Status')
  final bool status;

  @override
  String toString() {
    return 'ChuyenMon(maChuyenMon: $maChuyenMon, tenChuyenMon: $tenChuyenMon, displayOrder: $displayOrder, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChuyenMonImpl &&
            (identical(other.maChuyenMon, maChuyenMon) ||
                other.maChuyenMon == maChuyenMon) &&
            (identical(other.tenChuyenMon, tenChuyenMon) ||
                other.tenChuyenMon == tenChuyenMon) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, maChuyenMon, tenChuyenMon, displayOrder, status);

  /// Create a copy of ChuyenMon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChuyenMonImplCopyWith<_$ChuyenMonImpl> get copyWith =>
      __$$ChuyenMonImplCopyWithImpl<_$ChuyenMonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChuyenMonImplToJson(
      this,
    );
  }
}

abstract class _ChuyenMon implements ChuyenMon {
  factory _ChuyenMon(
      @JsonKey(name: 'ma_chuyen_mon') final int maChuyenMon,
      @JsonKey(name: 'ten_chuyen_mon') final String tenChuyenMon,
      @JsonKey(name: 'DisplayOrder') final int displayOrder,
      @JsonKey(name: 'Status') final bool status) = _$ChuyenMonImpl;

  factory _ChuyenMon.fromJson(Map<String, dynamic> json) =
      _$ChuyenMonImpl.fromJson;

  @override
  @JsonKey(name: 'ma_chuyen_mon')
  int get maChuyenMon;
  @override
  @JsonKey(name: 'ten_chuyen_mon')
  String get tenChuyenMon;
  @override
  @JsonKey(name: 'DisplayOrder')
  int get displayOrder;
  @override
  @JsonKey(name: 'Status')
  bool get status;

  /// Create a copy of ChuyenMon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChuyenMonImplCopyWith<_$ChuyenMonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
