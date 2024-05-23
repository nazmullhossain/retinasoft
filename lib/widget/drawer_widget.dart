
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:retinasoft/conroller/public_controller.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../pages/profile_pages.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {


  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'images/profile.jpg',
                          ),
                          fit: BoxFit.contain,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Retina soft',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(
                            0xff48043F,
                          ),
                          textBaseline: TextBaseline.alphabetic,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
          ),
          PublicController.pc.token.isNotEmpty
              ? ListTile(

            dense: true,
            leading: Icon(Icons.person, size: 30,),
            title: Text('Profile', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePages(),
                  ));
            },
          )
              : Container(),

          ListTile(
              dense: true,
              leading: Icon(Icons.login, size: 30),
              title: Text('Sign In', style: TextStyle(fontSize: 20,),
              )
          )
        ],
      ),
    );
  }
}
