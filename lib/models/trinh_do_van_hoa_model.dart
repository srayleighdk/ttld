class TrinhDoVanHoa {
  final String hocvanTen;
  final int displayOrder;
  final bool status;

  TrinhDoVanHoa({
    required this.hocvanTen,
    required this.displayOrder,
    required this.status,
  });

  factory TrinhDoVanHoa.fromJson(Map<String, dynamic> json) {
    return TrinhDoVanHoa(
      hocvanTen: json['hocvanTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hocvanTen': hocvanTen,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
