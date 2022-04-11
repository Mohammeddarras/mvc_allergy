import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:get/get.dart' as GET;
import 'package:mvc_allergy_app/Config/size_config.dart';
import 'package:mvc_allergy_app/Constant/constant.dart';
import 'package:mvc_allergy_app/Controller/allergy_controller.dart';
import 'package:mvc_allergy_app/View/Login/login.dart';

import 'new_password_screen.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static const String id = "ForgotPassword";

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

AllergyController allergyController = Get.put(AllergyController());

TextEditingController mobileController = TextEditingController();

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  Widgets widgets = Widgets();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: const BoxDecoration(
                    color: kColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70), bottomRight: Radius.circular(70))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 8),
              child: IconButton(
                  onPressed: (){
                    Get.to(const Login());
                  },
                  icon:const Icon(Icons.arrow_back,size: 30,color: Colors.white,)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widgets.buildLogo(context),
                widgets.buildTextField(context),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Widgets {

  Widget buildLogo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Image.asset("assets/images/logo.png", height: 80.0),
        )
      ],
    );
  }

  Widget buildTextField(context) {

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 30,
                              fontWeight: FontWeight.bold,
                              color: kColor),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: kColor,
                            ),
                            labelText: "Mobile Number"),
                      ),
                    ),
                    SizedBox(height: getProportionalHeight(30),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1.4 * (MediaQuery.of(context).size.height / 20),
                          width: 5 * (MediaQuery.of(context).size.width / 10),
                          margin:const EdgeInsets.only(bottom: 20),
                          child: RaisedButton(
                            elevation: 5.0,
                            color: kColor,
                            onPressed: (){
                              allergyController.forgot(mobileController.text.toString());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize:
                                  MediaQuery.of(context).size.height / 40),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ]);
  }
}



