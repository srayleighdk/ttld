import 'package:ttld/models/nhanvien/nhanvien_model.dart';

class Company {
  final String idDn;
  final String tenDoanhnghiep;
  List<NhanVien>? nhanVienList;

  Company({
    required this.idDn,
    required this.tenDoanhnghiep,
    this.nhanVienList,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        idDn: json['id_dn'],
        tenDoanhnghiep: json['ten_doanhnghiep'],
      );

  Map<String, dynamic> toJson() => {
        'id_dn': idDn,
        'ten_doanhnghiep': tenDoanhnghiep,
      };
}
