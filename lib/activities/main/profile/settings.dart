import 'package:flutter/material.dart';

import 'package:plantsility_app/services/database.dart';

import 'package:provider/provider.dart';
import 'package:plantsility_app/models/user.dart';

import 'package:plantsility_app/widgets/buttons/rounded_rect_button.dart';
import 'package:plantsility_app/widgets/text_fields/custom_text_field.dart';
import 'package:plantsility_app/activities/main/profile/circle_avatar_custom.dart';
import 'package:plantsility_app/widgets/loading/chasing_dots_loading.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String? _firstName;
  String? _lastName;
  String? _username;
  String? _email;
  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {

    // user model to provide uid for Database Service
    final user = Provider.of<UserModel>(context);


    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      initialData: null,
      builder: (context, snapshot) {
        UserDataModel? userData = snapshot.data;
        if (userData != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Edit Profile",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 20
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const CircleAvatarCustom(
                    src: "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
                    radius: 65,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Change Picture",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 12,
                      ),
                    )
                  ),

                  const Padding(padding: EdgeInsets.only(bottom: 30)),

                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // TODO add validation to form text fields
                          // TODO find way to make form more flexible (list builder or custom widget)
                          children: [
                            Text("First Name", style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),),
                            CustomTextField(
                              initialValue: userData.firstName ?? _firstName,
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              fontSize: 12,
                              onChanged: (val) {
                                setState(() {
                                  _firstName = val;
                                });
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            Text("Last Name", style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),),
                            CustomTextField(
                              initialValue: userData.lastName ?? _lastName,
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              fontSize: 12,
                              onChanged: (val) {
                                setState(() {
                                  _lastName = val;
                                });
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            Text("Username", style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),),
                            CustomTextField(
                              initialValue: userData.username ?? _username,
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              fontSize: 12,
                              onChanged: (val) {
                                setState(() {
                                  _username = val;
                                });
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            Text("Email", style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),),
                            CustomTextField(
                              initialValue: userData.email ?? _email,
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              fontSize: 12,
                              onChanged: (val) {
                                setState(() {
                                  _email = val;
                                });
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            Text("Phone Number", style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),),
                            CustomTextField(
                              initialValue: userData.phoneNumber ?? _phoneNumber,
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              fontSize: 12,
                              onlyDigits: true,
                              onChanged: (val) {
                                setState(() {
                                  _phoneNumber = val;
                                });
                              },
                            ),

                            const Padding(padding: EdgeInsets.only(bottom: 20)),

                            Center(
                              child: RoundedRectButton(
                                width: 283,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()){
                                    // creating user data model object to provide it to updateUserData method
                                    UserDataModel userDataModel = UserDataModel(
                                      username: _username ?? userData.username,
                                      firstName: _firstName ?? userData.firstName,
                                      lastName: _lastName ?? userData.lastName,
                                      email: _email ?? userData.email,
                                      phoneNumber: _phoneNumber ?? userData.phoneNumber,
                                      favorite: userData.favorite
                                    );

                                    dynamic response = DatabaseService(uid: user.uid).updateUserData(userDataModel);

                                    // if error acquired while updating user data
                                    if (response == null) {
                                      // do something
                                    }
                                  }
                                },
                                text: const Text("Save Changes")
                              ),
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        }
        else {
          return const ChasingDotsLoading();
        }

      }
    );
  }
}

