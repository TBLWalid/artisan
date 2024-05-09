import 'package:artisans_app/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:artisans_app/profile_page.dart';

class CommentPage extends StatefulWidget {
  final String postId; // To identify the post

  const CommentPage({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _commentController = TextEditingController();

  List<Comment> comments = []; // List to store comments

  // Fetch comments from your data source (e.g., Firebase)
  Future<void> _fetchComments() async {
    // Replace this with your logic to fetch comments from database
    // based on postId
    setState(() {
      comments = [
        Comment(name: "ayoub belme", message: "This is a great post!"),
        Comment(name: "walid TBL", message: "Amazing!"),
      ];
    });
  }

  // Add a new comment
  void _addComment() {
    final commentText = _commentController.text;
    if (commentText.isNotEmpty) {
      setState(() {
        comments.add(Comment(name: name, message: commentText));
        _commentController.text = ""; // Clear text field
      });
      // Persist the comment to your data source (e.g., Firebase)
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchComments(); // Fetch comments on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Text field to add a comment (moved to top)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration:
                        const InputDecoration(hintText: "Write a comment"),
                  ),
                ),
                IconButton(
                  onPressed: _addComment,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
          // Display the list of comments
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(comment.name[0])),
                  title: Text(comment.name),
                  subtitle: Text(comment.message),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Comment {
  final String name;
  final String message;

  const Comment({required this.name, required this.message});
}
