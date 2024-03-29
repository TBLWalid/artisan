import 'package:flutter/material.dart';

class MyRequestsPage extends StatelessWidget {
  // قائمة بالطلبات
  final List<String> orders = [
    'Order 1',
    'Order 2',
    'Order 3',
    // يمكنك إضافة المزيد من الطلبات هنا
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(orders[index]),
            // يمكنك إضافة المزيد من المعلومات هنا مثل تفاصيل الطلب أو حالته
          );
        },
      ),
    );
  }
}
