import 'package:artisans_app/func.dart';
import 'package:artisans_app/home_page.dart';
import 'package:artisans_app/language_switch_page.dart';
import 'package:artisans_app/main.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:artisans_app/models/user_model.dart';

String name = '';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  late String name;
  late String email;
  late String password;
  late String Domain;
  late String state;
  bool spinner = false;
  String dropdownValue = 'Wilaya';

  final _firestore = FirebaseFirestore.instance;
// void getinfo()async{
//   final infos = await _firestore.collection('users').get();
//   for (var info in infos.docs){
// print(info.data());
//   }
// }
  CollectionReference users = FirebaseFirestore.instance.collection('users');
final user = FirebaseAuth.instance.currentUser;
  // Future<void> addUser() {
  //   // Call the user's CollectionReference to add a new user
  //   return users
  //       .add({
  //         'first_name': _firstnameController.text,
  //         'last_name': _lastnameController.text,
  //         'email': _emailController.text,
  //         'phoneNo': _phoneController.text,
  //         'state': _stateController.text,
  //       })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'signup',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[800],
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Lets create your account',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              name = value;
                            },
                            controller: _firstnameController,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              hintText: 'First Name',
                              hintStyle: TextStyle(
                                color: Colors.grey[800],
                              ),
                              // prefixIcon: Icon(Icons.data_usage_rounded),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              name = value;
                            },
                            controller: _lastnameController,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              hintText: 'Last Name',
                              hintStyle: TextStyle(
                                color: Colors.grey[800],
                              ),
                              // prefixIcon: Icon(Icons.data_usage_rounded),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      controller: _passwordController,
                      autofocus: false,
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      autofocus: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      controller: _domainController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        hintText: 'Domain',
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      controller: _stateController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        hintText: 'State',
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),

                    // Container(

                    //   width: 320,
                    //   height: 53,
                    //   decoration: BoxDecoration(

                    //       color: Colors.grey.withOpacity(0.1),
                    //       border: Border.all(color: Colors.black),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: DropdownButton<String>(
                    //     value: dropdownValue,
                    //     onChanged: (newValue) {
                    //       setState(() {
                    //         dropdownValue = newValue!;

                    //       });
                    //     },
                    //     items: <String>[
                    //       'Wilaya',
                    //       'Adrar',
                    //       'Chlef',
                    //       'Laghouat',
                    //       'Oum El Bouaki',
                    //       'Batna',
                    //       'Bijaya',
                    //       'Biskra',
                    //       'Bechar',
                    //       'Blida',
                    //       'Bouira',
                    //       'Tamenrasset',
                    //       'Tebassa',
                    //       'Tlemcen',
                    //       'Tiaret',
                    //       'Tizi ouzou',
                    //       'Alger',
                    //       'Djelfa',
                    //       'Jijel',
                    //       'Setif',
                    //       'Saida',
                    //       'Skikda',
                    //       'Sidi Bel Abbas',
                    //       'Annaba',
                    //       'Guelma',
                    //       'Constantine',
                    //       'Medea'
                    //     ].map<DropdownMenuItem<String>>((String value) {
                    //       return DropdownMenuItem<String>(

                    //         value: value,

                    //         child: Padding(
                    //           padding:
                    //               const EdgeInsets.symmetric(horizontal: 20.0),
                    //           child: Text(value),
                    //         ),
                    //       );
                    //     }).toList(),
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       // Change text color
                    //       fontSize: 18.0, // Change font size
                    //     ),
                    //   ),
                    // ),

                    SizedBox(height: 24.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // لون الخلفية
                        // لون النص عند التفاعل
                        backgroundColor: Colors.brown[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 50.0),
                      ),
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                          // addUser();
                          _firestore.collection('users').add({
                            'full_name': _firstnameController.text,
                            'last_name': _lastnameController.text,
                            'email': _emailController.text,
                            'phoneNo': _phoneController.text,
                            'profession': _domainController.text,
                            'state': _stateController.text,
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                        ;
                        if (user != null) {
  
  // ... access other relevant properties
}
                      },
                      child: Stack(alignment: Alignment.center, children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 70, 49, 41)),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          Text(
                            "I have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                              fontSize: 20.0,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              " Log in",
                              style: TextStyle(
                                color: Colors.brown[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
