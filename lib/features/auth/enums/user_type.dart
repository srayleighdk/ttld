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
}
