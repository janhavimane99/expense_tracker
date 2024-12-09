import 'dart:convert';
import 'dart:io';

import 'package:expense_tracker_flutter/services/global_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String api = "http://localhost:3000/api/";

  Future<Map<String, dynamic>?> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the JSON string
    String? userDetailsJson = prefs.getString('userDetails');

    if (!GlobalService.isNullOrEmpty(userDetailsJson)) {
      // Convert the JSON string back to a Map
      return jsonDecode(userDetailsJson!);
    }

    return null; // Return null if no data is found
  }

  Future<Map<String, String>> setHttpHeaders() async {
    Map<String, dynamic>? user = await getUserDetails();

    String token =
        GlobalService.isNullOrEmpty(user?['token']) ? '' : user?['token'];

    // Set up headers
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'auth-token': token,
    };

    return headers;
  }

  // Helper method to structure error responses
  Map<String, dynamic> _handleError(Object error) {
    print("error:- ${error}");
    if (error is SocketException) {
      return {
        'success': false,
        'message': 'No internet connection. Please try again later.'
      };
    } else if (error is HttpException) {
      return {
        'success': false,
        'message': 'Could not connect to the server. Please try again later.'
      };
    } else if (error is FormatException) {
      return {
        'success': false,
        'message': 'Invalid response format. Please contact support.'
      };
    } else {
      return {
        'success': false,
        'message': 'An unexpected error occurred: $error'
      };
    }
  }

  Future<Map<String, dynamic>> getRequest(String paramUrl) async {
    try {
      String apiUrl = '$api$paramUrl';
      Map<String, String> headers = await setHttpHeaders();

      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        return {
          'success': false,
          'message': 'Error: ${response.statusCode}, ${response.body}'
        };
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<Map<String, dynamic>> postRequest(
      String paramUrl, Map<String, dynamic> map) async {
    try {
      String apiUrl = '$api$paramUrl';
      Map<String, String> headers = await setHttpHeaders();

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        return {
          'success': false,
          'message': 'Error: ${response.statusCode}, ${response.body}'
        };
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<Map<String, dynamic>> deleteRequest(String paramUrl) async {
    try {
      String apiUrl = '$api$paramUrl';
      Map<String, String> headers = await setHttpHeaders();

      final response = await http.delete(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return {'success': true, 'message': 'Resource deleted successfully'};
      } else {
        return {
          'success': false,
          'message': 'Error: ${response.statusCode}, ${response.body}'
        };
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  /* getRequest(String paramUrl) async {
    String apiUrl = '$api$paramUrl';

    // Await the headers since it's an async method
    Map<String, String> headers = await setHttpHeaders();

    return await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );
  }

  postRequest(String paramUrl, Map<String, dynamic> map) async {

    
    String apiUrl = '$api$paramUrl';

    // Await the headers since it's an async method
    Map<String, String> headers = await setHttpHeaders();

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(map),
    );

    return response;
  }

  deleteRequest(String paramUrl) async {
    String apiUrl = '$api$paramUrl';

    // Await the headers since it's an async method
    Map<String, String> headers = await setHttpHeaders();

    return await http.delete(
      Uri.parse(apiUrl),
      headers: headers,
    );
  } */

  signUp(String username, String email, String password) async {
    Map<String, dynamic> bdJson = {
      "username": username,
      "emailId": email,
      "password": password
    };

    final res = await postRequest('user/signup', bdJson);

    final resJson = res['success'] ? res['data'] : {'message': res['message']};

    String msg = resJson['message'];

    bool userAdded = GlobalService.containsIgnoreCase('user added', msg);

    bool userAlreadyPresent =
        GlobalService.containsIgnoreCase('is already exists', msg);

    if (userAdded) {
      GlobalService.showSnackbar('success', msg);
    } else if (userAlreadyPresent) {
      GlobalService.showSnackbar('warning', msg);
    } else {
      GlobalService.showSnackbar('error', msg);
    }
  }

  signIn(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> bdJson = {"username": username, "password": password};

    final res = await ApiService().postRequest('user/login', bdJson);

    final resJson = res['success'] ? res['data'] : {'message': res['message']};

    String msg = resJson['message'];

    bool successfulLogin =
        GlobalService.containsIgnoreCase(msg, 'logged in successfully');

    if (successfulLogin) {
      final userDetails = {
        "username": resJson['username'],
        "_id": resJson['_id'],
        "token": resJson['token']
      };
      // Save the JSON string
      await prefs.setString('userDetails', jsonEncode(userDetails));

      Get.toNamed('/listExpenses');
      GlobalService.showSnackbar('success', msg);
    } else {
      GlobalService.showSnackbar('error', msg);
    }
  }
}
