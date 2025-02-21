class QuocGia {
  final String tenQuocGia;
  final String viettat;
  final int displayOrder;
  final bool status;

  QuocGia({
    required this.tenQuocGia,
    required this.viettat,
    required this.displayOrder,
    required this.status,
  });

  factory QuocGia.fromJson(Map<String, dynamic> json) {
    return QuocGia(
      tenQuocGia: json['tenQuocGia'] ?? '',
      viettat: json['viettat'] ?? '',
      displayOrder: json['displayOrder'] ?? 0,
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenQuocGia': tenQuocGia,
      'viettat': viettat,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
