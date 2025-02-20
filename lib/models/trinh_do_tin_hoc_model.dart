class TrinhDoTinHoc {
  final String tdthId;
  final String tdthTen;
  final int displayOrder;
  final bool status;

  TrinhDoTinHoc({
    required this.tdthId,
    required this.tdthTen,
    required this.displayOrder,
    required this.status,
  });

  factory TrinhDoTinHoc.fromJson(Map<String, dynamic> json) {
    return TrinhDoTinHoc(
      tdthId: json['tdthId'],
      tdthTen: json['tdthTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tdthId': tdthId,
      'tdthTen': tdthTen,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
