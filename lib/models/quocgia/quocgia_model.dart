class QuocGia {
  final String name; // Changed from tenQuocGia to name
  final String viettat;
  final int displayOrder;
  final bool status;

  QuocGia({
    required this.name, // Changed from tenQuocGia to name
    required this.viettat,
    required this.displayOrder,
    required this.status,
  });

  factory QuocGia.fromJson(Map<String, dynamic> json) {
    return QuocGia(
      name: json['name'] ?? '', // Changed from tenQuocGia to name
      viettat: json['viettat'] ?? '',
      displayOrder: json['displayOrder'] ?? 0,
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name, // Changed from tenQuocGia to name
      'viettat': viettat,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
