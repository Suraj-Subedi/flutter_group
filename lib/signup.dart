import 'package:flutter/material.dart';
import 'package:june_20/components/custom_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          onPressed: () {},
          title: 'Sign up',
        ),
      ),
    );
  }
}
