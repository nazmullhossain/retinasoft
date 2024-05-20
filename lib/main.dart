import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:retinasoft/conroller/public_controller.dart';
import 'package:retinasoft/pages/home_pages.dart';
import 'package:retinasoft/pages/login_pages.dart';
import 'package:retinasoft/widget/navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final PublicController publicController = Get.put(PublicController());
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token="";

  getToken()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    token=await prefs.getString("token")??"";
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:token.isNotEmpty? NavigationWidget():LoginPages(),
    );
  }
}