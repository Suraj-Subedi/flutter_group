import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/modules/cart/views/cart_view.dart';
import 'package:flutter_ecom/app/modules/home/views/home_view.dart';
import 'package:flutter_ecom/app/modules/orders/views/orders_view.dart';
import 'package:flutter_ecom/app/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;
  List<Widget> screens = [
    const HomeView(),
    const OrdersView(),
    const CartView(),
    const ProfileView()
  ];

  final count = 0.obs;

  void increment() => count.value++;
}
