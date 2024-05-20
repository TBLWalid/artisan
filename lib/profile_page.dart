import 'dart:typed_data';

import 'package:artisans_app/comment.dart';
import 'package:artisans_app/my_information.dart';
import 'package:artisans_app/pic_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';
  Uint8List? _image;
  String? profilePhotoUrl;
  String role = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      userName = userData['full_name'];
      profilePhotoUrl = userData['profilePhotoUrl'];
    });
  }

  Future<void> uploadImageToStorage(Uint8List image) async {
    final user = FirebaseAuth.instance.currentUser;
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('profilePhotos')
        .child('${user!.uid}.jpg');

    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'profilePhotoUrl': downloadUrl,
    });

    setState(() {
      profilePhotoUrl = downloadUrl;
      _image = image;
    });
  }

  Future<void> selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    await uploadImageToStorage(img);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[800],
          title: Text(
            'My Profile',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SizedBox(height: 150.0),
                  Stack(
                    children: [
                      profilePhotoUrl != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(profilePhotoUrl!),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  AssetImage('images/blank_profile.png'),
                            ),
                      Positioned(
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo),
                        ),
                        bottom: -10,
                        left: 80,
                      ),
                    ],
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(248, 41, 120, 128),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(tabs: [
              Tab(icon: Icon(Icons.image)),
              Tab(icon: Icon(Icons.info_outlined)),
              Tab(icon: Icon(Icons.star_rate_rounded)),
            ]),
            Expanded(
              child: TabBarView(
                children: [
                  picprofile(),
                  MyInformation(
                    onRoleChanged: (newRole) {
                      setState(() {
                        role = newRole;
                      });
                    },
                  ),
                  CommentPage(
                    postId: '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? _file = await _picker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      throw Exception('No image selected');
    }
  }
}
