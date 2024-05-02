import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class reviewprofile extends StatefulWidget {
  const reviewprofile({Key? key}) : super(key: key);

  @override
  State<reviewprofile> createState() => _reviewprofileState();
}

class _reviewprofileState extends State<reviewprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RatingBar.builder(
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
    );
  }
}
