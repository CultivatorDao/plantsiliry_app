import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:plantsility_app/services/auth.dart';
import 'package:plantsility_app/services/database.dart';
import 'package:plantsility_app/models/user.dart';

import 'package:plantsility_app/activities/main/profile/line_button.dart';
import 'package:plantsility_app/activities/main/profile/circle_avatar_custom.dart';
import 'package:plantsility_app/widgets/loading/chasing_dots_loading.dart';

import 'package:plantsility_app/activities/main/profile/settings.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<UserModel>(context);


    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      initialData: null,
      builder: (context, snapshot) {
        UserDataModel? userData = snapshot.data;
        if (userData != null) {
          return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: <Widget>[
                  // TODO: create circle image widget with border
                  const CircleAvatarCustom(
                    src: "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
                    radius: 36,
                  ),

                  Text(
                    "${userData.firstName} ${userData.lastName}",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18
                    ),
                  ),

                  SizedBox(
                    height: 30,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
                      },
                      style: TextButton.styleFrom(
                      ),
                      child: Text(
                        "Edit profile",
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 12
                        ),
                      )
                    ),
                  ),

                  const Padding(padding: EdgeInsets.only(bottom: 20)),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Label(text: "Profile info"),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        child: Column(
                          children: <Widget>[
                            InformationLine(label: "Username", value: userData.username.toString()),
                            const Padding(padding: EdgeInsets.only(bottom: 18)),
                            InformationLine(label: "Email", value: userData.email.toString()),
                            const Padding(padding: EdgeInsets.only(bottom: 18)),
                            InformationLine(label: "Phone number", value: userData.phoneNumber.toString()),
                          ],
                        ),
                      ),
                      
                      const Label(text: "Content"),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        child: Column(
                          children: <Widget>[
                            LineButton(
                              text: "Favorite",
                              leftIcon: Icons.favorite_border,
                              onTap: () {debugPrint("checl");},
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 9)),
                            LineButton(
                              text: "My pots",
                              leftIcon: Icons.file_download_outlined,
                              onTap: () {}
                            ),
                          ],
                        ),
                      ),
                      
                      const Label(text: "Preferences"),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        child: Column(
                          children: <Widget>[
                            LineButton(
                              text: "Language",
                              leftIcon: Icons.translate_outlined,
                              onTap: () {}
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 9)),
                            LineButton(
                              text: "Dark mode",
                              leftIcon: Icons.dark_mode_outlined,
                              onTap: () {}
                            ),
                          ],
                        ),
                      ),

                      const Label(text: "Account"),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        child: Column(
                          children: <Widget>[
                            LineButton(
                              text: "Log Out",
                              leftIcon: Icons.logout_outlined,
                              onTap: () {
                                _auth.signOut();
                              }
                            )
                          ],
                        ),
                      )

                    ],
                  )

                ],
              )
          );
        }
        else {
          return const ChasingDotsLoading();
        }
      },
    );
  }
}


class Label extends StatefulWidget {
  const Label({super.key, required this.text});

  final String text;

  @override
  State<Label> createState() => _LabelState();
}

class _LabelState extends State<Label> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Expanded>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 25),
            color: const Color.fromARGB(255, 246, 246, 246),
            child: Text(
              widget.text,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 16,
                height: 1.6
              ),
            ),
          )
        )
      ],
    );
  }
}



class InformationLine extends StatefulWidget {
  const InformationLine({super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  State<InformationLine> createState() => _InformationLineState();
}

class _InformationLineState extends State<InformationLine> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Text>[
        Text(
          widget.label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(
          widget.value,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}

