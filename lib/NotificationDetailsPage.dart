import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationDetailsPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> _getClientName(String clientId) async {
    var snapshot = await _firestore.collection('users').doc(clientId).get();
    return snapshot['full_name']; // Assuming the field name is 'full_name'
  }

  Future<String> _getClientFCMToken(String clientId) async {
    var snapshot = await _firestore.collection('users').doc(clientId).get();
    return snapshot['token']; // Assuming the field name is 'fcm_token'
  }

  @override
  Widget build(BuildContext context) {
    final String artisanId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Client',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[800],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(artisanId)
            .collection('clientid')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No client IDs found'));
          }

          List<String> clientIds =
              snapshot.data!.docs.map((doc) => doc.id).toList();

          return ListView.builder(
            itemCount: clientIds.length,
            itemBuilder: (context, index) {
              var clientId = clientIds[index];

              return FutureBuilder<String>(
                future: _getClientName(clientId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text('Loading...'),
                    );
                  }
                  if (snapshot.hasError) {
                    return ListTile(
                      title: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (!snapshot.hasData) {
                    return ListTile(
                      title: Text('No name found'),
                    );
                  }

                  var clientName = snapshot.data!;
                  return FutureBuilder<String>(
                    future: _getClientFCMToken(clientId),
                    builder: (context, tokenSnapshot) {
                      if (tokenSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return ListTile(
                          title: Text('Loading...'),
                        );
                      }
                      if (tokenSnapshot.hasError) {
                        return ListTile(
                          title: Text('Error: ${tokenSnapshot.error}'),
                        );
                      }
                      if (!tokenSnapshot.hasData) {
                        return ListTile(
                          title: Text('No FCM token found'),
                        );
                      }

                      var clientFCMToken = tokenSnapshot.data!;
                      return GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Accept or Reject?"),
                                content: Text(
                                    "Do you want to accept or reject $clientName?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Accept'),
                                    onPressed: () {
                                      _firestore
                                          .collection('users')
                                          .doc(clientId)
                                          .collection('artisanId')
                                          .doc(artisanId)
                                          .set({
                                        'addedAt': FieldValue
                                            .serverTimestamp(), // يمكنك إضافة البيانات التي تريدها هنا
                                      });
                                      _firestore
                                          .collection('users')
                                          .doc(clientId)
                                          .collection('artisanId')
                                          .doc(artisanId)
                                          .update({'status': 'accepted'});
                                      _firestore
                                          .collection('users')
                                          .doc(artisanId)
                                          .collection('clientid')
                                          .doc(clientId)
                                          .update({'status': 'accepted'});

                                      _firebaseMessaging.sendMessage(
                                        to: clientFCMToken,
                                        data: {
                                          'title': 'تم قبول الطلب',
                                          'body': 'تم قبول طلبك من $artisanId',
                                          'clientFCMToken': clientFCMToken,
                                        },
                                      );

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Reject'),
                                    onPressed: () {
                                      _firestore
                                          .collection('users')
                                          .doc(clientId)
                                          .collection('artisanId')
                                          .doc(artisanId)
                                          .set({
                                        'addedAt': FieldValue
                                            .serverTimestamp(), // يمكنك إضافة البيانات التي تريدها هنا
                                      });
                                      _firestore
                                          .collection('users')
                                          .doc(clientId)
                                          .collection('artisanId')
                                          .doc(artisanId)
                                          .update({'status': 'reject'});
                                      _firestore
                                          .collection('users')
                                          .doc(artisanId)
                                          .collection('clientid')
                                          .doc(clientId)
                                          .update({'status': 'Reject'});

                                      _firebaseMessaging.sendMessage(
                                        to: clientFCMToken,
                                        data: {
                                          'title': 'تم رفض الطلب',
                                          'body': 'تم رفض طلبك من $artisanId',
                                          'clientFCMToken': clientFCMToken,
                                        },
                                      );

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text('Client Name: $clientName'),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
