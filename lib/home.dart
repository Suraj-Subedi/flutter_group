import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var products = [
    {
      "name": "Blazer",
      "color": "red",
    },
    {
      "name": "Shirt",
      "color": "blue",
    },
    {
      "name": "Pants",
      "color": "green",
    },
    {
      "name": "Shoes",
      "color": "yellow",
    },
    {
      "name": "Socks",
      "color": "orange",
    },
    {
      "name": "Tie",
      "color": "purple",
    },
    {
      "name": "Hat",
      "color": "pink",
    },
    {
      "name": "Gloves",
      "color": "brown",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ProductCard(name: products[index]['name']!);
          },

          // Container(
          //   height: 100,
          //   width: 300,
          //   color: Colors.orange,
          // )
        ),
        // child: Column(
        //   children: [
        //     // Container(
        //     //   height: 70,
        //     //   width: double.infinity,
        //     //   decoration: const BoxDecoration(
        //     //     color: Colors.blue,
        //     //     boxShadow: [
        //     //       BoxShadow(
        //     //         color: Colors.grey,
        //     //         blurRadius: 10,
        //     //         offset: Offset(0, 5),
        //     //       ),
        //     //     ],
        //     //   ),
        //     //   child: const Center(
        //     //       child: Text(
        //     //     'My Appbar',
        //     //     style: TextStyle(
        //     //         fontSize: 20,
        //     //         fontWeight: FontWeight.bold,
        //     //         color: Colors.white),
        //     //   )),
        //     // ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Container(
        //           color: Colors.red,
        //           width: 100,
        //         ),
        //         Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             const Image(
        //                 height: 100,
        //                 width: 100,
        //                 image: AssetImage('assets/image/logo.jpg')),
        //             Container(
        //               height: 100,
        //               width: 100,
        //               color: Colors.yellow,
        //             ),
        //             Container(
        //               height: 100,
        //               width: 100,
        //               color: Colors.green,
        //             )
        //           ],
        //         ),
        //         Container(
        //           color: Colors.blue,
        //           width: 100,
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                height: 15,
              ),
              Hero(
                tag: 'profile',
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    'https://marketplace.canva.com/EAFEits4-uw/1/0/800w/canva-boy-cartoon-gamer-animated-twitch-profile-photo-r0bPCSjUqg0.jpg',
                  ),
                ),
              ),
              Text(
                'Ahmed Ali',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ahmed@gmail.com',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )),
        ));
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  const ProductCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ]),
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              fontFamily: GoogleFonts.permanentMarker().fontFamily,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Add to cart")),
          // TextButton(
          //   onPressed: () {},
          //   child: Container(
          //     padding: const EdgeInsets.all(5),
          //     decoration: const BoxDecoration(
          //       color: Colors.blue,
          //       borderRadius: BorderRadius.all(Radius.circular(10)),
          //     ),
          //     child: const Text(
          //       "Add to cart",
          //       style: TextStyle(
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
