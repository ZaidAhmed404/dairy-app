import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/MessageWidget.dart';
import '../cubit/LoadingCubit/loading_cubit.dart';

class MilkServices {
  CollectionReference milkReceived =
      FirebaseFirestore.instance.collection('milk_received');
  CollectionReference paymentSent =
      FirebaseFirestore.instance.collection('payment_sent');
  CollectionReference milkSent =
      FirebaseFirestore.instance.collection('milk_sent');

  CollectionReference paymentReceived =
      FirebaseFirestore.instance.collection('payment_received');
  CollectionReference paymentPending =
      FirebaseFirestore.instance.collection('payment_pending');
  CollectionReference analytics =
      FirebaseFirestore.instance.collection('analytics');

  Future<void> addMilk(
      {required String name,
      required String milk1,
      required String fat1,
      required String milk2,
      required String fat2,
      required String milk3,
      required String fat3,
      required String milk4,
      required String fat4,
      required String milk5,
      required String fat5,
      required String price,
      required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    // try {
    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(true);
    }
    int total = 0;

    await analytics
        .doc("0pBF1p9wVCcoAsbAWt64")
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        log(doc["total"].toString(), name: "total");
        total = int.parse(doc["total"].toString());
      }
    }).catchError((error) {
      print("Error getting document: $error");
    });
    total = total +
        int.parse(milk1) +
        int.parse(milk2) +
        int.parse(milk3) +
        int.parse(milk4) +
        int.parse(milk5);

    log("${total}", name: "total");

    await analytics.doc("0pBF1p9wVCcoAsbAWt64").set({"total": total});

    double totalMilk5 = ((double.parse(milk1) * double.parse(fat1)) / 5) +
        ((double.parse(milk2) * double.parse(fat2)) / 5) +
        ((double.parse(milk3) * double.parse(fat3)) / 5) +
        ((double.parse(milk4) * double.parse(fat4)) / 5) +
        ((double.parse(milk5) * double.parse(fat5)) / 5);
    double totalMilk6 = ((double.parse(milk1) * double.parse(fat1)) / 6) +
        ((double.parse(milk2) * double.parse(fat2)) / 6) +
        ((double.parse(milk3) * double.parse(fat3)) / 6) +
        ((double.parse(milk4) * double.parse(fat4)) / 6) +
        ((double.parse(milk5) * double.parse(fat5)) / 6);
    final now = DateTime.now();
    await milkReceived
        .add({
          "name": name,
          "milk_1": milk1,
          "fat_1": fat1,
          "milk_2": milk2,
          "fat_2": fat2,
          "milk_3": milk3,
          "fat_3": fat3,
          "milk_4": milk4,
          "fat_4": fat4,
          "milk_5": milk5,
          "fat_5": fat5,
          "price": price,
          "totalMilk": int.parse(milk1) +
              int.parse(milk2) +
              int.parse(milk3) +
              int.parse(milk4) +
              int.parse(milk5),
          "total_5": totalMilk5,
          "total_6": totalMilk6,
          "price_5": double.parse(price) * totalMilk5,
          "price_6": double.parse(price) * totalMilk6,
          "rate": price,
          "date": "${now.day}-${now.month}-${now.year}",
        })
        .then((value) => log("Milk data Added", name: "success"))
        .catchError(
            (error) => log("Failed to add milk data: $error", name: "error"));
    if (context.mounted) {
      messageWidget(
          context: context,
          isError: false,
          message: "Data Entered Successfully");
    }
    // } catch (error) {
    //   if (context.mounted) {
    //     messageWidget(
    //         context: context, isError: true, message: error.toString());
    //   }
    // }
    BlocProvider.of<LoadingCubit>(context).setLoading(false);
  }

  addPaymentSent(
      {required String payment,
      required String docId,
      required String name,
      required String totalPayment5,
      required String totalPayment6,
      required BuildContext context}) async {
    try {
      final now = DateTime.now();

      await milkReceived
          .doc(docId)
          .update({
            "price_5": double.parse(totalPayment5) - double.parse(payment),
            "price_6": double.parse(totalPayment6) - double.parse(payment),
          })
          .then((_) => log('milk data updated successfully', name: "success"))
          .catchError(
              (error) => log('error in updating milk data', name: "error"));

      await paymentSent
          .add({
            "name": name,
            "payment_sent": payment,
            "date": "${now.day}-${now.month}-${now.year}",
            "pending_price_5":
                double.parse(totalPayment5) - double.parse(payment),
            "pending_price_6":
                double.parse(totalPayment6) - double.parse(payment),
          })
          .then((value) => log("Payment data Added", name: "success"))
          .catchError((error) =>
              log("Failed to add payment data: $error", name: "error"));

      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "Payment Added Successfully");
        Navigator.pop(context);
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());

        Navigator.pop(context);
      }
    }
  }

  Future<void> sendMilk(
      {required String name,
      required String milk,
      required String fat,
      required String price,
      required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    try {
      if (context.mounted) {
        BlocProvider.of<LoadingCubit>(context).setLoading(true);
      }
      int total = 0;

      await analytics
          .doc("0pBF1p9wVCcoAsbAWt64")
          .get()
          .then((DocumentSnapshot doc) {
        if (doc.exists) {
          log(doc["total"].toString(), name: "total");
          total = int.parse(doc["total"].toString());
        }
      }).catchError((error) {
        print("Error getting document: $error");
      });

      await analytics
          .doc("0pBF1p9wVCcoAsbAWt64")
          .set({"total": total - int.parse(milk)});
      final now = DateTime.now();
      String docId = "";
      await milkSent.add({
        "name": name,
        "milk": milk,
        "fat": fat,
        "rate": price,
        "milk_5": (double.parse(milk) * double.parse(fat)) / 5,
        "pending": double.parse(milk) * double.parse(price),
        "pending_160": double.parse(milk) * 160,
        "date": "${now.day}-${now.month}-${now.year}"
      }).then((value) {
        log("Milk data Added ${value.id}", name: "success");
        docId = value.id;
      }).catchError((error) {
        log("Failed to add milk data: $error", name: "error");
      });

      await paymentPending
          .doc(docId)
          .set({
            "name": name,
            "pending": double.parse(milk) * double.parse(price),
            "pending_160": double.parse(milk) * 160,
            "date": "${now.day}-${now.month}-${now.year}"
          })
          .then((value) => log("Payment added data Added", name: "success"))
          .catchError((error) =>
              log("Failed to add payment data: $error", name: "error"));
      if (context.mounted) {
        BlocProvider.of<LoadingCubit>(context).setLoading(false);
        messageWidget(
            context: context,
            isError: false,
            message: "Data Entered Successfully");
      }
    } catch (error) {
      if (context.mounted) {
        BlocProvider.of<LoadingCubit>(context).setLoading(false);
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }

  receivePayment(
      {required String name,
      required String docId,
      required String payment,
      required String price,
      required String price160,
      required BuildContext context}) async {
    final now = DateTime.now();

    try {
      // await milkSent
      //     .doc(docId)
      //     .update({
      //       "pending": double.parse(price) - double.parse(payment),
      //       "pending_160": double.parse(price160) - double.parse(payment),
      //     })
      //     .then((value) {})
      //     .catchError((error) {
      //       log("Failed to add milk data: $error", name: "error");
      //     });
      await paymentReceived
          .add({
            "name": name,
            "payment": payment,
            "date": "${now.day}-${now.month}-${now.year}"
          })
          .then((value) => log("Payment added data Added", name: "success"))
          .catchError((error) =>
              log("Failed to add payment data: $error", name: "error"));
      await paymentPending
          .doc(docId)
          .update({
            "name": name,
            "pending": double.parse(price) - double.parse(payment),
            "pending_160": double.parse(price160) - double.parse(payment),
          })
          .then((value) => log("Payment added data Added", name: "success"))
          .catchError((error) =>
              log("Failed to add payment data: $error", name: "error"));
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "Payment Added Successfully");
        Navigator.pop(context);
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
        Navigator.pop(context);
      }
    }
  }

  deleteMilkReceived({required String docId, required String milk}) async {
    try {
      int total = 0;
      await analytics
          .doc("0pBF1p9wVCcoAsbAWt64")
          .get()
          .then((DocumentSnapshot doc) {
        if (doc.exists) {
          total = doc["total"];

          log("$total");
        }
      }).catchError((error) {
        print("Error getting document: $error");
      });
      log("$milk", name: "milk");
      log("${total - int.parse(milk)}");
      await analytics
          .doc("0pBF1p9wVCcoAsbAWt64")
          .set({"total": total - int.parse(milk)});
      await milkReceived.doc(docId).delete();
    } catch (e) {
      return false;
    }
  }
}
