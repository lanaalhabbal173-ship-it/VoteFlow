class UserModel {
  String? userId;

  String name;

  String email;

  String role;

  int createdAt;

  UserModel({
    this.userId,

    required this.name,

    required this.email,

    required this.role,

    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,

      "name": name,

      "email": email,

      "role": role,

      "createdAt": createdAt,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"],

      name: json["name"],

      email: json["email"],

      role: json["role"],

      createdAt: json["createdAt"],
    );
  }
}
