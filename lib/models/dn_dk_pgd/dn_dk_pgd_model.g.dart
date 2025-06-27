// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dn_dk_pgd_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DnDkPgd _$DnDkPgdFromJson(Map<String, dynamic> json) => DnDkPgd(
      id: json['id'] as String?,
      idDoanhnghiep: json['idDoanhnghiep'] as String?,
      dksgdUsername: json['dksgdUsername'] as String?,
      dksgdEmail: json['dksgdEmail'] as String?,
      dksgdTen: json['dksgdTen'] as String?,
      dksgdTentat: json['dksgdTentat'] as String?,
      maHoSo: json['maHoSo'] as String?,
      dksgdNguoilienhe: json['dksgdNguoilienhe'],
      dksgdWebsite: json['dksgdWebsite'],
      dksgdSolaodong: (json['dksgdSolaodong'] as num?)?.toInt(),
      dksgdNganhnghekinhdoanh: json['dksgdNganhnghekinhdoanh'],
      dksgdDienthoai: json['dksgdDienthoai'],
      dksgdFax: json['dksgdFax'],
      dksgdDiachichitiet: json['dksgdDiachichitiet'],
      dksgddmHinhthucthamgia: json['dksgddmHinhthucthamgia'],
      dksgdNganhnghe: json['dksgdNganhnghe'],
      dksgdGhichu: json['dksgdGhichu'],
      dksgdSolanxem: json['dksgdSolanxem'],
      dksgdHienthi: json['dksgdHienthi'] as bool?,
      dksgdhtNlh: json['dksgdhtNlh'] as bool?,
      dksgdhtTelephone: json['dksgdhtTelephone'] as bool?,
      dksgdhtWeb: json['dksgdhtWeb'] as bool?,
      dksgdhtFax: json['dksgdhtFax'] as bool?,
      dksgdhtEmail: json['dksgdhtEmail'] as bool?,
      dksgdhtAddress: json['dksgdhtAddress'] as bool?,
      dksgdhtName: json['dksgdhtName'] as bool?,
      dksgdDuyet: json['dksgdDuyet'],
      dksgddmHinhthucdoanhnghiep: json['dksgddmHinhthucdoanhnghiep'],
      dksgddmPhiengiaodichlan: json['dksgddmPhiengiaodichlan'],
      dksgddmPhiengiaodichlanTen: json['dksgddmPhiengiaodichlanTen'],
      dksgddmHinhthucdoanhnghiepTen: json['dksgddmHinhthucdoanhnghiepTen'],
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'],
      modifiredDate: json['modifiredDate'] == null
          ? null
          : DateTime.parse(json['modifiredDate'] as String),
      modifiredBy: json['modifiredBy'],
    );

Map<String, dynamic> _$DnDkPgdToJson(DnDkPgd instance) => <String, dynamic>{
      'id': instance.id,
      'idDoanhnghiep': instance.idDoanhnghiep,
      'dksgdUsername': instance.dksgdUsername,
      'dksgdEmail': instance.dksgdEmail,
      'dksgdTen': instance.dksgdTen,
      'dksgdTentat': instance.dksgdTentat,
      'maHoSo': instance.maHoSo,
      'dksgdNguoilienhe': instance.dksgdNguoilienhe,
      'dksgdWebsite': instance.dksgdWebsite,
      'dksgdSolaodong': instance.dksgdSolaodong,
      'dksgdNganhnghekinhdoanh': instance.dksgdNganhnghekinhdoanh,
      'dksgdDienthoai': instance.dksgdDienthoai,
      'dksgdFax': instance.dksgdFax,
      'dksgdDiachichitiet': instance.dksgdDiachichitiet,
      'dksgddmHinhthucthamgia': instance.dksgddmHinhthucthamgia,
      'dksgdNganhnghe': instance.dksgdNganhnghe,
      'dksgdGhichu': instance.dksgdGhichu,
      'dksgdSolanxem': instance.dksgdSolanxem,
      'dksgdHienthi': instance.dksgdHienthi,
      'dksgdhtNlh': instance.dksgdhtNlh,
      'dksgdhtTelephone': instance.dksgdhtTelephone,
      'dksgdhtWeb': instance.dksgdhtWeb,
      'dksgdhtFax': instance.dksgdhtFax,
      'dksgdhtEmail': instance.dksgdhtEmail,
      'dksgdhtAddress': instance.dksgdhtAddress,
      'dksgdhtName': instance.dksgdhtName,
      'dksgdDuyet': instance.dksgdDuyet,
      'dksgddmHinhthucdoanhnghiep': instance.dksgddmHinhthucdoanhnghiep,
      'dksgddmPhiengiaodichlan': instance.dksgddmPhiengiaodichlan,
      'dksgddmPhiengiaodichlanTen': instance.dksgddmPhiengiaodichlanTen,
      'dksgddmHinhthucdoanhnghiepTen': instance.dksgddmHinhthucdoanhnghiepTen,
      'createdDate': instance.createdDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiredDate': instance.modifiredDate?.toIso8601String(),
      'modifiredBy': instance.modifiredBy,
    };
