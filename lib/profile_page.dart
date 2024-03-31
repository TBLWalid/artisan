import 'package:artisans_app/my_information.dart';
import 'package:flutter/material.dart';
import 'my_requests_page.dart';

String name = 'Walid TBL';
String role = 'Client';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

final List<String> posts = [
  'Post 1',
  'Post 2',
  'Post 3',
  // يمكنك إضافة المزيد من المنشورات هنا
];

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
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
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ListTile(
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
          ListTile(
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
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.grey.shade400, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          posts[index],
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Divider(
                          color: Colors.grey.shade400,
                          thickness: 0.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.comment_outlined),
                                SizedBox(width: 4),
                                Text('Comment'),
                              ],
                            ),
                          ],
                        ),
                      ],
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
