import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meo_shop/Widgets/PayDialogWidget.dart';

import '../../Model/MilkReceivedModel.dart';
import '../../Widgets/ConfirmDialogWidget.dart';
import '../../Widgets/MilkReportDialogWidget.dart';

class MilkReceiveScreen extends StatefulWidget {
  Function(int) onAddPressed;

  MilkReceiveScreen({super.key, required this.onAddPressed});

  @override
  State<MilkReceiveScreen> createState() => _MilkReceiveScreenState();
}

class _MilkReceiveScreenState extends State<MilkReceiveScreen> {
  int itemPerPage = 100;

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
                  "Milk Received",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const Spacer(),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                        onPressed: () => showMilkReportDialogWidget(
                              context: context,
                            ),
                        icon: const Icon(
                          Icons.info,
                          color: Colors.blue,
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                        onPressed: () {
                          widget.onAddPressed(5);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        ))),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('milk_received')
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
                  List<MilkReceivedModel> milkData =
                      snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    return MilkReceivedModel.fromMap(data);
                  }).toList();
                  final documents = snapshot.data!.docs;
                  return SizedBox(
                    child: ListView.builder(
                      itemCount: milkData.length,
                      itemBuilder: (context, index) {
                        MilkReceivedModel milk = milkData[index];
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 5),
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
                                        width: width * 0.3,
                                        child: Text(
                                          "(${milk.date}) ${milk.name}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: width * 0.2,
                                        child: Text(
                                          milk.price,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => Dialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child:
                                                          ConfirmDialogWidget(
                                                        docId:
                                                            documents[index].id,
                                                        milk: milk.totalMilk,
                                                      )));
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: IconButton(
                                            onPressed: () => showPayDialogue(
                                                context: context,
                                                docId: documents[index].id,
                                                payment_5: milk.price5,
                                                payment_6: milk.price6,
                                                name: milk.name),
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
                                        width: width * 0.25,
                                      ),
                                      SizedBox(
                                        width: width * 0.25,
                                        child: const Text(
                                          "Fat 5",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.25,
                                        child: const Text(
                                          "Fat 6",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
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
                                        width: width * 0.25,
                                        child: const Text(
                                          "Milk",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.25,
                                        child: Text(
                                          milk.totalMilk5,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.25,
                                        child: Text(
                                          milk.totalMilk6,
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
                                        width: width * 0.25,
                                        child: const Text(
                                          "Price",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.25,
                                        child: Text(
                                          milk.price5,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.25,
                                        child: Text(
                                          milk.price6,
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
