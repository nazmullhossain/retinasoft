import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:retinasoft/conroller/public_controller.dart';
import 'package:retinasoft/model/login_model.dart';
import 'package:retinasoft/pages/home_pages.dart';
import 'package:retinasoft/pages/login_pages.dart';
import 'package:retinasoft/widget/navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/business_type_model.dart';
import '../model/get_branch_model.dart';
import '../pages/otp_pages.dart';
import '../pages/signup_otp_pages.dart';
import '../varriables/varriable.dart';
import 'package:http/http.dart' as http;
import '../widget/loader_widget.dart';

class ApiHelper {
  //***********signup******************************************
  Future<void> signUp(
      String phone, String email, String name, BuildContext context) async {
    final url = Uri.parse('${Variables.baseUrl}sign-up/store');

    var request = http.MultipartRequest('POST', url)
      ..fields['phone'] = phone
      ..fields['email'] = email
      ..fields['name'] = name
      ..fields['business_name'] = 'Test Account'
      ..fields['business_type_id'] = '7';

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
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

//***********SignUp Otp******************************************
  Future<void> signupVerifyOtpCode(
      String id, String otpCode, BuildContext context) async {
    var url = Uri.parse('${Variables.baseUrl}sign-up/verify-otp-code');
    var request = http.MultipartRequest('POST', url)
      ..fields['identifier_id'] = id
      ..fields['otp_code'] = otpCode;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        if (jsonResponse["status"] == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
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

//***********LoginOTP******************************************
  Future<void> sendOtp(BuildContext context, String phoneNuber) async {
    try {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}send-login-otp'),
        body: {'identifier': phoneNuber},
      );
      print("otppppp ${response.body}");
      LoaderWidget.warningSnackBar(title: "", message: "${response.body}");
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["status"] == 200) {
          LoaderWidget.warningSnackBar(
              title: "sent opt successfully", message: "");
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => OtpPages()));
        }
      } else {
        LoaderWidget.warningSnackBar(
            title: "sent opt unsuccessfully", message: "${response.body}");
      }
    } catch (e) {
      LoaderWidget.warningSnackBar(title: "Failed", message: e.toString());
    }
  }

//***********Login******************************************

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

        String branchId =
            "${PublicController.pc.loginModel.value.user!.branchId}";
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        sharedPreferences.setString("branch", branchId);
        print("sharre token $token");
        print('Login successful');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => NavigationWidget()));
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

//***********Fetch Business type data******************************************
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

//***********Fetch Branch******************************************
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

//***********Create Branch******************************************
  Future<void> createBranch(String branchName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";
    try {
      final response = await http.post(
        Uri.parse(Variables.baseUrl + 'admin/branch/create'),
        headers: {
          'Authorization': 'Bearer $token',
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

//***********UpdateBranch******************************************
  Future<void> updateBranch(String updateBranchName, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";
    final response = await http.post(
      Uri.parse("${Variables.baseUrl}admin/branch/$id/update"),
      headers: {
        'Authorization': 'Bearer $token',
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String branch = prefs.getString("branch") ?? "";
    String token = prefs.getString("token") ?? "";
    final url = Uri.parse(Variables.baseUrl + 'admin/branch/$id/delete');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Branch deleted successfully');
    } else {
      print('Failed to delete branch. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

//***********Create Customer******************************************
  createCustomer(String name, String phone, String mail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String branch = await prefs.getString("branch") ?? "";
    String token = await prefs.getString("token") ?? "";
    print("brachhhhhhhhhhhhhhhh $branch");
    var url = Uri.parse(
        'https://skill-test.retinasoft.com.bd/api/v1/admin/$branch/customer/create');
    var headers = {
      'Authorization': 'Bearer $token',
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String branch = prefs.getString("branch") ?? "";
    String token = prefs.getString("token") ?? "";
    final url = Uri.parse(
        'https://skill-test.retinasoft.com.bd/api/v1/admin/$branch/customer/$id/delete');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Request was successful.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

//***********UpdateCustomer******************************************
  updateCustomer(String name, String number, String gmail, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String branch = prefs.getString("branch") ?? "";
    String token = prefs.getString("token") ?? "";
    var url = Uri.parse(
        'https://skill-test.retinasoft.com.bd/api/v1/admin/$branch/customer/$id/update');
    var headers = {'Authorization': 'Bearer $token'};

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

//***********Logout******************************************
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    print("lognout $token");
    try {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}logout'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(".....>>>>>>${jsonResponse["status"]}");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPages()));
        await prefs.remove('token');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logged out successfully')),
        );
      } else {
        // Error logging out
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to log out')),
        );
      }
    } catch (e) {
      LoaderWidget.warningSnackBar(title: e.toString(), message: "failed");
    }
  }

//***********Delete account******************************************
  Future<void> deleteAccount(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    final url = Uri.parse(
        'https://skill-test.retinasoft.com.bd/api/v1/admin/account-delete');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print("delete ${response.body}");
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        LoaderWidget.warningSnackBar(
            title: "Account deleted successfully", message: "");
        prefs.remove("token");
        prefs.remove("branch");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPages()));
      }
      print('Account deleted successfully ${response.body}');
    } else {
      // Failed to delete the account
      print(
          'Failed to delete the account. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
//***********update account account******************************************
  Future<void> updateProfile(BuildContext context, String name,int id) async {
    try {
      const url = '${Variables.baseUrl}admin/profile/update';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'name': name,
          'business_type_id': "6",
        },
      );
        print("update=>>>>>>>>>>>>${response.body}");
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["status"] == 200) {
          LoaderWidget.warningSnackBar(
              title: "", message: "Profile updated successfully");
        }
      } else {
        LoaderWidget.warningSnackBar(
            title: "Failed to update profile", message: "");
      }
    } catch (e) {
      LoaderWidget.warningSnackBar(title: "", message: e.toString());
    }
  }
}
