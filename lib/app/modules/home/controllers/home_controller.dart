import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/models/category.dart';
import 'package:flutter_ecom/app/models/product.dart';
import 'package:flutter_ecom/app/routes/app_pages.dart';
import 'package:flutter_ecom/app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  late final SharedPreferences sharedPref;
  List<Category>? categories;
  List<Product>? products;

  final count = 0.obs;
  @override
  void onInit() async {
    sharedPref = await SharedPreferences.getInstance();
    super.onInit();
    getCategories();
    getProducts();
  }

  void logout() {
    sharedPref.remove('token');
    Get.offAllNamed(Routes.LOGIN);
  }

  void getCategories() async {
    try {
      var url = Uri.http(baseUrl, 'ecom_api/getCategories');

      var response = await http.get(url);
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        categories = categoryFromJson(jsonEncode(data['data']));
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

  void getProducts() async {
    try {
      var url = Uri.http(baseUrl, 'ecom_api/getProduct');

      var response = await http.get(url);
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        products = productFromJson(jsonEncode(data['data']));
        update();
      } else {
        showCustomSnackBar(
            message: data['message'], color: Colors.red, isTop: true);
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong',
      ));
    }
  }

  void increment() => count.value++;
}
