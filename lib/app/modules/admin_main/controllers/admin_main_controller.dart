import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/modules/admin_category/views/admin_category_view.dart';
import 'package:flutter_ecom/app/modules/admin_home/views/admin_home_view.dart';
import 'package:flutter_ecom/app/modules/admin_products/views/admin_products_view.dart';
import 'package:flutter_ecom/app/modules/admin_users/views/admin_users_view.dart';
import 'package:flutter_ecom/app/modules/orders/views/orders_view.dart';
import 'package:flutter_ecom/app/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';

class AdminMainController extends GetxController {
  final currentIndex = 0.obs;
  List<Widget> screens = [
    const AdminHomeView(),
    const AdminUsersView(),
    const AdminProductsView(),
    const AdminCategoryView(),
    const ProfileView()
  ];
  final count = 0.obs;

  void increment() => count.value++;
}
