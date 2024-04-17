import 'package:artisans_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'settings_page.dart';
import 'profile_page.dart';
import 'post_page.dart';
import 'login_page.dart'; // استيراد صفحة LoginPage
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ArtisansApp());
}

class ArtisansApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(), // يتم عرض واجهة يعفوف أولاً
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(88)),
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage("images/logo.png"),
                            fit: BoxFit.cover)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Container(
            height: 200,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[600],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(88),
                        bottomLeft: Radius.circular(88)),
                  ),
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (_, index) {
                      return Container(
                        padding: const EdgeInsets.only(top: 25),
                        width: 100,
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("تطبيق الحرفيين",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            SizedBox(height: 5),
                            Text("يتيح التواصل المباشر لطلب الخدمات بسهولة",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            Text("يتيح للمستخدمين تقييم ومراجعة الحرفيين",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            Text("لمساعدة الآخرين في الاختيار",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(88)),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                // عند الضغط على الزر، يتم نقل المستخدم إلى واجهة دعسوق
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                              child: Text("تسجيل الدخول",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF1e1c2a).withOpacity(0.8),
                                  )),
                            ),
                          ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // عند الضغط على الزر، يتم نقل المستخدم إلى واجهة دعسوق
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "مواصلة",
                                  style: TextStyle(
                                    color: Color(0xFF1e1c2a).withOpacity(0.8),
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                    width: 8), // المسافة بين النص والأيقونة
                                Icon(Icons.arrow_forward, // أيقونة السهم للأمام
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    PostPage(),
    LoginPage(),
    ProfilePage(),
    SettingsPage(), // إضافة صفحة LoginPage
  ];
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 165),
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.notifications_none),
      //       onPressed: () {
      //         // افتح صفحة البحث
      //       },
      //     ),
      //   ],
      //   title: Text(
      //     'Artisanss',
      //     style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
      //   ),
      //   backgroundColor: Color.fromARGB(255, 236, 237, 219),
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Color.fromARGB(255, 107, 107, 107),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
