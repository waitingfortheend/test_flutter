import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_diversition/generated/locales.g.dart';
import 'package:test_diversition/screens/home/home.dart';
import 'package:test_diversition/screens/setting/settings_screen.dart';
import 'package:test_diversition/screens/users/user_screen.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const UserScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: LocaleKeys.home.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: LocaleKeys.users.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: LocaleKeys.setting_title.tr,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
