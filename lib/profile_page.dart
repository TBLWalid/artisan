import 'dart:typed_data';

import 'package:artisans_app/func.dart';
import 'package:artisans_app/my_information.dart';
import 'package:artisans_app/pic_profile.dart';
import 'package:artisans_app/review_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'create_poste.dart';
import 'signup_page.dart';

String role = 'Client';

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
                            backgroundImage: AssetImage('images/walid.jpg'),
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
                      Text(
                        role,
                        style: TextStyle(fontSize: 18),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(248, 41, 120, 128),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 2,
                                      blurRadius: 3)
                                ]),
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              Icons.message,
                              color: Colors.white,
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
                onNameChanged: (newName) {
                  setState(() {
                    name = newName;
                  });
                },
                onRoleChanged: (newRole) {
                  setState(() {
                    role = newRole;
                  });
                },
              ),
              reviewprofile(),
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
