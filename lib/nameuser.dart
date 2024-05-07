import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class aaa extends StatefulWidget {
  @override
  _UserIdScreenState createState() => _UserIdScreenState();
}

class _UserIdScreenState extends State<aaa> {
  String firebaseUserId = '';
  String firestoreUserId = '';

  @override
  void initState() {
    super.initState();
    fetchFirebaseUserId();
    fetchFirestoreUserId();
  }

  void fetchFirebaseUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        firebaseUserId = user.uid;
      });
    } else {
      setState(() {
        firebaseUserId = 'No user signed in';
      });
    }
  }

  void fetchFirestoreUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        setState(() {
          firestoreUserId = snapshot.id;
        });
      } else {
        setState(() {
          firestoreUserId = 'User ID not found in Firestore';
        });
      }
    } else {
      setState(() {
        firestoreUserId = 'No user signed in';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User ID Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Firebase Authentication User ID: $firebaseUserId'),
            SizedBox(height: 20),
            Text('Firestore User ID: $firestoreUserId'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: aaa(),
  ));
}
