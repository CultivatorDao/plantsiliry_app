import 'package:flutter/material.dart';
import 'package:plantsility_app/services/auth.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            TextButton(
              onPressed: () async {

              },
              child: const Text("Sign up"))
          ],
        ),
      ),
    );
  }
}
