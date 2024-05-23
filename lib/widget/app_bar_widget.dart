import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retinasoft/conroller/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../varriables/color_variable.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({super.key, required this.titleName});
  final String titleName;


  @override
  Widget build(BuildContext context) {
    ApiHelper apiHelper=ApiHelper();
    return AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // automaticallyImplyLeading: false,
        backgroundColor: AllColor.primaryColor,
        centerTitle: true,
        title: Text(
          titleName,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          OutlinedButton(

              onPressed: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await apiHelper.logout(context);
                prefs.remove("token");
                prefs.remove("branch");
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
