import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class infoprofile extends StatefulWidget {
  final String artisanId; // استقبال المعرف هنا

  const infoprofile({Key? key, required this.artisanId}) : super(key: key);

  @override
  State<infoprofile> createState() => _infoprofileState();
}

class _infoprofileState extends State<infoprofile> {
  late String email = '';
  late String profession = '';
  late String state = '';
  late String phoneNo = '';

  // دالة لاسترجاع بيانات الحرفي من Firestore باستخدام المعرف
  void fetchData() async {
    // استعلام Firestore للحصول على بيانات الحرفي باستخدام المعرف
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.artisanId)
        .get();

    // استخراج البيانات من snapshot وتعيينها في المتغيرات المناسبة
    setState(() {
      email = snapshot['email'];
      profession = snapshot['profession'];
      state = snapshot['state'];
      phoneNo = snapshot['phoneNo'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // استدعاء الدالة لاسترجاع بيانات الحرفي عند تهيئة الحالة
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.email_outlined),
            title: Text(email), // استخدام البريد الإلكتروني من بيانات Firestore
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.work_outline),
            title: Text(profession), // استخدام المهنة من بيانات Firestore
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text(state), // استخدام الولاية من بيانات Firestore
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(phoneNo), // استخدام رقم الهاتف من بيانات Firestore
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
