
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:get/get.dart';
import 'package:mvc_allergy_app/Constant/constant.dart';
import 'package:mvc_allergy_app/Controller/allergy_controller.dart';
import 'package:mvc_allergy_app/View/AllergyItemScreen/allergy_item_screen.dart';
import 'package:mvc_allergy_app/View/Dialog/show_allergy.dart';
import 'package:mvc_allergy_app/View/History/history.dart';
import 'package:mvc_allergy_app/View/Login/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String finalText = "";
  bool isInitilized = false;
  List<OcrText> list = [];

  _startScan() async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      try {
        final scanResult = await FlutterMobileVision.read(
          waitTap: true,
          forceCloseCameraOnTap: true,
          fps: 5,
          multiple: true,
        );
        List<String> itemsScanned = [];
        for(final scan in scanResult) {
          itemsScanned.add(scan.value);
        }

        final String items = itemsScanned.join(',');
        print("ITEMS TO SEND: $items");
        final prefs = await SharedPreferences.getInstance();
        final result = await AllergyController().checkAllergy(items, prefs.getInt('user_id').toString());
        print("result: $result");
        if (result['error_code'] == '0') {
          print("response(data): ${result['data']}");
          list = scanResult;
          showAllergy(result['data']);
        } else {
          showAllergy([], text: "You have no allergies from this product");
        }

        setState(() {
          list;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Allergy"),
        backgroundColor: kColor,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              width: 310,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: kColor,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Allergy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Allergy Item',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Get.to(const AllergyItemScreen());
              },
            ),
            ListTile(
              title: const Text(
                'History',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Get.to(History());
              },
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('user_id');
                Get.off(const Login());
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                  onTap: () {
                    _startScan();
                  },
                  child: const Icon(
                    Icons.camera_alt,
                    size: 130,
                  )),
            ),
            const Divider(
              thickness: 7.0,
              endIndent: 10.0,
              indent: 10.0,
              color: kColor,
            ),
            const SizedBox(
              height: 10.0,
            ),
            for (final item in list) ...[
              Text(
                "${item.value} \n ", style: const TextStyle(color: Colors.black),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
