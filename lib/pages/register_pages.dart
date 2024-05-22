import 'package:flutter/material.dart';
import 'package:retinasoft/widget/app_bar_widget.dart';
import 'package:retinasoft/widget/text_field_widget.dart';

import '../conroller/api_helper.dart';
import '../widget/input_decration_widget.dart';
import '../widget/loader_widget.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({super.key});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  TextEditingController name = TextEditingController();
  TextEditingController gmail = TextEditingController();
  TextEditingController phone = TextEditingController();
  ApiHelper apiHelper = ApiHelper();
  bool _isLoggingIn = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    gmail.dispose();
    phone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: "Register"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFieldWidgett(controller: name, hinText: "name"),
              SizedBox(
                height: 10,
              ),
              TextFieldWidgett(controller: gmail, hinText: "gmail"),
              SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: phone,
              ),
              SizedBox(
                height: 10,
              ),
              OutlinedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoggingIn = true;
                    });
                    if (name.text.isNotEmpty &&
                        gmail.text.isNotEmpty &&
                        phone.text.isNotEmpty) {
                      await apiHelper.signUp(
                          phone.text, gmail.text, name.text, context);
                      setState(() {
                        _isLoggingIn = false;
                      });
                    } else {
                      LoaderWidget.warningSnackBar(
                          title: "Hi,*", message: "Requried all field");
                    }
                  },
                  child: _isLoggingIn
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text("Get OTP"))
            ],
          ),
        ),
      ),
    );
  }
}
