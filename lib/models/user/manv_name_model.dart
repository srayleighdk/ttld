import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class ManvNameModel extends GenericPickerItem {
  ManvNameModel({
    required String manv,
    required String name,
  }) : super(id: manv, displayName: name);

  factory ManvNameModel.fromJson(Map<String, dynamic> json) {
    return ManvNameModel(
      manv: json['manv'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manv'] = id;
    data['name'] = displayName;
    return data;
  }
}
