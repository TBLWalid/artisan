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
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Client : $clientName',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            ButtonBar(
                              children: [
                                SizedBox(
                                  width: 30.0,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _acceptRequest(clientId, artisanId,
                                        clientFCMToken, clientName);
                                  },
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    // تحديد شكل الحواف
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8), // تحديد قيمة التدوير هنا
                                      // يمكنك ضبط قيمة التدوير حسب الحاجة
                                    ),
                                    // تحديد الطول والعرض
                                    minimumSize:
                                        Size(120, 50), // طول وعرض الزر بالبكسل
                                    // تحديد اللون
                                    backgroundColor:
                                        Colors.green, // لون الخلفية
                                    disabledBackgroundColor:
                                        Colors.white, // لون النص
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _rejectRequest(clientId, artisanId,
                                        clientFCMToken, clientName);
                                  },
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    // تحديد شكل الحواف
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8), // تحديد قيمة التدوير هنا
                                      // يمكنك ضبط قيمة التدوير حسب الحاجة
                                    ),
                                    // تحديد الطول والعرض
                                    minimumSize:
                                        Size(120, 50), // طول وعرض الزر بالبكسل
                                    // تحديد اللون
                                    backgroundColor: Color.fromARGB(
                                        255, 154, 7, 7), // لون الخلفية
                                    disabledBackgroundColor:
                                        Colors.white, // لون النص
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                              ],
                            ),
                          ],
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

  void _acceptRequest(String clientId, String artisanId, String clientFCMToken,
      String clientName) {
    _firestore
        .collection('users')
        .doc(clientId)
        .collection('artisanId')
        .doc(artisanId)
        .set({
      'addedAt': FieldValue.serverTimestamp(),
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
        'title': 'Request Accepted',
        'body': 'Your request has been accepted by $artisanId',
        'clientFCMToken': clientFCMToken,
      },
    );
  }

  void _rejectRequest(String clientId, String artisanId, String clientFCMToken,
      String clientName) {
    _firestore
        .collection('users')
        .doc(clientId)
        .collection('artisanId')
        .doc(artisanId)
        .set({
      'addedAt': FieldValue.serverTimestamp(),
    });
    _firestore
        .collection('users')
        .doc(clientId)
        .collection('artisanId')
        .doc(artisanId)
        .update({'status': 'rejected'});
    _firestore
        .collection('users')
        .doc(artisanId)
        .collection('clientid')
        .doc(clientId)
        .update({'status': 'rejected'});

    _firebaseMessaging.sendMessage(
      to: clientFCMToken,
      data: {
        'title': 'Request Rejected',
        'body': 'Your request has been rejected by $artisanId',
        'clientFCMToken': clientFCMToken,
      },
    );
  }
}
