// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ntd_tuyendung_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NTDTuyenDungImpl _$$NTDTuyenDungImplFromJson(Map<String, dynamic> json) =>
    _$NTDTuyenDungImpl(
      idTuyenDung: json['idTuyenDung'] as String?,
      tdTieude: json['tdTieude'] as String?,
      tdChucDanh: (json['tdChucDanh'] as num?)?.toInt(),
      tdNganhkhac: json['tdNganhkhac'] as String?,
      tdSoluong: (json['tdSoluong'] as num?)?.toInt(),
      tdMotacongviec: json['tdMotacongviec'] as String?,
      tdMotayeucau: json['tdMotayeucau'] as String?,
      tdQuyenloi: json['tdQuyenloi'] as String?,
      tdGhichu: json['tdGhichu'] as String?,
      tdLuongkhoidiem: (json['tdLuongkhoidiem'] as num?)?.toInt(),
      ngayNhanHoSo: json['ngayNhanHoSo'] as String?,
      ngayHetNhanHoSo: json['ngayHetNhanHoSo'] as String?,
      isDenKhiTuyenXong: json['isDenKhiTuyenXong'] as bool?,
      tdNoinophoso: json['tdNoinophoso'] as String?,
      tdHosobaogom: json['tdHosobaogom'] as String?,
      tdYeuCauChieuCao: (json['tdYeuCauChieuCao'] as num?)?.toInt(),
      tdYeucauKinhnghiem: (json['tdYeucauKinhnghiem'] as num?)?.toInt(),
      tdYeucauTuoiMin: (json['tdYeucauTuoiMin'] as num?)?.toInt(),
      tdYeucauTuoiMax: (json['tdYeucauTuoiMax'] as num?)?.toInt(),
      tdLanxem: (json['tdLanxem'] as num?)?.toInt(),
      tdDuyet: json['tdDuyet'] as bool?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'] as String?,
      modifiredDate: json['modifiredDate'] == null
          ? null
          : DateTime.parse(json['modifiredDate'] as String),
      modifiredBy: json['modifiredBy'] as String?,
      tdId: json['tdId'] as String?,
      tdIdDoanhnghiep: json['tdIdDoanhnghiep'] as String?,
      nguonThuThap: json['nguonThuThap'] as String?,
      soLuongDat: (json['soLuongDat'] as num?)?.toInt(),
      soLuongKhongDat: (json['soLuongKhongDat'] as num?)?.toInt(),
      soLuongChoKetQua: (json['soLuongChoKetQua'] as num?)?.toInt(),
      idMucLuong: (json['idMucLuong'] as num?)?.toInt(),
      idDoTuoi: (json['idDoTuoi'] as num?)?.toInt(),
      doanhNghiepYeuCau: json['doanhNghiepYeuCau'] as String?,
      idDoituongCs: (json['idDoituongCs'] as num?)?.toInt(),
      idphieut11: json['idphieut11'] as String?,
      idDoanhNghiep: json['idDoanhNghiep'] as String?,
      tdNoilamviec: (json['tdNoilamviec'] as num?)?.toInt(),
      tdNganhnghe: (json['tdNganhnghe'] as num?)?.toInt(),
      tdYeuCauHocVan: (json['tdYeuCauHocVan'] as num?)?.toInt(),
      tdThoigianlamviec: (json['tdThoigianlamviec'] as num?)?.toInt(),
      idKinhnghiem: json['idKinhnghiem'] as String?,
      idBacHoc: json['idBacHoc'] as String?,
      idKynang: json['idKynang'] as String?,
      idHinhthucLv: json['idHinhthucLv'] as String?,
      tdYeuCauTinHoc: json['tdYeuCauTinHoc'] as String?,
      tdYeuCauNgoaiNgu: json['tdYeuCauNgoaiNgu'] as String?,
      tdYeuCauGioiTinh: (json['tdYeuCauGioiTinh'] as num?)?.toInt(),
      maHoso: json['maHoso'] as String?,
      nguoiLienhe: json['nguoiLienhe'] as String?,
      soDienthoai: json['soDienthoai'] as String?,
      diaChiDn: json['diaChiDn'] as String?,
      tenDoanhNghiep: json['tenDoanhNghiep'] as String?,
      noiLamviec: json['noiLamviec'] as String?,
      tenNganhnghe: json['tenNganhnghe'] as String?,
      mucLuong: json['mucLuong'] as String?,
    );

