import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'info_profile.dart';
import 'pic_profile.dart';
import 'review_profile.dart';

String role = 'Client';

class Artisan {
  final String id;
  final String name;
  final String profession;
  final String location;

  Artisan({
    required this.id,
    required this.name,
    required this.profession,
    required this.location,
  });
}

class ShowProfilePage extends StatefulWidget {
  final String artisanId;
  final String artisanName;

  ShowProfilePage({
    Key? key,
    required this.artisanId,
    required this.artisanName,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ShowProfilePage> {
  Uint8List? _image;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String profession = '';
  late String state = '';

  // دالة لاسترجاع بيانات الحرفي من Firestore باستخدام المعرف
  void fetchData() async {
    // استعلام Firestore للحصول على بيانات الحرفي باستخدام المعرف
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.artisanId)
        .get();

    // استخراج البيانات من snapshot وتعيينها في المتغيرات المناسبة
    setState(() {
      profession = snapshot['profession'];
      state = snapshot['state'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // استدعاء الدالة لاسترجاع بيانات الحرفي عند تهيئة الحالة
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    String? clientId;
    if (user != null) {
      clientId = user.uid; // استخدام معرف المستخدم الحالي كـ clientId
    }

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
                  Stack(
                    children: [
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
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.artisanName,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '  $profession',
                            style: TextStyle(fontSize: 20.0),
                          ), // استخدام المهنة من بيانات Firestore
                          Text(state), // استخدام الولاية من بيانات Firestore
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.image),
                ),
                Tab(
                  icon: Icon(Icons.call),
                ),
                Tab(
                  icon: Icon(Icons.star_outline),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  picprofile(),
                  infoprofile(
                    artisanId: widget.artisanId,
                  ),
                  reviewprofile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
