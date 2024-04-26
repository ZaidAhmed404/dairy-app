import 'package:flutter/material.dart';
import 'package:meo_shop/main.dart';

import 'ButtonWidget.dart';
import 'TextFieldWidget.dart';

Future showPayDialogue(
    {required String docId,
    required String name,
    required String payment_5,
    required String payment_6,
    required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            backgroundColor: Colors.white,
            child: PayDialogWidget(
                payment_5: payment_5,
                payment_6: payment_6,
                name: name,
                docId: docId),
          ));
}

class PayDialogWidget extends StatefulWidget {
  PayDialogWidget(
      {super.key,
      required this.payment_6,
      required this.payment_5,
      required this.docId,
      required this.name});

  String payment_5;
  String payment_6;
  String docId;
  String name;

  @override
  State<PayDialogWidget> createState() => _PayDialogWidgetState();
}

class _PayDialogWidgetState extends State<PayDialogWidget> {
  TextEditingController paymentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Payment",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Payment with 5 Fat",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.payment_5,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Payment with 6 Fat",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.payment_6,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                textFieldWidth: MediaQuery.of(context).size.width,
                hintText: "Enter Payment",
                text: "Payment",
                controller: paymentController,
                isPassword: false,
                isEnabled: true,
                textInputType: TextInputType.number,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Payment is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : ButtonWidget(
                      onPressedFunction: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await appConstants.milkServices.addPaymentSent(
                              payment: paymentController.text.trim(),
                              docId: widget.docId,
                              name: widget.name,
                              totalPayment5: widget.payment_5,
                              totalPayment6: widget.payment_6,
                              context: context);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      buttonText: "Save",
                      buttonColor: Colors.blue,
                      borderColor: Colors.blue,
                      textColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
