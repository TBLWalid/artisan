import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'back.dart'; // Import your HomePageBackground widget
import 'show_profile_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomePageBackground(
            screenHeight: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                    height: kToolbarHeight), // Match the height of the app bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter artisan name...',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('first_name', isEqualTo: searchQuery)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text('No artisans found with this name.'),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> artisanData =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          return buildArtisanCard(
                              artisanData, snapshot.data!.docs[index].id);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArtisanCard(Map<String, dynamic> artisanData, String artisanId) {
    String firstName = artisanData['first_name'];
    String lastName = artisanData['last_name'];
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage('images/walid.jpg'),
          ),
          title: Text('$firstName $lastName'),
          subtitle:
              Text('${artisanData['profession']} - ${artisanData['state']}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowProfilePage(
                  artisanId: artisanId,
                  artisanName: '$firstName $lastName',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
