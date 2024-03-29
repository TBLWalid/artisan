import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // إضافة بحث هنا
          Padding(
            padding:
                const EdgeInsets.all(12.0), // تغيير الحواف الأفقية (horizontal)
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن حرفي...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 8.0), // تقليل الارتفاع بتعيين التباعد العمودي
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.builder(
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio:
                      0.7, // تعديل النسبة لتجعل البطاقات أطول من العرض
                  crossAxisSpacing: 16.0, // زيادة المسافة بين البطاقات الأفقية
                  mainAxisSpacing: 16.0, // زيادة المسافة بين البطاقات الرأسية
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // افتح صفحة التفاصيل للمنشور
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // تطبيق الحواف المنعرجة
                        border: Border.all(
                            color: Colors.grey), // اطار حول البطاقة بأكملها
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/profile_picture.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                        10.0)), // تطبيق حواف منعرجة للجزء العلوي فقط
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'اسم الحرفي',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'نوع الحرفة',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // افتح صفحة إضافة منشور جديد
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
