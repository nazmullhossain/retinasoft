

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoaderWidget{
  static sucessSnackBar({required title,message='',duration=3}){
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.green,
        backgroundColor: Colors.black,
        duration: Duration(seconds: duration),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.subdirectory_arrow_left)

    );
  }
  static warningSnackBar({required title,message=''}){
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor:Color(0xff48043F),
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.subdirectory_arrow_left)

    );
  }
}