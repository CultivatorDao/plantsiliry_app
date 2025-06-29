import 'package:flutter/material.dart';

import 'package:plantsility_app/activities/main/shop/shop.dart';
import 'package:plantsility_app/activities/main/encyclopedia/encyclopedia.dart';
import 'package:plantsility_app/activities/main/profile/profile.dart';
import 'package:plantsility_app/activities/main/devices/devices_list.dart';


// Widget for navigation through app main screens
class MainActivityManager extends StatefulWidget {
  /// Contains all application activities, such as Shop, Encyclopedia, Profile and etc.
  ///
  /// Allows user to navigate between them.
  const MainActivityManager({Key? key}) : super(key: key);

  @override
  State<MainActivityManager> createState() => _MainActivityManagerState();
}

class _MainActivityManagerState extends State<MainActivityManager> {
  int _selectedIndex = 0;

  // All app screens/activities
  final List<Widget> _pages = [
    const EncyclopediaScreen(),
    const Shop(),
    const DevicesListPage(),
    const ProfileScreen(),
  ];

  // bottom bar icons
  final List<BottomNavigationBarItem> pageIcons = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: "Энциклопедия"),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Магазин"),
    BottomNavigationBarItem(icon: Icon(Icons.devices_outlined), label: "Устройства"),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Профиль"),
  ];

  // changes current page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Энциклопедия',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Магазин',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices_outlined),
            activeIcon: Icon(Icons.devices),
            label: 'Устройства',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
