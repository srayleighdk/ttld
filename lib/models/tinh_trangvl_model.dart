class TinhTrangViecLam {
  final String tenTrangThai;
  final int displayOrder;
  final bool status;

  TinhTrangViecLam({
    required this.tenTrangThai,
    required this.displayOrder,
    required this.status,
  });

  factory TinhTrangViecLam.fromJson(Map<String, dynamic> json) {
    return TinhTrangViecLam(
      tenTrangThai: json['tenTrangThai'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenTrangThai': tenTrangThai,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
