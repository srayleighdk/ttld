class HinhThucDaoTao {
  final String htdtTen;
  final int displayOrder;
  final bool status;

  HinhThucDaoTao({
    required this.htdtTen,
    required this.displayOrder,
    required this.status,
  });

  factory HinhThucDaoTao.fromJson(Map<String, dynamic> json) {
    return HinhThucDaoTao(
      htdtTen: json['htdtTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'htdtTen': htdtTen,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
