import 'package:freezed_annotation/freezed_annotation.dart';

part 'chinhsachluong_model.freezed.dart';
part 'chinhsachluong_model.g.dart';

@freezed
class ChinhSachLuong with _$ChinhSachLuong {
  const factory ChinhSachLuong({
    @JsonKey(name: 'Id') int? id,
    String? ten,
    int? vung,
    @JsonKey(name: 'salaryMin') int? salaryMin,
    double? nldBhxh,
    double? nldBhyt,
    double? nldBhtn,
    double? dnBhxh,
    double? dnBhyt,
    double? dnBhtn,
    double? dnThaisan,
    double? dnTnld,
    bool? status,
    String? createdBy,
    DateTime? createdDate,
    String? modifiredBy,
    DateTime? modifiredDate,
  }) = _ChinhSachLuong;

  factory ChinhSachLuong.fromJson(Map<String, dynamic> json) =>
      _$ChinhSachLuongFromJson(json);
}
