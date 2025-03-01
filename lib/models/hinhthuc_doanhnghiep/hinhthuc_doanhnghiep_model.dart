class HinhThucDoanhNghiep {
  final int id;
  final String name;
  final String idLhdn;
  final int displayOrder;
  final bool status;

  HinhThucDoanhNghiep({
    required this.id,
    required this.name,
    required this.idLhdn,
    required this.displayOrder,
    required this.status,
  });

  factory HinhThucDoanhNghiep.fromJson(Map<String, dynamic> json) {
    return HinhThucDoanhNghiep(
      id: json['id'],
      name: json['name'],
      idLhdn: json['idLhdn'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idLhdn': idLhdn,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
