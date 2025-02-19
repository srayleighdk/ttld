// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doituong.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DoiTuongChinhSach _$DoiTuongChinhSachFromJson(Map<String, dynamic> json) {
  return _DoiTuongChinhSach.fromJson(json);
}

/// @nodoc
mixin _$DoiTuongChinhSach {
  @JsonKey(name: 'dtcs_id')
  int get dtcsId => throw _privateConstructorUsedError;
  @JsonKey(name: 'dtcs_ten')
  String? get dtcsTen => throw _privateConstructorUsedError; // Nullable
  @JsonKey(name: 'DisplayOrder')
  int get displayOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'Status')
  bool get status => throw _privateConstructorUsedError;

  /// Serializes this DoiTuongChinhSach to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoiTuongChinhSach
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoiTuongChinhSachCopyWith<DoiTuongChinhSach> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoiTuongChinhSachCopyWith<$Res> {
  factory $DoiTuongChinhSachCopyWith(
          DoiTuongChinhSach value, $Res Function(DoiTuongChinhSach) then) =
      _$DoiTuongChinhSachCopyWithImpl<$Res, DoiTuongChinhSach>;
  @useResult
  $Res call(
      {@JsonKey(name: 'dtcs_id') int dtcsId,
      @JsonKey(name: 'dtcs_ten') String? dtcsTen,
      @JsonKey(name: 'DisplayOrder') int displayOrder,
      @JsonKey(name: 'Status') bool status});
}

/// @nodoc
class _$DoiTuongChinhSachCopyWithImpl<$Res, $Val extends DoiTuongChinhSach>
    implements $DoiTuongChinhSachCopyWith<$Res> {
  _$DoiTuongChinhSachCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoiTuongChinhSach
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dtcsId = null,
    Object? dtcsTen = freezed,
    Object? displayOrder = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      dtcsId: null == dtcsId
          ? _value.dtcsId
          : dtcsId // ignore: cast_nullable_to_non_nullable
              as int,
      dtcsTen: freezed == dtcsTen
          ? _value.dtcsTen
          : dtcsTen // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$DoiTuongChinhSachImplCopyWith<$Res>
    implements $DoiTuongChinhSachCopyWith<$Res> {
  factory _$$DoiTuongChinhSachImplCopyWith(_$DoiTuongChinhSachImpl value,
          $Res Function(_$DoiTuongChinhSachImpl) then) =
      __$$DoiTuongChinhSachImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'dtcs_id') int dtcsId,
      @JsonKey(name: 'dtcs_ten') String? dtcsTen,
      @JsonKey(name: 'DisplayOrder') int displayOrder,
      @JsonKey(name: 'Status') bool status});
}

/// @nodoc
class __$$DoiTuongChinhSachImplCopyWithImpl<$Res>
    extends _$DoiTuongChinhSachCopyWithImpl<$Res, _$DoiTuongChinhSachImpl>
    implements _$$DoiTuongChinhSachImplCopyWith<$Res> {
  __$$DoiTuongChinhSachImplCopyWithImpl(_$DoiTuongChinhSachImpl _value,
      $Res Function(_$DoiTuongChinhSachImpl) _then)
      : super(_value, _then);

  /// Create a copy of DoiTuongChinhSach
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dtcsId = null,
    Object? dtcsTen = freezed,
    Object? displayOrder = null,
    Object? status = null,
  }) {
    return _then(_$DoiTuongChinhSachImpl(
      null == dtcsId
          ? _value.dtcsId
          : dtcsId // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == dtcsTen
          ? _value.dtcsTen
          : dtcsTen // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$DoiTuongChinhSachImpl implements _DoiTuongChinhSach {
  _$DoiTuongChinhSachImpl(
      @JsonKey(name: 'dtcs_id') this.dtcsId,
      @JsonKey(name: 'dtcs_ten') this.dtcsTen,
      @JsonKey(name: 'DisplayOrder') this.displayOrder,
      @JsonKey(name: 'Status') this.status);

  factory _$DoiTuongChinhSachImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoiTuongChinhSachImplFromJson(json);

  @override
  @JsonKey(name: 'dtcs_id')
  final int dtcsId;
  @override
  @JsonKey(name: 'dtcs_ten')
  final String? dtcsTen;
// Nullable
  @override
  @JsonKey(name: 'DisplayOrder')
  final int displayOrder;
  @override
  @JsonKey(name: 'Status')
  final bool status;

  @override
  String toString() {
    return 'DoiTuongChinhSach(dtcsId: $dtcsId, dtcsTen: $dtcsTen, displayOrder: $displayOrder, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoiTuongChinhSachImpl &&
            (identical(other.dtcsId, dtcsId) || other.dtcsId == dtcsId) &&
            (identical(other.dtcsTen, dtcsTen) || other.dtcsTen == dtcsTen) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, dtcsId, dtcsTen, displayOrder, status);

  /// Create a copy of DoiTuongChinhSach
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoiTuongChinhSachImplCopyWith<_$DoiTuongChinhSachImpl> get copyWith =>
      __$$DoiTuongChinhSachImplCopyWithImpl<_$DoiTuongChinhSachImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoiTuongChinhSachImplToJson(
      this,
    );
  }
}

abstract class _DoiTuongChinhSach implements DoiTuongChinhSach {
  factory _DoiTuongChinhSach(
      @JsonKey(name: 'dtcs_id') final int dtcsId,
      @JsonKey(name: 'dtcs_ten') final String? dtcsTen,
      @JsonKey(name: 'DisplayOrder') final int displayOrder,
      @JsonKey(name: 'Status') final bool status) = _$DoiTuongChinhSachImpl;

  factory _DoiTuongChinhSach.fromJson(Map<String, dynamic> json) =
      _$DoiTuongChinhSachImpl.fromJson;

  @override
  @JsonKey(name: 'dtcs_id')
  int get dtcsId;
  @override
  @JsonKey(name: 'dtcs_ten')
  String? get dtcsTen; // Nullable
  @override
  @JsonKey(name: 'DisplayOrder')
  int get displayOrder;
  @override
  @JsonKey(name: 'Status')
  bool get status;

  /// Create a copy of DoiTuongChinhSach
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoiTuongChinhSachImplCopyWith<_$DoiTuongChinhSachImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
