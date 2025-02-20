class Tinh {
  final String mahuyen;
  final String tenhuyen;
  final int sott;
  final bool show;
  final String tentinh;

  Tinh({
    required this.mahuyen,
    required this.tenhuyen,
    required this.sott,
    required this.show,
    required this.tentinh,
  });

  factory Tinh.fromJson(Map<String, dynamic> json) {
    return Tinh(
      mahuyen: json['mahuyen'] ?? '',
      tenhuyen: json['tenhuyen'] ?? '',
      sott: json['sott'] ?? 0,
      show: json['show'] ?? false,
      tentinh: json['tentinh'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mahuyen': mahuyen,
      'tenhuyen': tenhuyen,
      'sott': sott,
      'show': show,
      'tentinh': tentinh,
    };
  }
}
