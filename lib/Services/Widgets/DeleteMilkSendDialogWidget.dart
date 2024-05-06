import 'package:flutter/material.dart';

import '../../main.dart';

class DeleteMilkSoldDialogWidget extends StatefulWidget {
  DeleteMilkSoldDialogWidget(
      {super.key, required this.milk, required this.docId});

  String docId;
  String milk;

  @override
  State<DeleteMilkSoldDialogWidget> createState() =>
      _DeleteMilkSoldDialogWidgetState();
}

class _DeleteMilkSoldDialogWidgetState
    extends State<DeleteMilkSoldDialogWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Are you Sure?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    )),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      )
                    : TextButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await appConstants.milkServices.deleteMilkSold(
                              docId: widget.docId, milk: widget.milk);
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
