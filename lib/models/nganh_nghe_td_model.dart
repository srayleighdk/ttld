class NganhNgheTD {
  final int id;
  final String name;
  final String manhom;
  final int displayOrder;
  final bool status;

  NganhNgheTD({
    required this.id,
    required this.name,
    required this.manhom,
    required this.displayOrder,
    required this.status,
  });

  factory NganhNgheTD.fromJson(Map<String, dynamic> json) {
    return NganhNgheTD(
      id: json['id'],
      name: json['name'],
      manhom: json['manhom'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'manhom': manhom,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
