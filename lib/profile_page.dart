import 'package:flutter/material.dart';
import 'my_requests_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/profile_picture.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'Walid TBL',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Client',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('tebbalwalid8@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+213560629569'),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('My Requests'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyRequestsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
