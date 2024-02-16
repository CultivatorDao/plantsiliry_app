import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:plantsility_app/models/user.dart';
import 'package:plantsility_app/services/auth.dart';

import 'package:plantsility_app/activities/authenticate.dart';

import '../themes/light_theme.dart';


// Main application class
class Plantsility extends StatefulWidget {
  /// Main application class.
  const Plantsility({super.key});

  @override
  State<Plantsility> createState() => _PlantsilityState();

  // Make access to State object for any descendant widget
  // ignore: library_private_types_in_public_api
  static _PlantsilityState of(BuildContext context)
  => context.findAncestorStateOfType<_PlantsilityState>()!;
}

class _PlantsilityState extends State<Plantsility> {

  // Variable to control current theme
  ThemeMode _themeMode = ThemeMode.system;

  // Change app theme from light to dark and vice versa
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // wrap main app in StreamProvider to get access to user object throughout child widgets
    return StreamProvider<UserModel?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: "Plantsility",
        // TODO Add themes
        theme: lightTheme,
        // darkTheme: darkTheme,
        themeMode: _themeMode,
        home: const Authenticate(),
      ),
    );
  }
}
