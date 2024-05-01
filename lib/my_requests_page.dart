import 'package:flutter/material.dart';

class MyRequestsPage extends StatelessWidget {
  // قائمة بالطلبات
  final List<Order> orders = [
    Order(
        customerName: 'John Doe',
        craftType: 'Plumbing',
        orderNumber: 'Order 1'),
    Order(
        customerName: 'Jane Smith',
        craftType: 'Electrical',
        orderNumber: 'Order 2'),
    Order(
        customerName: 'Alice Johnson',
        craftType: 'Carpentry',
        orderNumber: 'Order 3'),
    // يمكنك إضافة المزيد من الطلبات هنا
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders', style: TextStyle(color: Colors.white)),
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
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: ListTile(
                title: Text(orders[index].orderNumber),
                subtitle: Text(
                    'Customer: ${orders[index].customerName}\nCraft Type: ${orders[index].craftType}'),
                // يمكنك إضافة المزيد من المعلومات هنا مثل تفاصيل الطلب أو حالته
              ),
            ),
          );
        },
      ),
    );
  }
}

// تعريف نموذج بيانات الطلب
class Order {
  final String customerName;
  final String craftType;
  final String orderNumber;

  Order(
      {required this.customerName,
      required this.craftType,
      required this.orderNumber});
}
