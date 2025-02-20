class NganhNgheCapDo {
  final int groupId;
  final int level1;
  final int level2;
  final int level3;
  final int level4;
  final int level5;
  final String ten;
  final int displayOrder;
  final bool status;

  NganhNgheCapDo({
    required this.groupId,
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
    required this.level5,
    required this.ten,
    required this.displayOrder,
    required this.status,
  });

  factory NganhNgheCapDo.fromJson(Map<String, dynamic> json) {
    return NganhNgheCapDo(
      groupId: json['groupId'],
      level1: json['level1'],
      level2: json['level2'],
      level3: json['level3'],
      level4: json['level4'],
      level5: json['level5'],
      ten: json['ten'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'level1': level1,
      'level2': level2,
      'level3': level3,
      'level4': level4,
      'level5': level5,
      'ten': ten,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
