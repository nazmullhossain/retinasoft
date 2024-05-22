import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:retinasoft/conroller/api_helper.dart';
import 'package:retinasoft/model/profile_model.dart';
import 'package:retinasoft/widget/app_bar_widget.dart';
import 'package:http/http.dart' as http;
import '../conroller/public_controller.dart';
import '../varriables/varriable.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  StreamController<ProfileModel> _streamController = StreamController();
  ApiHelper apiHelper = ApiHelper();
  Timer? timer;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
    timer!.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          'Authorization': 'Bearer ${PublicController.pc.token}',
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
      appBar: AppBarWidget(
        titleName: "Profile",
        onTap: () {
          apiHelper.logout(context);
        },
      ),
      body: StreamBuilder<ProfileModel>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset(
                          "images/profile.jpg",
                          height: 80,
                          width: 80,
                        )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
// StreamBuilder<ProfileModel>(stream: _streamController.stream,
// builder: (context,snap){
//
// if(snap.hasData){
// return Container(
// width: double.infinity,
// padding: EdgeInsets.all(20),
// decoration: BoxDecoration(
// color: Colors.grey,
// borderRadius: BorderRadius.circular(10),
//
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text("Id=>${  snap.data!.responseUser!.id}"),
// Text("Name=>${  snap.data!.responseUser!.name}"),
// Text("Gmail=>${  snap.data!.responseUser!.email}"),
// Text("Phone=>${  snap.data!.responseUser!.phone}"),
// Text("Image=>${  snap.data!.responseUser!.imageFullPath}"),
// Text("Business Name=>${  snap.data!.responseUser!.businessName}"),
// Text("BusinessType=>${  snap.data!.responseUser!.businessType}"),
// Text("${  snap.data!.responseUser!.businessTypeId}"),
// Text("businessTypeId=>${  snap.data!.responseUser!.branch}"),
// Text("companyId=>${  snap.data!.responseUser!.companyId}"),
// Text("branchId=>${  snap.data!.responseUser!.branchId}"),
// ],
// ),
// );
// }return Center(child: CircularProgressIndicator(),);
// })
