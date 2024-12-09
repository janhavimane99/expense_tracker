import 'dart:async';
import 'package:expense_tracker_flutter/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    // Set up a 3-second delay
    Timer(const Duration(seconds: 3), () {
      // Navigate to LoginPage after the delay
      Get.toNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CText(
              text: 'Welcome to Expense Tracker',
              fontSize: 20,
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/expenses.png', // Your logo image path
              width: 150, // Set the desired width
              height: 150, // Set the desired height
            ),
          ],
        ),
      ),
    );
  }
}
