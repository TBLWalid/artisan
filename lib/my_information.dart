import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String role = 'Client';

class MyInformation extends StatefulWidget {
  final ValueChanged<String> onRoleChanged;

  const MyInformation({
    Key? key,
    required this.onRoleChanged,
  }) : super(key: key);

  @override
  State<MyInformation> createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // late String _uid;
  // late String _name;
  // late String _email;
  // late String _phone;

  // final userId = FirebaseAuth.instance.currentUser!.uid;
  // List<QueryDocumentSnapshot> data = [];

// Or using snapshots for real-time updates

  // void getdata() async {
  //   User? user = _auth.currentUser;
  //   _uid = user!.uid;
  //   // print('user.email ${user.email}');
  //   final DocumentSnapshot userDoc =
  //       await FirebaseFirestore.instance.collection('users').doc(_uid).get();
  //   // setState(() {
  //   //   _name = userDoc.get('last_name');
  //   //   _email = userDoc.get('email');
  //   // });

  //   print('name ${user.email}');
  // }

  String userName = '';
  String ntel = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      userName = userData['full_name'];
      email = userData['email'];
      ntel = userData['phoneNo'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListView(padding: EdgeInsets.all(2.0), children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Name'),
          subtitle: Text(userName),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final newName = await showDialog<String>(
                context: context,
                builder: (context) => _NameEditDialog(initialValue: userName),
              );
              if (newName != null) {
                setState(() {
                  userName = newName;
                });
              }
            },
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.group),
          title: Text('Type'),
          subtitle: Text(role),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final newRole = await showDialog<String>(
                context: context,
                builder: (context) => _RoleEditDialog(initialValue: role),
              );
              if (newRole != null) {
                setState(() {
                  role = newRole;
                  widget.onRoleChanged(newRole);
                });
              }
            },
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('Email'),
          subtitle: Text(email),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final newEmail = await showDialog<String>(
                context: context,
                builder: (context) => _EmailEditDialog(initialValue: email),
              );
              if (newEmail != null) {
                setState(() {
                  email = newEmail;
                });
              }
            },
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone Number'),
          subtitle: Text(ntel),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final newNtel = await showDialog<String>(
                context: context,
                builder: (context) => _PhoneEditDialog(initialValue: ntel),
              );
              if (newNtel != null) {
                setState(() {
                  ntel = newNtel;
                });
              }
            },
          ),
        ),
      ]),
    );
  }
}

class _NameEditDialog extends StatefulWidget {
  final String initialValue;

  const _NameEditDialog({Key? key, required this.initialValue})
      : super(key: key);

  @override
  _NameEditDialogState createState() => _NameEditDialogState();
}

class _NameEditDialogState extends State<_NameEditDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Name'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: 'Name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog without saving
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _controller.text); // Return the new value
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class _RoleEditDialog extends StatefulWidget {
  final String initialValue;

  const _RoleEditDialog({Key? key, required this.initialValue})
      : super(key: key);

  @override
  _RoleEditDialogState createState() => _RoleEditDialogState();
}

class _RoleEditDialogState extends State<_RoleEditDialog> {
  late String _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Role'),
      content: DropdownButton<String>(
        value: _selectedRole,
        onChanged: (newValue) {
          setState(() {
            _selectedRole = newValue!;
          });
        },
        items: ['Client', 'Artisan'].map<DropdownMenuItem<String>>((role) {
          return DropdownMenuItem<String>(
            value: role,
            child: Text(role),
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog without saving
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _selectedRole); // Return the new value
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class _PhoneEditDialog extends StatefulWidget {
  final String initialValue;

  const _PhoneEditDialog({Key? key, required this.initialValue})
      : super(key: key);

  @override
  _PhoneEditDialogState createState() => _PhoneEditDialogState();
}

class _PhoneEditDialogState extends State<_PhoneEditDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Phone Number'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: 'Phone Number'),
        keyboardType: TextInputType.phone,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog without saving
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _controller.text); // Return the new value
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class _EmailEditDialog extends StatefulWidget {
  final String initialValue;

  const _EmailEditDialog({Key? key, required this.initialValue})
      : super(key: key);

  @override
  _EmailEditDialogState createState() => _EmailEditDialogState();
}

class _EmailEditDialogState extends State<_EmailEditDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Email'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: 'Email Address'),
        keyboardType: TextInputType.emailAddress,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog without saving
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _controller.text); // Return the new value
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
