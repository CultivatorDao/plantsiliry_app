import 'package:flutter/material.dart';

import 'package:plantsility_app/activities/authenticate.dart';
import 'package:plantsility_app/activities/entrance/entrance.dart';


// Main application class
class Plantsility extends StatelessWidget {
  const Plantsility({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Plantsility",
      // TODO Add themes
      // theme: lightTheme,
      // darkTheme: darkTheme,
      // TODO: change to app routes, instead of home page
      home: Scaffold(
        body: Center(
          child: EnterScreen(),
        ),
      ),
    );
  }
}
