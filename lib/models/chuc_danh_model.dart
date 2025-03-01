class ChucDanhModel {
  int? id;
  String? name;
  int? displayOrder;
  int? idLoai;
  bool? status;

  ChucDanhModel({
    this.id,
    this.name,
    this.displayOrder,
    this.idLoai,
    this.status,
  });

  factory ChucDanhModel.fromJson(Map<String, dynamic> json) {
    return ChucDanhModel(
      id: json['id'],
      name: json['name'],
      displayOrder: json['displayOrder'],
      idLoai: json['idLoai'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['displayOrder'] = displayOrder;
    data['idLoai'] = idLoai;
    data['status'] = status;
    return data;
  }
}
