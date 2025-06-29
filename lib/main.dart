import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'main_app/main_app.dart';
import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAdaNQ47mj_i_O9MXjnaSxXXVyWRM6Q_Sw',
      appId: '1:149808937076:android:8c69f7d91b98de1dbb3921',
      messagingSenderId: '149808937076',
      storageBucket: "gs://plantsility.appspot.com",
      projectId: 'plantsility'
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: const Plantsility(),
    );
  }
}
