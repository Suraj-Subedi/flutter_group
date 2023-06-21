import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.red,
            width: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                  height: 100,
                  width: 100,
                  image: AssetImage('assets/image/logo.jpg')),
              Container(
                height: 100,
                width: 100,
                color: Colors.yellow,
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.green,
              )
            ],
          ),
          Container(
            color: Colors.blue,
            width: 100,
          ),
        ],
      ),
    );
  }
}

class Cart extends StatelessWidget {
  final int numberOfProducts;
  const Cart({super.key, required this.numberOfProducts});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        numberOfProducts.toString(),
        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('this is profile page');
  }
}
