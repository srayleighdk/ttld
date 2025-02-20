class TrinhDoNgoaiNgu {
  final String tdnnId;
  final String tdnnTen;
  final int displayOrder;
  final bool status;

  TrinhDoNgoaiNgu({
    required this.tdnnId,
    required this.tdnnTen,
    required this.displayOrder,
    required this.status,
  });

  factory TrinhDoNgoaiNgu.fromJson(Map<String, dynamic> json) {
    return TrinhDoNgoaiNgu(
      tdnnId: json['tdnnId'],
      tdnnTen: json['tdnnTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tdnnId': tdnnId,
      'tdnnTen': tdnnTen,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
