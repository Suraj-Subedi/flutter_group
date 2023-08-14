import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/components/my_button.dart';
import 'package:flutter_ecom/app/components/my_textfield.dart';
import 'package:flutter_ecom/app/models/user.dart';

import 'package:get/get.dart';

import '../controllers/admin_users_controller.dart';

class AdminUsersView extends GetView<AdminUsersController> {
  const AdminUsersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: GetBuilder<AdminUsersController>(
          init: AdminUsersController(),
          builder: (controller) {
            if (controller.users == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.users!.length,
                  itemBuilder: (context, index) => UserCard(
                        user: controller.users![index],
                      )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddUserPopup(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final Users user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user.fullName ?? '',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                user.role?.toUpperCase() ?? '',
                style: TextStyle(
                  fontSize: 17,
                  color: user.role == 'admin' ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.delete,
          //       color: Colors.red,
          //     ))
        ],
      ),
    );
  }
}

class AddUserPopup extends StatelessWidget {
  const AddUserPopup({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminUsersController());
    return Dialog(
        insetPadding: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                'Add user (Admin)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: controller.name,
                hintText: 'Enter your name',
                labelText: 'Full Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name can't be empty";
                  }
                  return null;
                },
              ),
              MyTextField(
                controller: controller.email,
                hintText: 'Enter your Email',
                labelText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email can't be empty";
                  } else if (!GetUtils.isEmail(value)) {
                    return "Give proper email address";
                  }
                  return null;
                },
              ),
              MyTextField(
                controller: controller.password,
                hintText: 'Enter your Password',
                labelText: 'Password',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password can't be empty";
                  }
                  return null;
                },
              ),
              MyButton(
                title: 'Add User',
                onPressed: controller.addUser,
              )
            ]),
          ),
        ));
  }
}
