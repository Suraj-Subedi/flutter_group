// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? role;

  Users({
    this.userId,
    this.fullName,
    this.email,
    this.role,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        userId: json["user_id"],
        fullName: json["full_name"],
        email: json["email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "email": email,
        "role": role,
      };
}
