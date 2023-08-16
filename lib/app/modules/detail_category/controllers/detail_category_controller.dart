import 'package:flutter_ecom/app/models/category.dart';
import 'package:flutter_ecom/app/models/product.dart';
import 'package:flutter_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ecom/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class DetailCategoryController extends GetxController {
  List<Product> products = [];
  var category = Get.arguments as Category;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    var homeController = Get.find<HomeController>();
    products = homeController.products!
        .where((element) => element.categoryId == category.categoryId)
        .toList();
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
