class TonGiao {
  final String tenTg;
  final int displayOrder;
  final bool status;

  TonGiao({
    required this.tenTg,
    required this.displayOrder,
    required this.status,
  });

  factory TonGiao.fromJson(Map<String, dynamic> json) {
    return TonGiao(
      tenTg: json['tenTg'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenTg': tenTg,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
