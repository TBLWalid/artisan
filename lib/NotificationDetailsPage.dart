import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Client IDs'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('client0')
            .doc('client0')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return Text('No data found');
          }

          // Retrieve the document data
          var documentData = snapshot.data!.data() as Map<String, dynamic>?;

          // Check if documentData is null or empty
          if (documentData == null || documentData.isEmpty) {
            return Text('No document data found');
          }

          // Extract client IDs
          List<String> clientIds = [];
          documentData.forEach((key, value) {
            if (key != 'clientId') {
              clientIds.add(value);
            }
          });

          // Check if there are any client IDs
          if (clientIds.isEmpty) {
            return Text('No client IDs found');
          }

          return ListView.builder(
            itemCount: clientIds.length,
            itemBuilder: (context, index) {
              var clientId = clientIds[index];

              // Display clientId in ListTile
              return ListTile(
                title: Text('Client ID: $clientId'),
              );
            },
          );
        },
      ),
    );
  }
}
