import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'signup_page.dart';

String email = 'tebbalwali8@gmail.com';
String ntel = '+213560629569';

class MyInformation extends StatefulWidget {
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onRoleChanged;

// getData()async{
//   QuerySnapshot querySnapshot =
//   await FirebaseFirestore.instance
//   .collection('users')
//   .get();
//   data.addAll(querySnapshot.docs);
//   setState(() {

//   });
// }

  const MyInformation({
    Key? key,
    required this.onNameChanged,
    required this.onRoleChanged,
  }) : super(key: key);

  @override
  State<MyInformation> createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  List<QueryDocumentSnapshot> data = [];

  getdata() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    data.addAll(querySnapshot.docs);
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }
 

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListView(padding: EdgeInsets.all(2.0), children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Name'),
          subtitle: Text(name),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final newName = await showDialog<String>(
                context: context,
                builder: (context) => _NameEditDialog(initialValue: name),
              );
              if (newName != null) {
                setState(() {
                  name = newName;
                  widget.onNameChanged(newName);
                });
              }
            },
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.group),
          title: Text('type'),
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
          leading: Icon(Icons.person),
          title: Text('email'),
          subtitle: Text(email),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final newemail = await showDialog<String>(
                context: context,
                builder: (context) => _EmailEditDialog(initialValue: email),
              );
              if (newemail != null) {
                setState(() {
                  email = newemail;
                  widget.onNameChanged(newemail);
                });
              }
            },
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Numero tel'),
          subtitle: Text(ntel),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final newntel = await showDialog<String>(
                context: context,
                builder: (context) => _PhoneEditDialog(initialValue: ntel),
              );
              if (newntel != null) {
                setState(() {
                  ntel = newntel;
                  widget.onNameChanged(newntel);
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
        keyboardType: TextInputType.phone, // تحديد نوع لوحة المفاتيح للأرقام
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // إغلاق الحوار دون حفظ التغييرات
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _controller.text); // إرجاع القيمة الجديدة
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
        keyboardType: TextInputType
            .emailAddress, // تحديد نوع لوحة المفاتيح للبريد الإلكتروني
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // إغلاق الحوار دون حفظ التغييرات
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _controller.text); // إرجاع القيمة الجديدة
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
