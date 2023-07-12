import 'package:flutter_ecom/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  late final SharedPreferences sharedPref;

  final count = 0.obs;
  @override
  void onInit() async {
    sharedPref = await SharedPreferences.getInstance();
    super.onInit();
  }

  void logout() {
    sharedPref.remove('token');
    Get.offAllNamed(Routes.LOGIN);
  }

  void increment() => count.value++;
}
