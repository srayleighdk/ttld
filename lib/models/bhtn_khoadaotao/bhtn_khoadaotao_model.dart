import 'package:freezed_annotation/freezed_annotation.dart';

part 'bhtn_khoadaotao_model.freezed.dart';
part 'bhtn_khoadaotao_model.g.dart';

@freezed
class BhtnKhoadaotao with _$BhtnKhoadaotao {
  const BhtnKhoadaotao._();

  const factory BhtnKhoadaotao({
    @JsonKey(name: 'IdKhoadaotao') int? idKhoadaotao,
    @JsonKey(name: 'Idcosodaotao') int? idcosodaotao,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'IDBhtn') String? idBhtn,
    @JsonKey(name: 'Hocphi') double? hocphi,
    @JsonKey(name: 'Sothangdaotao') double? sothangdaotao,
    @JsonKey(name: 'DisplayOrder') int? displayOrder,
    @JsonKey(name: 'Status') bool? status,
    @JsonKey(name: 'PortalID') int? portalId,
    @JsonKey(name: 'Updated') DateTime? updated,
    @JsonKey(name: 'IsDeleted') bool? isDeleted,
  }) = _BhtnKhoadaotao;

  factory BhtnKhoadaotao.fromJson(Map<String, dynamic> json) =>
      _$BhtnKhoadaotaoFromJson(json);
}
