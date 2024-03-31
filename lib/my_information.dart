import 'package:flutter/material.dart';
import 'profile_page.dart';

class MyInformation extends StatefulWidget {
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onRoleChanged;

  const MyInformation({
    Key? key,
    required this.onNameChanged,
    required this.onRoleChanged,
  }) : super(key: key);

  @override
  State<MyInformation> createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Information'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
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
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Role'),
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
        ],
      ),
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
