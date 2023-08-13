// To parse this JSON data, do
//
//     final stats = statsFromJson(jsonString);

import 'dart:convert';

Stats statsFromJson(String str) => Stats.fromJson(json.decode(str));

String statsToJson(Stats data) => json.encode(data.toJson());

class Stats {
  final String? totalOrders;
  final String? totalUsers;
  final String? totalIncome;

  Stats({
    this.totalOrders,
    this.totalUsers,
    this.totalIncome,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        totalOrders: json["total_orders"],
        totalUsers: json["total_users"],
        totalIncome: json["total_income"],
      );

  Map<String, dynamic> toJson() => {
        "total_orders": totalOrders,
        "total_users": totalUsers,
        "total_income": totalIncome,
      };
}
