class NganhNgheDaoTao {
  final String nnTen;
  final String bachoc;
  final String summary;
  final int displayOrder;
  final bool status;

  NganhNgheDaoTao({
    required this.nnTen,
    required this.bachoc,
    required this.summary,
    required this.displayOrder,
    required this.status,
  });

  factory NganhNgheDaoTao.fromJson(Map<String, dynamic> json) {
    return NganhNgheDaoTao(
      nnTen: json['nnTen'],
      bachoc: json['bachoc'],
      summary: json['summary'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nnTen': nnTen,
      'bachoc': bachoc,
      'summary': summary,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
