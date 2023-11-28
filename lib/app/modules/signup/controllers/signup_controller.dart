import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/routes/app_pages.dart';
import 'package:flutter_ecom/app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  final count = 0.obs;
  final GlobalKey<FormState> signUpFormKey = GlobalKey();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void signUp() async {
    try {
      if (signUpFormKey.currentState!.validate()) {
        var url = Uri.http(baseUrl, 'ecom_api/auth/register');

        var response = await http.post(url, body: {
          'email': emailController.text,
          'fullname': nameController.text,
          'password': passwordController.text
        });
        var data = jsonDecode(response.body);
        if (data['status'] == 200) {
          showCustomSnackBar(message: data['message'], color: Colors.green);
          Get.to(Routes.LOGIN);
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
