import 'package:expense_tracker_flutter/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData.dark(useMaterial3: true),
      // Define initial route (Landing Page)
      initialRoute: '/landingPage',
      // Fetch the routes from routes.dart
      getPages: getAppRoutes(),
      // Handle unknown routes (for dynamic navigation or invalid routes)
      unknownRoute: handleUnknownRoute(),
    );
  }
}
