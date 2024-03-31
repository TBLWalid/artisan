import 'package:artisans_app/create_poste.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: posts.length, // عدد المنشورات
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      posts[index].title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      posts[index].body,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'الصور:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: List.generate(
                        posts[index].images.length,
                        (i) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              posts[index].images[i],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'تعليقات:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    RatingBar.builder(
                      initialRating: 3, // التقييم الافتراضي
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // يمكنك التعامل مع التقييم المحدث هنا
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatepostPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// قم بتعريف بيانات المنشور في مكان ما، هنا سنستخدم قائمة مؤقتة للأغراض التوضيحية
List<Post> posts = [
  Post(
    title: 'عنوان المنشور 1',
    body: 'محتوى المنشور 1',
    images: [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
    ],
  ),
  Post(
    title: 'عنوان المنشور 2',
    body: 'محتوى المنشور 2',
    images: [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
    ],
  ),
  // يمكنك إضافة المزيد من المنشورات هنا
];

// تعريف نموذج بيانات المنشور
class Post {
  final String title;
  final String body;
  final List<String> images;

  Post({required this.title, required this.body, required this.images});
}
