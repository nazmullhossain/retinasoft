import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:retinasoft/conroller/api_helper.dart';
import 'package:retinasoft/widget/app_bar_widget.dart';

import '../conroller/public_controller.dart';
import '../model/business_type_model.dart';
import '../varriables/config.dart';

class BusinessTypePages extends StatefulWidget {
  const BusinessTypePages({super.key});

  @override
  State<BusinessTypePages> createState() => _BusinessTypePagesState();
}

class _BusinessTypePagesState extends State<BusinessTypePages> {
  List<BusinessTypes>? getBusinessType;
  ApiHelper apiHelper=ApiHelper();

  Future<List<BusinessTypes>> getBusinessData()async{
    getBusinessType=await apiHelper.getBusinessType(context);
    return getBusinessType!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBusinessData();

  }




  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (pc) {
        return Scaffold(
          appBar: AppBarWidget(titleName: 'Business type',),

          body: FutureBuilder<List<BusinessTypes>>(
              future: getBusinessData(),
              builder: (context,snap){
                if(snap.hasData){
                  return SizedBox(
                    height: MediaQuery.of(context).size.height*0.9,
                    child: ListView.builder(
                        itemCount: getBusinessType!.length,
                        itemBuilder: (context,index){
                        final  data=getBusinessType![index];
                      return ListTile(
                        tileColor: Colors.red,
                        contentPadding: EdgeInsets.all(10),

                        leading:Text("${data.id}"),
                        title: Text("${data.name}"),
                        subtitle: Text("${data.slug}"),
                      );
                    }),
                  );
                }
                else if(snap.hasError){
                  return Center(child: Text("${snap.error}"),);
                }
                return Center(child: CircularProgressIndicator(),);
              })

        );
      }
    );
  }

}
