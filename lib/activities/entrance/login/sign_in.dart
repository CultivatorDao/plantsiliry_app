import 'package:flutter/material.dart';
import 'package:plantsility_app/services/auth.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(helperText: "Email"),),
            const TextField(decoration: InputDecoration(helperText: "Password"),),
            TextButton(onPressed: () {}, child: const Text("Sign In")),
            TextButton(onPressed: () {}, child: const Text("Sign Up")),
            TextButton(
              onPressed: _signInAnonymously,
              child: const Text("Sign Anon")
            ),
          ],
        ),
      ),
    );
  }
}
