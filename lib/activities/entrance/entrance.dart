import 'package:flutter/material.dart';
import 'package:plantsility_app/activities/entrance/login/sign_in.dart';


class Entrance extends StatelessWidget {
  const Entrance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 180)),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Explore new \nteam collaboration \nexperience",
                    // TODO create custom big label text theme
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),

              const Padding(padding: EdgeInsets.only(bottom: 32)),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Keep your files, documents, tools \nin one place.",
                    // TODO create custom medium label text theme
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Color.fromARGB(255, 104, 103, 119),
                        decoration: TextDecoration.none,
                        height: 1.5),
                  ),
                ],
              ),


              const Padding(padding: EdgeInsets.only(bottom: 12)),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Communicate with your team and set "
                        "\nup business processes and goals \nthrough the mobile and web application.",
                    // TODO create custom medium label text theme
                    style: TextStyle(fontFamily: "Poppins",
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Color.fromARGB(255, 104, 103, 119),
                        decoration: TextDecoration.none,
                        height: 1.5),
                  ),
                ],
              ),

              const Padding(padding: EdgeInsets.only(bottom: 200)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 164,
                    height: 56,
                    child: FilledButton(onPressed: () {
                      Navigator.pushNamed(context, '/sign-up');
                    },
                      // TODO create roundedRect button theme
                      style: FilledButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 44, 94, 70),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: const Text("Sign Up", style: TextStyle(fontFamily: "Poppins"),),),
                  ),

                  const Padding(padding: EdgeInsets.only(right: 8)),

                  SizedBox(
                    width: 164,
                    height: 56,
                    child: FilledButton(onPressed: () {
                      // Navigator.pushNamed(context, '/sign-in');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                        // TODO create roundedRect button theme
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 248, 250, 250),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Sign In", style: TextStyle(color: Colors.black, fontFamily: "Poppins"),)),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
