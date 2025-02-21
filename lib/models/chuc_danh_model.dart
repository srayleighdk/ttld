class ChucDanhModel {
  String? tenChucDanh;
  int? displayOrder;
  bool? status;

  ChucDanhModel({
    this.tenChucDanh,
    this.displayOrder,
    this.status,
  });

  ChucDanhModel.fromJson(Map<String, dynamic> json) {
    tenChucDanh = json['tenChucDanh'];
    displayOrder = json['displayOrder'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenChucDanh'] = tenChucDanh;
    data['displayOrder'] = displayOrder;
    data['status'] = status;
    return data;
  }
}
