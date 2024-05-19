import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart' as photo_view; // Import photo_view

class picprofile extends StatefulWidget {
  @override
  _picprofileState createState() => _picprofileState();
}

class _picprofileState extends State<picprofile> {
  List<XFile> _images = []; // List of picked XFile images
  List<String> _uploadedImageUrls = []; // List to store downloaded image URLs
  int _selectedImageIndex = -1; // Track selected image index
  final FirebaseStorage _storage =
      FirebaseStorage.instance; // Instance for storage
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Instance for authentication

  @override
  void initState() {
    super.initState();
    // Fetch uploaded image URLs on app launch
    _fetchUploadedImageUrls();
  }

  Future<void> _fetchUploadedImageUrls() async {
    // Get reference to user ID for path construction
    final String userId = _auth.currentUser?.uid ?? ""; // Handle null user

    if (userId.isEmpty) {
      // Handle case where no user is signed in
      print('Error: No user is currently signed in.');
      return;
    }

    final storageRef = _storage.ref().child('user_images/$userId');
    final ListResult result = await storageRef.listAll();

    // Fetch download URLs
    final List<String> downloadedUrls = await Future.wait(
        result.items.map((item) async => await item.getDownloadURL()).toList());

    setState(() {
      _uploadedImageUrls = downloadedUrls;
    });
  }

  Future<void> pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
      await uploadImage(image);
    }
  }

  Future<void> uploadImage(XFile image) async {
    // Get reference to user ID for path construction
    final String userId = _auth.currentUser?.uid ?? ""; // Handle null user

    if (userId.isEmpty) {
      // Handle case where no user is signed in
      print('Error: No user is currently signed in.');
      return;
    }

    final storageRef =
        _storage.ref().child('user_images/$userId/${image.name}');
    final task = storageRef.putFile(File(image.path));
    final snapshot = await task.whenComplete(() => null);
    final imageUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      _uploadedImageUrls.add(imageUrl);
    });
  }

  void _handleImageTap(int index) {
    setState(() {
      _selectedImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Add Photo'),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: _uploadedImageUrls.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _handleImageTap(index),
                      child: Image.network(
                        _uploadedImageUrls[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Text('Error loading image');
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          _selectedImageIndex >= 0
              ? photo_view.PhotoView(
                  imageProvider:
                      NetworkImage(_uploadedImageUrls[_selectedImageIndex]),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                  ),
                )
              : SizedBox(), // Empty SizedBox when no image selected
        ],
      ),
    );
  }
}
