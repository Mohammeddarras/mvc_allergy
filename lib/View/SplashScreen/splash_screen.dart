import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mvc_allergy_app/Controller/allergy_controller.dart';
import 'package:mvc_allergy_app/View/Login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AllergyController allergyController = Get.put(AllergyController());

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if(preferences.getInt('user_id') != null){
      allergyController.checkUserItems(preferences.getInt('user_id').toString());
    }else {
      Get.to(const Login());
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),() {
      getPref();
      // savePref(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png',height: 150.0),
          ],
        ),
      ),
    );
  }
}
