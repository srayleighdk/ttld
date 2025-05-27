import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class NganhNgheChuyenNganh extends GenericPickerItem {
  final int sott;
  final bool show;

  NganhNgheChuyenNganh({
    required super.id,
    required String name,
    required this.sott,
    required this.show,
  }) : super(displayName: name);

  factory NganhNgheChuyenNganh.fromJson(Map<String, dynamic> json) {
    return NganhNgheChuyenNganh(
      sott: json['sott'],
      name: json['name'],
      id: json['id'],
      show: json['show'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'sott': sott,
      'show': show,
    };
  }
}
