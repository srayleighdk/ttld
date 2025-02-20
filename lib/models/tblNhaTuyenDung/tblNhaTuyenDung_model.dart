import 'package:freezed_annotation/freezed_annotation.dart';

part 'tblNhaTuyenDung_model.freezed.dart';
part 'tblNhaTuyenDung_model.g.dart';

@freezed
class NtdModel with _$NtdModel {
  const factory NtdModel({
    required String? idDoanhNghiep,
    String? username,
    String? password,
    required String ntdMadn,
    String? ntdTentat,
    String? ntdTen,
    String? imagePath,
    String? mst,
    int? ntdHinhThucDoanhNghiep,
    int? ntdSoLaoDong,
    String? ntdGioiThieu,
    int? ntdKdnId,
    String? ntdThuocKhuCongNghiep,
    String? ntdDiaChiThanhPho,
    String? ntdDiaChiHuyen,
    String? ntdDiaChiXaPhuong,
    String? ntdDiaChiChiTiet,
    String? ntdNguoiLienHe,
    int? ntdChucVu,
    String? ntdDienThoai,
    String? ntdFax,
    String? ntdEmail,
    String? ntdWebsite,
    @Default(false) bool ntdDuyet,
    @Default(false) bool ntdTopBlock,
    String? ntdQuocGia,
    int? ntdNamThanhLap,
    String? ntdLinhVucHoatDong,
    @Default(false) bool ntdhtNlh,
    @Default(false) bool ntdhtTelephone,
    @Default(false) bool ntdhtWeb,
    @Default(false) bool ntdhtFax,
    @Default(false) bool ntdhtEmail,
    @Default(false) bool ntdhtAddress,
    @Default('system') String createdBy,
    @Default('system') String modifiredBy,
    required DateTime createdDate,
    required DateTime modifiredDate,
    String? ntdId,
    @Default(false) bool newsletterSubscription,
    @Default(false) bool jobsletterSubscription,
    int? ntdLoai,
    String? nongThonThanhThi,
    String? idLoaiHinhDoanhNghiep,
    String? idNganhKinhTe,
    int? idThoiGianHoatDong,
    required int? idStatus,
    required int? displayOrder,
  }) = _NtdModel;

  factory NtdModel.fromJson(Map<String, dynamic> json) => NtdModel(
        idDoanhNghiep: json['idDoanhNghiep']?.toString(),
        username: json['username'] as String?,
        password: json['password'] as String?,
        ntdMadn: json['ntdMadn'] as String,
        ntdTentat: json['ntdTentat'] as String?,
        ntdTen: json['ntdTen'] as String?,
        imagePath: json['imagePath'] as String?,
        mst: json['mst'] as String?,
        ntdHinhThucDoanhNghiep: json['ntdHinhThucDoanhNghiep'] == null
            ? null
            : int.tryParse(json['ntdHinhThucDoanhNghiep'].toString()),
        ntdSoLaoDong: json['ntdSoLaoDong'] == null
            ? null
            : int.tryParse(json['ntdSoLaoDong'].toString()),
        ntdGioiThieu: json['ntdGioithieu'] as String?,
        ntdKdnId: json['ntdKdnId'] == null
            ? null
            : int.tryParse(json['ntdKdnId'].toString()),
        ntdThuocKhuCongNghiep: json['ntdThuockhucongnghiep'] as String?,
        ntdDiaChiThanhPho: json['ntdDiachithanhpho'] == "null"
            ? null
            : json['ntdDiachithanhpho'] as String?,
        ntdDiaChiHuyen: json['ntdDiachihuyen'] as String?,
        ntdDiaChiXaPhuong: json['ntdDiachixaphuong'] as String?,
        ntdDiaChiChiTiet: json['ntdDiachichitiet'] as String?,
        ntdNguoiLienHe: json['ntdNguoilienhe'] as String?,
        ntdChucVu: json['ntdChucvu'] == null
            ? null
            : int.tryParse(json['ntdChucvu'].toString()),
        ntdDienThoai: json['ntdDienthoai'] as String?,
        ntdFax: json['ntdFax'] as String?,
        ntdEmail: json['ntdEmail'] as String?,
        ntdWebsite: json['ntdWebsite'] as String?,
        ntdDuyet: json['ntdDuyet'] as bool? ?? false,
        ntdTopBlock: json['ntdTopblock'] as bool? ?? false,
        ntdQuocGia: json['ntdQuocgia'] as String?,
        ntdNamThanhLap: json['ntdNamthanhlap'] == null
            ? null
            : int.tryParse(json['ntdNamthanhlap'].toString()),
        ntdLinhVucHoatDong: json['ntdLinhvuchoatdong'] as String?,
        ntdhtNlh: json['ntdhtNlh'] as bool? ?? false,
        ntdhtTelephone: json['ntdhtTelephone'] as bool? ?? false,
        ntdhtWeb: json['ntdhtWeb'] as bool? ?? false,
        ntdhtFax: json['ntdhtFax'] as bool? ?? false,
        ntdhtEmail: json['ntdhtEmail'] as bool? ?? false,
        ntdhtAddress: json['ntdhtAddress'] as bool? ?? false,
        createdBy: json['createdBy'] as String? ?? 'system',
        modifiredBy: json['modifiredBy'] as String? ?? 'system',
        createdDate: DateTime.parse(json['createdDate'] as String),
        modifiredDate: DateTime.parse(json['modifiredDate'] as String),
        ntdId: json['ntdId'] as String?,
        newsletterSubscription:
            json['newsletterSubscription'] as bool? ?? false,
        jobsletterSubscription: json['jobsletterSubscription'] as bool? ?? false,
        ntdLoai: json['ntdLoai'] == null
            ? null
            : int.tryParse(json['ntdLoai'].toString()),
        nongThonThanhThi: json['nongThonThanhThi'] as String?,
        idLoaiHinhDoanhNghiep: json['idLoaiHinhDoanhNghiep'] as String?,
        idNganhKinhTe: json['idNganhKinhTe'] as String?,
        idThoiGianHoatDong: json['idThoiGianHoatDong'] == null
            ? null
            : int.tryParse(json['idThoiGianHoatDong'].toString()),
        idStatus: json['idStatus'] == null
            ? null
            : int.tryParse(json['idStatus'].toString()),
        displayOrder: json['displayOrder'] == null
            ? null
            : int.tryParse(json['displayOrder'].toString()),
      );
}
