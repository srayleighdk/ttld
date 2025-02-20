class NguonThuThap {
  final String idNguonThuThap;
  final String tenNguonThuThap;
  final int displayOrder;
  final bool status;

  NguonThuThap({
    required this.idNguonThuThap,
    required this.tenNguonThuThap,
    required this.displayOrder,
    required this.status,
  });

  factory NguonThuThap.fromJson(Map<String, dynamic> json) {
    return NguonThuThap(
      idNguonThuThap: json['idNguonThuThap'],
      tenNguonThuThap: json['tenNguonThuThap'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idNguonThuThap': idNguonThuThap,
      'tenNguonThuThap': tenNguonThuThap,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
