import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class KinhNghiemLamViec implements GenericPickerItem {
  final String id;
  final String displayName;

  KinhNghiemLamViec({
    required this.id,
    required this.displayName,
  });

  factory KinhNghiemLamViec.fromJson(Map<String, dynamic> json) {
    return KinhNghiemLamViec(
      id: json['id'] as String,
      displayName: json['ten'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': displayName,
    };
  }

  @override
  String get title => displayName;

  @override
  String get value => id;
}
