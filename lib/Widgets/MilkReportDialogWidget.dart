import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future showMilkReportDialogWidget({required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            backgroundColor: Colors.white,
            child: MilkReportDialogWidget(),
          ));
}

class MilkReportDialogWidget extends StatefulWidget {
  MilkReportDialogWidget({
    super.key,
  });

  @override
  State<MilkReportDialogWidget> createState() => _MilkReportDialogWidgetState();
}

class _MilkReportDialogWidgetState extends State<MilkReportDialogWidget> {
  TextEditingController paymentController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnalytics();
  }

  String total = "0";

  getAnalytics() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('analytics')
        .doc("0pBF1p9wVCcoAsbAWt64")
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        setState(() {
          total = doc["total"].toString();
        });
        log(total);
      }
    }).catchError((error) {
      print("Error getting document: $error");
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Milk Report",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Milk",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        total,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
