import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ecom/app/utils/constants.dart';

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
      body: GetBuilder(
          init: ProfileController(),
          builder: (controller) {
            if (controller.user == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      getAvatar(
                        name: controller.user?.fullName ?? '',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.user?.fullName ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.user?.email ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.user?.role == 'admin' ? 'ADMIN' : '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        homeController.logout();
                      },
                      child: const Text('Logout')),
                ),
              ],
            );
          }),
    );
  }
}
