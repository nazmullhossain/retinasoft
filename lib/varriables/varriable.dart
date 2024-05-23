import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_variable.dart';

class Variables {
  //static const String baseUrl = 'http://tashfia.binduitsolutions.com/api/';
  static const String baseUrl = 'https://skill-test.retinasoft.com.bd/api/v1/';

 static TextStyle style(BuildContext context,double size){
    return GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: size,
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
    );
  }

  static List<MyListItem> items = [
    MyListItem(
      title: 'Common',
      color: Color(0xffFFF0F0),

      image: 'images/common.png',
    ),
    MyListItem(
      title: 'Branch',
      color: Color(0xffE3F3FF),
      image: 'images/banc.png',
    ),
    MyListItem(
      title: 'Customer',
      color: Color(0xffF0F5F9),
      image: 'images/customer.jpg',
    ),
    MyListItem(
      title: 'Profile',
      color: Color(0xffFFF2DF),
      image: 'images/pr.jpg',
    ),

  ];
}

class MyListItem {
  final String title;
  final String image;
  final Color color;


  MyListItem({required this.title, required this.image,required this.color});



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