import 'package:expense_tracker_flutter/screens/add_expenses.dart';
import 'package:expense_tracker_flutter/screens/landing_screen.dart';
import 'package:expense_tracker_flutter/screens/list_expenses.dart';
import 'package:expense_tracker_flutter/screens/sign_in.dart';
import 'package:expense_tracker_flutter/screens/sign_up.dart';
import 'package:expense_tracker_flutter/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Define a function that returns the routes
List<GetPage> getAppRoutes() {
  return [
    GetPage(name: '/landingPage', page: () => const LandingPage()),
    GetPage(name: '/login', page: () => const SignIn()),
    GetPage(name: '/signUp', page: () => const SignUp()),
    GetPage(name: '/addExpenses', page: () => const AddExpenses()),
    GetPage(name: '/listExpenses', page: () => const ListExpenses()),
  ];
}

GetPage<dynamic> handleUnknownRoute() {
  return GetPage(
    name: '/notfound',
    page: () {
      return const UnknownPage();
    },
  );
}

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const CText(
        text: 'Incorrect Route',
        fontSize: 18,
      )),
      body: const Center(
        child: CText(
          text: 'Page Not Found',
          fontSize: 20,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
