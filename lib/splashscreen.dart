import 'dart:async';
import 'package:face_detection/app_routes.dart';
import 'package:face_detection/home.dart';
import 'package:flutter/material.dart';

class MySplash extends StatefulWidget {
  static const routeName = "/splash";
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  void initState() {
    super.initState();
    // Wait for 5 seconds before navigating to the main screen
    // Timer(Duration(seconds: 4), () {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => const Home()),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Column(
        children: [
          const SizedBox(height: 150),
          Center(
              child: Image.network(
                  "https://cdn1.expresscomputer.in/wp-content/uploads/2021/03/24161759/EC_Artificial_Intelligence_750.jpg",
                  width: 450,
                  height: 200)),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.catndDog);
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 250,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(6)),
              child: const Text(
                "Cat nd Dog Detector",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.object);
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 250,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(6)),
              child: const Text(
                "Object Detector",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
