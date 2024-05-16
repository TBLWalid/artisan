import 'package:artisans_app/language_switch_page.dart';
import 'package:artisans_app/login_page.dart';
import 'package:artisans_app/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'NotificationDetailsPage.dart';
import 'btn.dart';
import 'main.dart';

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
            leading: Image.asset('images/info.png'),
            title: Text(
              'Information',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => information_page()));
            },
          ),
          if (isLoggedIn)
            SizedBox(
              height: 25,
            ),
          if (isLoggedIn)
            ListTile(
              leading: Image.asset('images/cloche-de-notification.png'),
              title: Text(
                'Notifications',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationDetailsPage()),
                );
              },
            ),
          SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Image.asset('images/langues.png'),
            title: Text(
              'Language',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => language()),
              );
              // Add code to navigate to language page
            },
          ),
          SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Image.asset('images/noun-dark-mode-5399506.png'),
            title: Text(
              'Dark Mode',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Add code to enable/disable dark mode
            },
            trailing: buttonOnOff(),
          ),
          SizedBox(
            height: 25,
          ),
          if (!isLoggedIn)
            ListTile(
              leading: Image.asset('images/add-friend.png'),
              title: Text(
                'Signup',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
            ),
          if (!isLoggedIn)
            SizedBox(
              height: 25,
            ),
          if (!isLoggedIn)
            ListTile(
              leading: Image.asset('images/mot-de-passe.png'),
              title: Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          if (!isLoggedIn)
            SizedBox(
              height: 25,
            ),
          if (isLoggedIn)
            ListTile(
              leading: Image.asset(
                  'images/se-deconnecter.png'), // استبدل 'images/se-deconnecter.png' بالمسار الدقيق للصورة
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomePage()));
              },
            ),
        ],
      ),
    );
  }
}
