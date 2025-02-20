class LoaiViecLam {
  final String loaivieclamTen;
  final int displayOrder;
  final bool status;

  LoaiViecLam({
    required this.loaivieclamTen,
    required this.displayOrder,
    required this.status,
  });

  factory LoaiViecLam.fromJson(Map<String, dynamic> json) {
    return LoaiViecLam(
      loaivieclamTen: json['loaivieclamTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loaivieclamTen': loaivieclamTen,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
