import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/modules/home/controllers/home_controller.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whisper Book'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              homeController.logout();
            },
            child: const Text('Logout')),
      ),
    );
  }
}
