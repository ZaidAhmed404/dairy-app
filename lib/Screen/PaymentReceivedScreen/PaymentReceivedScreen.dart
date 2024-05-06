import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Model/PaymentPendingModel.dart';
import '../../Model/PaymentReceivedModel.dart';
import '../../Widgets/ReceivePaymentDialogWidget.dart';
import '../../Widgets/TextFieldWidget.dart';

enum options { All, Pending }

class PaymentReceivedScreen extends StatefulWidget {
  PaymentReceivedScreen({
    super.key,
  });

  @override
  State<PaymentReceivedScreen> createState() => _PaymentReceivedScreenState();
}

class _PaymentReceivedScreenState extends State<PaymentReceivedScreen> {
  options? _character = options.All;
  String selected = "All";
  int itemPerPage = 100;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Payment Received",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Row(
                  children: [
                    Radio<options>(
                      value: options.All,
                      groupValue: _character,
                      activeColor: Colors.blue,
                      onChanged: (options? value) {
                        setState(() {
                          _character = value;
                          selected = "All";
                        });
                      },
                    ),
                    const Text('All'),
                  ],
                ),
                Row(
                  children: [
                    Radio<options>(
                      value: options.Pending,
                      activeColor: Colors.blue,
                      groupValue: _character,
                      onChanged: (options? value) {
                        setState(() {
                          _character = value;

                          selected = "Pending";
                          log("$_character");
                        });
                      },
                    ),
                    const Text('Pending'),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            TextFieldWidget(
              textFieldWidth: MediaQuery.of(context).size.width,
              hintText: "Search Name",
              text: "Name",
              controller: searchController,
              isPassword: false,
              isEnabled: true,
              textInputType: TextInputType.text,
              validationFunction: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              haveHeading: false,
              onChange: (text) {
                setState(() {});
              },
            ),
            if (selected == "Pending")
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('payment_pending')
                      .orderBy('date')
                      .limit(itemPerPage)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    List<PaymentPendingModel> paymentData = [];
                    if (searchController.text.isNotEmpty) {
                      paymentData = snapshot.data!.docs
                          .map((doc) {
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            return PaymentPendingModel.fromJson(data, doc.id);
                          })
                          .where((element) =>
                              element.name.contains(searchController.text))
                          .toList();
                    } else {
                      paymentData = snapshot.data!.docs.map((doc) {
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        return PaymentPendingModel.fromJson(data, doc.id);
                      }).toList();
                    }

                    // final documents = snapshot.data!.docs;

                    return SizedBox(
                      child: ListView.builder(
                        itemCount: paymentData.length,
                        itemBuilder: (context, index) {
                          PaymentPendingModel payment = paymentData[index];
                          return Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey)),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width * 0.2,
                                          child: Text(
                                            payment.date,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                            payment.name,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: IconButton(
                                              onPressed: () =>
                                                  showReceivePayDialogue(
                                                      context: context,
                                                      docId: payment.id,
                                                      price: payment.pending,
                                                      price160:
                                                          payment.pending160,
                                                      name: payment.name),
                                              icon: const Icon(
                                                Icons.payment,
                                                color: Colors.blue,
                                              )),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width * 0.2,
                                          child: const Text(
                                            "Pending",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                            payment.pending,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            if (selected == "All")
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('payment_received')
                      .limit(itemPerPage)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    List<PaymentReceivedModel> paymentData = [];
                    if (searchController.text.isNotEmpty) {
                      paymentData = snapshot.data!.docs
                          .map((doc) {
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            return PaymentReceivedModel.fromJson(data);
                          })
                          .where((element) =>
                              element.name.contains(searchController.text))
                          .toList();
                    } else {
                      paymentData = snapshot.data!.docs.map((doc) {
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        return PaymentReceivedModel.fromJson(data);
                      }).toList();
                    }

                    return SizedBox(
                      child: ListView.builder(
                        itemCount: paymentData.length,
                        itemBuilder: (context, index) {
                          PaymentReceivedModel payment = paymentData[index];
                          return Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey)),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                            payment.date,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                            payment.name,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          child: const Text(
                                            "Payment",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                            payment.payment,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            Row(
              children: [
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: IconButton(
                      onPressed: () {
                        int value = itemPerPage - 100;
                        if (value != 0) {
                          setState(() {
                            itemPerPage = value;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.blue,
                      )),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: IconButton(
                      onPressed: () {
                        int value = itemPerPage + 100;
                        if (value != 0) {
                          setState(() {
                            itemPerPage = value;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.blue,
                      )),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
