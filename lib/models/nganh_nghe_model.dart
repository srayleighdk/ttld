class NganhNghe {
  final String idNkt;
  final String tenNganhKt;
  final String manhom;
  final int displayOrder;
  final bool status;

  NganhNghe({
    required this.idNkt,
    required this.tenNganhKt,
    required this.manhom,
    required this.displayOrder,
    required this.status,
  });

  factory NganhNghe.fromJson(Map<String, dynamic> json) {
    return NganhNghe(
      idNkt: json['idNkt'],
      tenNganhKt: json['tenNganhKt'],
      manhom: json['manhom'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idNkt': idNkt,
      'tenNganhKt': tenNganhKt,
      'manhom': manhom,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
