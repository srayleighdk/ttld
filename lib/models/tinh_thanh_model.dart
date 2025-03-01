class TinhThanhModel {
  int? tpId;
  String? tpTen;
  int? displayOrder;
  bool? status;
  String? matinh;

  TinhThanhModel({
    this.tpId,
    this.tpTen,
    this.displayOrder,
    this.status,
    this.matinh,
  });

  factory TinhThanhModel.fromJson(Map<String, dynamic> json) {
    return TinhThanhModel(
      tpId: json['tpId'],
      tpTen: json['tpTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
      matinh: json['matinh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tpId': tpId,
      'tpTen': tpTen,
      'displayOrder': displayOrder,
      'status': status,
      'matinh': matinh,
    };
  }
}