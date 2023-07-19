import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/components/my_button.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Whisper Book'),
        ),
        body: GetBuilder<HomeController>(builder: (controller) {
          if (controller.categories == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories!.length,
                      itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.only(right: 15),
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 10,
                            ),
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue.withOpacity(0.5)),
                            child: Text(
                              controller.categories![index].title ?? '',
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          )),
                )
              ],
            ),
          );
        }),
        drawer: Drawer(
          child: Center(
            child: SizedBox(
              height: 75,
              child: MyButton(
                title: 'Logout',
                onPressed: controller.logout,
              ),
            ),
          ),
        ));
  }
}
