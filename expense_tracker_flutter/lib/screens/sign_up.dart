import 'package:expense_tracker_flutter/services/api_service.dart';
import 'package:expense_tracker_flutter/services/global_service.dart';
import 'package:expense_tracker_flutter/services/screen_util.dart';
import 'package:expense_tracker_flutter/widgets/button.dart';
import 'package:expense_tracker_flutter/widgets/text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late bool _obscureText1 = true;
  late bool _obscureText2 = true;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (GlobalService.isNullOrEmpty(value)) {
                                return 'Email is required.!';
                              }
                              // Simple email validation
                              if (!GlobalService.emailValidator(value!)) {
                                return 'Please enter a valid email address';
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
                                _obscureText1, // Use the state variable here
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText1
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText1 =
                                        !_obscureText1; // Toggle the state
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
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText:
                                _obscureText2, // Use the state variable here
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText2
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText2 =
                                        !_obscureText2; // Toggle the state
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (GlobalService.isNullOrEmpty(value)) {
                                return 'Confirm Password is required!';
                              }
                              if (!GlobalService.equalsTo(
                                  passwordController.text, value!)) {
                                return 'Password\'s did not matches!';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CButton(
                            text: 'Sign Up',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ApiService().signUp(
                                    usernameController.text,
                                    emailController.text,
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
                          text: 'Already have an account?  ',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        TextSpan(
                            text: 'Sign In',
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
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
