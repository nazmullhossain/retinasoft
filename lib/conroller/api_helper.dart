import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:retinasoft/conroller/public_controller.dart';
import 'package:retinasoft/model/login_model.dart';
import 'package:retinasoft/pages/home_pages.dart';
import 'package:retinasoft/pages/login_pages.dart';
import 'package:retinasoft/pages/otp_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/business_type_model.dart';
import '../model/customer_model.dart';
import '../model/get_branch_model.dart';
import '../pages/signup_otp_pages.dart';
import '../varriables/varriable.dart';
import 'package:http/http.dart' as http;

import '../widget/loader_widget.dart';

class ApiHelper {
  Future<void> signUp(
      String phone, String email, String name, BuildContext context) async {
    final url =
        Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/sign-up/store');

    var request = http.MultipartRequest('POST', url)
      ..fields['phone'] = phone
      ..fields['email'] = email
      ..fields['name'] = name
      ..fields['business_name'] = 'Test Account'
      ..fields['business_type_id'] = '7';

    try {
      SharedPreferences prefs=await SharedPreferences.getInstance();
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var decodedResponse = jsonDecode(responseData);
        print(decodedResponse);
        if (decodedResponse['status'] == 200) {
      PublicController.pc.i = decodedResponse['identifier_id'];
        // await  prefs.setInt("id", "${PublicController.pc.id}" as int);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SignupOtpPages()));
        } else {
          print('Response: ${decodedResponse['status']}');
          LoaderWidget.warningSnackBar(title: "", message: "${responseData}");
        }
      } else {
        print('Sign Up failed with status: ${response.statusCode}');
        var responseData = await response.stream.bytesToString();
        print('Response: $responseData');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> signupVerifyOtpCode(String id,String otpCode, BuildContext context) async {
    var url = Uri.parse(
        'https://skill-test.retinasoft.com.bd/api/v1/sign-up/verify-otp-code');

    var request = http.MultipartRequest('POST', url)
      ..fields['identifier_id'] = id
      ..fields['otp_code'] = otpCode;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        if (jsonResponse["status"] == 200) {
          SharedPreferences prefs=await SharedPreferences.getInstance();
          // prefs.remove("id");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LoginPages()));
        }
        print('Response data: $jsonResponse');
      } else {
        print('Failed to verify OTP. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }






  Future<void> sendOtp(BuildContext context, String phoneNuber) async {
    // if (_formKey.currentState!.validate()) {
    //   setState(() {
    //     _isLoading = true;
    //   });

    final response = await http.post(
      Uri.parse(Variables.baseUrl + 'send-login-otp'),
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

  Future<void> login(BuildContext context, String otp, String num) async {
    var response = await http.post(
      Uri.parse(Variables.baseUrl + 'login'),
      body: {
        'otp_code': otp,
        'identifier': num,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      PublicController.pc.loginModel.value =
          LoginModel.fromJson(jsonDecode(response.body));
      if (PublicController.pc.loginModel.value.status == 200) {
        print("model ${PublicController.pc.loginModel.value.user!.apiToken}");
        String token = "${PublicController.pc.loginModel.value.user!.apiToken}";
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        print("sharre token $token");
        print('Login successful');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePages()));
        LoaderWidget.warningSnackBar(
            title: "Hi,*", message: "Login successful");
      } else {
        LoaderWidget.warningSnackBar(title: "Hi,*", message: "wrong otp");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPages()));
      }

      // You can parse response.body here
    } else {
      // Handle error response
      print('Login failed');
    }
  }

  //businness type
  Future<List<BusinessTypes>> getBusinessType(BuildContext context) async {
    List<BusinessTypes> businesTypeData = [];

    try {
      http.Response res = await http.get(
        Uri.parse(Variables.baseUrl + "get-business-types"),
      );
      print("company data${res.body.length}");

      if (res.statusCode == 200) {
        var jsonRes = jsonDecode(res.body);
        print(jsonRes);

        BusinessTypeModel businessTypeModel =
            BusinessTypeModel.fromJson(jsonRes);

        for (BusinessTypes data in businessTypeModel.businessTypes!) {
          businesTypeData.add(data);
        }
      } else {}
    } catch (e) {
      print(e.toString());
    }
    return businesTypeData;
  }

//branch
  Future<List<Branches2>> getBranch() async {
    List<Branches2> brachch2 = [];

    try {
      http.Response res = await http.get(
        Uri.parse(Variables.baseUrl + "admin/branches"),
        headers: {
          'Authorization': 'Bearer ${PublicController.pc.token}',
        },
      );
      print("company data${res.body.length}");

      if (res.statusCode == 200) {
        var jsonRes = jsonDecode(res.body);
        print(jsonRes);

        GetBrachModel getBrachModel = GetBrachModel.fromJson(jsonRes);

        for (Branches2 data in getBrachModel.branches!.branches2!) {
          brachch2.add(data);
        }
      } else {}
    } catch (e) {
      print(e.toString());
    }
    return brachch2;
  }

  //Branch Create
  Future<void> createBranch(String branchName) async {
    try {
      final response = await http.post(
        Uri.parse(Variables.baseUrl + 'admin/branch/create'),
        headers: {
          'Authorization': 'Bearer ${PublicController.pc.token}',
        },
        body: {
          'name': branchName,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful response
        LoaderWidget.warningSnackBar(
            title: "", message: "Branch Created successful");
      } else {
        // Handle error response
        LoaderWidget.warningSnackBar(
            title: "Hi,*", message: "Branch Created unsuccessful");
      }
    } catch (e) {
      LoaderWidget.warningSnackBar(title: "", message: e.toString());
    }
  }

  Future<void> updateBranch(String updateBranchName, int id) async {
    final response = await http.post(
      Uri.parse(Variables.baseUrl + "admin/branch/$id/update"),
      headers: {
        'Authorization': 'Bearer ${PublicController.pc.token}',
      },
      body: {
        'name': updateBranchName,
      },
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Branch updated successfully');
    } else {
      // Handle error
      print('Failed to update branch: ${response.statusCode}');
    }
  }

  Future<void> deleteBranch(int id) async {
    final url = Uri.parse(Variables.baseUrl + 'admin/branch/$id/delete');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer ${PublicController.pc.token}',
      },
    );

    if (response.statusCode == 200) {
      print('Branch deleted successfully');
    } else {
      print('Failed to delete branch. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  createCustomer(String name, String phone, String mail) async {
    var url = Uri.parse(
        'https://skill-test.retinasoft.com.bd/api/v1/admin/167/customer/create');
    var headers = {
      'Authorization': 'Bearer buTY1716277709L5UD75',
    };
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['name'] = name
      ..fields['phone'] = phone
      ..fields['email'] = mail
      ..fields['type'] = '0';

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Customer created successfully');
      var responseBody = await response.stream.bytesToString();
      print(responseBody);
    } else {
      print('Failed to create customer');
      print('Status code: ${response.statusCode}');
      var responseBody = await response.stream.bytesToString();
      print(responseBody);
    }
  }

  Future<void> customerDelete(int id) async {
    final url = Uri.parse(
        'https://skill-test.retinasoft.com.bd/api/v1/admin/167/customer/$id/delete');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer ${PublicController.pc.token}',
      },
    );

    if (response.statusCode == 200) {
      print('Request was successful.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  updateCustomer(String name, String number, String gmail, int id) async {
    var url = Uri.parse(
        'https://skill-test.retinasoft.com.bd/api/v1/admin/167/customer/$id/update');
    var headers = {'Authorization': 'Bearer ${PublicController.pc.token}'};

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['name'] = name
      ..fields['phone'] = number
      ..fields['email'] = gmail
      ..fields['type'] = '0';

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await http.Response.fromStream(response);
      var responseData = jsonDecode(responseBody.body);
      print('Success: $responseData');
    } else {
      print('Failed with status code: ${response.statusCode}');
    }
  }

  Future<void> logout(BuildContext context) async {
    final response = await http.post(
      Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/logout'),
      headers: {
        'Authorization': 'Bearer ${PublicController.pc.token}',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse=jsonDecode(response.body);
      print(".....>>>>>>${jsonResponse["status"]}");
      // Successful logout
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPages()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged out successfully')),
      );
    } else {
      // Error logging out
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out')),
      );
    }
  }
}
