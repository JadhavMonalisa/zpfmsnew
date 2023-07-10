import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import 'package:zpfmsnew/theme/app_colors.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class UploadedPhotoScreen extends StatefulWidget {
  const UploadedPhotoScreen({Key? key}) : super(key: key);

  @override
  State<UploadedPhotoScreen> createState() => _UploadedPhotoScreenState();
}

class _UploadedPhotoScreenState extends State<UploadedPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async {  return await cont.navigateFromPhotoUploadedList();},
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                color: const Color.fromARGB(246, 214, 105, 17),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_sharp),
              ),
              title: cont.language == "English"
                  ? const Text(
                "Uploaded photos",
                style: TextStyle(
                    color: Color.fromARGB(246, 214, 105, 17),
                    fontWeight: FontWeight.bold),
              )
                  : const Text(
                "फोटो अपलोड केलेले",
                style: TextStyle(
                    color: Color.fromARGB(246, 214, 105, 17),
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              // actions: [],
            ),
            body: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 1.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    cont.uploadedPhotoList.isEmpty ? const Opacity(opacity: 0.0):
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.only(left:5.0,right: 5.0,top: 10.0,),
                          child:RichText(
                            text: TextSpan(
                              text: "Photos For Work Order Number: ",
                              style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16.0),
                              children: <TextSpan>[
                                TextSpan(
                                    text: cont.workOrderNumberToShow.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 16.0)),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          )
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Radio(
                              activeColor: Colors.red,
                              value: 0,
                              groupValue: cont.radioValueOnPhotoList,
                              onChanged: (val){cont.radioChangeAndCallApi(val!,"Before");}),
                        ),

                        cont.language == "English"
                            ? buildTextBoldWidget("Before", Colors.black, context, 16.0,fontWeight: FontWeight.normal)
                            : buildTextBoldWidget("आधी", Colors.black, context, 16.0,fontWeight: FontWeight.normal),
                        Flexible(
                          child: Radio<int>(
                              activeColor: Colors.red,
                              value: 1,
                              groupValue: cont.radioValueOnPhotoList,
                              onChanged: (val){cont.radioChangeAndCallApi(val!,"After");}),
                        ),
                        cont.language == "English"
                            ? buildTextBoldWidget("After", Colors.black, context, 16.0,fontWeight: FontWeight.normal)
                            : buildTextBoldWidget("नंतर", Colors.black, context, 16.0,fontWeight: FontWeight.normal),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    // ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: cont.testViewPhotoList.length,
                    //     itemBuilder:(context,ind){
                    //   return Container(
                    //   height: 100.0,
                    //   width: 100.0,
                    //   decoration: BoxDecoration(border: Border.all(color: Colors.black),),
                    //   child: cont.testViewPhotoList[ind] == null || cont.testViewPhotoList.isEmpty?
                    //   Center(child:buildTextBoldWidget("Can't\nupload", Colors.black, context, 10.0,align: TextAlign.center)):
                    //   Image.memory(cont.testViewPhotoList[ind], fit: BoxFit.fill,
                    //   errorBuilder: (BuildContext context, Object object, StackTrace? stack){
                    //   return Padding(padding: const EdgeInsets.only(top: 30.0),
                    //   child: buildTextBoldWidget("No Image Found", Colors.black, context, 10.0,align: TextAlign.center));
                    //   },)
                    //   );
                    // }),
                    cont.isLoading ? Center(child: buildCircularIndicator(),) :
                    Padding(
                        padding: const EdgeInsets.only(left:10.0,right:10.0,bottom: 10.0),
                        child:
                        cont.uploadedPhotoList.isEmpty
                            ? buildTextBoldWidget("Record Not Found", blackColor, context, 14,align: TextAlign.center) :
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: cont.uploadedPhotoList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left:5.0,right:5.0,bottom: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.transparent,),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        cont.language == "English"
                                            ? Text("Uploaded Date : ${cont.uploadedPhotoList[index].createdDate!}", style: const TextStyle(fontWeight: FontWeight.bold),)
                                            : Text("अपलोड केलेली तारीख : ${cont.uploadedPhotoList[index].createdDate!}",style: const TextStyle(fontWeight: FontWeight.bold),),
                                        const Divider(thickness: 2.0,),
                                        SizedBox(
                                          //height: 120,
                                          width: double.infinity,
                                          child:ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: cont.imgList.length,
                                              itemBuilder: (context,imgIndex){
                                                return
                                                  cont.uploadedPhotoList[index].createdDate == cont.imgList[imgIndex].createdDate ?
                                                  Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: (){
                                                              cont.imgList[imgIndex].img == null
                                                                  ?  ScaffoldMessenger.of(context).showSnackBar(
                                                                const SnackBar(content: Text('Can\'t view image!')),
                                                              )
                                                                  : cont.navigateToViewImage(cont.imgList[imgIndex].img!);
                                                            },
                                                            child: Container(
                                                                height: 100.0,
                                                                width: 100.0,
                                                                decoration: BoxDecoration(border: Border.all(color: Colors.black),),
                                                                child: cont.imgList[imgIndex].img == null ?
                                                                Center(child:buildTextBoldWidget("Can't\nupload", Colors.black, context, 10.0,align: TextAlign.center)):
                                                                Image.memory(cont.imgList[imgIndex].img!, fit: BoxFit.fill,
                                                                  errorBuilder: (BuildContext context, Object object, StackTrace? stack){
                                                                    return Padding(padding: const EdgeInsets.only(top: 30.0),
                                                                        child: buildTextBoldWidget("No Image Found", Colors.black, context, 10.0,align: TextAlign.center));
                                                                  },)
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10.0),
                                                          Flexible(
                                                            child: Table(
                                                              columnWidths: const {
                                                                0: FlexColumnWidth(5),
                                                                1: FlexColumnWidth(5),
                                                              },
                                                              children: [
                                                                buildTableRowForPhoto(context,"Photo Taken : ","${cont.imgList[imgIndex].mode}",fontSize:14.0,fontColor:blackColor),
                                                                buildTableRowForPhoto(context,"Latitude : ","${cont.imgList[imgIndex].latitude}",fontSize:14.0,fontColor:blackColor),
                                                                buildTableRowForPhoto(context,"Longitude : ","${cont.imgList[imgIndex].longitude}",fontSize:14.0,fontColor:blackColor),
                                                                buildTableRowForPhoto(context,"Address : ","${cont.imgList[imgIndex].location}",fontSize:14.0,fontColor:blackColor),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                  )
                                                      : const Opacity(opacity: 0.0,);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                    ),
                  ],
                ),
              )
            )
        ),
      );
    });
  }
}
