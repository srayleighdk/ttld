class NganhNgheChuyenNganh {
  final int sott;
  final int ma;
  final String ten;
  final bool show;

  NganhNgheChuyenNganh({
    required this.sott,
    required this.ma,
    required this.ten,
    required this.show,
  });

  factory NganhNgheChuyenNganh.fromJson(Map<String, dynamic> json) {
    return NganhNgheChuyenNganh(
      sott: json['sott'],
      ma: json['ma'],
      ten: json['ten'],
      show: json['show'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sott': sott,
      'ma': ma,
      'ten': ten,
      'show': show,
    };
  }
}
