class HinhThucDoanhNghiep {
  final String tenHinhthuc;
  final String idLhdn;
  final int displayOrder;
  final bool status;

  HinhThucDoanhNghiep({
    required this.tenHinhthuc,
    required this.idLhdn,
    required this.displayOrder,
    required this.status,
  });

  factory HinhThucDoanhNghiep.fromJson(Map<String, dynamic> json) {
    return HinhThucDoanhNghiep(
      tenHinhthuc: json['tenHinhthuc'],
      idLhdn: json['idLhdn'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenHinhthuc': tenHinhthuc,
      'idLhdn': idLhdn,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
