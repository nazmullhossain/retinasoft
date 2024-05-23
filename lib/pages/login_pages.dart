import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retinasoft/pages/register_pages.dart';
import 'package:retinasoft/varriables/config.dart';

import '../conroller/api_helper.dart';
import '../conroller/public_controller.dart';
import '../varriables/color_variable.dart';
import '../varriables/varriable.dart';
import '../widget/app_bar_widget.dart';
import '../widget/input_decration_widget.dart';
import '../widget/loader_widget.dart';
import '../widget/validation_widget.dart';
import 'otp_pages.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final controller = Get.put(PublicController());
  ApiHelper apiHelper = ApiHelper();

  bool _isLoggingIn = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.textEditingController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login",style: Variables.style(context,20)),
        centerTitle: true,
        backgroundColor: AllColor.primaryColor,
      ),
      body: GetBuilder<PublicController>(builder: (pc) {
        if (controller.size.value <= 0.0) controller.initApp(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: dSize(.01),
                ),
                TextFieldWidget(
                  controller: controller.textEditingController.value,
                ),
                SizedBox(
                  height: dSize(.01),
                ),
                OutlinedButton(
                    onPressed: () async {
                      if (controller
                          .textEditingController.value.text.isNotEmpty) {
                        setState(() {
                          _isLoggingIn = true;
                        });
                        await Future.delayed(
                            Duration(seconds: 3)); // Simulate a 3-second delay
                        await apiHelper.sendOtp(context,
                            controller.textEditingController.value.text.trim());


                        setState(() {
                          _isLoggingIn = false;
                        });
                      } else {
                        LoaderWidget.warningSnackBar(
                            title: "Required*",
                            message: "Please enter all field");
                      }
                    },
                    child: _isLoggingIn
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text("Get OTP")),
                SizedBox(
                  height: dSize(0.02),
                ),
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RegisterPages()));
                    },
                    child: Text("Create an Account"))
              ],
            ),
          ),
        );
      }),
    );
  }
}
