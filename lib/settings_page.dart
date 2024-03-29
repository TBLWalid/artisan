import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // أضف أكواد للانتقال إلى صفحة الإشعارات أو تنفيذ إعدادات الإشعارات هنا
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () {
              // أضف أكواد لتغيير لغة التطبيق هنا
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
            onTap: () {
              // أضف أكواد لتفعيل أو تعطيل وضع الظلام هنا
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // أضف أكواد لتسجيل الخروج من التطبيق هنا
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
