import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_allergy_app/View/SplashScreen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MVC App',
      home: SplashScreen(),
    );
  }
}
