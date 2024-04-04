
import 'package:face_detection/home.dart';
import 'package:face_detection/object.dart';
import 'package:face_detection/splashscreen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String catndDog = '/catnddog';
  static const String object = '/object';
  static const String splash = '/splash';
  static Map<String, WidgetBuilder> routes = {
   catndDog:(context)=> const Home(),
   object:(context) => const Home1(),
   splash:(context) => const MySplash()
  };
}
