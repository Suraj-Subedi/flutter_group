import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:june_20/components/custom_button.dart';
import 'package:june_20/signUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.network(
                'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo.png',
                height: 110,
              ),
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;

                  // if(value.length<8){
                  //   return 'Password must be at least 8 characters';
                  // }
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                obscureText: true,
                obscuringCharacter: "*",
                decoration: const InputDecoration(
                  labelText: 'Pasword',
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                title: 'Login',
                onPressed: () {
                  if (formKey.currentState == null) return;
                  formKey.currentState!.validate();

                  Get.showSnackbar(const GetSnackBar(
                    title: 'Login',
                    message: 'Login successful',
                    duration: Duration(seconds: 2),
                    snackPosition: SnackPosition.TOP,
                  ));
                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     if (formKey.currentState == null) return;
              //     formKey.currentState!.validate();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.all(20),
              //     child: const Text(
              //       'Login',
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, '/signUp');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const SignUpPage(),
                      //   ),
                      // );
                      Get.to(const SignUpPage());
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
