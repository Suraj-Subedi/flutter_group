import 'package:flutter/material.dart';
import 'package:june_20/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  int numberOfProducts = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const Home(),
      Cart(
        numberOfProducts: numberOfProducts,
      ),
      const Profile()
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Row'),
        centerTitle: true,
      ),
      backgroundColor: Colors.teal,
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            print(value);
            setState(() {
              currentIndex = value;
            });
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ]),
      drawer: Drawer(
          child: SafeArea(
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
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          setState(() {
            numberOfProducts++;
          });
        },
        child: const Icon(
          Icons.add_task_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
