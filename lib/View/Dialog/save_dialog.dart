import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

FutureOr<String?> messageSave() async {
  final dialog = await Get.dialog(
    Dialog(
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child:  Text('Save Allergy'),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('OK')),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );

  return dialog;
}
