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
import 'package:mvc_allergy_app/View/Login/login.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  static const String id = "Register";

  @override
  _RegisterState createState() => _RegisterState();
}
AllergyController allergyController = Get.put(AllergyController());

TextEditingController nameController = TextEditingController();
TextEditingController mobileController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _RegisterState extends State<Register> {

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
                widgets.buildLogin(context)
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
          padding: const EdgeInsets.only(bottom: 20,top: 40),
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
          borderRadius: const BorderRadius.all(Radius.circular(20),),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration:const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register",
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
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.user,
                          color: kColor,
                        ),
                        labelText: "Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
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
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.checkDouble,
                          color: kColor,
                        ),
                        suffixIcon: Icon(FontAwesomeIcons.eyeSlash),
                        labelText: "Confirm Password"),
                  ),
                ),
                SizedBox(height: getProportionalHeight(20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1.4 * (MediaQuery
                          .of(context)
                          .size
                          .height / 20),
                      width: 5 * (MediaQuery
                          .of(context)
                          .size
                          .width / 10),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: kColor,
                        onPressed: () {
                          allergyController.register(nameController.text.toString(), mobileController.text.toString(), passwordController.text.toString(),);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Register",
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

  Widget buildLogin(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: FlatButton(
            onPressed: () {
              Get.to(const Login());
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Do you have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height / 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Login',
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
