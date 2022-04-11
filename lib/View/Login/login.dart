import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart' as GET;
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:mvc_allergy_app/Config/size_config.dart';
import 'package:mvc_allergy_app/Constant/constant.dart';
import 'package:mvc_allergy_app/Controller/allergy_controller.dart';
import 'package:mvc_allergy_app/View/AllergyItemScreen/allergy_item_screen.dart';
import 'package:mvc_allergy_app/View/ForgotScreen/forgot_password_screen.dart';
import 'package:mvc_allergy_app/View/HomeScreen/home_screen.dart';
import 'package:mvc_allergy_app/View/Register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static const String id = "Login";

  @override
  _LoginState createState() => _LoginState();
}

AllergyController allergyController = Get.put(AllergyController());

TextEditingController mobileController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginState extends State<Login> {

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
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70))),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widgets.buildLogo(context),
                widgets.buildTextField(context),
                widgets.buildSignUp(context)
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
          child: Image.asset("assets/images/logo.png",height: 80.0),
        )
      ],
    );
  }

  Widget buildTextField(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20),),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
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
                      "Login",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30,
                          fontWeight: FontWeight.bold,
                          color: kColor),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    enabled: true,
                    onChanged: (val){
                      print("VAL: $val");
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: kColor,
                        ),
                        labelText: "Mobile Number"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: kColor,
                        ),
                        suffixIcon: Icon(FontAwesomeIcons.eyeSlash),
                        labelText: "Password"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Get.to(const ForgotPasswordScreen());
                      },
                      child: const Text("forget password"),
                    ),
                  ],
                ),
                SizedBox(height: getProportionalHeight(15),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1.4 * (MediaQuery.of(context).size.height / 20),
                      width: 5 * (MediaQuery.of(context).size.width / 10),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: kColor,
                        onPressed: (){
                          allergyController.login(mobileController.text.toString(), passwordController.text.toString());
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Login",
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
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildSignUp(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:const EdgeInsets.only(top: 1),
          child: FlatButton(
            onPressed: () {
              Get.to(const Register());
              },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                      color: kColor,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
