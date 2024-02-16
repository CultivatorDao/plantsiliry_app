import 'package:flutter/material.dart';

import 'package:plantsility_app/services/auth.dart';

import 'package:plantsility_app/widgets/buttons/rounded_rect_button.dart';
import 'package:plantsility_app/widgets/text_fields/custom_text_field.dart';
import 'package:plantsility_app/widgets/validator/validator.dart';

import 'package:plantsility_app/activities/entrance/registration/registration.dart';


class SignIn extends StatefulWidget {
  /// Allows user to sign in in his account.
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // Initialize authenticate service object
  final AuthService _auth = AuthService();
  // Set key for form validation
  final _formKey = GlobalKey<FormState>();

  // Variables that stores values from form text fields
  String email = '';
  String password = '';

  // If sign in completed with error show this message
  String error = "";

  // Sign in as guest
  void _signInAnonymously() async {
    dynamic response = await _auth.signInAnon();
    if (response == null) {
      debugPrint("error with sighning in");
    }
    else {
      debugPrint("signed in");
      debugPrint(response.uid.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Let’s sign you in.",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const Padding(padding: EdgeInsets.only(bottom: 16)),

            Text(
              "Wellcome back to your workspace!",
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const Padding(padding: EdgeInsets.only(bottom: 58)),

            // Gets user email and password to authenticate user
            Form(
              key: _formKey,
              // Wrap Column with Expanded to be able to use MainAxisAlignment.spaceBetween
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        CustomTextField(
                          hintText: "email@mail.ru",
                          label: "Email",
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: Validator(
                            isEmail: true,
                          ),
                        ),

                        const Padding(padding: EdgeInsets.only(bottom: 26)),

                        CustomTextField(
                          hintText: "qwerty123",
                          label: "Password",
                          passwordField: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),

                        const Padding(padding: EdgeInsets.only(bottom: 8)),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            // TODO: add activity to restore account password
                            onPressed: () {},
                            child: Text(
                              "Forgot your password?",
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ),
                        ),

                        const Padding(padding: EdgeInsets.only(bottom: 12)),

                        Text(error, style: const TextStyle(color: Colors.red),)
                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Don’t have an account?",
                            ),
                            Container(
                              color: const Color.fromARGB(255, 226, 227, 228),
                              margin: const EdgeInsets.only(left: 24, right: 10),
                              width: 2,
                              height: 24,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const SignUp()));
                              },
                              child: Text(
                                "Register",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),

                        RoundedRectButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                dynamic response = await _auth.signIn(email, password);
                                // Checking if got valid response
                                if (response == null) {
                                  setState(() {
                                    error = "Wrong email or password";
                                  });
                                }
                                else {
                                  // Exit sign in page if successfully logged in
                                  // Ignore this warning
                                  Navigator.pop(context);
                                }
                              }
                            },
                            width: 328,
                            text: const Text("Sign In")
                        )
                      ],
                    )

                  ],
                ),
              )
            )
          ],
        )
      ),
    );
  }
}


