import 'package:flutter/material.dart';
import 'package:xxx/presentation/screens/home_screen.dart';
import 'package:xxx/presentation/screens/profile_screen.dart';
import 'package:xxx/presentation/screens/statistics_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  final List<Widget> _screens = [
    HomePage(),
    StatisticsScreen(),
    ProfileScreen()
  ];

  void _onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: _screens[selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.black,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          height: 60,
          indicatorColor: Colors.white,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          animationDuration: Duration(milliseconds: 500),
          selectedIndex: selectedIndex,
          onDestinationSelected: _onItemTap,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(
                Icons.sentiment_dissatisfied_outlined,
                size: 35,
                color: Colors.white,
              ),
              label: '',
              selectedIcon: Icon(
                Icons.sentiment_very_satisfied_rounded,
                size: 30,
                color: Colors.black,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.recent_actors_outlined,
                size: 35,
                color: Colors.white,
              ),
              label: '',
              selectedIcon: Icon(
                Icons.format_list_bulleted_outlined,
                size: 35,
                color: Colors.black,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_2_outlined,
                size: 35,
                color: Colors.white,
              ),
              label: '',
              selectedIcon: Icon(
                Icons.person,
                size: 30,
                color: Colors.black,
              ),
            ),
          ]),
    );
  }
}
