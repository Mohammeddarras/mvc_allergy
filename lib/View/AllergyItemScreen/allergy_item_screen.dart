import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mvc_allergy_app/Constant/constant.dart';
import 'package:mvc_allergy_app/Controller/allergy_controller.dart';
import 'package:mvc_allergy_app/Model/allergy_info.dart';
import 'package:mvc_allergy_app/View/Dialog/save_dialog.dart';
import 'package:mvc_allergy_app/View/ForgotScreen/forgot_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllergyItemScreen extends StatefulWidget {
  const AllergyItemScreen({Key? key}) : super(key: key);

  static const String id = "AllergyItemScreen";

  @override
  _AllergyItemScreenState createState() => _AllergyItemScreenState();
}

class _AllergyItemScreenState extends State<AllergyItemScreen> {
  List<Allergy> allergies = [];
  List<Allergy> userAllergies = [];
  List<String> selectedItems = [];
  bool isLoading = true;

  final ScrollController _scrollController = ScrollController();
  AllergyController allergyController = Get.put(AllergyController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final preferences = await SharedPreferences.getInstance();
      final result = await allergyController.getAllergyItem();

      final allergiesUser = await allergyController.getUserAllergyItem(preferences.getInt('user_id').toString());
      userAllergies.addAll(allergiesUser['data']);
      for (final allergy in userAllergies) {
        selectedItems.add(allergy.itemID.toString());
      }
      allergies.addAll(result['data']);
      setState(() => isLoading = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Allergy Item"),
        backgroundColor: kColor,
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: allergies.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              final allergy = allergies[index];
              return SizedBox(
                height: 40,
                child: ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                  // onTap: () => onItemClicked(),
                  leading: Checkbox(
                    activeColor: Colors.grey,
                    checkColor: Colors.white,
                    value: selectedItems.contains(allergy.id.toString()),
                    onChanged: (value) {
                      if (selectedItems.contains(allergy.id.toString())) {
                        selectedItems.remove(allergy.id.toString());
                      } else {
                        selectedItems.add(allergy.id.toString());
                      }
                      setState(() {

                      });
                      print("selectedItems: ${selectedItems.length}");
                      selectedItems.forEach((element) {
                        print("element: $element");
                      });
                    },
                  ),
                  title: Text(
                    allergy.englishName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: kColor,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.save,
                size: 30,
              ),
              const SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                  onTap: () {
                    allergyController.addAllergyItems(selectedItems.join(','));
                    messageSave();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 25),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
