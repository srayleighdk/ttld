import 'package:freezed_annotation/freezed_annotation.dart';

part 'chinhsachluong_model.freezed.dart';
part 'chinhsachluong_model.g.dart';

@freezed
class ChinhSachLuong with _$ChinhSachLuong {
  const factory ChinhSachLuong({
    @JsonKey(name: 'Id') required int id,
    required String ten,
    required int vung,
    @JsonKey(name: 'salaryMin') required int salaryMin,
    required double nldBhxh,
    required double nldBhyt,
    required double nldBhtn,
    required double dnBhxh,
    required double dnBhyt,
    required double dnBhtn,
    required double dnThaisan,
    required double dnTnld,
    required bool status,
    required String createdBy,
    required DateTime createdDate,
    required String modifiredBy,
    required DateTime modifiredDate,
  }) = _ChinhSachLuong;

  factory ChinhSachLuong.fromJson(Map<String, dynamic> json) =>
      _$ChinhSachLuongFromJson(json);
}
