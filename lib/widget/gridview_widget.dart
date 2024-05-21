import 'package:flutter/material.dart';
import 'package:retinasoft/pages/business_type_pages.dart';
import 'package:retinasoft/varriables/varriable.dart';

import '../pages/branch_pages.dart';
import '../pages/customer_pages.dart';

class GirdViewWiget extends StatelessWidget {
  const GirdViewWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 350,
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount:
          Variables.items.length,
          scrollDirection: Axis.vertical,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              // crossAxisSpacing: 10,
              // mainAxisSpacing: 10,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusinessTypePages()));
                }
                if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BranchPages()));
                }
                if (index == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CustomerPages()));
                }


              },

              // navigateToSearchScreen(context,
              //     GlobalVarriable.categoryImages[index]["title"] as MyListItem)
              // >navigateToCategoryPage(context, GlobalVariables.categoryImages[index]['title']!),

              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        Variables.items[index].image,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      Variables.items[index].title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            );
          }),
    );

  }
}
