import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:june_20/onboarding_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    OnboardingController onboardingController = Get.put(OnboardingController());
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: onboardingController.pageController,
          // physics: const BouncingScrollPhysics(),
          // physics: const NeverScrollableScrollPhysics(),
          children: const [
            FirstPage(),
            SecondPage(),
            ThirdPage(),
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    OnboardingController onboardingController = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "This is first page",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
          child: NextButton(
            onPressed: () {
              onboardingController.pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
          ),
        ),
      ],
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "This is second page",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        NextButton(
          onPressed: () {},
        )
      ],
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "This is third page",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        NextButton(
          onPressed: () {},
        )
      ],
    );
  }
}

class NextButton extends StatelessWidget {
  final void Function() onPressed;
  const NextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 30)),
      ),
      onPressed: onPressed,
      child: const Text("Next"),
    );
  }
}
