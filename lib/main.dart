import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  final String? token = sharedPref.getString('token');
  runApp(
    GetMaterialApp(
      title: "Application",
      // home: const GetStarted(),
      initialRoute: token == null ? Routes.LOGIN : Routes.MAIN,
      getPages: AppPages.routes,
    ),
  );
}
