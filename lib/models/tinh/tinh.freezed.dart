// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tinh.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Tinh _$TinhFromJson(Map<String, dynamic> json) {
  return _Tinh.fromJson(json);
}

/// @nodoc
mixin _$Tinh {
  int get displayOrder => throw _privateConstructorUsedError;
  String get matinh => throw _privateConstructorUsedError;
  String get tentinh => throw _privateConstructorUsedError;
  String get mabhyt => throw _privateConstructorUsedError;
  bool get show => throw _privateConstructorUsedError;

  /// Serializes this Tinh to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tinh
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TinhCopyWith<Tinh> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TinhCopyWith<$Res> {
  factory $TinhCopyWith(Tinh value, $Res Function(Tinh) then) =
      _$TinhCopyWithImpl<$Res, Tinh>;
  @useResult
  $Res call(
      {int displayOrder,
      String matinh,
      String tentinh,
      String mabhyt,
      bool show});
}

/// @nodoc
class _$TinhCopyWithImpl<$Res, $Val extends Tinh>
    implements $TinhCopyWith<$Res> {
  _$TinhCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tinh
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayOrder = null,
    Object? matinh = null,
    Object? tentinh = null,
    Object? mabhyt = null,
    Object? show = null,
  }) {
    return _then(_value.copyWith(
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      matinh: null == matinh
          ? _value.matinh
          : matinh // ignore: cast_nullable_to_non_nullable
              as String,
      tentinh: null == tentinh
          ? _value.tentinh
          : tentinh // ignore: cast_nullable_to_non_nullable
              as String,
      mabhyt: null == mabhyt
          ? _value.mabhyt
          : mabhyt // ignore: cast_nullable_to_non_nullable
              as String,
      show: null == show
          ? _value.show
          : show // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TinhImplCopyWith<$Res> implements $TinhCopyWith<$Res> {
  factory _$$TinhImplCopyWith(
          _$TinhImpl value, $Res Function(_$TinhImpl) then) =
      __$$TinhImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int displayOrder,
      String matinh,
      String tentinh,
      String mabhyt,
      bool show});
}

/// @nodoc
class __$$TinhImplCopyWithImpl<$Res>
    extends _$TinhCopyWithImpl<$Res, _$TinhImpl>
    implements _$$TinhImplCopyWith<$Res> {
  __$$TinhImplCopyWithImpl(_$TinhImpl _value, $Res Function(_$TinhImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tinh
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayOrder = null,
    Object? matinh = null,
    Object? tentinh = null,
    Object? mabhyt = null,
    Object? show = null,
  }) {
    return _then(_$TinhImpl(
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      matinh: null == matinh
          ? _value.matinh
          : matinh // ignore: cast_nullable_to_non_nullable
              as String,
      tentinh: null == tentinh
          ? _value.tentinh
          : tentinh // ignore: cast_nullable_to_non_nullable
              as String,
      mabhyt: null == mabhyt
          ? _value.mabhyt
          : mabhyt // ignore: cast_nullable_to_non_nullable
              as String,
      show: null == show
          ? _value.show
          : show // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TinhImpl implements _Tinh {
  _$TinhImpl(
      {this.displayOrder = 0,
      this.matinh = '',
      this.tentinh = '',
      this.mabhyt = '',
      this.show = false});

  factory _$TinhImpl.fromJson(Map<String, dynamic> json) =>
      _$$TinhImplFromJson(json);

  @override
  @JsonKey()
  final int displayOrder;
  @override
  @JsonKey()
  final String matinh;
  @override
  @JsonKey()
  final String tentinh;
  @override
  @JsonKey()
  final String mabhyt;
  @override
  @JsonKey()
  final bool show;

  @override
  String toString() {
    return 'Tinh(displayOrder: $displayOrder, matinh: $matinh, tentinh: $tentinh, mabhyt: $mabhyt, show: $show)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinhImpl &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.matinh, matinh) || other.matinh == matinh) &&
            (identical(other.tentinh, tentinh) || other.tentinh == tentinh) &&
            (identical(other.mabhyt, mabhyt) || other.mabhyt == mabhyt) &&
            (identical(other.show, show) || other.show == show));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, displayOrder, matinh, tentinh, mabhyt, show);

  /// Create a copy of Tinh
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TinhImplCopyWith<_$TinhImpl> get copyWith =>
      __$$TinhImplCopyWithImpl<_$TinhImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TinhImplToJson(
      this,
    );
  }
}

abstract class _Tinh implements Tinh {
  factory _Tinh(
      {final int displayOrder,
      final String matinh,
      final String tentinh,
      final String mabhyt,
      final bool show}) = _$TinhImpl;

  factory _Tinh.fromJson(Map<String, dynamic> json) = _$TinhImpl.fromJson;

  @override
  int get displayOrder;
  @override
  String get matinh;
  @override
  String get tentinh;
  @override
  String get mabhyt;
  @override
  bool get show;

  /// Create a copy of Tinh
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TinhImplCopyWith<_$TinhImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
