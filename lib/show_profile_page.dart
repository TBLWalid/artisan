import 'dart:typed_data';

import 'package:artisans_app/func.dart';
import 'package:artisans_app/pic_profile.dart';
import 'package:artisans_app/review_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'info_profile.dart';
import 'signup_page.dart';

String role = 'Client';

class Artisan {
  final String name;
  final String profession;
  final String location;

  Artisan(
      {required this.name, required this.profession, required this.location});
}

class ShowProfilePage extends StatefulWidget {
  //final Artisan artisan;

  //ProfilePage({required this.artisan});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ShowProfilePage> {
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  @override
  // void initState(){
  //   getData();
  //   super.initState();
  // }
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: const Color.fromARGB(255, 0, 0, 0),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
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
                  ]),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
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
                              // padding: EdgeInsets.all(12),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 6),
                              child: Text(
                                'request',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )),
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
              infoprofile(),
              reviewprofile(),
            ]))
          ],
        ),
      ),
    );
  }
}
