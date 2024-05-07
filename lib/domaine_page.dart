import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'show_profile_page.dart';

class DomainePage extends StatefulWidget {
  final String category;

  DomainePage({Key? key, required this.category}) : super(key: key);

  @override
  _DomainePageState createState() => _DomainePageState();
}

class _DomainePageState extends State<DomainePage> {
  late Stream<QuerySnapshot> artisansStream;
  @override
  void initState() {
    super.initState();
    fetchArtisans();
  }

  void fetchArtisans() {
    artisansStream = FirebaseFirestore.instance
        .collection('users')
        .where('profession', isEqualTo: widget.category)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color.fromARGB(255, 177, 165, 160),
            ],
            stops: [0.0, 0.7],
            transform: GradientRotation(30 * 3.1415926535 / 180),
          ),
        ),
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: artisansStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> artisanData =
                      documents[index].data() as Map<String, dynamic>;
                  return buildArtisanCard(artisanData);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildArtisanCard(Map<String, dynamic> artisanData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 350.0,
            height: 180.0,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'images/walid.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            artisanData['full_name'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${artisanData['profession']} - ${artisanData['state']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 20.0,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowProfilePage(),
                                ),
                              );
                            },
                            child: Text(
                              'Show Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
