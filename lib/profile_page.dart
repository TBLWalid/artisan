import 'package:artisans_app/my_information.dart';
import 'package:flutter/material.dart';
import 'listes/liste_poste.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'my_requests_page.dart';

String name = 'Walid TBL';
String role = 'Client';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                SizedBox(
                  height: 150.0,
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/walid.jpg'),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      role,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    RatingBar.builder(
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
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: Icon(Icons.language),
                  title: Text('My Information'),
                  onTap: () async {
                    final updatedName = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyInformation(
                          onNameChanged: (newName) {
                            setState(() {
                              name = newName;
                            });
                          },
                          onRoleChanged: (newRole) {
                            setState(() {
                              role = newRole;
                            });
                          },
                        ),
                      ),
                    );

                    if (updatedName != null) {
                      setState(() {
                        name = updatedName;
                      });
                    }
                  },
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Icon(Icons.language),
                  title: Text('My Requests'),
                  onTap: () {
                    // Navigate to My Requests page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyRequestsPage()),
                    );
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color.fromARGB(
                        255, 255, 255, 255), // تعيين لون الخلفية إلى الأبيض
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            posts[index].title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            posts[index].body,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'الصور:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: List.generate(
                              posts[index].images.length,
                              (i) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.network(
                                    posts[index].images[i],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'تعليقات:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
