import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:retinasoft/conroller/api_helper.dart';
import 'package:retinasoft/widget/app_bar_widget.dart';
import 'package:retinasoft/widget/text_field_widget.dart';

import '../conroller/public_controller.dart';
import '../varriables/color_variable.dart';
import '../varriables/varriable.dart';

class SignupOtpPages extends StatefulWidget {
  const SignupOtpPages({super.key});

  @override
  State<SignupOtpPages> createState() => _SignupOtpPagesState();
}

class _SignupOtpPagesState extends State<SignupOtpPages> {
  OtpFieldController otpController = OtpFieldController();
  ApiHelper apiHelper=ApiHelper();
  TextEditingController textEditingController=TextEditingController();

  PublicController controller = Get.find<PublicController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Phone number otp",style: Variables.style(context,20)),
          centerTitle: true,
          backgroundColor: AllColor.primaryColor,
        ),
        body: GetBuilder<PublicController>(
            builder: (pc) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [

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
                        onCompleted: (pin)async {
                        await  apiHelper.signupVerifyOtpCode("${PublicController.pc.i}", pin, context);
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
