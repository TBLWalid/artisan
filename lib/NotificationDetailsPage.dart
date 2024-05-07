import 'package:flutter/material.dart';

class NotificationDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 10, // عدد الإشعارات
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showNotificationDetails(context, index);
            },
            child: Card(
              elevation: 3, // رفعية البطاقة
              margin: EdgeInsets.symmetric(
                  vertical: 8, horizontal: 16), // هامش البطاقة
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.brown[800], // لون الصورة الدائرية
                  child: Icon(
                    Icons.notifications, // أيقونة الإشعار
                    color: Colors.white, // لون أيقونة الإشعار
                  ),
                ),
                title: Text(
                  'Notification Title $index', // عنوان الإشعار
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Notification Description $index', // وصف الإشعار
                ),
                trailing: Text(
                  '5m', // الوقت منذ الإشعار
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showNotificationDetails(BuildContext context, int index) {
    // Replace this with your logic to show notification details
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notification Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer Name: John Doe'),
              Text('Customer Location: New York'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Logic for accepting the request
                      Navigator.pop(context);
                    },
                    child: Text('Accept'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Logic for rejecting the request
                      Navigator.pop(context);
                    },
                    child: Text('Reject'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