Map<String, dynamic> _$$NTDTuyenDungImplToJson(_$NTDTuyenDungImpl instance) =>
    <String, dynamic>{
      'idTuyenDung': instance.idTuyenDung,
      'tdTieude': instance.tdTieude,
      'tdChucDanh': instance.tdChucDanh,
      'tdNganhkhac': instance.tdNganhkhac,
      'tdSoluong': instance.tdSoluong,
      'tdMotacongviec': instance.tdMotacongviec,
      'tdMotayeucau': instance.tdMotayeucau,
      'tdQuyenloi': instance.tdQuyenloi,
      'tdGhichu': instance.tdGhichu,
      'tdLuongkhoidiem': instance.tdLuongkhoidiem,
      'ngayNhanHoSo': instance.ngayNhanHoSo,
      'ngayHetNhanHoSo': instance.ngayHetNhanHoSo,
      'isDenKhiTuyenXong': instance.isDenKhiTuyenXong,
      'tdNoinophoso': instance.tdNoinophoso,
      'tdHosobaogom': instance.tdHosobaogom,
      'tdYeuCauChieuCao': instance.tdYeuCauChieuCao,
      'tdYeucauKinhnghiem': instance.tdYeucauKinhnghiem,
      'tdYeucauTuoiMin': instance.tdYeucauTuoiMin,
      'tdYeucauTuoiMax': instance.tdYeucauTuoiMax,
      'tdLanxem': instance.tdLanxem,
      'tdDuyet': instance.tdDuyet,
      'createdDate': instance.createdDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiredDate': instance.modifiredDate?.toIso8601String(),
      'modifiredBy': instance.modifiredBy,
      'tdId': instance.tdId,
      'tdIdDoanhnghiep': instance.tdIdDoanhnghiep,
      'nguonThuThap': instance.nguonThuThap,
      'soLuongDat': instance.soLuongDat,
      'soLuongKhongDat': instance.soLuongKhongDat,
      'soLuongChoKetQua': instance.soLuongChoKetQua,
      'idMucLuong': instance.idMucLuong,
      'idDoTuoi': instance.idDoTuoi,
      'doanhNghiepYeuCau': instance.doanhNghiepYeuCau,
      'idDoituongCs': instance.idDoituongCs,
      'idphieut11': instance.idphieut11,
      'idDoanhNghiep': instance.idDoanhNghiep,
      'tdNoilamviec': instance.tdNoilamviec,
      'tdNganhnghe': instance.tdNganhnghe,
      'tdYeuCauHocVan': instance.tdYeuCauHocVan,
      'tdThoigianlamviec': instance.tdThoigianlamviec,
      'idKinhnghiem': instance.idKinhnghiem,
      'idBacHoc': instance.idBacHoc,
      'idKynang': instance.idKynang,
      'idHinhthucLv': instance.idHinhthucLv,
      'tdYeuCauTinHoc': instance.tdYeuCauTinHoc,
      'tdYeuCauNgoaiNgu': instance.tdYeuCauNgoaiNgu,
      'tdYeuCauGioiTinh': instance.tdYeuCauGioiTinh,
      'maHoso': instance.maHoso,
      'nguoiLienhe': instance.nguoiLienhe,
      'soDienthoai': instance.soDienthoai,
      'diaChiDn': instance.diaChiDn,
      'tenDoanhNghiep': instance.tenDoanhNghiep,
      'noiLamviec': instance.noiLamviec,
      'tenNganhnghe': instance.tenNganhnghe,
      'mucLuong': instance.mucLuong,
    };
