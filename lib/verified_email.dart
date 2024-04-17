import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class verified extends StatelessWidget {
  const verified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'verify your email',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.brown[800],
        ),
        body: ListView(
          children: [
            FirebaseAuth.instance.currentUser!.emailVerified
                ? Text('welcome')
                : Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: MaterialButton(
                      onPressed: () {
                        
                      },
                      textColor: Colors.white,
                      color: Colors.brown[600],
                      child: Text(
                        'please verify your email',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  )
          ],
        ));
  }
}
