import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'ProfilePicturePage.dart';
import 'login_page.dart';

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

  String domain = "option1";
  String wilaya = "option1";

  final _firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'signup',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
                    Container(
                      width: 320,
                      height: 53,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(width: 1, style: BorderStyle.solid),
                          color: Colors.grey.withOpacity(0.1)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DropdownButton<String>(
                          value: domain,
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.brown,
                              size: 29,
                            ),
                          ),
                          underline: Container(
                            height: 1,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: "option1",
                              child: Text("domain"),
                            ),
                            DropdownMenuItem(
                              value: "Aluminum",
                              child: Text("Aluminum"),
                            ),
                            DropdownMenuItem(
                              value: "Painter",
                              child: Text("Painter"),
                            ),
                            DropdownMenuItem(
                              value: "Plumber",
                              child: Text("Plumber"),
                            ),
                            DropdownMenuItem(
                              value: "Air Conditioner Technician",
                              child: Text("Air Conditioner Technician"),
                            ),
                            DropdownMenuItem(
                              value: "Carpenter",
                              child: Text("Carpenter"),
                            ),
                            DropdownMenuItem(
                              value: "Applicance Repair Technician",
                              child: Text("Applicance Repair Technician"),
                            ),
                            DropdownMenuItem(
                              value: "Electrician",
                              child: Text("Electrician"),
                            ),
                            DropdownMenuItem(
                              value: "Cleaner",
                              child: Text("Cleaner"),
                            ),
                            DropdownMenuItem(
                              value: "Landscaper",
                              child: Text("Landscaper"),
                            ),
                            DropdownMenuItem(
                              value: "Roofing Contractor",
                              child: Text("Roofing Contractor"),
                            ),
                            DropdownMenuItem(
                              value: "Pest Control Technician",
                              child: Text("Pest Control Technician"),
                            ),
                            DropdownMenuItem(
                              value: "Flooring Installer",
                              child: Text("Flooring Installer"),
                            ),
                            DropdownMenuItem(
                              value: "Glazier",
                              child: Text("Glazier"),
                            ),
                            DropdownMenuItem(
                              value: "Security System Installer",
                              child: Text("Security System Installer"),
                            ),
                            DropdownMenuItem(
                              value: "Furniture Assembler",
                              child: Text("Furniture Assembler"),
                            ),
                            DropdownMenuItem(
                              value: "Mover",
                              child: Text("Mover"),
                            ),
                            DropdownMenuItem(
                              value: "Carpet Cleaner",
                              child: Text("Carpet Cleaner"),
                            ),
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              domain = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Container(
                      width: 320,
                      height: 53,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(width: 1, style: BorderStyle.solid),
                          color: Colors.grey.withOpacity(0.1)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DropdownButton<String>(
                          value: wilaya,
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 110.0),
                            child: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.brown,
                              size: 29,
                            ),
                          ),
                          underline: Container(
                            height: 1,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'option1',
                              child: Text('state'),
                            ),
                            DropdownMenuItem(
                              value: 'Adrar',
                              child: Text('Adrar'),
                            ),
                            DropdownMenuItem(
                              value: 'Chlef',
                              child: Text('Chlef'),
                            ),
                            DropdownMenuItem(
                              value: 'Laghouat',
                              child: Text('Laghouat'),
                            ),
                            DropdownMenuItem(
                              value: 'Oum El Bouaghi',
                              child: Text('Oum El Bouaghi'),
                            ),
                            DropdownMenuItem(
                              value: 'Batna',
                              child: Text('Batna'),
                            ),
                            DropdownMenuItem(
                              value: 'Bejaia',
                              child: Text('Bejaia'),
                            ),
                            DropdownMenuItem(
                              value: 'Biskra',
                              child: Text('Biskra'),
                            ),
                            DropdownMenuItem(
                              value: 'Bechar',
                              child: Text('Bechar'),
                            ),
                            DropdownMenuItem(
                              value: 'Blida',
                              child: Text('Blida'),
                            ),
                            DropdownMenuItem(
                              value: 'Bouira',
                              child: Text('Bouira'),
                            ),
                            DropdownMenuItem(
                              value: 'Tamanrasset',
                              child: Text('Tamanrasset'),
                            ),
                            DropdownMenuItem(
                              value: 'Tebessa',
                              child: Text('Tebessa'),
                            ),
                            DropdownMenuItem(
                              value: 'Tlemcen',
                              child: Text('Tlemcen'),
                            ),
                            DropdownMenuItem(
                              value: 'Tiaret',
                              child: Text('Tiaret'),
                            ),
                            DropdownMenuItem(
                              value: 'Tizi Ouzou',
                              child: Text('Tizi Ouzou'),
                            ),
                            DropdownMenuItem(
                              value: 'Algiers',
                              child: Text('Algiers'),
                            ),
                            DropdownMenuItem(
                              value: 'Djelfa',
                              child: Text('Djelfa'),
                            ),
                            DropdownMenuItem(
                              value: 'Jijel',
                              child: Text('Jijel'),
                            ),
                            DropdownMenuItem(
                              value: 'Setif',
                              child: Text('Setif'),
                            ),
                            DropdownMenuItem(
                              value: 'Saïda',
                              child: Text('Saïda'),
                            ),
                            DropdownMenuItem(
                              value: 'Skikda',
                              child: Text('Skikda'),
                            ),
                            DropdownMenuItem(
                              value: 'Sidi Bel Abbes',
                              child: Text('Sidi Bel Abbes'),
                            ),
                            DropdownMenuItem(
                              value: 'Annaba',
                              child: Text('Annaba'),
                            ),
                            DropdownMenuItem(
                              value: 'Guelma',
                              child: Text('Guelma'),
                            ),
                            DropdownMenuItem(
                              value: 'Constantine',
                              child: Text('Constantine'),
                            ),
                            DropdownMenuItem(
                              value: 'Medea',
                              child: Text('Medea'),
                            ),
                            DropdownMenuItem(
                              value: 'Mostaganem',
                              child: Text('Mostaganem'),
                            ),
                            DropdownMenuItem(
                              value: 'Msila',
                              child: Text('Msila'),
                            ),
                            DropdownMenuItem(
                              value: 'Mascara',
                              child: Text('Mascara'),
                            ),
                            DropdownMenuItem(
                              value: 'Ouargla',
                              child: Text('Ouargla'),
                            ),
                            DropdownMenuItem(
                              value: 'Oran',
                              child: Text('Oran'),
                            ),
                            DropdownMenuItem(
                              value: 'El Bayadh',
                              child: Text('El Bayadh'),
                            ),
                            DropdownMenuItem(
                              value: 'Illizi',
                              child: Text('Illizi'),
                            ),
                            DropdownMenuItem(
                              value: 'Bordj Bou Arreridj',
                              child: Text('Bordj Bou Arreridj'),
                            ),
                            DropdownMenuItem(
                              value: 'Boumerdes',
                              child: Text('Boumerdes'),
                            ),
                            DropdownMenuItem(
                              value: 'El Tarf',
                              child: Text('El Tarf'),
                            ),
                            DropdownMenuItem(
                              value: 'Tindouf',
                              child: Text('Tindouf'),
                            ),
                            DropdownMenuItem(
                              value: 'Tissemsilt',
                              child: Text('Tissemsilt'),
                            ),
                            DropdownMenuItem(
                              value: 'El Oued',
                              child: Text('El Oued'),
                            ),
                            DropdownMenuItem(
                              value: 'Khenchela',
                              child: Text('Khenchela'),
                            ),
                            DropdownMenuItem(
                              value: 'Souk Ahras',
                              child: Text('Souk Ahras'),
                            ),
                            DropdownMenuItem(
                              value: 'Tipaza',
                              child: Text('Tipaza'),
                            ),
                            DropdownMenuItem(
                              value: 'Mila',
                              child: Text('Mila'),
                            ),
                            DropdownMenuItem(
                              value: 'Aïn Defla',
                              child: Text('Aïn Defla'),
                            ),
                            DropdownMenuItem(
                              value: 'Naama',
                              child: Text('Naama'),
                            ),
                            DropdownMenuItem(
                              value: 'Aïn Temouchent',
                              child: Text('Aïn Temouchent'),
                            ),
                            DropdownMenuItem(
                              value: 'Ghardaia',
                              child: Text('Ghardaia'),
                            ),
                            DropdownMenuItem(
                              value: 'Relizane',
                              child: Text('Relizane'),
                            ),
                            DropdownMenuItem(
                              value: 'Timimoun',
                              child: Text('Timimoun'),
                            ),
                            DropdownMenuItem(
                              value: 'Bordj Badji Mokhtar',
                              child: Text('Bordj Badji Mokhtar'),
                            ),
                            DropdownMenuItem(
                              value: 'Ouled Djellal',
                              child: Text('Ouled Djellal'),
                            ),
                            DropdownMenuItem(
                              value: 'Béni Abbès',
                              child: Text('Béni Abbès'),
                            ),
                            DropdownMenuItem(
                              value: 'In Salah',
                              child: Text('In Salah'),
                            ),
                            DropdownMenuItem(
                              value: 'In Guezzam',
                              child: Text('In Guezzam'),
                            ),
                            DropdownMenuItem(
                              value: 'Touggourt',
                              child: Text('Touggourt'),
                            ),
                            DropdownMenuItem(
                              value: 'Djanet',
                              child: Text('Djanet'),
                            ),
                            DropdownMenuItem(
                              value: 'El M’Ghaier',
                              child: Text('El M’Ghaier'),
                            ),
                            DropdownMenuItem(
                              value: 'El Meniaa',
                              child: Text('El Meniaa'),
                            ),
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              wilaya = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
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
                                builder: (context) => ProfilePicturePage()),
                          );
                          final user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            final String fullName = _firstnameController.text +
                                ' ' +
                                _lastnameController.text;
                            _firestore.collection('users').doc(user.uid).set({
                              'first_name': _firstnameController.text,
                              'last_name': _lastnameController.text,
                              'full_name': fullName,
                              'email': _emailController.text,
                              'phoneNo': _phoneController.text,
                              // 'profession': _domainController.text,
                              'profession': domain,
                              'state': wilaya,
                            });
                          } else {
                            // يمكنك إضافة رسالة خطأ هنا أو إجراء إجراء آخر حسب الحالة
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
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
