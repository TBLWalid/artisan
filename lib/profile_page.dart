import 'dart:typed_data';

import 'package:artisans_app/comment.dart';
import 'package:artisans_app/func.dart';
import 'package:artisans_app/my_information.dart';
import 'package:artisans_app/pic_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'create_poste.dart';

final TextEditingController _nameImage = TextEditingController();
final TextEditingController _bio = TextEditingController();

//final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//class storedata {
//  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
//    Reference ref = _storage.ref().child(childName);
//   UploadTask uploadTask = ref.putData(file);
//    TaskSnapshot snapshot = await uploadTask;
//    String downloadURL = await snapshot.ref.getDownloadURL();
//    return downloadURL;
// }

//Future<String> savedata(
//    {required String name,
//   required String bio,
//    required Uint8List file}) async {
//  String resp = 'some error occured';
//  try {
//    String imageURL = await uploadImageToStorage('profileImage', file);
//    await _firestore.collection('users').add({'imageLink': imageURL});
//    resp = 'success';
//  } catch (err) {
//    resp = err.toString();
//  }
//  return resp;
// }
//}

class Artisan {
  final String name;
  final String profession;
  final String location;
  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  final user = FirebaseAuth.instance.currentUser;

  Artisan(
      {required this.name, required this.profession, required this.location});
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      userName = userData['full_name'];
    });
  }

  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  // void saveprofile() async {
  //   String name = _nameImage.text;
  //   String bio = _bio.text;
  //   String resp =
  //       await storedata().savedata(name: name, bio: bio, file: _image!);
  // }

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
                  SizedBox(
                    height: 150.0,
                  ),
                  Stack(children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage('images/blank_profile.png'),
                          ),
                    Positioned(
                      child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo)),
                      bottom: -10,
                      left: 80,
                    ),
                  ]),
                  SizedBox(
                    width: 20.0,
                  ),
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
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            // onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => ChatPage()));
                            // },
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
                              padding: EdgeInsets.all(12),
                              child: Icon(
                                Icons.message,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(tabs: [
              Tab(
                icon: Icon(
                  Icons.image,
                ),
              ),
              Tab(
                icon: Icon(Icons.info_outlined),
              ),
              Tab(
                icon: Icon(Icons.star_rate_rounded),
              ),
            ]),
            Expanded(
                child: TabBarView(children: [
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
            ]))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatepostPage()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
