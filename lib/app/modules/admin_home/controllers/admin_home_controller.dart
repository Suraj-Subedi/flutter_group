import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/models/stats.dart';
import 'package:flutter_ecom/app/utils/constants.dart';
import 'package:flutter_ecom/app/utils/memory_management.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminHomeController extends GetxController {
  Stats? stats;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getStats();
  }

  void getStats() async {
    try {
      var url = Uri.http(baseUrl, 'ecom_api/getStats');

      var response = await http
          .post(url, body: {'token': MemoryManagement.getAccessToken()});
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        stats = statsFromJson(jsonEncode(data['data']));
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
