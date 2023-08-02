import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter_ecom/app/utils/memory_management.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MemoryManagement.init();
  Get.put(CartController(), permanent: true);
  var token = MemoryManagement.getAccessToken();
  var role = MemoryManagement.getRole();

  runApp(
    KhaltiScope(
      publicKey: 'test_public_key_dde0878862604f24b2475a9806c833d2',
      builder: (context, navigatorKey) => GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "Application",
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: const [
          KhaltiLocalizations.delegate,
        ],
        // home: const GetStarted(),
        initialRoute: token == null
            ? Routes.LOGIN
            : role == 'admin'
                ? Routes.ADMIN_MAIN
                : Routes.MAIN,
        getPages: AppPages.routes,
      ),
    ),
  );
}
