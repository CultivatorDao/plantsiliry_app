import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:plantsility_app/main_app/main_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAdaNQ47mj_i_O9MXjnaSxXXVyWRM6Q_Sw',
          appId: '1:149808937076:android:8c69f7d91b98de1dbb3921',
          messagingSenderId: '149808937076',
          projectId: 'plantsility'
      )
  );
  runApp(const Plantsility());
}
