import 'package:basic_utils/basic_utils.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GlobalService {
  static bool emailValidator(String str) {
    return str.stringUtils().isEmail();
  }

  static bool emailValidator2(String str) {
    return !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(str);
  }

  static bool equalsTo(String str1, String str2) {
    return StringUtils.isNullOrEmpty(str1) || StringUtils.isNullOrEmpty(str2)
        ? false
        : str1.trim() == str2.trim();
  }

  static bool equalsIgnoreCase(String str1, String str2) {
    return StringUtils.isNullOrEmpty(str1) || StringUtils.isNullOrEmpty(str2)
        ? false
        : str1.trim().toLowerCase() == str2.trim().toLowerCase();
  }

  static bool containsIgnoreCase(String str1, String str2) {
    return StringUtils.isNullOrEmpty(str1) || StringUtils.isNullOrEmpty(str2)
        ? false
        : str1.trim().toLowerCase().contains(str2.trim().toLowerCase());
  }

  static isNullOrEmpty(String? str) {
    return StringUtils.isNullOrEmpty(str);
  }

  static String numFormatter(int value) {
    // Create a NumberFormat instance with two decimal places
    final formatter = NumberFormat('0.00');

    // Format the integer value
    return formatter.format(value.toDouble());
  }

  // Dynamic function to open the date picker
  static Future<String> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    String formattedDate =
        pickedDate == null ? '' : DateFormat('yyyy-MM-dd').format(pickedDate);

    return formattedDate;
  }

  static void showSnackbar(String type, String message) {
    Color bgColor;

    switch (type) {
      case 'success':
        bgColor = Colors.greenAccent;
        break;
      case 'warning':
        bgColor = Colors.yellowAccent;
        break;
      case 'error':
      default:
        bgColor = Colors.redAccent;
    }

    Get.snackbar(
      type.capitalizeFirst ?? 'Notification',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor,
      colorText: Colors.white,
    );
  }
}
