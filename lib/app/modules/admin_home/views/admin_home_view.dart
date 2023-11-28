import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/components/my_button.dart';
import 'package:flutter_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ecom/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Whisper Book'),
        ),
        body: SingleChildScrollView(
          child: GetBuilder<AdminHomeController>(
            init: AdminHomeController(),
            builder: (controller) {
              if (controller.stats == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Stats info',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StatCard(
                        title: 'Total Users',
                        value: controller.stats!.totalUsers.toString(),
                      ),
                      StatCard(
                        title: 'Total Orders',
                        value: controller.stats!.totalOrders.toString(),
                      ),
                      StatCard(
                        title: 'Total Income',
                        value: 'Rs.${controller.stats!.totalIncome}',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Recent Orders',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButton(
                          title: 'View orders',
                          onPressed: () {
                            Get.toNamed(Routes.ORDERS);
                          })
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      margin: const EdgeInsets.only(bottom: 15),
      height: 75,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
