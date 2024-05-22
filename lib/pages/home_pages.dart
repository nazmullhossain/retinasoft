import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retinasoft/varriables/color_variable.dart';
import 'package:retinasoft/widget/app_bar_widget.dart';

import '../widget/drawer_widget.dart';
import '../widget/gridview_widget.dart';
import '../widget/slider_widget.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: "Home",),


      body: _bodyUi(context),

    );
  }
 Widget _bodyUi(BuildContext context)=>SingleChildScrollView(
   child: Column(
     children: [
       Container(
         decoration: BoxDecoration(
           color: AllColor.primaryColor
         ),
         child: Column(
           children: [
             Text("Hey, Zofan...",
               style: GoogleFonts.lato(
                 textStyle: Theme.of(context).textTheme.displayLarge,
                 fontSize: 25,
                 color: Colors.white,
                 fontWeight: FontWeight.w700,
                 fontStyle: FontStyle.italic,
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(30.0),
               child: SliderScreen(),
             ),
           ],
         ),
       ),
    
       GirdViewWiget(),
     ],
   ),
 );
}
