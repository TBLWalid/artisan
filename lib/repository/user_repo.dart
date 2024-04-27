import 'package:artisans_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:artisans_app/signup_page.dart';

class UserRepo extends GetxController {
  static Function<S>({String? tag}) get instance => Get.find;

  final _db = FirebaseFirestore.instance;

  get user => null;

  get error => null;
  createUser(UserModel) async{
    await _db.collection('Users').add(user
            .toJson()
            .whenComplete(() => Get.snackbar(
                "success", "your acount has been created",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.1),
                colorText: Colors.green))
            .catchError((Error, StackTrace) {
          Get.snackbar(
            'Error',
            'something went wrong try again',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red,
          );
          print(error.toString());
        }));
  }
}
