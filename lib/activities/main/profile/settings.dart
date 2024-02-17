import 'package:flutter/material.dart';
import 'package:plantsility_app/widgets/buttons/rounded_rect_button.dart';
import 'package:plantsility_app/widgets/text_fields/custom_text_field.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(width: 130, height: 130, color: Colors.green,),
              TextButton(onPressed: () {}, child: const Text("Change Picture")),
              Form(child: Column(
                children: [
                  const Text("First Name"),
                  const CustomTextField(),
                  const Text("Last Name"),
                  const CustomTextField(),
                  const Text("Username"),
                  const CustomTextField(),
                  const Text("Email"),
                  const CustomTextField(),
                  const Text("Phone Number"),
                  const CustomTextField(),
                  RoundedRectButton(onPressed: () {}, text: const Text("Save Changes"))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
