import 'package:flutter/material.dart';

import '../main.dart';
import 'ButtonWidget.dart';
import 'TextFieldWidget.dart';

Future showReceivePayDialogue(
    {required String docId,
    required String name,
    required String price,
    required String price160,
    required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            backgroundColor: Colors.white,
            child: ReceivePayDialogWidget(
                price: price, price160: price160, name: name, docId: docId),
          ));
}

class ReceivePayDialogWidget extends StatefulWidget {
  ReceivePayDialogWidget(
      {super.key,
      required this.price160,
      required this.price,
      required this.docId,
      required this.name});

  String price;
  String price160;
  String docId;
  String name;

  @override
  State<ReceivePayDialogWidget> createState() => _ReceivePayDialogWidgetState();
}

class _ReceivePayDialogWidgetState extends State<ReceivePayDialogWidget> {
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
                    "Payment",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.price,
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
                    "Payment(160)",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.price160,
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
                },haveHeading: true,onChange: (text){},
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
                          await appConstants.milkServices.receivePayment(
                              payment: paymentController.text.trim(),
                              docId: widget.docId,
                              name: widget.name,
                              price: widget.price,
                              price160: widget.price160,
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
