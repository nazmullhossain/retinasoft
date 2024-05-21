import 'package:flutter/material.dart';

class TextFieldWidgett extends StatelessWidget {
  TextFieldWidgett({super.key,required this.controller,required this.hinText});
  TextEditingController controller;
  String hinText;

  @override
  Widget build(BuildContext context) {
    return   TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hinText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
