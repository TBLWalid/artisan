import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String firebaseUserId = '';
String databaseUserId = '';
String message = '';

class CheckUserIdScreen extends StatefulWidget {
  @override
  _CheckUserIdScreenState createState() => _CheckUserIdScreenState();
}

class _CheckUserIdScreenState extends State<CheckUserIdScreen> {
  @override
  void initState() {
    super.initState();
    fetchFirebaseUserId();
    fetchDatabaseUserId();
  }

  void fetchFirebaseUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        firebaseUserId = user.uid;
      });
    } else {
      setState(() {
        message = 'No user signed in';
      });
    }
  }

  void fetchDatabaseUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (documentSnapshot.exists) {
        setState(() {
          databaseUserId = documentSnapshot.get('userId') ?? 'No user';
        });
      } else {
        setState(() {
          message = 'User ID not found in database';
        });
      }
    } else {
      setState(() {
        message = 'No user signed in';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User ID Comparison'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Firebase Auth User ID: $firebaseUserId'),
            Text('Database User ID: $databaseUserId'),
            SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CheckUserIdScreen(),
  ));
}
