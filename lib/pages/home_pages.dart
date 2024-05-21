import 'package:flutter/material.dart';
import 'package:retinasoft/widget/app_bar_widget.dart';

import '../widget/gridview_widget.dart';
import '../widget/slider_widget.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: "Home",),

      body: _bodyUi(),

    );
  }
 Widget _bodyUi()=>Column(
   children: [
    SliderScreen(),
     GirdViewWiget(),
   ],
 );
}
