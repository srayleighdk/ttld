class HinhThucDiaDiem {
  final int id;
  final String nganhhocTen;
  final int displayOrder;
  final bool status;

  HinhThucDiaDiem({
    required this.id,
    required this.nganhhocTen,
    required this.displayOrder,
    required this.status,
  });

  factory HinhThucDiaDiem.fromJson(Map<String, dynamic> json) {
    return HinhThucDiaDiem(
      id: json['id'],
      nganhhocTen: json['nganhhocTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nganhhocTen': nganhhocTen,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
