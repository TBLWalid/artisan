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
