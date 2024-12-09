import 'package:expense_tracker_flutter/services/api_service.dart';
import 'package:expense_tracker_flutter/services/global_service.dart';
import 'package:expense_tracker_flutter/services/screen_util.dart';
import 'package:expense_tracker_flutter/widgets/button.dart';
import 'package:expense_tracker_flutter/widgets/text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ScreenUtil.getResponsiveWidth(context),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  border: Border.all(color: Colors.black87),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CText(
                      text: "Sign Up",
                      fontSize: 25,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                        color: Color(0xFF77A9F5), height: 2, thickness: 2),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                            ),
                            validator: (value) {
                              if (GlobalService.isNullOrEmpty(value)) {
                                return 'Username is required.!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText:
                                _obscureText, // Use the state variable here
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText =
                                        !_obscureText; // Toggle the state
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (GlobalService.isNullOrEmpty(value)) {
                                return 'Password is required!';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CButton(
                            text: 'Login',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await ApiService().signIn(
                                    usernameController.text,
                                    passwordController.text);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                        color: Color(0xFF77A9F5), height: 2, thickness: 2),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                          text: 'Don\'t have an account?  ',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.toNamed('/abhi');
                                // print(Get.currentRoute);
                                Get.toNamed('/signUp');
                              }),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
