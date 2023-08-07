import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/models/order.dart';
import 'package:flutter_ecom/app/utils/constants.dart';
import 'package:flutter_ecom/app/utils/memory_management.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrdersController extends GetxController {
  List<Order>? orders;

  final count = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOrders();
  }

  void getOrders() async {
    try {
      var url = Uri.http(baseUrl, 'ecom_api/getOrders');

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        orders = orderFromJson(jsonEncode(data['data']));
        update();
      } else {
        showCustomSnackBar(
            message: data['message'], color: Colors.red, isTop: true);
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong',
      ));
    }
  }

  void increment() => count.value++;
}
