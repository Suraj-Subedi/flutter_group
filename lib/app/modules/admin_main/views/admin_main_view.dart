import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_main_controller.dart';

class AdminMainView extends GetView<AdminMainController> {
  const AdminMainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.screens[controller.currentIndex.value],
        bottomNavigationBar: FloatingNavbar(
          onTap: (int val) {
            controller.currentIndex.value = val;
          },
          currentIndex: controller.currentIndex.value,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.list, title: 'Orders'),
            FloatingNavbarItem(icon: Icons.category, title: 'Categories'),
            FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
          ],
        ),
      ),
    );
  }
}
