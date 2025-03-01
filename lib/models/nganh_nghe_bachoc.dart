class NganhNgheBacHoc {
  final String id;
  final String name;
  final String idNhom;
  final int ordinalNumbers;
  final bool status;

  NganhNgheBacHoc({
    required this.id,
    required this.name,
    required this.idNhom,
    required this.ordinalNumbers,
    required this.status,
  });

  factory NganhNgheBacHoc.fromJson(Map<String, dynamic> json) {
    return NganhNgheBacHoc(
      id: json['id'],
      name: json['name'],
      idNhom: json['idNhom'],
      ordinalNumbers: json['ordinalNumbers'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idNhom': idNhom,
      'ordinalNumbers': ordinalNumbers,
      'status': status,
    };
  }
}
