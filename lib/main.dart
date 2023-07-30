import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/utils/memory_management.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MemoryManagement.init();
  var token = MemoryManagement.getAccessToken();
  var role = MemoryManagement.getRole();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      // home: const GetStarted(),
      initialRoute: token == null
          ? Routes.LOGIN
          : role == 'admin'
              ? Routes.ADMIN_MAIN
              : Routes.MAIN,
      getPages: AppPages.routes,
    ),
  );
}
