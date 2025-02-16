import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends Equatable {
  final String idUserGroup;
  final String? parentId;
  final String? name;
  final String? description;
  final int displayOrder;
  final int groupLevel;
  final bool status;

  const Group({
    required this.idUserGroup,
    this.parentId,
    this.name,
    this.description,
    this.displayOrder = 0,
    this.groupLevel = 0,
    this.status = true,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object?> get props => [
        idUserGroup,
        parentId,
        name,
        description,
        displayOrder,
        groupLevel,
        status,
      ];
}
