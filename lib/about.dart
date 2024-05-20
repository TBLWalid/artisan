import 'package:flutter/material.dart';

class aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CraftsMatch', // Replace with your app name
      theme: ThemeData(
        primarySwatch: Colors.teal, // Customize theme colors
      ),
      home: LandingPage(), // Replace with your desired initial screen
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // Consider adding user roles (client/craftsman) for tailored experiences

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Info App',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ), // Replace with your app name
        backgroundColor: Colors.brown[600],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero image or video showcasing app functionality (optional)
            Image.asset(
                'images/aboutapp.png'), // Replace with your image asset path

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CraftsMatch: Connecting Clients with Skilled Craftsmen',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.brown[600],
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'App description',
                        style: TextStyle(
                            color: Colors.brown[600],
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'CraftsMatch is a mobile application that simplifies the process of finding and hiring skilled craftsmen for your projects. Whether you need help with home repairs, furniture restoration, creative endeavors, or anything in between, CraftsMatch puts you in touch with talented professionals who can bring your vision to life.',
                    style: TextStyle(wordSpacing: 1, fontSize: 16),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.brown[600],
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Target Users',
                        style: TextStyle(
                            color: Colors.brown[600],
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Clients: Homeowners, businesses, or individuals seeking skilled craftsmen for various projects.',
                      style: TextStyle(wordSpacing: 1, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.brown[600],
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Benefits for Clients:',
                        style: TextStyle(
                            color: Colors.brown[600],
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Text(
                        'Seamless Search & Filtering:',
                        style: TextStyle(
                            color: Color.fromARGB(251, 100, 152, 156),
                            fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Find the perfect craftsman for your needs by location, skillset, budget, and customer ratings.',
                    style: TextStyle(wordSpacing: 1, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Secure In-App Communication:',
                    style: TextStyle(
                        color: Color.fromARGB(251, 100, 152, 156),
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Chat directly with craftsmen to discuss project details, pricing, and scheduling in a secure environment.',
                    style: TextStyle(wordSpacing: 1, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Streamlined Project Management :',
                    style: TextStyle(
                        color: Color.fromARGB(251, 100, 152, 156),
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' Track project milestones, receive updates, and manage payments securely within the app.',
                    style: TextStyle(wordSpacing: 1, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Access to a Wide Range of Craftsmen:',
                    style: TextStyle(
                        color: Color.fromARGB(251, 100, 152, 156),
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' Discover a diverse pool of talented professionals in your area.',
                    style: TextStyle(wordSpacing: 1, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Image.asset(
                    'images/client.png',
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.brown[600],
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Benefits for Craftsmen:',
                        style: TextStyle(
                            color: Colors.brown[600],
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Increased Visibility:',
                    style: TextStyle(
                        color: Color.fromARGB(251, 100, 152, 156),
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Showcase your skills and experience to a wider audience of potential clients.',
                    style: TextStyle(wordSpacing: 1, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Convenient Project Management:',
                    style: TextStyle(
                        color: Color.fromARGB(251, 100, 152, 156),
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Manage projects, communicate with clients, and receive payments efficiently within the app.',
                    style: TextStyle(wordSpacing: 1, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Simplified Client Communication:',
                    style: TextStyle(
                        color: Color.fromARGB(251, 100, 152, 156),
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' Respond to inquiries and stay connected with clients through secure in-app messaging.',
                    style: TextStyle(wordSpacing: 1, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Build Your Reputation:',
                    style: TextStyle(
                        color: Color.fromARGB(251, 100, 152, 156),
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' Earn positive reviews and establish yourself as a trusted craftsman.',
                    style: TextStyle(wordSpacing: 1, fontSize: 16),
                  ),
                  Image.asset(
                    'images/craftsman.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Implement additional screens for client registration/login, craftsman registration/login, search functionality, project details, profiles, etc.