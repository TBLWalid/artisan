import 'package:artisans_app/language_switch_page.dart';
import 'package:artisans_app/login_page.dart';
import 'package:artisans_app/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'NotificationDetailsPage.dart';
import 'btn.dart';

class SettingsPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = _auth.currentUser != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[800],
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Information'),
            onTap: () {
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => information_page()));
            },
          ),
          Divider(),
          if (isLoggedIn)
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationDetailsPage()),
                );
              },
            ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => language()),
              );
              // Add code to navigate to language page
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
            onTap: () {
              // Add code to enable/disable dark mode
            },
            trailing: buttonOnOff(),
          ),
          if (!isLoggedIn) Divider(),
          if (!isLoggedIn)
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Signup'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
            ),
          if (!isLoggedIn) Divider(),
          if (!isLoggedIn)
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          if (isLoggedIn) Divider(),
          if (isLoggedIn)
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _auth.signOut();
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
