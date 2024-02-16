import 'package:flutter/material.dart';
import 'package:plantsility_app/services/auth.dart';


class Shop extends StatefulWidget {
  /// Contains cards of all company selling products.
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
      ),
      body: TextButton(onPressed: () {
        _auth.signOut();
      }, child: const Text("Sign Out")),
    );
  }
}
