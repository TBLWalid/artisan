import 'package:flutter/material.dart';

class CreatepostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create poste'),
        backgroundColor: Color.fromARGB(255, 236, 237, 219),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What\'s happening?',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write your post here...',
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Implement image upload functionality
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.camera_alt),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Craft Type',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    ElevatedButton(
                      onPressed: () {
                        // Implement post functionality
                      },
                      child: Text('Post'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Add your other widgets here
          ],
        ),
      ),
    );
  }
}
