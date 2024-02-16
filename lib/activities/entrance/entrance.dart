import 'package:flutter/material.dart';

import 'package:plantsility_app/widgets/buttons/rounded_rect_button.dart';

import 'package:plantsility_app/activities/entrance/login/sign_in.dart';
import 'package:plantsility_app/activities/entrance/registration/registration.dart';


class Entrance extends StatelessWidget {
  /// Welcome page, that allows user to register account or sign in into his account if he has one.
  const Entrance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 180)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Explore new \nteam collaboration \nexperience",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),

              const Padding(padding: EdgeInsets.only(bottom: 32)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Keep your files, documents, tools \nin one place.",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),


              const Padding(padding: EdgeInsets.only(bottom: 12)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Communicate with your team and set \n"
                    "up business processes and goals \n"
                    "through the mobile and web application.",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),

              const Padding(padding: EdgeInsets.only(bottom: 200)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedRectButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()));
                    },
                    text: Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                    )
                  ),

                  const Padding(padding: EdgeInsets.only(right: 8)),

                  RoundedRectButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                    text: Text(
                      "Sign In",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    color: const Color.fromARGB(255, 248, 250, 250),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
