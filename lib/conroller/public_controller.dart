import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:retinasoft/model/business_type_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/customer_model.dart';
import '../model/login_model.dart';
import 'api_helper.dart';

class PublicController extends GetxController {
  ApiHelper apiHelper = ApiHelper();
  static PublicController pc = Get.find();
  late SharedPreferences pref;
  RxDouble size = 0.0.obs;
  Rx<LoginModel> loginModel = LoginModel().obs;
  Rx<BusinessTypeModel> businessTypeModel = BusinessTypeModel().obs;
  final hidePassword = true.obs;
  var textEditingController = TextEditingController().obs;
  var idController = TextEditingController().obs;
  int i=0 ;
  String token = "";
  int id=0;


  @override
  void onInit() {
    super.onInit();

    getToken();
  }

  Future<void> initApp(BuildContext context) async {
    // pref = await SharedPreferences.getInstance();
    if (MediaQuery.of(context).size.width <= 500) {
      size.value = MediaQuery.of(context).size.width;
    } else {
      size(MediaQuery.of(context).size.height);
    }
    update();
    if (kDebugMode) {
      print('Initialized\n Size: ${size.value}');
    }
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString("token") ?? "";
    // id=await prefs.getInt("id")??0;

    print(token);
    update();
  }
}
