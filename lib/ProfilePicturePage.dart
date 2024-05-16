import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

final TextEditingController _nameImage = TextEditingController();
final TextEditingController _bio = TextEditingController();

//final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//class storedata {
// Future<String> uploadImageToStorage(String childName, Uint8List file) async {
//   Reference ref = _storage.ref().child(childName);
//   UploadTask uploadTask = ref.putData(file);
//   TaskSnapshot snapshot = await uploadTask;
//   String downloadURL = await snapshot.ref.getDownloadURL();
//   return downloadURL;
//  }

// Future<String> savedata(
//     {required String name,
//     required String bio,
//     required Uint8List file}) async {
//   String resp = 'some error occured';
//   try {
//     String imageURL = await uploadImageToStorage('profileImage', file);
//     await _firestore.collection('users').add({'imageLink': imageURL});
//     resp = 'success';
//   } catch (err) {
//     resp = err.toString();
//   }
//   return resp;
//  }
//}

class ProfilePicturePage extends StatefulWidget {
  @override
  _ProfilePicturePageState createState() => _ProfilePicturePageState();
}

class _ProfilePicturePageState extends State<ProfilePicturePage> {
  File? _imageFile;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _goToHomePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Please upload a profile picture',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _getImage,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: Container(
                      width: 240,
                      height: 240,
                      child: _imageFile != null
                          ? Image.file(_imageFile!, fit: BoxFit.cover)
                          : Icon(Icons.person, size: 240),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                        ),
                      ),
                      width: 60,
                      height: 60,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Stack(alignment: Alignment.center, children: [
                Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
