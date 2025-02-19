// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'danhmuc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DanhMuc _$DanhMucFromJson(Map<String, dynamic> json) {
  return _DanhMuc.fromJson(json);
}

/// @nodoc
mixin _$DanhMuc {
  @JsonKey(name: 'ma_chuc_danh')
  int get maChucDanh => throw _privateConstructorUsedError;
  @JsonKey(name: 'ten_chuc_danh')
  String get tenChucDanh => throw _privateConstructorUsedError;
  @JsonKey(name: 'DisplayOrder')
  int get displayOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'Status')
  bool get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'idLoai')
  int get idLoai => throw _privateConstructorUsedError;

  /// Serializes this DanhMuc to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DanhMuc
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DanhMucCopyWith<DanhMuc> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DanhMucCopyWith<$Res> {
  factory $DanhMucCopyWith(DanhMuc value, $Res Function(DanhMuc) then) =
      _$DanhMucCopyWithImpl<$Res, DanhMuc>;
  @useResult
  $Res call(
      {@JsonKey(name: 'ma_chuc_danh') int maChucDanh,
      @JsonKey(name: 'ten_chuc_danh') String tenChucDanh,
      @JsonKey(name: 'DisplayOrder') int displayOrder,
      @JsonKey(name: 'Status') bool status,
      @JsonKey(name: 'idLoai') int idLoai});
}

/// @nodoc
class _$DanhMucCopyWithImpl<$Res, $Val extends DanhMuc>
    implements $DanhMucCopyWith<$Res> {
  _$DanhMucCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DanhMuc
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maChucDanh = null,
    Object? tenChucDanh = null,
    Object? displayOrder = null,
    Object? status = null,
    Object? idLoai = null,
  }) {
    return _then(_value.copyWith(
      maChucDanh: null == maChucDanh
          ? _value.maChucDanh
          : maChucDanh // ignore: cast_nullable_to_non_nullable
              as int,
      tenChucDanh: null == tenChucDanh
          ? _value.tenChucDanh
          : tenChucDanh // ignore: cast_nullable_to_non_nullable
              as String,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      idLoai: null == idLoai
          ? _value.idLoai
          : idLoai // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DanhMucImplCopyWith<$Res> implements $DanhMucCopyWith<$Res> {
  factory _$$DanhMucImplCopyWith(
          _$DanhMucImpl value, $Res Function(_$DanhMucImpl) then) =
      __$$DanhMucImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ma_chuc_danh') int maChucDanh,
      @JsonKey(name: 'ten_chuc_danh') String tenChucDanh,
      @JsonKey(name: 'DisplayOrder') int displayOrder,
      @JsonKey(name: 'Status') bool status,
      @JsonKey(name: 'idLoai') int idLoai});
}

/// @nodoc
class __$$DanhMucImplCopyWithImpl<$Res>
    extends _$DanhMucCopyWithImpl<$Res, _$DanhMucImpl>
    implements _$$DanhMucImplCopyWith<$Res> {
  __$$DanhMucImplCopyWithImpl(
      _$DanhMucImpl _value, $Res Function(_$DanhMucImpl) _then)
      : super(_value, _then);

  /// Create a copy of DanhMuc
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maChucDanh = null,
    Object? tenChucDanh = null,
    Object? displayOrder = null,
    Object? status = null,
    Object? idLoai = null,
  }) {
    return _then(_$DanhMucImpl(
      null == maChucDanh
          ? _value.maChucDanh
          : maChucDanh // ignore: cast_nullable_to_non_nullable
              as int,
      null == tenChucDanh
          ? _value.tenChucDanh
          : tenChucDanh // ignore: cast_nullable_to_non_nullable
              as String,
      null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      null == idLoai
          ? _value.idLoai
          : idLoai // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DanhMucImpl implements _DanhMuc {
  _$DanhMucImpl(
      @JsonKey(name: 'ma_chuc_danh') this.maChucDanh,
      @JsonKey(name: 'ten_chuc_danh') this.tenChucDanh,
      @JsonKey(name: 'DisplayOrder') this.displayOrder,
      @JsonKey(name: 'Status') this.status,
      @JsonKey(name: 'idLoai') this.idLoai);

  factory _$DanhMucImpl.fromJson(Map<String, dynamic> json) =>
      _$$DanhMucImplFromJson(json);

  @override
  @JsonKey(name: 'ma_chuc_danh')
  final int maChucDanh;
  @override
  @JsonKey(name: 'ten_chuc_danh')
  final String tenChucDanh;
  @override
  @JsonKey(name: 'DisplayOrder')
  final int displayOrder;
  @override
  @JsonKey(name: 'Status')
  final bool status;
  @override
  @JsonKey(name: 'idLoai')
  final int idLoai;

  @override
  String toString() {
    return 'DanhMuc(maChucDanh: $maChucDanh, tenChucDanh: $tenChucDanh, displayOrder: $displayOrder, status: $status, idLoai: $idLoai)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DanhMucImpl &&
            (identical(other.maChucDanh, maChucDanh) ||
                other.maChucDanh == maChucDanh) &&
            (identical(other.tenChucDanh, tenChucDanh) ||
                other.tenChucDanh == tenChucDanh) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.idLoai, idLoai) || other.idLoai == idLoai));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, maChucDanh, tenChucDanh, displayOrder, status, idLoai);

  /// Create a copy of DanhMuc
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DanhMucImplCopyWith<_$DanhMucImpl> get copyWith =>
      __$$DanhMucImplCopyWithImpl<_$DanhMucImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DanhMucImplToJson(
      this,
    );
  }
}

abstract class _DanhMuc implements DanhMuc {
  factory _DanhMuc(
      @JsonKey(name: 'ma_chuc_danh') final int maChucDanh,
      @JsonKey(name: 'ten_chuc_danh') final String tenChucDanh,
      @JsonKey(name: 'DisplayOrder') final int displayOrder,
      @JsonKey(name: 'Status') final bool status,
      @JsonKey(name: 'idLoai') final int idLoai) = _$DanhMucImpl;

  factory _DanhMuc.fromJson(Map<String, dynamic> json) = _$DanhMucImpl.fromJson;

  @override
  @JsonKey(name: 'ma_chuc_danh')
  int get maChucDanh;
  @override
  @JsonKey(name: 'ten_chuc_danh')
  String get tenChucDanh;
  @override
  @JsonKey(name: 'DisplayOrder')
  int get displayOrder;
  @override
  @JsonKey(name: 'Status')
  bool get status;
  @override
  @JsonKey(name: 'idLoai')
  int get idLoai;

  /// Create a copy of DanhMuc
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DanhMucImplCopyWith<_$DanhMucImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
