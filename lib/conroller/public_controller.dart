import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_model.dart';
import 'api_helper.dart';

class PublicController extends GetxController {
  ApiHelper apiHelper = ApiHelper();
  static PublicController pc = Get.find();
 late  SharedPreferences pref;
  RxDouble size = 0.0.obs;
  Rx<LoginModel> loginModel = LoginModel().obs;
  final hidePassword = true.obs;
  var textEditingController = TextEditingController().obs;
  RxString token="".obs;




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
}
