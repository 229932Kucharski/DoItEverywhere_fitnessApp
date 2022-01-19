import 'package:DIE/pages/activity/activity_page.dart';
import 'package:DIE/pages/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';

import 'points/points_page.dart';

int? lastPageIndex;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _selectedIndex = (lastPageIndex == null) ? 0 : lastPageIndex!;
  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
      lastPageIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        extendBody: true,
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! > 0) {
              if (_selectedIndex > 0) {
                _selectedIndex -= 1;
                onPageChanged(_selectedIndex);
                _onItemTapped(_selectedIndex);
              }
            } else if (details.primaryVelocity! < 0) {
              if (_selectedIndex < 2) {
                _selectedIndex += 1;
                onPageChanged(_selectedIndex++);
                _onItemTapped(_selectedIndex);
              }
            }
          },
          child: PageView(
            controller: _pageController,
            children: const [
              PointsPage(),
              ActivityPage(),
              UserPage(),
            ],
            onPageChanged: onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          backgroundColor: const Color(0xFF1f0b53),
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.run_circle), label: "Activity"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          ],
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}
