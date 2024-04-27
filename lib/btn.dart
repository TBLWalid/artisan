import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buttonOnOff extends StatefulWidget {
  const buttonOnOff({Key? key}) : super(key: key);

  @override
  State<buttonOnOff> createState() => _buttonOnOffState();
}

class _buttonOnOffState extends State<buttonOnOff> {
  bool _light = false;
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      activeColor: Colors.brown,
      value: _light,
      onChanged: (bool value) {
        setState(() {
          _light = value;
        });
      },
    );
  }
}