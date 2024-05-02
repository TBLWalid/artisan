import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreatepostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'create post',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[800],
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
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Description',
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
                      child: Text('ajouter'),
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
