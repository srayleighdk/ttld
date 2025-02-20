class NguonViecLam {
  final int maNguonVlt;
  final int displayOrder;
  final String tenNguonVlt;
  final bool status;

  NguonViecLam({
    required this.maNguonVlt,
    required this.displayOrder,
    required this.tenNguonVlt,
    required this.status,
  });

  factory NguonViecLam.fromJson(Map<String, dynamic> json) {
    return NguonViecLam(
      maNguonVlt: json['maNguonVlt'],
      displayOrder: json['displayOrder'],
      tenNguonVlt: json['tenNguonVlt'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maNguonVlt': maNguonVlt,
      'displayOrder': displayOrder,
      'tenNguonVlt': tenNguonVlt,
      'status': status,
    };
  }
}
