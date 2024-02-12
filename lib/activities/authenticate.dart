import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:plantsility_app/models/user.dart';

import 'package:plantsility_app/activities/entrance/entrance.dart';
import 'package:plantsility_app/activities/main/main_activity_manager.dart';


// When starting app checks if user was logged in
class Authenticate extends StatelessWidget {
  const Authenticate({super.key});

  @override
  Widget build(BuildContext context) {

    // listen to stream to get user obj on auth state change
    final user = Provider.of<UserModel?>(context);

    // Return Entrance or Main Activity Nav if user is authenticated
    if (user == null) {
      return const Entrance();
    }
    else {
      return const MainActivityManager();
    }

  }
}
