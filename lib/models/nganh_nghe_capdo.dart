import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class NganhNgheCapDo extends GenericPickerItem {
  final int groupId;
  final dynamic level1;
  final dynamic level2;
  final dynamic level3;
  final dynamic level4;
  final dynamic level5;
  final dynamic displayOrder;
  final bool status;

  NganhNgheCapDo({
    required int super.id,
    required String name,
    required this.groupId,
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
    required this.level5,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory NganhNgheCapDo.fromJson(Map<String, dynamic> json) {
    return NganhNgheCapDo(
      id: json['id'],
      name: json['name'],
      groupId: json['groupId'],
      level1: json['level1'],
      level2: json['level2'],
      level3: json['level3'],
      level4: json['level4'],
      level5: json['level5'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'groupId': groupId,
      'level1': level1,
      'level2': level2,
      'level3': level3,
      'level4': level4,
      'level5': level5,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
