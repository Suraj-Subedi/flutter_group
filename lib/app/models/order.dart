// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  final String? orderId;
  final String? userId;
  final String? total;
  final String? status;
  final DateTime? orderDate;
  final String? fullName;
  final String? email;

  Order({
    this.orderId,
    this.userId,
    this.total,
    this.status,
    this.orderDate,
    this.fullName,
    this.email,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        userId: json["user_id"],
        total: json["total"],
        status: json["status"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        fullName: json["full_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "total": total,
        "status": status,
        "order_date": orderDate?.toIso8601String(),
        "full_name": fullName,
        "email": email,
      };
}
