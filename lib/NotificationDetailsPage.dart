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
    return snapshot['token']; // Assuming the field name is 'token'
  }

  @override
  Widget build(BuildContext context) {
    final String artisanId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Clients',
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
            return Center(
                child:
                    Text('No clients found', style: TextStyle(fontSize: 20.0)));
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
                          title: Text(
                            'No FCM token found',
                          ),
                        );
                      }

                      var clientFCMToken = tokenSnapshot.data!;
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Column(
                                children: [
                                  Text(
                                    'Client Name: $clientName',
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                  // Text(
                                  //   'neighborhood: $clientName',
                                  //   style: TextStyle(fontSize: 20.0),
                                  // ),
                                ],
                              ),
                            ),
                            FutureBuilder<DocumentSnapshot>(
                              future: _firestore
                                  .collection('users')
                                  .doc(artisanId)
                                  .collection('clientid')
                                  .doc(clientId)
                                  .get(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return Container(); // Handle if document does not exist
                                }
                                var data = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                if (!data.containsKey('status')) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          _acceptRequest(
                                            clientId,
                                            artisanId,
                                            clientFCMToken,
                                            clientName,
                                            context,
                                          );
                                        },
                                        child: Text(
                                          'Accept',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          minimumSize: Size(120, 50),
                                          backgroundColor: Colors.green,
                                          disabledBackgroundColor: Colors.white,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _rejectRequest(
                                            clientId,
                                            artisanId,
                                            clientFCMToken,
                                            clientName,
                                          );
                                        },
                                        child: Text(
                                          'Reject',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          minimumSize: Size(120, 50),
                                          backgroundColor:
                                              Color.fromARGB(255, 154, 7, 7),
                                          disabledBackgroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                var status = data['status'] as String?;
                                if (status == 'completed') {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'completed',
                                        style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        'images/checked.png',
                                        height: 24.0,
                                        width: 24.0,
                                      ),
                                    ],
                                  );
                                } else if (status == 'accepted') {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ButtonBar(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                await _firestore
                                                    .collection('users')
                                                    .doc(artisanId)
                                                    .collection('clientid')
                                                    .doc(clientId)
                                                    .update({
                                                  'status': 'completed'
                                                });

                                                await _firestore
                                                    .collection('users')
                                                    .doc(clientId)
                                                    .collection('artisanId')
                                                    .doc(artisanId)
                                                    .update({
                                                  'status': 'completed'
                                                });
                                              } catch (e) {
                                                print(
                                                    'Error updating status: $e');
                                              }
                                            },
                                            child: Text(
                                              'Transaction completed?',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: Size(200, 50),
                                              backgroundColor: Colors.brown,
                                              disabledBackgroundColor:
                                                  Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }

                                // Return default widget if status is neither completed nor accepted
                                return Container();
                              },
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
      String clientName, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String day = '';
        String month = '';
        String description = '';
        return AlertDialog(
          title: Text('Enter Date and Description'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    day = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Day',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    month = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Month',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    description = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Gather all data and perform a single set operation
                await _firestore
                    .collection('users')
                    .doc(clientId)
                    .collection('artisanId')
                    .doc(artisanId)
                    .set({
                  'addedAt': FieldValue.serverTimestamp(),
                  'day': day,
                  'month': month,
                  'description': description,
                  'status': 'accepted'
                }, SetOptions(merge: true));

                await _firestore
                    .collection('users')
                    .doc(artisanId)
                    .collection('clientid')
                    .doc(clientId)
                    .update({'status': 'accepted'});

                // Send notification to client
                await _sendNotification(
                  clientFCMToken,
                  'Request Accepted',
                  'Your request has been accepted by $artisanId. Day: $day, Month: $month, Description: $description',
                );

                Navigator.of(context).pop();
              },
              child: Text('Accept'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendNotification(
      String token, String title, String body) async {
    // Replace this with your function to send notifications, possibly using Cloud Functions or another backend service.
    print('Sending notification to $token: $title - $body');
  }

  void _rejectRequest(String clientId, String artisanId, String clientFCMToken,
      String clientName) async {
    try {
      await _firestore
          .collection('users')
          .doc(clientId)
          .collection('artisanId')
          .doc(artisanId)
          .set({
        'addedAt': FieldValue.serverTimestamp(),
      });

      await _firestore
          .collection('users')
          .doc(clientId)
          .collection('artisanId')
          .doc(artisanId)
          .update({'status': 'rejected'});

      await _firestore
          .collection('users')
          .doc(artisanId)
          .collection('clientid')
          .doc(clientId)
          .update({'status': 'rejected'});

      await _sendNotification(
        clientFCMToken,
        'Request Rejected',
        'Your request has been rejected by $artisanId',
      );
    } catch (e) {
      print('Error rejecting request: $e');
    }
  }
}
