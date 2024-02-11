import 'package:flutter/material.dart';

import 'package:plantsility_app/services/auth.dart';
import 'package:plantsility_app/widgets/buttons/rounded_rect_button.dart';
import 'package:plantsility_app/widgets/text_fields/custom_text_field.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

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

            Form(child: Column(
              children: <Widget>[
                const CustomTextField(
                  hintText: "Email",
                  label: "Email",
                ),

                const Padding(padding: EdgeInsets.only(bottom: 26)),

                const CustomTextField(
                  hintText: "Password",
                  label: "Password",
                  passwordField: true,
                ),

                const Padding(padding: EdgeInsets.only(bottom: 8)),

                Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot your password?",
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ),
                ),

                const Padding(padding: EdgeInsets.only(bottom: 96)),

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
                      onPressed: () {},
                      child: Text(
                        "Register",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),

                const Padding(padding: EdgeInsets.only(bottom: 28)),

                RoundedRectButton(
                  onPressed: () {},
                  width: 328,
                  text: const Text("Sign In")
                )
              ],
            ))
          ],
        )
      ),
    );
  }
}


