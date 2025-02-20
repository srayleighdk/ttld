// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'huyen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Huyen _$HuyenFromJson(Map<String, dynamic> json) {
  return _Huyen.fromJson(json);
}

/// @nodoc
mixin _$Huyen {
  String get mahuyen => throw _privateConstructorUsedError;
  String get tenhuyen => throw _privateConstructorUsedError;
  int get sott => throw _privateConstructorUsedError;
  bool get show => throw _privateConstructorUsedError;
  String get tentinh => throw _privateConstructorUsedError;

  /// Serializes this Huyen to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Huyen
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HuyenCopyWith<Huyen> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HuyenCopyWith<$Res> {
  factory $HuyenCopyWith(Huyen value, $Res Function(Huyen) then) =
      _$HuyenCopyWithImpl<$Res, Huyen>;
  @useResult
  $Res call(
      {String mahuyen, String tenhuyen, int sott, bool show, String tentinh});
}

/// @nodoc
class _$HuyenCopyWithImpl<$Res, $Val extends Huyen>
    implements $HuyenCopyWith<$Res> {
  _$HuyenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Huyen
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mahuyen = null,
    Object? tenhuyen = null,
    Object? sott = null,
    Object? show = null,
    Object? tentinh = null,
  }) {
    return _then(_value.copyWith(
      mahuyen: null == mahuyen
          ? _value.mahuyen
          : mahuyen // ignore: cast_nullable_to_non_nullable
              as String,
      tenhuyen: null == tenhuyen
          ? _value.tenhuyen
          : tenhuyen // ignore: cast_nullable_to_non_nullable
              as String,
      sott: null == sott
          ? _value.sott
          : sott // ignore: cast_nullable_to_non_nullable
              as int,
      show: null == show
          ? _value.show
          : show // ignore: cast_nullable_to_non_nullable
              as bool,
      tentinh: null == tentinh
          ? _value.tentinh
          : tentinh // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HuyenImplCopyWith<$Res> implements $HuyenCopyWith<$Res> {
  factory _$$HuyenImplCopyWith(
          _$HuyenImpl value, $Res Function(_$HuyenImpl) then) =
      __$$HuyenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String mahuyen, String tenhuyen, int sott, bool show, String tentinh});
}

/// @nodoc
class __$$HuyenImplCopyWithImpl<$Res>
    extends _$HuyenCopyWithImpl<$Res, _$HuyenImpl>
    implements _$$HuyenImplCopyWith<$Res> {
  __$$HuyenImplCopyWithImpl(
      _$HuyenImpl _value, $Res Function(_$HuyenImpl) _then)
      : super(_value, _then);

  /// Create a copy of Huyen
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mahuyen = null,
    Object? tenhuyen = null,
    Object? sott = null,
    Object? show = null,
    Object? tentinh = null,
  }) {
    return _then(_$HuyenImpl(
      mahuyen: null == mahuyen
          ? _value.mahuyen
          : mahuyen // ignore: cast_nullable_to_non_nullable
              as String,
      tenhuyen: null == tenhuyen
          ? _value.tenhuyen
          : tenhuyen // ignore: cast_nullable_to_non_nullable
              as String,
      sott: null == sott
          ? _value.sott
          : sott // ignore: cast_nullable_to_non_nullable
              as int,
      show: null == show
          ? _value.show
          : show // ignore: cast_nullable_to_non_nullable
              as bool,
      tentinh: null == tentinh
          ? _value.tentinh
          : tentinh // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HuyenImpl implements _Huyen {
  _$HuyenImpl(
      {required this.mahuyen,
      required this.tenhuyen,
      required this.sott,
      required this.show,
      required this.tentinh});

  factory _$HuyenImpl.fromJson(Map<String, dynamic> json) =>
      _$$HuyenImplFromJson(json);

  @override
  final String mahuyen;
  @override
  final String tenhuyen;
  @override
  final int sott;
  @override
  final bool show;
  @override
  final String tentinh;

  @override
  String toString() {
    return 'Huyen(mahuyen: $mahuyen, tenhuyen: $tenhuyen, sott: $sott, show: $show, tentinh: $tentinh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HuyenImpl &&
            (identical(other.mahuyen, mahuyen) || other.mahuyen == mahuyen) &&
            (identical(other.tenhuyen, tenhuyen) ||
                other.tenhuyen == tenhuyen) &&
            (identical(other.sott, sott) || other.sott == sott) &&
            (identical(other.show, show) || other.show == show) &&
            (identical(other.tentinh, tentinh) || other.tentinh == tentinh));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, mahuyen, tenhuyen, sott, show, tentinh);

  /// Create a copy of Huyen
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HuyenImplCopyWith<_$HuyenImpl> get copyWith =>
      __$$HuyenImplCopyWithImpl<_$HuyenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HuyenImplToJson(
      this,
    );
  }
}

abstract class _Huyen implements Huyen {
  factory _Huyen(
      {required final String mahuyen,
      required final String tenhuyen,
      required final int sott,
      required final bool show,
      required final String tentinh}) = _$HuyenImpl;

  factory _Huyen.fromJson(Map<String, dynamic> json) = _$HuyenImpl.fromJson;

  @override
  String get mahuyen;
  @override
  String get tenhuyen;
  @override
  int get sott;
  @override
  bool get show;
  @override
  String get tentinh;

  /// Create a copy of Huyen
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HuyenImplCopyWith<_$HuyenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
