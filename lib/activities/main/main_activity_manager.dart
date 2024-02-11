import 'package:flutter/material.dart';
import 'package:plantsility_app/activities/main/shop/shop.dart';


// Widget for navigation through app main screens
class MainActivityManager extends StatefulWidget {
  const MainActivityManager({super.key});

  @override
  State<MainActivityManager> createState() => _MainActivityManagerState();
}

class _MainActivityManagerState extends State<MainActivityManager> {

  // All app screens/activities
  static List<Widget> pages = <Widget>[
      const Shop(),
      const Placeholder(),
    ];

  // bottom bar icons
  final List<BottomNavigationBarItem> pageIcons = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Shop"),
    BottomNavigationBarItem(icon: Icon(Icons.settings_overscan), label: "Scanner"),
    // BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: "Encyclopedia"),
    // BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: "Profile"),
  ];

  // defines current page
  int selectedPage = 0;

  // changes current page
  void onItemTap(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const  Color.fromARGB(255, 44, 94, 70),
        selectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 44, 94, 70)
        ),
        unselectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 173, 210, 188)
        ),
        items: pageIcons,
        currentIndex: selectedPage,
        onTap: onItemTap,
      ),
      body: Center(
        child: pages.elementAt(selectedPage),
      ),
    );
  }
}
