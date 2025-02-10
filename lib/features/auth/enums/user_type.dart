enum UserType {
  admin,
  ntd,
  ntv;

  String get displayName {
    switch (this) {
      case UserType.admin:
        return 'ADMIN';
      case UserType.ntd:
        return 'NTD';
      case UserType.ntv:
        return 'NTV';
    }
  }

  String get tooltip {
    switch (this) {
      case UserType.admin:
        return 'Administrator';
      case UserType.ntd:
        return 'Nhà Tuyển Dụng';
      case UserType.ntv:
        return 'Người Tìm Việc';
    }
  }
}
