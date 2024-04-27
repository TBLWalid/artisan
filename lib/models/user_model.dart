 import 'package:flutter/material.dart';

// // Import the firebase_core and cloud_firestore plugin
 import 'package:firebase_core/firebase_core.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:artisans_app/signup_page.dart';

// class AddUser extends StatelessWidget {
//   final String fullName;
//   final String lastName;
//   final String email;
//   final int phone;
//   final String state;

//   AddUser(this.fullName, this.lastName, this.email, this.phone, this.state);

//   @override
//   Widget build(BuildContext context) {
//     // Create a CollectionReference called users that references the firestore collection
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     Future<void> addUser() {
//       // Call the user's CollectionReference to add a new user
//       return users
//           .add({
//             'firstName': fullName, // John Doe
//             'lastName': lastName, // Stokes and Sons
//             'email': email, // 42
//             'phoneNo': phone,
//             'state': state,
//           })
//           .then((value) => print("User Added"))
//           .catchError((error) => print("Failed to add user: $error"));
//     }

   
//   }
// }
