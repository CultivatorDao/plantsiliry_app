import 'package:flutter/material.dart';


// Main application class
class Plantsility extends StatelessWidget {
  const Plantsility({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Plantsility",
      // Add themes
      // theme: ,
      // TODO: change to app routes, instead of home page
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Plantsility"),
        ),
        body: const Center(
          child: Text("Title"),
        ),
      ),
    );
  }
}
