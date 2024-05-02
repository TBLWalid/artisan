
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:artisans_app/signup_page.dart';

class comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;

  const comment(
      {Key? key, required this.text, required this.user, required this.time})
      : super(key: key);

// void addcomment(String commentText){
//   FirebaseFirestore.instance.collection('User Posts').doc(widget.postId).collection('comments').add({
//     'commentText':commentText,
//     'commentedBy':currentUser?.email,
//     'commentTime':Timestamp.now(),
//   });
// }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),

      ),
      child: Column(
        children: [
           Text(text),
           Row(
            children: [
              Text(user),
              Text(' . '),
              Text(time),


            ],
           )

        ],
      ),
    );
  }
}
