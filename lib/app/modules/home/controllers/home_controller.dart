import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/models/category.dart';
import 'package:flutter_ecom/app/models/product.dart';
import 'package:flutter_ecom/app/routes/app_pages.dart';
import 'package:flutter_ecom/app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  var imageBytes = Uint8List(0).obs;
  late final SharedPreferences sharedPref;
  List<Category>? categories;
  List<Product>? products;
  GlobalKey<FormState> addCategoryKey = GlobalKey();
  var titleController = TextEditingController();

  //products controllers

  GlobalKey<FormState> addProductKey = GlobalKey();
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  var selectedCategory = ''.obs;

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

  void resetProductForm() {
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    selectedCategory.value = '';
    imageBytes.value = Uint8List(0);
    image = null;
  }

  void pickImage() async {
    try {
      image = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        imageBytes.value = await image!.readAsBytes();
      }
    } catch (e) {
      showCustomSnackBar(
        message: 'Couln\'t pick Image',
        color: Colors.red,
        isTop: true,
      );
    }
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

  Future<void> addCategory() async {
    try {
      if (addCategoryKey.currentState!.validate()) {
        var url = Uri.http(baseUrl, 'ecom_api/addCategory');

        var response = await http.post(url, body: {
          'token': sharedPref.getString('token'),
          'title': titleController.text
        });

        var data = jsonDecode(response.body);
        if (data['status'] == 200) {
          Get.back();
          getCategories();
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

  Future<void> deleteCategory({required String categoryId}) async {
    try {
      var url = Uri.http(baseUrl, 'ecom_api/deleteCategory');

      var response = await http.post(url, body: {
        'token': sharedPref.getString('token'),
        'categoryId': categoryId
      });
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        Get.back();
        getCategories();
        showCustomSnackBar(message: data['message'], color: Colors.green);
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

  Future<void> addProduct() async {
    try {
      if (addProductKey.currentState!.validate()) {
        var url = Uri.http(baseUrl, 'ecom_api/addProduct');

        var form = http.MultipartRequest('POST', url);
        form.fields['token'] = sharedPref.getString('token')!;
        form.fields['name'] = nameController.text;
        form.fields['price'] = priceController.text;
        form.fields['description'] = descriptionController.text;
        form.fields['category'] = selectedCategory.value;
        form.files.add(http.MultipartFile.fromBytes('image', imageBytes.value,
            filename: image!.name));

        // var response = await http.post(url, body: {
        //   'token': sharedPref.getString('token'),
        //   'name': nameController.text,
        //   'price': priceController.text,
        //   'description': descriptionController.text,
        //   'category': selectedCategory.value
        // });

        var response = await http.Response.fromStream(await form.send());

        var data = jsonDecode(response.body);
        if (data['status'] == 200) {
          Get.back();
          resetProductForm();
          getProducts();
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
