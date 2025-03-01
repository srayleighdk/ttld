class ThoiGianHoatDong {
  final int idThoiGianHd;
  final String tenThoiGianHd;
  final int displayOrder;
  final bool status;

  ThoiGianHoatDong({
    required this.idThoiGianHd,
    required this.tenThoiGianHd,
    required this.displayOrder,
    required this.status,
  });

  factory ThoiGianHoatDong.fromJson(Map<String, dynamic> json) {
    return ThoiGianHoatDong(
      idThoiGianHd: json['idThoiGianHd'],
      tenThoiGianHd: json['tenThoiGianHd'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idThoiGianHd': idThoiGianHd,
      'tenThoiGianHd': tenThoiGianHd,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
