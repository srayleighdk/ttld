class LoaiHinh {
  final String id;
  final String name;
  final int displayOrder;
  final bool status;

  LoaiHinh({
    required this.id,
    required this.name,
    required this.displayOrder,
    required this.status,
  });

  factory LoaiHinh.fromJson(Map<String, dynamic> json) {
    return LoaiHinh(
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
