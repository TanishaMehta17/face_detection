import 'dart:async';
import 'package:face_detection/home.dart';
import 'package:flutter/material.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  void initState() {
    super.initState();
    // Wait for 5 seconds before navigating to the main screen
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Column(
        children: [Center(child: Image.asset("assets/images/c.png"))],
      ),
    );
  }
}
