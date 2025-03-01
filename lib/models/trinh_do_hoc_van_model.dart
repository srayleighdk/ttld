class TrinhDoHocVan {
  final int id;
  final String name;

  final int displayOrder;
  final int idCaphoc;
  final String phanloai;
  final bool status;

  TrinhDoHocVan({
    required this.id,
    required this.name,
    required this.displayOrder,
    required this.idCaphoc,
    required this.phanloai,
    required this.status,
  });

  factory TrinhDoHocVan.fromJson(Map<String, dynamic> json) {
    return TrinhDoHocVan(
      id: json['id'],
      name: json['name'],
      displayOrder: json['displayOrder'],
      idCaphoc: json['idCaphoc'],
      phanloai: json['phanloai'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'displayOrder': displayOrder,
      'idCaphoc': idCaphoc,
      'phanloai': phanloai,
      'status': status,
    };
  }
}
