import 'package:flutter/material.dart';
import 'package:get/get.dart';

const ipAddress = "192.168.1.7";

const baseUrl = ipAddress;
// Obtain shared preferences.

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
        snackPosition: SnackPosition.BOTTOM

        // backgroundColor: color ?? Colors.green,
        ));