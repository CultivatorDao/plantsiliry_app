import 'package:flutter/material.dart';
import 'package:plantsility_app/activities/main/profile/settings.dart';

import 'package:provider/provider.dart';

import 'package:plantsility_app/services/database.dart';
import 'package:plantsility_app/models/user.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {


    return StreamProvider<List<UserDataModel>?>.value(
      value: DatabaseService().users,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(),
        body: const ProfileScreenBody()
      ),
    );
  }
}


class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<UserDataModel>?>(context);
    if (users != null) {
      for (var element in users) {
        debugPrint(element.username);
      }
    }

    return Column(
      children: [
        TextButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
        }, child: const Text("Settings"))
      ],
    );
  }
}
