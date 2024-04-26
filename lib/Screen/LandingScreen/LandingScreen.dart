import 'package:flutter/material.dart';
import 'package:meo_shop/Screen/AddMilkSoldScreen/AddMilkSoldScreen.dart';
import 'package:meo_shop/Screen/MilkSoldScreen/MilkSoldScreen.dart';
import 'package:meo_shop/Screen/PaymentSentScreen/PaymentSentScreen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../AddMilkScreen/AddMilkScreen.dart';
import '../MilkReceivedScreen/MilkReceivedScreen.dart';
import '../PaymentReceivedScreen/PaymentReceivedScreen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var _currentIndex = 0;

  updateIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: _currentIndex == 5
            ? AddMilkScreen()
            : _currentIndex == 0
                ? MilkReceiveScreen(
                    onAddPressed: updateIndex,
                  )
                : _currentIndex == 1
                    ? PaymentSentScreen()
                    : _currentIndex == 2
                        ? MilkSoldScreen(onAddPressed: updateIndex)
                        : _currentIndex == 3
                            ? PaymentReceivedScreen()
                            : _currentIndex == 6
                                ? AddMilkSoldScreen()
                                : const Center(child: Text("Other")),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: _currentIndex == 0
                        ? null
                        : Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: const Icon(
                  Icons.receipt,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Received",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              selectedColor: Colors.blue,
            ),
            SalomonBottomBarItem(
              icon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _currentIndex == 1
                          ? null
                          : Colors.blue.withOpacity(0.2)),
                  child: const Icon(
                    Icons.details_rounded,
                    color: Colors.blue,
                  )),
              title: const Text(
                "Payment",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              selectedColor: Colors.blue,
            ),
            SalomonBottomBarItem(
              icon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _currentIndex == 2
                          ? null
                          : Colors.blue.withOpacity(0.2)),
                  child: const Icon(
                    Icons.receipt,
                    color: Colors.blue,
                  )),
              title: const Text(
                "Milk",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              selectedColor: Colors.blue,
            ),
            SalomonBottomBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: _currentIndex == 3
                        ? null
                        : Colors.blue.withOpacity(0.2)),
                child: const Icon(
                  Icons.details_rounded,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Payment",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              selectedColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
