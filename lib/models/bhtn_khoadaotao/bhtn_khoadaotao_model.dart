import 'package:freezed_annotation/freezed_annotation.dart';

part 'bhtn_khoadaotao_model.freezed.dart';
part 'bhtn_khoadaotao_model.g.dart';

@freezed
class BhtnKhoadaotao with _$BhtnKhoadaotao {
  const BhtnKhoadaotao._();

  const factory BhtnKhoadaotao({
    @JsonKey(name: 'IdKhoadaotao') int? idKhoadaotao,
    @JsonKey(name: 'Idcosodaotao') int? idcosodaotao,
    @JsonKey(name: 'IdNgheDaoTao') int? idNgheDaoTao,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'IDBhtn') String? idBhtn,
    @JsonKey(name: 'Hocphi') double? hocphi,
    @JsonKey(name: 'Sothangdaotao') double? sothangdaotao,
    @JsonKey(name: 'DisplayOrder') int? displayOrder,
    @JsonKey(name: 'Status') bool? status,
    @JsonKey(name: 'PortalID') int? portalId,
    @JsonKey(name: 'Updated') DateTime? updated,
    @JsonKey(name: 'IsDeleted') bool? isDeleted,
    @JsonKey(name: 'ngheDaoTao') NganhNgheDaoTaoInfo? ngheDaoTao,
  }) = _BhtnKhoadaotao;

  factory BhtnKhoadaotao.fromJson(Map<String, dynamic> json) =>
      _$BhtnKhoadaotaoFromJson(json);
}

@freezed
class NganhNgheDaoTaoInfo with _$NganhNgheDaoTaoInfo {
  const factory NganhNgheDaoTaoInfo({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'nn_ten') String? nnTen,
    @JsonKey(name: 'IdBachoc') String? bachoc,
  }) = _NganhNgheDaoTaoInfo;

  factory NganhNgheDaoTaoInfo.fromJson(Map<String, dynamic> json) =>
      _$NganhNgheDaoTaoInfoFromJson(json);
}
