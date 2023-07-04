import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/my_button.dart';
import '../../../components/my_textfield.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: const [
                Text(
                  "Register yourself:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const MyTextField(
              hintText: 'Enter your name',
              labelText: 'Full Name',
            ),
            const MyTextField(
              hintText: 'Enter your Email',
              labelText: 'Email',
            ),
            const MyTextField(
              hintText: 'Enter your Password',
              labelText: 'Password',
              isPassword: true,
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(title: 'Register', onPressed: () {}),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
