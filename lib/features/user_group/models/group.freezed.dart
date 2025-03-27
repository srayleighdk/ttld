// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  String get idUserGroup => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<UserModel> get users => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  int get groupLevel => throw _privateConstructorUsedError;
  bool get status => throw _privateConstructorUsedError;
  DateTime? get createdDate => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  DateTime? get modifiredDate => throw _privateConstructorUsedError;
  String? get modifiredBy => throw _privateConstructorUsedError;

  /// Serializes this Group to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call(
      {String idUserGroup,
      String? parentId,
      String? name,
      String? description,
      List<UserModel> users,
      int displayOrder,
      int groupLevel,
      bool status,
      DateTime? createdDate,
      String? createdBy,
      DateTime? modifiredDate,
      String? modifiredBy});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUserGroup = null,
    Object? parentId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? users = null,
    Object? displayOrder = null,
    Object? groupLevel = null,
    Object? status = null,
    Object? createdDate = freezed,
    Object? createdBy = freezed,
    Object? modifiredDate = freezed,
    Object? modifiredBy = freezed,
  }) {
    return _then(_value.copyWith(
      idUserGroup: null == idUserGroup
          ? _value.idUserGroup
          : idUserGroup // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      groupLevel: null == groupLevel
          ? _value.groupLevel
          : groupLevel // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiredDate: freezed == modifiredDate
          ? _value.modifiredDate
          : modifiredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifiredBy: freezed == modifiredBy
          ? _value.modifiredBy
          : modifiredBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupImplCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$GroupImplCopyWith(
          _$GroupImpl value, $Res Function(_$GroupImpl) then) =
      __$$GroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String idUserGroup,
      String? parentId,
      String? name,
      String? description,
      List<UserModel> users,
      int displayOrder,
      int groupLevel,
      bool status,
      DateTime? createdDate,
      String? createdBy,
      DateTime? modifiredDate,
      String? modifiredBy});
}

/// @nodoc
class __$$GroupImplCopyWithImpl<$Res>
    extends _$GroupCopyWithImpl<$Res, _$GroupImpl>
    implements _$$GroupImplCopyWith<$Res> {
  __$$GroupImplCopyWithImpl(
      _$GroupImpl _value, $Res Function(_$GroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUserGroup = null,
    Object? parentId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? users = null,
    Object? displayOrder = null,
    Object? groupLevel = null,
    Object? status = null,
    Object? createdDate = freezed,
    Object? createdBy = freezed,
    Object? modifiredDate = freezed,
    Object? modifiredBy = freezed,
  }) {
    return _then(_$GroupImpl(
      idUserGroup: null == idUserGroup
          ? _value.idUserGroup
          : idUserGroup // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      groupLevel: null == groupLevel
          ? _value.groupLevel
          : groupLevel // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiredDate: freezed == modifiredDate
          ? _value.modifiredDate
          : modifiredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifiredBy: freezed == modifiredBy
          ? _value.modifiredBy
          : modifiredBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupImpl implements _Group {
  _$GroupImpl(
      {required this.idUserGroup,
      this.parentId,
      this.name,
      this.description,
      final List<UserModel> users = const [],
      this.displayOrder = 0,
      this.groupLevel = 1,
      this.status = true,
      this.createdDate,
      this.createdBy,
      this.modifiredDate,
      this.modifiredBy})
      : _users = users;

  factory _$GroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupImplFromJson(json);

  @override
  final String idUserGroup;
  @override
  final String? parentId;
  @override
  final String? name;
  @override
  final String? description;
  final List<UserModel> _users;
  @override
  @JsonKey()
  List<UserModel> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey()
  final int displayOrder;
  @override
  @JsonKey()
  final int groupLevel;
  @override
  @JsonKey()
  final bool status;
  @override
  final DateTime? createdDate;
  @override
  final String? createdBy;
  @override
  final DateTime? modifiredDate;
  @override
  final String? modifiredBy;

  @override
  String toString() {
    return 'Group(idUserGroup: $idUserGroup, parentId: $parentId, name: $name, description: $description, users: $users, displayOrder: $displayOrder, groupLevel: $groupLevel, status: $status, createdDate: $createdDate, createdBy: $createdBy, modifiredDate: $modifiredDate, modifiredBy: $modifiredBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupImpl &&
            (identical(other.idUserGroup, idUserGroup) ||
                other.idUserGroup == idUserGroup) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.groupLevel, groupLevel) ||
                other.groupLevel == groupLevel) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.modifiredDate, modifiredDate) ||
                other.modifiredDate == modifiredDate) &&
            (identical(other.modifiredBy, modifiredBy) ||
                other.modifiredBy == modifiredBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idUserGroup,
      parentId,
      name,
      description,
      const DeepCollectionEquality().hash(_users),
      displayOrder,
      groupLevel,
      status,
      createdDate,
      createdBy,
      modifiredDate,
      modifiredBy);

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      __$$GroupImplCopyWithImpl<_$GroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupImplToJson(
      this,
    );
  }
}

abstract class _Group implements Group {
  factory _Group(
      {required final String idUserGroup,
      final String? parentId,
      final String? name,
      final String? description,
      final List<UserModel> users,
      final int displayOrder,
      final int groupLevel,
      final bool status,
      final DateTime? createdDate,
      final String? createdBy,
      final DateTime? modifiredDate,
      final String? modifiredBy}) = _$GroupImpl;

  factory _Group.fromJson(Map<String, dynamic> json) = _$GroupImpl.fromJson;

  @override
  String get idUserGroup;
  @override
  String? get parentId;
  @override
  String? get name;
  @override
  String? get description;
  @override
  List<UserModel> get users;
  @override
  int get displayOrder;
  @override
  int get groupLevel;
  @override
  bool get status;
  @override
  DateTime? get createdDate;
  @override
  String? get createdBy;
  @override
  DateTime? get modifiredDate;
  @override
  String? get modifiredBy;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
