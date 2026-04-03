import 'package:flutter/material.dart';
import 'package:rick_and_morty/presenter/widgets/liked_screen.dart';
import 'package:rick_and_morty/presenter/widgets/list_screen.dart';
import 'package:rick_and_morty/presenter/widgets/settings_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

final List<String> _titles = ['Rick and Morty', 'Liked', 'Settings'];

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: [ListScreen(), LikedScreen(), SettingsScreen()][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue[800],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30),
            label: '',
          ),
        ],
      ),
    );
  }
}
