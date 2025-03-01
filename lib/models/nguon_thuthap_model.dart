class NguonThuThap {
  final String id;
  final String name;
  final int displayOrder;
  final bool status;

  NguonThuThap({
    required this.id,
    required this.name,
    required this.displayOrder,
    required this.status,
  });

  factory NguonThuThap.fromJson(Map<String, dynamic> json) {
    return NguonThuThap(
      id: json['id'],
      name: json['name'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
