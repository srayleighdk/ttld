class ThoiGianLamViec {
  final String tenThoigian;
  final int displayOrder;
  final bool status;

  ThoiGianLamViec({
    required this.tenThoigian,
    required this.displayOrder,
    required this.status,
  });

  factory ThoiGianLamViec.fromJson(Map<String, dynamic> json) {
    return ThoiGianLamViec(
      tenThoigian: json['tenThoigian'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenThoigian': tenThoigian,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
