import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class infoprofile extends StatefulWidget {
  final String artisanId; // استقبال المعرف هنا

  const infoprofile({Key? key, required this.artisanId}) : super(key: key);

  @override
  State<infoprofile> createState() => _infoprofileState();
}

class _infoprofileState extends State<infoprofile> {
  late String email = '';
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
          InkWell(
            onTap: () {
              launch('tel:$phoneNo');
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.brown[600],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  SizedBox(width: 16),
                  Text(
                    phoneNo,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            // تخصيص اللون عند الضغط
            splashColor:
                const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              launch('mailto:$email');
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.brown[600],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.email_outlined, color: Colors.white),
                  SizedBox(width: 16),
                  Text(
                    email,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            // تخصيص اللون عند الضغط
            splashColor: Colors.blue.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
