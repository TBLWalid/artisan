import 'package:flutter/material.dart';
import 'home_page.dart';
import 'settings_page.dart';
import 'profile_page.dart';
import 'my_requests_page.dart';
import 'login_page.dart'; // استيراد صفحة LoginPage

void main() {
  runApp(ArtisansApp());
}

class ArtisansApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MyRequestsPage(),
    LoginPage(),
    ProfilePage(),
    SettingsPage(), // إضافة صفحة LoginPage
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 165),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              // افتح صفحة البحث
            },
          ),
        ],
        title: Text(
          'Artisans',
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: Color.fromARGB(255, 236, 237, 219),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Color.fromARGB(255, 236, 237, 219),
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Color.fromARGB(255, 107, 107, 107),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
