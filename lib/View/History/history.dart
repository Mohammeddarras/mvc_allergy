import 'package:flutter/material.dart';
import 'package:mvc_allergy_app/Constant/constant.dart';
import 'package:mvc_allergy_app/Controller/allergy_controller.dart';
import 'package:mvc_allergy_app/Model/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<HistoryModel> _history = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final prefs = await SharedPreferences.getInstance();
      final result = await AllergyController().getHistory(prefs.getInt('user_id').toString());
      _history.addAll(result);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("History"),
        backgroundColor: kColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final item in _history) ...[
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: item.allergy_items.isNotEmpty ? Colors.red : kColor,
                        width: 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Scanned Items: ${item.request_items}'),
                    if (item.allergy_items.isNotEmpty) ...[
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Allergy Items: ${item.allergy_items}'),
                    ],
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Date: ${item.created_at}")
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ]
          ],
        ),
      ),
    );
  }
}
