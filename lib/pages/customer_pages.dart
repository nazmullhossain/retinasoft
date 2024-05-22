import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:retinasoft/conroller/api_helper.dart';
import 'package:retinasoft/conroller/public_controller.dart';
import 'package:retinasoft/varriables/color_variable.dart';
import 'package:retinasoft/varriables/config.dart';
import 'package:retinasoft/varriables/varriable.dart';
import 'package:retinasoft/widget/app_bar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:retinasoft/widget/input_decration_widget.dart';
import '../model/customer_model.dart';
import '../widget/text_field_widget.dart';

class CustomerPages extends StatefulWidget {
  const CustomerPages({super.key});

  @override
  State<CustomerPages> createState() => _CustomerPagesState();
}

class _CustomerPagesState extends State<CustomerPages> {
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController gmail=TextEditingController();
  //edit
  TextEditingController ename=TextEditingController();
  TextEditingController egmail=TextEditingController();
  TextEditingController ephn=TextEditingController();
  final controller = Get.put(PublicController());
  ApiHelper apiHelper=ApiHelper();
  StreamController<CustomerModel> _streamController = StreamController();
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
    PublicController.pc.getToken();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getCustomerData();
    });
  }

  Future<void> getCustomerData() async {
    try {
      final url = Variables.baseUrl + 'admin/269/0/customers';
      final resonse = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer 9psN17163668459q5o118',
        },
      );
      if (resonse.statusCode == 200) {
        print(resonse.body);
        final data = jsonDecode(resonse.body);
        CustomerModel customers2 = CustomerModel.fromJson(data);
        if (!_streamController.isClosed) {
          _streamController.sink.add(customers2);
        }

        print("c${customers2.customers!.customers2}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.size.value <= 0.0) controller.initApp(context);
    return Scaffold(
      appBar: AppBarWidget(
        titleName: "customer",
      ),
      body: StreamBuilder<CustomerModel>(
          stream: _streamController.stream,
          builder: (context, snap) {
              if(snap.connectionState==ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snap.data!.customers!.customers2!.isEmpty){
                return Center(child: Text("No data"),);
              }

              return CustomerData(snap);


          }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        addEm();
      },child: Icon(Icons.add),),
    );
  }

  Widget CustomerData(snap) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView.builder(
          itemCount: snap.data!.customers!.customers2!.length,
          itemBuilder: (context, index) {
            final cus = snap.data!.customers!.customers2![index];

            return InkWell(
              onTap: (){

              },
              child: Container(
                height: dSize(0.40),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AllColor.hintColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${cus.id}"),
                      Text("${cus.name}"),
                      Text("${cus.balance}"),
                      Text("${cus.phone}"),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(onPressed: () {
                          ename.text=cus.name;
                          ephn.text=cus.phone;
                        editEm(cus.id);



                        }, child: Icon(Icons.edit)),
                        SizedBox(
                          width: 2,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              apiHelper.customerDelete(cus.id);
                            }, child: Icon(Icons.delete)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future addEm() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Create Customer",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFieldWidgett(controller: name, hinText: "name"),
              TextFieldWidgett(controller: phone, hinText: "phone"),
              TextFieldWidgett(controller: gmail, hinText: "gmail"),
              OutlinedButton(
                  onPressed: () async {
                    if (name.text.isNotEmpty && phone.text.isNotEmpty && gmail.text.isNotEmpty) {
                     await apiHelper.createCustomer(name.text, phone.text, gmail.text);
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
              TextFieldWidgett(controller: ename, hinText: "name"),
              SizedBox(height: 1,),
              TextFieldWidgett(controller: egmail, hinText: "gmail"),
              SizedBox(height: 1,),
              TextFieldWidgett(controller: ephn, hinText: "phone"),
              SizedBox(height: 1,),
              OutlinedButton(
                  onPressed: () async {
                    if(ename.text.isNotEmpty && egmail.text.isNotEmpty && ephn.text.isNotEmpty){
                      apiHelper.updateCustomer(ename.text, egmail.text, ephn.text,id);
                      Navigator.pop(context);
                    }else{
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
