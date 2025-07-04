enum Region { lamDong, binhThuan, binhDinh }

extension RegionExtension on Region {
  String get displayName {
    switch (this) {
      case Region.lamDong:
        return 'Lâm Đồng';
      case Region.binhThuan:
        return 'Bình Thuận';
      case Region.binhDinh:
        return 'Bình Định';
    }
  }

  String get baseUrlKey {
    switch (this) {
      case Region.lamDong:
        return 'API_LAMDONG';
      case Region.binhThuan:
        return 'API_BINHTHUAN';
      case Region.binhDinh:
        return 'API_BINHDINH';
    }
  }

  String get avatarUrlKey {
    switch (this) {
      case Region.lamDong:
        return 'URL_AVATAR_LD';
      case Region.binhThuan:
        return 'URL_AVATAR_BT';
      case Region.binhDinh:
        return 'URL_AVATAR_BD';
    }
  }
}

Region? regionFromString(String? regionName) {
  if (regionName == null) return null;
  try {
    return Region.values.firstWhere(
        (e) => e.name.toLowerCase() == regionName.toLowerCase());
  } catch (e) {
    return null; // Return null if the string doesn't match any enum value
  }
}
