import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'color_variable.dart';

class Variables {
  //static const String baseUrl = 'http://tashfia.binduitsolutions.com/api/';
  static const String baseUrl = 'https://skill-test.retinasoft.com.bd/api/v1';

  // final Map<String, String> authHeader = {
  //   "Content-Type": "application/json",
  //   'Authorization': 'Bearer ${PublicController.pc.loginResponse.value.token}',
  // };

  static var statusBarTheme = SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark
      ));

  static var portraitMood = SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  static ThemeData themeData = ThemeData(
      primarySwatch: const MaterialColor(0xffE9118F, AllColor.primaryColorMap),
      scaffoldBackgroundColor: AllColor.appBgColor,
      canvasColor: Colors.transparent,
      fontFamily: 'openSans',
      textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: "openSans"),
          displayMedium: TextStyle(fontFamily: "openSans"),
          displaySmall: TextStyle(fontFamily: "openSans"),
          headlineMedium: TextStyle(fontFamily: "openSans"),
          headlineSmall: TextStyle(fontFamily: "openSans"),
          titleLarge: TextStyle(fontFamily: "openSans"),
          titleMedium: TextStyle(fontFamily: "openSans"),
          titleSmall: TextStyle(fontFamily: "openSans"),
          bodyLarge: TextStyle(fontFamily: "openSans"),
          bodyMedium: TextStyle(fontFamily: "openSans"),
          bodySmall: TextStyle(fontFamily: "openSans"),
          labelLarge: TextStyle(fontFamily: "openSans"),
          labelSmall: TextStyle(fontFamily: "openSans")
      )
  );

}

void showToast(message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black87,
    textColor: Colors.white,
    fontSize: 16.0
);

// DateTime today12Am(){
//   DateTime dt = DateTime.now();
//   return DateTime.parse("${dt.year}"
//       "-""${dt.month.toString().length==1?'0${dt.month}':dt.month}"
//       "-""${dt.day.toString().length==1?'0${dt.day}':dt.day}"
//       " 12:00:00");
// }
//
// DateTime today23Pm(){
//   DateTime dt = DateTime.now();
//   return DateTime.parse("${dt.year}"
//       "-""${dt.month.toString().length==1?'0${dt.month}':dt.month}"
//       "-""${dt.day.toString().length==1?'0${dt.day}':dt.day}"
//       " 23:59:59");
// }