import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:retinasoft/conroller/public_controller.dart';
import 'package:retinasoft/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../varriables/varriable.dart';
import 'package:http/http.dart' as http;

import '../widget/loader_widget.dart';

class ApiHelper {
  Future<void> sendOtp(BuildContext context, String phoneNuber) async {
    // if (_formKey.currentState!.validate()) {
    //   setState(() {
    //     _isLoading = true;
    //   });

    final response = await http.post(
      Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/send-login-otp'),
      body: {'identifier': phoneNuber},
    );
    print("otppppp ${response.body}");

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send OTP. Please try again.')),
      );
    }
  }

  //login

  Future<void> login(String otp, String num) async {
    var response = await http.post(
      Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/login'),
      body: {
        'otp_code': otp,
        'identifier': num,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      PublicController.pc.loginModel.value =
          LoginModel.fromJson(jsonDecode(response.body));
      print("model ${PublicController.pc.loginModel.value.user!.apiToken}");
      String token = "${PublicController.pc.loginModel.value.user!.apiToken}";
     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString("token", token);
      print("sharre token $token");

      print('Login successful');
      LoaderWidget.warningSnackBar(title: "Hi,*", message: "Login successful");

      // You can parse response.body here
    } else {
      // Handle error response
      print('Login failed');
    }
  }
}
