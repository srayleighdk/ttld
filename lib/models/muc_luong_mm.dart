
class MucLuongMM {
  final int idMucLuong;
  final String tenMucLuong;
  final int displayOrder;
  final bool status;

  MucLuongMM({
    required this.idMucLuong,
    required this.tenMucLuong,
    required this.displayOrder,
    required this.status,
  });

  factory MucLuongMM.fromJson(Map<String, dynamic> json) {
    return MucLuongMM(
      idMucLuong: json['idMucLuong'],
      tenMucLuong: json['tenMucLuong'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMucLuong': idMucLuong,
      'tenMucLuong': tenMucLuong,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
