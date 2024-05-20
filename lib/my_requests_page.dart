import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'show_profile_page.dart';

class ArtisanDetails {
  final String name;
  final String phoneNo;

  ArtisanDetails({required this.name, required this.phoneNo});
}

class HomePageBackground extends StatelessWidget {
  final double screenHeight;

  const HomePageBackground({Key? key, required this.screenHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomShapeClipper(),
      child: Container(
        height: screenHeight * 0.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 112, 72, 57), // Bottom color
              Colors.brown[800]!, // Top color
            ],
          ),
        ),
      ),
    );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartPoint = Offset(0, size.height * 0.65);
    Offset curveEndPoint = Offset(size.width, size.height * 0.65);
    path.lineTo(curveStartPoint.dx, curveStartPoint.dy);
    path.quadraticBezierTo(
        size.width / 2, size.height, curveEndPoint.dx, curveEndPoint.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyRequestsPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ArtisanDetails> _getArtisanDetails(String artisanId) async {
    var snapshot = await _firestore.collection('users').doc(artisanId).get();
    return ArtisanDetails(
      name: snapshot['full_name'] ?? 'No name found',
      phoneNo: snapshot['phoneNo'] ?? 'No phone number found',
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final String userId = _auth.currentUser!.uid;

    return Scaffold(
      body: Stack(
        children: [
          HomePageBackground(screenHeight: screenHeight),
          Positioned.fill(
            child: StreamBuilder<QuerySnapshot>(
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
                  return Center(
                      child: Text(
                    'No requests found',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ));
                }

                var artisanRequests = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: artisanRequests.length,
                  itemBuilder: (context, index) {
                    var artisanRequest = artisanRequests[index];
                    var artisanId = artisanRequest.id;
                    var status = artisanRequest['status'];

                    var data = artisanRequest.data() as Map<String, dynamic>;

                    var day = data.containsKey('day') && data['day'] != ''
                        ? data['day']
                        : null;
                    var month = data.containsKey('month') && data['month'] != ''
                        ? data['month']
                        : null;
                    var description = data.containsKey('description') &&
                            data['description'] != ''
                        ? data['description']
                        : null;

                    return Card(
                      color: Colors.brown[300],
                      elevation: 4,
                      margin: EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded corners
                        side: BorderSide(
                          color: Colors.brown.withOpacity(0.5), // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          var artisanDetails =
                              await _getArtisanDetails(artisanId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowProfilePage(
                                artisanId: artisanId,
                                artisanName: artisanDetails.name,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 3, // Spread radius
                                      blurRadius: 7, // Blur radius
                                      offset: Offset(0, 3), // Shadow direction
                                    ),
                                  ],
                                ),
                                height: 100, // Image height
                                width: 100, // Image width
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'images/walidd.jpg',
                                    fit: BoxFit.cover, // Fit image to full area
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder<ArtisanDetails>(
                                      future: _getArtisanDetails(artisanId),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text('Loading name...');
                                        }
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        return Text(
                                          snapshot.data!.name,
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Status: $status',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (status == 'accepted') ...[
                                      if (day != null)
                                        Text(
                                          'Day: $day',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      if (day != null)
                                        SizedBox(
                                          height: 5,
                                        ),
                                      if (month != null)
                                        Text(
                                          'Month: $month',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      if (month != null)
                                        SizedBox(
                                          height: 5,
                                        ),
                                      if (description != null)
                                        Text(
                                          'Description: $description',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                              if (status == 'accepted') ...[
                                IconButton(
                                  icon: Icon(
                                    Icons.phone,
                                    size: 40,
                                  ),
                                  onPressed: () async {
                                    var artisanDetails =
                                        await _getArtisanDetails(artisanId);
                                    launch('tel:${artisanDetails.phoneNo}');
                                  },
                                ),
                              ],
                              SizedBox(width: 8.0),
                              if (status == 'accepted' ||
                                  status == 'completed') ...[
                                Image.asset(
                                  'images/jaccepte.png',
                                  height: 30.0,
                                  width: 30.0,
                                ),
                              ] else if (status == 'rejected') ...[
                                Image.asset(
                                  'images/supprimer.png',
                                  height: 24.0,
                                  width: 24.0,
                                ),
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
          ),
        ],
      ),
    );
  }
}
