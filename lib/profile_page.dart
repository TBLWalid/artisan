import 'dart:typed_data';
import 'package:artisans_app/func.dart';
import 'package:artisans_app/info_profile.dart';
import 'package:artisans_app/my_information.dart';
import 'package:artisans_app/pic_profile.dart';
import 'package:artisans_app/review_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'listes/liste_poste.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'my_requests_page.dart';
import 'signup_page.dart';
import 'package:artisans_app/btn.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

String role = 'Client';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                                'follow',
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
                      SizedBox(
                        height: 8.0,
                      ),
                      RatingBar.builder(
                        initialRating: 3, // التقييم الافتراضي
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // يمكنك التعامل مع التقييم المحدث هنا
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.language),
                    title: Text('My Information'),
                    onTap: () async {
                      final updatedName = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyInformation(
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
                        ),
                      );

                      if (updatedName != null) {
                        setState(() {
                          name = updatedName;
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.language),
                    title: Text('My Requests'),
                    onTap: () {
                      // Navigate to My Requests page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyRequestsPage()),
                      );
                    },
                  ),
                )
              ],
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
