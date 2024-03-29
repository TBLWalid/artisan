import 'package:flutter/material.dart';

class ServiceDescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Description'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Service Description Page'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // زر الرجوع للصفحة السابقة
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
