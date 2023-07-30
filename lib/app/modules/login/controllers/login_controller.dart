import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/utils/memory_management.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey();

  final count = 0.obs;

  void login() async {
    try {
      if (loginFormKey.currentState!.validate()) {
        var url = Uri.http(baseUrl, 'ecom_api/auth/login');

        var response = await http.post(url, body: {
          'email': emailController.text,
          'password': passwordController.text
        });
        var data = jsonDecode(response.body);
        if (data['status'] == 200) {
          MemoryManagement.setAccessToken(data['token']);
          MemoryManagement.setRole(data['role']);

          if (data['role'] == 'admin') {
            Get.offAllNamed(Routes.ADMIN_MAIN);
          } else {
            Get.offAllNamed(Routes.MAIN);
          }
          showCustomSnackBar(message: data['message'], color: Colors.green);
        } else {
          showCustomSnackBar(
              message: data['message'], color: Colors.red, isTop: true);
        }
      }
    } catch (e) {
      print(e.toString());
      showCustomSnackBar(
          message: 'Something went wrong', color: Colors.red, isTop: true);
    }
  }

  void increment() => count.value++;
}
