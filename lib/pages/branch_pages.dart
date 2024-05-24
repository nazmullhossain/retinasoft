import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:retinasoft/conroller/api_helper.dart';
import 'package:retinasoft/varriables/color_variable.dart';
import 'package:retinasoft/widget/app_bar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../conroller/public_controller.dart';

import '../model/business_type_model.dart';
import '../model/get_branch_model.dart';
import '../varriables/config.dart';
import '../varriables/varriable.dart';

class BranchPages extends StatefulWidget {
  const BranchPages({super.key});

  @override
  State<BranchPages> createState() => _BranchPagesState();
}

class _BranchPagesState extends State<BranchPages> {
  ApiHelper apiHelper = ApiHelper();
  TextEditingController _branchController = TextEditingController();
  TextEditingController _upbranchController = TextEditingController();
  final controller = Get.put(PublicController());
  List<Branches2>? getBusinessType;

  getBusinessData() async {
    getBusinessType = await apiHelper.getBranch();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBusinessData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(builder: (pc) {
      if (controller.size.value <= 0.0) controller.initApp(context);
      return Scaffold(
        appBar: AppBarWidget(
          titleName: 'Business type',
        ),
        body: getBusinessType == null
            ? Center(
                child: Text("no data"),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: ListView.builder(
                    itemCount: getBusinessType!.length,
                    itemBuilder: (context, index) {
                      final data = getBusinessType![index];
                      return Container(
                        height: dSize(0.4),
                        // padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AllColor.secondaryColor,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          title: Text("${data.name}"),
                          subtitle: Text("${data.id}"),
                          trailing: Container(
                            width: 180,
                            child: Row(
                              children: [
                                OutlinedButton(
                                    onPressed: ()async {
                                      await apiHelper.deleteBranch(data.id!);
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>BranchPages()));
                                    },
                                    child: Text("Delete")),
                                OutlinedButton(
                                    onPressed: () {
                                      _upbranchController.text = data.name!;
                                      editEm(data.id!);
                                    },
                                    child: Text("Edit")),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addEm();
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }

  Future addEm() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "Add Branch",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextField(
                    controller: _branchController,
                    decoration: InputDecoration(
                        hintText: "Branch name",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  OutlinedButton(
                      onPressed: () async {
                        if (_branchController.text.isNotEmpty) {
                          apiHelper.createBranch(_branchController.text);
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
                        await apiHelper.getBranch();
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>BranchPages()));
                      },
                      child: Text("Create Branch"))
                ],
              ),
            ),
          ));

  Future editEm(int id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: Column(
                children: [
                  TextField(
                    controller: _upbranchController,
                    decoration: InputDecoration(
                        hintText: "Update Branch name",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  OutlinedButton(
                      onPressed: () async {
                        await apiHelper.updateBranch(
                            _upbranchController.text, id);
                        // await apiHelper.getBranch();

                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => BranchPages()));

                      },
                      child: Text("Update"))
                ],
              ),
            ),
          ));
}
