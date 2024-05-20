import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retinasoft/widget/validation_widget.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key,required this.controller});
 final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      validator: (value) => ValidiationWidget.validatePhoneNumber(value),
      controller: controller,
      keyboardType: TextInputType.phone,
      expands: false,
      decoration: InputDecoration(

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Phone",
        prefixIcon: Icon(Icons.phone),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(11),
      ],
    );
  }
}
