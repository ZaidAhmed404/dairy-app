import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meo_shop/Model/PaymentSentModel.dart';

class PaymentSentScreen extends StatefulWidget {
  PaymentSentScreen({
    super.key,
  });

  @override
  State<PaymentSentScreen> createState() => _PaymentSentScreenState();
}

class _PaymentSentScreenState extends State<PaymentSentScreen> {
  int itemPerPage = 100;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Text(
                  "Payment Sent",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('payment_sent')
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
                  List<PaymentSentModel> paymentData =
                      snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    return PaymentSentModel.fromJson(data);
                  }).toList();

                  return SizedBox(
                    child: ListView.builder(
                      itemCount: paymentData.length,
                      itemBuilder: (context, index) {
                        PaymentSentModel payment = paymentData[index];
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
                                        width: width * 0.45,
                                        child: Text(
                                          payment.name,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.4,
                                        child: Text(
                                          "${payment.paymentSent} (${payment.date})",
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
                                        width: width * 0.45,
                                        child: const Text(
                                          "Pending payment(6 fat)",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.4,
                                        child: Text(
                                          payment.pendingPrice6,
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
                                        width: width * 0.45,
                                        child: const Text(
                                          "Pending payment(5 fat)",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.4,
                                        child: Text(
                                          payment.pendingPrice5,
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
