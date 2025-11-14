enum Region { lamDong, giaLai }

extension RegionExtension on Region {
  String get displayName {
    switch (this) {
      case Region.lamDong:
        return 'Lâm Đồng';
      case Region.giaLai:
        return 'Gia Lai';
    }
  }

  String get baseUrlKey {
    switch (this) {
      case Region.lamDong:
        return 'API_LAMDONG';
      case Region.giaLai:
        return 'API_GIALAI';
    }
  }

  String get avatarUrlKey {
    switch (this) {
      case Region.lamDong:
        return 'URL_AVATAR_LD';
      case Region.giaLai:
        return 'URL_AVATAR_GL';
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
