import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class showpost extends StatefulWidget {
  @override
  _showpostState createState() => _showpostState();
}

class _showpostState extends State<showpost> {
  final _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _allPhotos = [];
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _fetchAllPhotos();
  }

  void _fetchAllPhotos() async {
    try {
      var snapshot = await _firestore.collection('users').get();

      List<Map<String, dynamic>> allPhotos = [];

      print("Fetched ${snapshot.docs.length} documents");

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          var userPhotos = await doc.reference.collection('userPhotos').get();
          userPhotos.docs.forEach((photoDoc) {
            if (photoDoc.data()['isPost'] ?? false) {
              // Check for 'isPost' or your criteria
              allPhotos.add(photoDoc.data());
            }
          });
        }
      }

      setState(() {
        _allPhotos = allPhotos;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = true;
        _loading = false;
      });
      print('Error fetching photos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : _error
            ? Center(child: Text('Error loading photos'))
            : _allPhotos.isEmpty
                ? Center(child: Text('No photos available'))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          2, // Adjust for the desired number of columns
                    ),
                    itemCount: _allPhotos.length,
                    itemBuilder: (context, index) {
                      String imageUrl = _allPhotos[index]['imageUrl'] ?? '';
                      return imageUrl.isNotEmpty
                          ? Image.network(imageUrl)
                          : Container(); // Handle case when imageUrl is empty
                    },
                  );
  }
}
