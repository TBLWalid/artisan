import 'package:artisans_app/firebase_options.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'my_requests_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ArtisansApp());
}

class ArtisansApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.6,
                    decoration: BoxDecoration(
                      color: Colors.brown[800],
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(70)),
                    ),
                    child: Center(
                      child: Image.asset(
                        'images/logoo.png',
                        scale: 0.8,
                        width: 320,
                      ),
                    ))
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.66,
                decoration: BoxDecoration(
                  color: Colors.brown[800],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.66,
                padding: EdgeInsets.only(top: 40, bottom: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70))),
                child: Column(
                  children: [
                    Text(
                      'CraftMatch',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'CraftMatch: Hire local craftspeople. Simple & secure....',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1,
                            wordSpacing: 3,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Material(
                      color: Color.fromARGB(251, 100, 152, 156),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _isLoggedIn = false; // Set default login status to false

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // Check login status on app start
  }

  void checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _isLoggedIn = user != null; // Update value based on user existence
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages;
    if (_isLoggedIn) {
      // If user is logged in
      _pages = [
        HomePage(),
        MyRequestsPage(),
        ProfilePage(),
        SettingsPage(),
      ];
    } else {
      // If user is not logged in
      _pages = [
        HomePage(),
        LoginPage(),
        SettingsPage(),
      ];
    }

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        backgroundColor: Colors.brown[800],
        activeColor: Colors.brown[100],
        items: _isLoggedIn
            ? [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.my_library_books, title: 'My Requests'),
                TabItem(icon: Icons.account_circle, title: 'Profile'),
                TabItem(icon: Icons.settings, title: 'Settings'),
              ]
            : [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.account_circle, title: 'Login'),
                TabItem(icon: Icons.settings, title: 'Settings'),
              ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
