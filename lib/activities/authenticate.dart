import 'package:flutter/material.dart';

import 'package:plantsility_app/activities/entrance/login/sign_in.dart';

// When starting app checks if user was logged in
class Authenticate extends StatelessWidget {
  const Authenticate({super.key});

  @override
  Widget build(BuildContext context) {
    // Return Entrance or Main Activity Nav if user is authenticated
    return const SignIn();
  }
}
