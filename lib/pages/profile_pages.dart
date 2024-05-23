import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retinasoft/conroller/api_helper.dart';
import 'package:retinasoft/model/profile_model.dart';
import 'package:retinasoft/varriables/color_variable.dart';
import 'package:retinasoft/widget/app_bar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../conroller/public_controller.dart';
import '../varriables/varriable.dart';
import '../widget/text_field_widget.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  StreamController<ProfileModel> _streamController = StreamController();
  ApiHelper apiHelper = ApiHelper();
  Timer? timer;
  TextEditingController nameController=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
    timer!.cancel();
  }

  String token = "";
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString("token") ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getCustomerData();
    });
  }

  Future<void> getCustomerData() async {
    try {
      final url = Variables.baseUrl + 'admin/profile';
      final resonse = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (resonse.statusCode == 200) {
        print(resonse.body);
        final data = jsonDecode(resonse.body);
        ProfileModel customers2 = ProfileModel.fromJson(data);
        if (!_streamController.isClosed) {
          _streamController.sink.add(customers2);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBarWidget(
        titleName: "Profile",

      ),
      body: StreamBuilder<ProfileModel>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("something wrong"));
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        color: AllColor.primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset(
                              "images/profile.jpg",
                              height: 120,
                              width: 120,
                            )),
                        Text("Name:  ${snapshot.data!.responseUser!.name!}",
                            style: Variables.style(context, 20)),
                        Text(
                            "Branch id:  ${snapshot.data!.responseUser!.branchId!}",
                            style: Variables.style(context, 20)),
                      ],
                    ),
                  ),
                  Text("Branch :  ${snapshot.data!.responseUser!.branch!}",
                      style: Variables.style(context, 20)),
                  SizedBox(
                    height: 3,
                  ),
                  Text("phone :  ${snapshot.data!.responseUser!.phone!}",
                      style: Variables.style(context, 20)),
                  Text("email :  ${snapshot.data!.responseUser!.email!}",
                      style: Variables.style(context, 20)),
                  Text(
                      "businessType :  ${snapshot.data!.responseUser!.businessType!}",
                      style: Variables.style(context, 20)),
                  Text(
                      "businessType :  ${snapshot.data!.responseUser!.businessType!}",
                      style: Variables.style(context, 20)),
                  Text(
                      "companyId :  ${snapshot.data!.responseUser!.companyId!}",
                      style: Variables.style(context, 20)),
                  Text(
                      "businessName :  ${snapshot.data!.responseUser!.businessName!}",
                      style: Variables.style(context, 20)),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            apiHelper.deleteAccount(context);
                          },
                          child: Text(
                            'Delete Account',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            backgroundColor: AllColor.primaryColor,
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final id=snapshot.data!.responseUser!.id;
                            nameController.text=snapshot.data!.responseUser!.name!;
                            editEm(id!);
                          },
                          child: Text(
                            'Edit Account',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            backgroundColor: AllColor.primaryColor,
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
  Future editEm(int id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          child: Column(
            children: [
              TextFieldWidgett(controller: nameController, hinText: "name"),

              OutlinedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty) {
                   apiHelper.updateProfile(context, nameController.text, id);
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please complete all field",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Text("Update"))
            ],
          ),
        ),
      ));
}
