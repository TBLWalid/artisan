import 'package:flutter/material.dart';

class language extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LanguageSwitchPage(),
      appBar: AppBar(
        title: Text(
          'Language',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class LanguageSwitchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Arabe'),
            onTap: () {
              //
            },
          ),
          Divider(),
          ListTile(
            title: Text('Anglais'),
            onTap: () {
              //
            },
          ),
          Divider(),
          ListTile(
            title: Text('Francais'),
            onTap: () {
              //
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
