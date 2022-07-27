
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
 // const CustomTextField({Key key}) : super(key: key);
 final TextEditingController controller;
 final String labelText;
 final TextInputType keyboardType;
 CustomTextField({this.controller,this.keyboardType,this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}