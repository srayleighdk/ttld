class TrinhDoHocVan {
  final String hocvanTen;
  final int displayOrder;
  final int idCaphoc;
  final String phanloai;
  final bool status;

  TrinhDoHocVan({
    required this.hocvanTen,
    required this.displayOrder,
    required this.idCaphoc,
    required this.phanloai,
    required this.status,
  });

  factory TrinhDoHocVan.fromJson(Map<String, dynamic> json) {
    return TrinhDoHocVan(
      hocvanTen: json['hocvanTen'],
      displayOrder: json['displayOrder'],
      idCaphoc: json['idCaphoc'],
      phanloai: json['phanloai'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hocvanTen': hocvanTen,
      'displayOrder': displayOrder,
      'idCaphoc': idCaphoc,
      'phanloai': phanloai,
      'status': status,
    };
  }
}
