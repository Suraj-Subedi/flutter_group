import 'package:flutter/material.dart';
import 'package:get/get.dart';

const ipAddress = "192.168.1.71";

const baseUrl = ipAddress;
// Obtain shared preferences.

var getImageUrl = (imageUrl) {
  return 'http://$ipAddress/ecom_api/$imageUrl';
};

String getAvatar({required String name, Color? color}) {
  var splitName = name.split(' ');
  return 'http://ui-avatars.com/api/?name=${splitName.first.characters}&length=2&format=png&rounded=true&size=256&background=${color ?? '0096FF'}&color=${color ?? 'FFFFFF'}';
}

var showCustomSnackBar = (
        {required String message, Color? color, bool isTop = false}) =>
    Get.showSnackbar(GetSnackBar(
        messageText: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        // snackPosition: isCart ? SnackPosition.TOP : SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
        backgroundColor: color ?? Colors.red,
        snackPosition: isTop ? SnackPosition.TOP : SnackPosition.BOTTOM

        // backgroundColor: color ?? Colors.green,
        ));
