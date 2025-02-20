class KCN {
  final String kcnTen;
  final int displayOrder;
  final bool status;
  final String matinh;

  KCN({
    required this.kcnTen,
    required this.displayOrder,
    required this.status,
    required this.matinh,
  });

  factory KCN.fromJson(Map<String, dynamic> json) {
    return KCN(
      kcnTen: json['kcnTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
      matinh: json['matinh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kcnTen': kcnTen,
      'displayOrder': displayOrder,
      'status': status,
      'matinh': matinh,
    };
  }
}
