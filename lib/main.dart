import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1 / 2,
                  child: Container(
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: const Center(
                        child: Text(
                      "Child 1",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // child: SingleChildScrollView(
        // child: Column(
        //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     for (int i = 0; i < 100; i++)
        //       Row(
        //         children: [
        //           Expanded(
        //             child: Container(
        //               height: 100,
        //               color: i % 2 == 0 ? Colors.white : Colors.blue,
        //             ),
        //           ),
        //           Expanded(
        //             child: Container(
        //               height: 100,
        //               color: i % 2 == 0 ? Colors.purple : Colors.red,
        //             ),
        //           ),
        //           Expanded(
        //             child: Container(
        //               height: 100,
        //               color: i % 2 == 0 ? Colors.black : Colors.orange,
        //             ),
        //           ),
        //         ],
        //       )
        //   ],
        // ),
        // ),
      ),
    );
  }
}
