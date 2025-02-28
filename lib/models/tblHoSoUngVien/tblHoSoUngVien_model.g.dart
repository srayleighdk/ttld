// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tblHoSoUngVien_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TblHoSoUngVienModelImpl _$$TblHoSoUngVienModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TblHoSoUngVienModelImpl(
      id: json['id'] as String,
      uvUsername: json['uvUsername'] as String?,
      uvPassword: json['uvPassword'] as String?,
      uvHoten: json['uvHoten'] as String?,
      uvEmail: json['uvEmail'] as String?,
      maHoSo: json['maHoSo'] as String?,
      idDanToc: (json['idDanToc'] as num?)?.toInt(),
      cvMongMuon: json['cvMongMuon'] as String?,
      documentPath: json['documentPath'] as String?,
      imagePath: json['imagePath'] as String?,
      uvDiachichitiet: json['uvDiachichitiet'] as String?,
      uvDienthoai: json['uvDienthoai'] as String?,
      uvSoCMND: json['uvSoCMND'] as String?,
      uvNgaycap: json['uvNgaycap'] == null
          ? null
          : DateTime.parse(json['uvNgaycap'] as String),
      uvNoicap: json['uvNoicap'] as String?,
      uvGioitinh: (json['uvGioitinh'] as num?)?.toInt(),
      uvChieucao: json['uvChieucao'] as String?,
      uvCannang: json['uvCannang'] as String?,
      uvNgaysinh: json['uvNgaysinh'] == null
          ? null
          : DateTime.parse(json['uvNgaysinh'] as String),
      uvcmCongviechientai: json['uvcmCongviechientai'] as String?,
      uvnvNganhnghe: json['uvnvNganhnghe'] as String?,
      uvnvNoilamviec: json['uvnvNoilamviec'] as String?,
      idMucluong: (json['idMucluong'] as num?)?.toInt(),
      uvnvTienluong: (json['uvnvTienluong'] as num?)?.toDouble(),
      uvGhichu: json['uvGhichu'] as String?,
      uvcmBangcap: json['uvcmBangcap'] as String?,
      uvcmKynang: json['uvcmKynang'] as String?,
      uvcmTrinhdongoaingu: json['uvcmTrinhdongoaingu'] as String?,
      uvcmTrinhdotinhoc: json['uvcmTrinhdotinhoc'] as String?,
      uvcmKinhnghiem: (json['uvcmKinhnghiem'] as num?)?.toInt() ?? 0,
      uvSolanxem: (json['uvSolanxem'] as num?)?.toInt() ?? 0,
      interview: (json['interview'] as num?)?.toInt() ?? 0,
      interviewed: (json['interviewed'] as num?)?.toInt() ?? 0,
      uvDuyet: json['uvDuyet'] as bool? ?? false,
      uvHienthi: json['uvHienthi'] as bool? ?? false,
      uvhtTelephone: json['uvhtTelephone'] as bool? ?? false,
      uvhtEmail: json['uvhtEmail'] as bool? ?? false,
      uvhtAddress: json['uvhtAddress'] as bool? ?? false,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'] as String?,
      modifiredDate: json['modifiredDate'] == null
          ? null
          : DateTime.parse(json['modifiredDate'] as String),
      modifiredBy: json['modifiredBy'] as String?,
      uvId: json['uvId'] as String?,
      newsletterSubscription: json['newsletterSubscription'] as bool? ?? false,
      jobsletterSubscription: json['jobsletterSubscription'] as bool? ?? false,
      coBHTN: json['coBHTN'] as bool?,
      soNhaDuong: json['soNhaDuong'] as String?,
      idThanhPho: (json['idThanhPho'] as num?)?.toInt(),
      idTinh: json['idTinh'] as String?,
      idHuyen: json['idHuyen'] as String?,
      idXa: json['idXa'] as String?,
      idTv: json['idTv'] as String?,
      mahoGD: json['mahoGD'] as String?,
      fileCV: json['fileCV'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      ngayduyet: json['ngayduyet'] == null
          ? null
          : DateTime.parse(json['ngayduyet'] as String),
      idNguonThuThap: json['idNguonThuThap'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      idBacHoc: json['idBacHoc'] as String?,
      diachilienhe: json['diachilienhe'] as String?,
      uvnvNganhngheId: (json['uvnvNganhngheId'] as num?)?.toInt(),
      uvcmTrinhdoId: (json['uvcmTrinhdoId'] as num?)?.toInt(),
      uvDoituongchinhsachId: (json['uvDoituongchinhsachId'] as num?)?.toInt(),
      uvnvThoigianId: (json['uvnvThoigianId'] as num?)?.toInt(),
      uvnvVitrimongmuonid: (json['uvnvVitrimongmuonid'] as num?)?.toInt(),
      uvHonnhanId: json['uvHonnhanId'] as bool? ?? false,
      tenDanToc: json['tenDanToc'] as String?,
      uvTinhtrangtantatId: (json['uvTinhtrangtantatId'] as num?)?.toInt(),
      uvnvHinhthuccongtyId: (json['uvnvHinhthuccongtyId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TblHoSoUngVienModelImplToJson(
        _$TblHoSoUngVienModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uvUsername': instance.uvUsername,
      'uvPassword': instance.uvPassword,
      'uvHoten': instance.uvHoten,
      'uvEmail': instance.uvEmail,
      'maHoSo': instance.maHoSo,
      'idDanToc': instance.idDanToc,
      'cvMongMuon': instance.cvMongMuon,
      'documentPath': instance.documentPath,
      'imagePath': instance.imagePath,
      'uvDiachichitiet': instance.uvDiachichitiet,
      'uvDienthoai': instance.uvDienthoai,
      'uvSoCMND': instance.uvSoCMND,
      'uvNgaycap': instance.uvNgaycap?.toIso8601String(),
      'uvNoicap': instance.uvNoicap,
      'uvGioitinh': instance.uvGioitinh,
      'uvChieucao': instance.uvChieucao,
      'uvCannang': instance.uvCannang,
      'uvNgaysinh': instance.uvNgaysinh?.toIso8601String(),
      'uvcmCongviechientai': instance.uvcmCongviechientai,
      'uvnvNganhnghe': instance.uvnvNganhnghe,
      'uvnvNoilamviec': instance.uvnvNoilamviec,
      'idMucluong': instance.idMucluong,
      'uvnvTienluong': instance.uvnvTienluong,
      'uvGhichu': instance.uvGhichu,
      'uvcmBangcap': instance.uvcmBangcap,
      'uvcmKynang': instance.uvcmKynang,
      'uvcmTrinhdongoaingu': instance.uvcmTrinhdongoaingu,
      'uvcmTrinhdotinhoc': instance.uvcmTrinhdotinhoc,
      'uvcmKinhnghiem': instance.uvcmKinhnghiem,
      'uvSolanxem': instance.uvSolanxem,
      'interview': instance.interview,
      'interviewed': instance.interviewed,
      'uvDuyet': instance.uvDuyet,
      'uvHienthi': instance.uvHienthi,
      'uvhtTelephone': instance.uvhtTelephone,
      'uvhtEmail': instance.uvhtEmail,
      'uvhtAddress': instance.uvhtAddress,
      'createdDate': instance.createdDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiredDate': instance.modifiredDate?.toIso8601String(),
      'modifiredBy': instance.modifiredBy,
      'uvId': instance.uvId,
      'newsletterSubscription': instance.newsletterSubscription,
      'jobsletterSubscription': instance.jobsletterSubscription,
      'coBHTN': instance.coBHTN,
      'soNhaDuong': instance.soNhaDuong,
      'idThanhPho': instance.idThanhPho,
      'idTinh': instance.idTinh,
      'idHuyen': instance.idHuyen,
      'idXa': instance.idXa,
      'idTv': instance.idTv,
      'mahoGD': instance.mahoGD,
      'fileCV': instance.fileCV,
      'displayOrder': instance.displayOrder,
      'ngayduyet': instance.ngayduyet?.toIso8601String(),
      'idNguonThuThap': instance.idNguonThuThap,
      'avatarUrl': instance.avatarUrl,
      'idBacHoc': instance.idBacHoc,
      'diachilienhe': instance.diachilienhe,
      'uvnvNganhngheId': instance.uvnvNganhngheId,
      'uvcmTrinhdoId': instance.uvcmTrinhdoId,
      'uvDoituongchinhsachId': instance.uvDoituongchinhsachId,
      'uvnvThoigianId': instance.uvnvThoigianId,
      'uvnvVitrimongmuonid': instance.uvnvVitrimongmuonid,
      'uvHonnhanId': instance.uvHonnhanId,
      'tenDanToc': instance.tenDanToc,
      'uvTinhtrangtantatId': instance.uvTinhtrangtantatId,
      'uvnvHinhthuccongtyId': instance.uvnvHinhthuccongtyId,
    };
