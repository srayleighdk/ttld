class ThoiGianLamViec {
  final int id;
  final String name;
  final String idhinhthuclamviec;
  final int displayOrder;
  final bool status;

  ThoiGianLamViec({
    required this.id,
    required this.name,
    required this.idhinhthuclamviec,
    required this.displayOrder,
    required this.status,
  });

  factory ThoiGianLamViec.fromJson(Map<String, dynamic> json) {
    return ThoiGianLamViec(
      id: json['id'],
      name: json['name'],
      idhinhthuclamviec: json['idhinhthuclamviec'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idhinhthuclamviec': idhinhthuclamviec,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
