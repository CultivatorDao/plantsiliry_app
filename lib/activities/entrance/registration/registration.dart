import 'package:flutter/material.dart';
import 'package:plantsility_app/services/auth.dart';
import 'package:plantsility_app/widgets/buttons/rounded_rect_button.dart';
import 'package:plantsility_app/widgets/text_fields/custom_text_field.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String username = '';
  String email = '';
  String password = '';
  String repPassword = '';

  // If sign up completed with error show this message
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(height: 1, color: const Color.fromARGB(255, 226, 227, 228),),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Address",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 24),
                      ),
                      Text(
                        "You will need it to sign in to the application",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),

                      const Padding(padding: EdgeInsets.only(bottom: 24)),

                      Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              // CustomTextField(
                              //   label: "Username",
                              //   hintText: "Username",
                              //   onChanged: (value) {},
                              // ),
                              const Padding(padding: EdgeInsets.only(bottom: 10)),
                              CustomTextField(
                                label: "Email",
                                hintText: "Email",
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                              const Padding(padding: EdgeInsets.only(bottom: 10)),
                              CustomTextField(
                                label: "Password",
                                hintText: "Password",
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                                passwordField: true,
                              ),
                              // const Padding(padding: EdgeInsets.only(bottom: 10)),
                              // CustomTextField(
                              //   label: "Repeat Password",
                              //   hintText: "Repeat Password",
                              //   onChanged: (value) {},
                              //   passwordField: true,
                              // ),
                            ],
                          )
                      ),

                      const Padding(padding: EdgeInsets.only(bottom: 12)),

                      Text(error, style: const TextStyle(color: Colors.red),)
                    ],
                  ),


                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "You will receive an SMS code for verification.",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),

                      const Padding(padding: EdgeInsets.only(bottom: 16)),

                      RoundedRectButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              dynamic response = await _auth.signUp(email, password);
                              if (response == null) {
                                setState(() {
                                  error = "This email is already used or not valid";
                                });
                              }
                            }
                          },
                          width: 343,
                          text: const Text("Sign Up")
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
