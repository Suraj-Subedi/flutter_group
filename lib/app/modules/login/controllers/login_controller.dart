import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  late final SharedPreferences sharedPref;
  var passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey();

  final count = 0.obs;

  @override
  void onInit() async {
    sharedPref = await SharedPreferences.getInstance();
    super.onInit();
  }

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
          sharedPref.setString('token', data['token']);
          Get.offAllNamed(Routes.HOME);
          showCustomSnackBar(message: data['message'], color: Colors.green);
        } else {
          showCustomSnackBar(
              message: data['message'], color: Colors.red, isTop: true);
        }
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong',
      ));
    }
  }

  void increment() => count.value++;
}
