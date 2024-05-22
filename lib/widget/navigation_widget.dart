import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retinasoft/varriables/color_variable.dart';
import 'package:retinasoft/varriables/varriable.dart';

import '../pages/home_pages.dart';



class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int index = 1;
  // final darkController = Get.put(ThemeController());
  final items = <Widget>[
    Icon(
      Icons.book,
      size: 30,
    ),
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.reviews,
      size: 30,
    ),
  ];
  final sceren = [
   Center(child: Text("1"),),

    // AddNewPage(),
    HomePages(),
    Center(child: Text("3"),),
    // AddNewPage()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.grey,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              // backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.white)),
            child: CurvedNavigationBar(
              color: AllColor.primaryColor,

              backgroundColor: Colors.transparent,
              height: 60,
              items: items,
              index: index,
              onTap: (index) => setState(() {
                this.index = index;
              }),
            ),
          ),
          body: sceren[index]),
    );
  }
}