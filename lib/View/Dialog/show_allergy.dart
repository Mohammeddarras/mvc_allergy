import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mvc_allergy_app/Model/allergy_info.dart';

FutureOr<String?> showAllergy(final List<Allergy> items, {final String text = ''}) async {
  final dialog = await Get.dialog(
    Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (items.isNotEmpty) ...[
              const Icon(
                Icons.warning,
                color: Colors.red,
                size: 50,
              ),
              const SizedBox(height: 16),
              Text(
                'You have allergy from the following items: ',
                textAlign: TextAlign.center,
                style: Theme.of(Get.context!)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
            ] else if (text.isNotEmpty) ...[
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              const SizedBox(height: 16),
              Text(text,
                  textAlign: TextAlign.center,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
            ],
            if (items.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < items.length; i++) ...[
                      Text(items[i].englishName),
                      const SizedBox(
                        height: 16,
                      ),
                    ]
                  ],
                ),
              ),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('OK'))
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );

  return dialog;
}
