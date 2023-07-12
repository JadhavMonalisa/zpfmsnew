import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/routes/app_pages.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class ViewPhotoScreen extends StatefulWidget {
  const ViewPhotoScreen({Key? key}) : super(key: key);

  @override
  State<ViewPhotoScreen> createState() => _ViewPhotoScreenState();
}

class _ViewPhotoScreenState extends State<ViewPhotoScreen> {
  var backScreenName = Get.arguments[0];
  var demandNo = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont){
    return WillPopScope(
        onWillPop: () async {return await Get.offNamed(AppRoutes.uploadedPhotoScreen,arguments: [backScreenName,demandNo]);},
      child:SafeArea(
        child:Scaffold(
        body:SizedBox(
        height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
      padding: const EdgeInsets.all(10.0),
      // child: Image.memory(cont.viewSelectedImage!,
      // fit: BoxFit.fill,
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      // errorBuilder: (BuildContext context,
      // Object object, StackTrace? stack){
      // return Center(
      // child: buildTextBoldWidget("No Image Found", Colors.black, context, 16.0,align: TextAlign.center));
      // },
      // ),
        child:Image.network(cont.viewSelectedImage!,fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          errorBuilder: (BuildContext context,
          Object object, StackTrace? stack){
          return Center(
          child: buildTextBoldWidget("No Image Found", Colors.black, context, 16.0,align: TextAlign.center));
          },
          ),
        )
      ),
      )
      )
      );
    });
  }
}
