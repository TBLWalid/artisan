import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InfoStoragePage extends StatelessWidget {
  final String artisanName;
  final String artisanProfession;
  final String artisanState;

  InfoStoragePage({
    required this.artisanName,
    required this.artisanProfession,
    required this.artisanState,
  });

  @override
  Widget build(BuildContext context) {
    // قم بتخزين المعلومات هنا
    // على سبيل المثال، يمكنك استخدام Firestore لحفظها في قاعدة البيانات
    FirebaseFirestore.instance.collection('artisan_info').add({
      'name': artisanName,
      'profession': artisanProfession,
      'state': artisanState,
      // يمكنك إضافة المزيد من المعلومات هنا حسب الحاجة
    });

    // يمكنك عرض أي صفحة أخرى هنا إذا كنت بحاجة إلى توجيه المستخدم إليها بعد التخزين
    return Container();
  }
}
