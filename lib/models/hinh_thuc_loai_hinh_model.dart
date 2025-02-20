class HinhThucLoaiHinh {
  final String idLhdn;
  final String tenLoaiHinh;
  final int displayOrder;
  final bool status;

  HinhThucLoaiHinh({
    required this.idLhdn,
    required this.tenLoaiHinh,
    required this.displayOrder,
    required this.status,
  });

  factory HinhThucLoaiHinh.fromJson(Map<String, dynamic> json) {
    return HinhThucLoaiHinh(
      idLhdn: json['idLhdn'],
      tenLoaiHinh: json['tenLoaiHinh'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idLhdn': idLhdn,
      'tenLoaiHinh': tenLoaiHinh,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
