import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:artisans_app/signup_page.dart';

class infoprofile extends StatefulWidget {
  const infoprofile({Key? key}) : super(key: key);

  @override
  State<infoprofile> createState() => _infoprofileState();
}

class _infoprofileState extends State<infoprofile> {
  // List<QueryDocumentSnapshot> data=[];
  // getData()async{
  //   QuerySnapshot querySnapshot =
  //   await FirebaseFirestore.instance
  //   .collection('users')
  //   .get();
  //   data.addAll(querySnapshot.docs);
  //   setState(() {

  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.email_outlined),
            title: Text('ayoubbelme2003@gmail.com'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.work_outline),
            title: Text('carpenter'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text('MEDEA'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('+213778252455'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
