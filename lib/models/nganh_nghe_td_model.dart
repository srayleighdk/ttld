class NganhNgheTD {
  final String manhom;
  final String nganhTen;
  final int displayOrder;
  final bool status;

  NganhNgheTD({
    required this.manhom,
    required this.nganhTen,
    required this.displayOrder,
    required this.status,
  });

  factory NganhNgheTD.fromJson(Map<String, dynamic> json) {
    return NganhNgheTD(
      manhom: json['manhom'],
      nganhTen: json['nganhTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'manhom': manhom,
      'nganhTen': nganhTen,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
