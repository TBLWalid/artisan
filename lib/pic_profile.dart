import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class picprofile extends StatefulWidget {
  const picprofile({Key? key}) : super(key: key);

  @override
  State<picprofile> createState() => _picprofileState();
}

class _picprofileState extends State<picprofile> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 5,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (Context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
