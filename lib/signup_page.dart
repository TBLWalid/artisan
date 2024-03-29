import 'package:flutter/material.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 236, 236, 165),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "images/logo.jpg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 124, 134, 72),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 124, 134, 72),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: _passwordController,
                    autofocus: false,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 124, 134, 72),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
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
                      fillColor: Colors.white.withOpacity(0.3),
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 124, 134, 72),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
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
                      fillColor: Colors.white.withOpacity(0.3),
                      hintText: 'State',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 124, 134, 72),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // لون الخلفية
                      // لون النص عند التفاعل
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 50.0),
                    ),
                    onPressed: () {
                      // Implement signup functionality here
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Color.fromARGB(255, 124, 134, 72),
                          fontSize: 18.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "I have an account? Log in",
                      style: TextStyle(
                          color: Color.fromARGB(255, 124, 134, 72),
                          fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
