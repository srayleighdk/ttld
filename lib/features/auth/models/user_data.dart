class UserData {
  final String id;
  final String userName;
  final String userType;
  // Add other user data fields as needed

  UserData({
    required this.id,
    required this.userName,
    required this.userType,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      userType: json['userType'] ?? '',
    );
  }
}
