class LoaiHinh {
  final String idLhdn;
  final String tenLoaiHinh;
  final int displayOrder;
  final bool status;

  LoaiHinh({
    required this.idLhdn,
    required this.tenLoaiHinh,
    required this.displayOrder,
    required this.status,
  });

  factory LoaiHinh.fromJson(Map<String, dynamic> json) {
    return LoaiHinh(
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
