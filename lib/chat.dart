// import 'dart:async';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';

// class ChatPage extends StatefulWidget {
//   final ChatPageArguments arguments;

//   const ChatPage({Key? key, required this.arguments}) : super(key: key);

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   late String _currentUserId;

//   late String _groupChatId;

//   late TextEditingController _chatInputController;
//   late ScrollController _listScrollController;
//   late FocusNode _focusNode;

//   File? _imageFile;
//   bool _isLoading = false;
//   bool _isShowSticker = false;
//   String _imageUrl = '';

//   @override
//   void initState() {
//     super.initState();
//     _chatInputController = TextEditingController();
//     _listScrollController = ScrollController();
//     _focusNode = FocusNode();
//     _readLocal();
//   }

//   @override
//   void dispose() {
//     _chatInputController.dispose();
//     _listScrollController.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }

//   void _readLocal() {
//     // Implement logic to read current user ID
//     _currentUserId = 'current_user_id';
    
//     String peerId = widget.arguments.peerId;
//     if (_currentUserId.compareTo(peerId) > 0) {
//       _groupChatId = '$_currentUserId-$peerId';
//     } else {
//       _groupChatId = '$peerId-$_currentUserId';
//     }
//   }

//   void _scrollListener() {
//     if (!_listScrollController.hasClients) return;
//     if (_listScrollController.offset >= _listScrollController.position.maxScrollExtent &&
//         !_listScrollController.position.outOfRange) {
//       // Implement logic for loading more messages
//     }
//   }

//   void _onFocusChange() {
//     if (_focusNode.hasFocus) {
//       // Hide sticker when keyboard appear
//       setState(() {
//         _isShowSticker = false;
//       });
//     }
//   }

//   Future<bool> _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedXFile = await imagePicker.pickImage(source: ImageSource.gallery).catchError((err) {
//       Fluttertoast.showToast(msg: err.toString());
//       return null;
//     });
//     if (pickedXFile != null) {
//       final imageFile = File(pickedXFile.path);
//       setState(() {
//         _imageFile = imageFile;
//         _isLoading = true;
//       });
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<void> _uploadFile() async {
//     final fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     // Implement logic for uploading file
//   }

//   void _onSendMessage(String content, int type) {
//     if (content.trim().isNotEmpty) {
//       _chatInputController.clear();
//       // Implement logic for sending message
//     } else {
//       Fluttertoast.showToast(msg: 'Nothing to send');
//     }
//   }

//   Widget _buildItemMessage(int index, DocumentSnapshot? document) {
//     // Implement logic for building message item
//   }

//   bool _isLastMessageLeft(int index) {
//     // Implement logic to determine if it's the last message from left
//   }

//   bool _isLastMessageRight(int index) {
//     // Implement logic to determine if it's the last message from right
//   }

//   void _onBackPress() {
//     // Implement logic for navigating back
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.arguments.peerNickname,
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: PopScope(
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   // Implement logic for building list of messages
//                   // _buildListMessage(),
//                   // _isShowSticker ? _buildStickers() : SizedBox.shrink(),
//                   // _buildInput(),
//                 ],
//               ),
//               Positioned(
//                 child: _isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
//               ),
//             ],
//           ),
//           canPop: false,
//           onPopInvoked: (didPop) {
//             if (didPop) return;
//             _onBackPress();
//           },
//         ),
//       ),
//     );
//   }
// }

// class ChatPageArguments {
//   final String peerId;
//   final String peerAvatar;
//   final String peerNickname;

//   ChatPageArguments({
//     required this.peerId,
//     required this.peerAvatar,
//     required this.peerNickname,
//   });
// }
