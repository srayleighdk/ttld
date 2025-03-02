class TrinhDoVanHoa {
  final int id;
  final String name;
  final int displayOrder;
  final bool status;

  TrinhDoVanHoa({
    required this.id,
    required this.name,
    required this.displayOrder,
    required this.status,
  });

  factory TrinhDoVanHoa.fromJson(Map<String, dynamic> json) {
    return TrinhDoVanHoa(
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
