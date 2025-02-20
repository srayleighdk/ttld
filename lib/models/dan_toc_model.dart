class DanToc {
  final String tenDt;
  final int displayOrder;
  final bool status;

  DanToc({
    required this.tenDt,
    required this.displayOrder,
    required this.status,
  });

  factory DanToc.fromJson(Map<String, dynamic> json) {
    return DanToc(
      tenDt: json['tenDt'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenDt': tenDt,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
