import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final bool isPassword;
  final bool isNumber;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const MyTextField(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.isPassword = false,
      this.validator,
      this.controller,
      this.isNumber = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPassword,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
