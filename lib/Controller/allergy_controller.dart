import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:mvc_allergy_app/Constant/constant.dart';
import 'package:mvc_allergy_app/Model/allergy_info.dart';
import 'package:mvc_allergy_app/Model/history.dart';
import 'package:mvc_allergy_app/View/AllergyItemScreen/allergy_item_screen.dart';
import 'package:mvc_allergy_app/View/ForgotScreen/new_password_screen.dart';
import 'package:mvc_allergy_app/View/HomeScreen/home_screen.dart';
import 'package:mvc_allergy_app/View/Login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllergyController extends GetxController{

  var client = http.Client();

  Future<Map<String, dynamic>> getAllergyItem() async {
    // var allergy;
    try {
      print('$IP/allergy/web-service/index.php?action=get_allergy_items');
      final response = await client.get(Uri.parse('$IP/allergy/web-service/index.php?action=get_allergy_items'));
      final jsonResponse = jsonDecode(response.body);

      return {
        'data': List<Allergy>.from(jsonResponse['response'].map((e) => Allergy.fromJson(e))),
      };
    } catch (Exception) {
      print(Exception);
      return {};
    }
  }

  Future<Map<String, dynamic>> getUserAllergyItem(final String userID) async {
    try {
      print('$IP/allergy/web-service/index.php?action=get_allergy_items');
      final response = await client.get(Uri.parse(
          '$IP/allergy/web-service/index.php?action=get_user_items&user_id=$userID'));
      final jsonResponse = jsonDecode(response.body);

      return {
        'data': List<Allergy>.from(jsonResponse['response'].map((e) => Allergy.fromJson(e))),
      };
    } catch (Exception) {
      print(Exception);
      return {};
    }
  }

  Future<Map<String, dynamic>> checkAllergy(final String items, userID) async {
    try {
      final response = await client
          .post(Uri.parse('$IP/allergy/web-service/index.php?'), body: {
        'user_id': userID,
        'items': items,
        'action': 'check_user_items'
      });
      var jsonResponse = jsonDecode(response.body.toString());
      print("jsonResponse of check allergy: $jsonResponse");
      return {
        'error_code': jsonResponse['response']['error_code'],
        if (jsonResponse['response']['allergy_items'] != null)
          'data': List<Allergy>.from(jsonResponse['response']['allergy_items']?.map((e) => Allergy.fromJson(e))),
      };
    } catch (Exception) {
      print(Exception);
      return {};
    }
  }

  Future<List<HistoryModel>> getHistory(final String userID) async {
    try {
      final response = await client.get(Uri.parse(
          '$IP/allergy/web-service/index.php?action=user_allergy_items_histroy&user_id=$userID'));
      var jsonResponse = jsonDecode(response.body.toString());
      print("jsonResponse of check allergy: $jsonResponse");
      return List<HistoryModel>.from(jsonResponse['response']?.map((e) => HistoryModel.fromJson(e)));
    } catch (Exception) {
      print(Exception);
      return [];
    }
  }

  checkUserItems(String userID) async {
    try{
      Response response = await post(
          Uri.parse('$IP/allergy/web-service/index.php/'),
          body: {
            'user_id' : userID,
            'action' : 'check_user_items_count'
          }
      );

      var data = jsonDecode(response.body.toString());
      print("data of checkUserItems is: $data");

      if (data['response']['error_code'] == "0") {
        Get.to(const HomeScreen());
      } else {
        return Get.off(const AllergyItemScreen());
      }
    }catch(e){
      print(e.toString());
    }
  }

  login(String mobile , password) async {
    try{
      Response response = await post(
          Uri.parse('$IP/allergy/web-service/index.php?'),
          body: {
            'mobile' : mobile,
            'password' : password,
            'action' : 'login'
          }
      );

      var data = jsonDecode(response.body.toString());
      print("data of login is: $data");
      if (data['response']['error_code'] == "0") {
        final preferences = await SharedPreferences.getInstance();
        preferences.setInt('user_id', data['response']['id']);
        checkUserItems(preferences.getInt('user_id').toString());

      } else {
        return
           Get.snackbar(
              "Login",
              "${data['response']['error_msg_ar']}",
             snackPosition: SnackPosition.BOTTOM,
            );
      }
    }catch(e){
      print(e.toString());
    }
  }

  register(String name , mobile , password ) async {
    try{
      Response response = await post(
          Uri.parse('$IP/allergy/web-service/index.php?'),
          body: {
            'name' : name,
            'mobile' : mobile,
            'password' : password,
            'action' : 'register'
          }
      );

      var data = jsonDecode(response.body.toString());
      if(data['response']['mobile'] != "" && data['response']['password'] != "") {
        if (data['response']['error_code'] == "0") {
          print('Register successfully');
          Get.off(const AllergyItemScreen());
        } else {
          print(data['response']['error_msg_ar']);
          return Get.snackbar(
            "Register",
            "${data['response']['error_msg_ar']}",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    }catch(e){
      print(e.toString());
    }
  }

  forgot(String mobile) async {
    try{
      Response response = await post(
          Uri.parse('$IP/allergy/web-service/index.php?'),
          body: {
            'mobile' : mobile,
            'action' : 'forgot_password'
          }
      );


      var data = jsonDecode(response.body.toString());
      if(data['response']['mobile'] != ""){
        if(data['response']['error_code'] == "0"){
          print('Mobile successfully');
          Get.to(NewPasswordScreen(id: data['response']['user_id'],));

        }else {
          print(data['response']['error_msg_ar']);
          return Get.snackbar(
            "Forgot Password",
            "${data['response']['error_msg_ar']}",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    }catch(e){
      print(e.toString());
    }
  }

  newPassword(int id, String password) async {

    try{
      Response response = await post(
          Uri.parse('$IP/allergy/web-service/index.php?'),
          body: {
            'user_id' : id.toString(),
            'password' : password,
            'action' : 'change_password'
          }
      );

      var data = jsonDecode(response.body.toString());
      if(data['response']['password'] != ""){
        if(data['response']['error_code'] == "0"){
          print('Update successfully');
          Get.to(const Login());

        }else {
          print(data['response']['error_msg_ar']);
          return Get.snackbar(
            "New Password",
            "${data['response']['error_msg_ar']}",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    }catch(e){
      print(e.toString());
    }
  }

  addAllergyItems(String items) async {
    if (items.isEmpty) {
      return;
    }
    final preferences = await SharedPreferences.getInstance();
    try {
      Response response = await post(Uri.parse('$IP/allergy/web-service/index.php?'), body: {
        'user_id': preferences.getInt('user_id').toString(),
        'items': items,
        'action': 'add_allergy_items'
      });

      var data = jsonDecode(response.body.toString());
      print("data: $data");
      if (data['response']['error_code'] == "0") {
      } else {
        print(data['response']['error_msg_ar']);
        return data['response']['error_msg_ar'];
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
