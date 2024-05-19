import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'show_profile_page.dart';

class MyRequestsPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _getArtisanName(String artisanId) async {
    var snapshot = await _firestore.collection('users').doc(artisanId).get();
    return snapshot['full_name']; // Assuming the field name is 'full_name'
  }

  @override
  Widget build(BuildContext context) {
    final String userId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Requests',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(userId)
            .collection('artisanId')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No requests found'));
          }

          var artisanRequests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: artisanRequests.length,
            itemBuilder: (context, index) {
              var artisanRequest = artisanRequests[index];
              var artisanId = artisanRequest.id;
              var status = artisanRequest['status'];

              return Card(
                elevation: 4,
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowProfilePage(
                                artisanId: artisanId,
                                artisanName: '${snapshot.data}',
                              )), // افتراضياً لديك صفحة اسمها ShowPage
                    );
                  },
                  child: ListTile(
                    title: FutureBuilder<String>(
                      future: _getArtisanName(artisanId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading name...');
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData) {
                          return Text('No name found');
                        }
                        return Text('Artisan Name: ${snapshot.data}');
                      },
                    ),
                    subtitle: Row(
                      children: [
                        Text('Status: $status'),
                        SizedBox(
                            width: 8.0), // إضافة مسافة صغيرة بين النص والأيقونة
                        if (status == 'accepted') ...[
                          Image.asset('images/jaccepte.png',
                              height: 24.0, width: 24.0),
                        ] else if (status == 'rejected') ...[
                          Image.asset('images/supprimer.png',
                              height: 24.0, width: 24.0),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
