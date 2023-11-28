import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/models/user.dart';
import 'package:flutter_ecom/app/utils/constants.dart';
import 'package:flutter_ecom/app/utils/memory_management.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminUsersController extends GetxController {
  List<Users>? users;
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  void addUser() async {
    try {
      if (formKey.currentState!.validate()) {
        var url = Uri.http(baseUrl, 'ecom_api/auth/addUser');

        var response = await http.post(url, body: {
          'token': MemoryManagement.getAccessToken(),
          'email': email.text,
          'fullname': name.text,
          'password': password.text
        });
        var data = jsonDecode(response.body);
        if (data['status'] == 200) {
          Get.back();
          getUsers();
          name.clear();
          email.clear();
          password.clear();
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

  void getUsers() async {
    try {
      var url = Uri.http(baseUrl, 'ecom_api/getUsers');

      var response = await http
          .post(url, body: {'token': MemoryManagement.getAccessToken()});
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        users = usersFromJson(jsonEncode(data['data']));
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
