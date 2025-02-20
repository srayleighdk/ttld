class NganhNgheBacHoc {
  final String idBacHoc;
  final String description;
  final int ordinalNumbers;
  final bool status;

  NganhNgheBacHoc({
    required this.idBacHoc,
    required this.description,
    required this.ordinalNumbers,
    required this.status,
  });

  factory NganhNgheBacHoc.fromJson(Map<String, dynamic> json) {
    return NganhNgheBacHoc(
      idBacHoc: json['idBacHoc'],
      description: json['description'],
      ordinalNumbers: json['ordinalNumbers'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idBacHoc': idBacHoc,
      'description': description,
      'ordinalNumbers': ordinalNumbers,
      'status': status,
    };
  }
}
