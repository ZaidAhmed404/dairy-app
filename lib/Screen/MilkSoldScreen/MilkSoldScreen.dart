import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Model/MilkSentModel.dart';

class MilkSoldScreen extends StatefulWidget {
  Function(int) onAddPressed;

  MilkSoldScreen({super.key, required this.onAddPressed});

  @override
  State<MilkSoldScreen> createState() => _MilkSoldScreenState();
}

class _MilkSoldScreenState extends State<MilkSoldScreen> {
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
                  "Milk Sold",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const Spacer(),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                        onPressed: () {
                          widget.onAddPressed(6);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        )))
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('milk_sent')
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
                  List<MilkSentModel> milkData = snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    return MilkSentModel.fromMap(data);
                  }).toList();
                  return SizedBox(
                    child: ListView.builder(
                      itemCount: milkData.length,
                      itemBuilder: (context, index) {
                        MilkSentModel milk = milkData[index];
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
                                        width: width * 0.4,
                                        child: Text(
                                          "(${milk.date}) ${milk.name}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                          milk.rate,
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
                                          "Milk",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                          milk.milk,
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
                                          "Milk(5 fat)",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                          milk.milk_5,
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
                                          "Milk Price",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                          milk.pending,
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
                                          "Milk payment(160)",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.4,
                                        child: Text(
                                          milk.pending160,
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
