class UserModel {
  String? uId;
  String? username;
  String? fullName;
  String? email;
  String? password;
  String? role;

  UserModel({
    this.uId,
    this.username,
    this.email,
    this.password,
    this.fullName,
    this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'full_name': fullName,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'],
      username: json['username'],
      fullName: json['full_name'],
      email: json['email'],
      role: json['role'],
    );
  }
}
