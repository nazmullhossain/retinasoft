import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:retinasoft/conroller/api_helper.dart';
import 'package:retinasoft/widget/app_bar_widget.dart';

import '../conroller/public_controller.dart';

class OtpPages extends StatefulWidget {
  const OtpPages({super.key});

  @override
  State<OtpPages> createState() => _OtpPagesState();
}

class _OtpPagesState extends State<OtpPages> {
  OtpFieldController otpController = OtpFieldController();
  ApiHelper apiHelper=ApiHelper();

  PublicController controller = Get.find<PublicController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: 'Phone Number OTP',),
      body: GetBuilder<PublicController>(
        builder: (pc) {
          return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    OTPTextField(
                       controller: otpController,
                       length: 6,
                       width: MediaQuery.of(context).size.width,
                       textFieldAlignment: MainAxisAlignment.spaceAround,
                       fieldWidth: 45,
                       fieldStyle: FieldStyle.box,
                       outlineBorderRadius: 15,
                       style: TextStyle(fontSize: 17),
                       onChanged: (pin) {
                         print("Changed: " + pin);
                       },
                       onCompleted: (pin) {
                         apiHelper.login(context,pin, controller.textEditingController.value.text);
                         print("Completed: " + pin);
                       }),
                    SizedBox(height: 15,),
                    Text("OTP will be: 123456",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
              );
        }
      )


    );

  }
}
