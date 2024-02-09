import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:plantsility_app/models/user.dart';
import 'package:plantsility_app/services/auth.dart';

import 'package:plantsility_app/activities/authenticate.dart';


// Main application class
class Plantsility extends StatelessWidget {
  const Plantsility({super.key});

  @override
  Widget build(BuildContext context) {
    // wrap main app in StreamProvider to get access to user object throughout child widgets
    return StreamProvider<UserModel?>.value(
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        title: "Plantsility",
        // TODO Add themes
        // theme: lightTheme,
        // darkTheme: darkTheme,
        // TODO: change to app routes, instead of home page
        home: Authenticate(),
      ),
    );
  }
}
