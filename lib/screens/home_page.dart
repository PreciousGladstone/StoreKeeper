import 'package:flutter/material.dart';
import 'package:storekeeperapp/screens/report.dart';
import 'package:storekeeperapp/screens/storekeeper_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final List<Widget> _screen = [StorekeeperHomePage(), Report()];

  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(
          context,
        ).colorScheme.secondary, // active color
        unselectedItemColor: Theme.of(
          context,
        ).colorScheme.onPrimary, // inactive color
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.insert_chart_outlined_rounded,
            ),
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}
