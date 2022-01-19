import 'package:DIE/pages/user/user_history_page.dart';
import 'package:DIE/pages/user/user_stats_page.dart';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';

class UserHistoryNavigator extends StatefulWidget {
  const UserHistoryNavigator({Key? key}) : super(key: key);

  @override
  _UserHistoryNavigatorState createState() => _UserHistoryNavigatorState();
}

class _UserHistoryNavigatorState extends State<UserHistoryNavigator> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
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
              if (_selectedIndex < 1) {
                _selectedIndex += 1;
                onPageChanged(_selectedIndex++);
                _onItemTapped(_selectedIndex);
              }
            }
          },
          child: PageView(
            controller: _pageController,
            children: const [
              UserHistoryPage(),
              UserStatsPage(),
            ],
            onPageChanged: onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          backgroundColor: const Color(0xFF140B37),
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                ),
                label: "History"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: "Stats"),
          ],
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}
