import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/routes/app_pages.dart';
import 'package:zpfmsnew/screens/common/nav_drawer.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class BeforeAfterPhotoUpload extends StatefulWidget {
  const BeforeAfterPhotoUpload({Key? key}) : super(key: key);

  @override
  State<BeforeAfterPhotoUpload> createState() => _BeforeAfterPhotoUploadState();
}

class _BeforeAfterPhotoUploadState extends State<BeforeAfterPhotoUpload> {
  GlobalKey<ScaffoldState> beforeAfterSKey1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DashboardController>(builder: (cont){
    return WillPopScope(
        onWillPop: () async {  return await cont.navigateToBillFromPhotoUpload();},
      child:

      Scaffold(
      key: beforeAfterSKey1,
      drawer: const NavDrawer(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          color: const Color.fromARGB(246, 214, 105, 17),
          onPressed: () {
            beforeAfterSKey1.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: cont.language == "English"
            ? const Text(
          "Photo Upload",
          style: TextStyle(
              color: Color.fromARGB(246, 214, 105, 17),
              fontWeight: FontWeight.bold),
        )
            : const Text(
          "फोटो अपलोड",
          style: TextStyle(
              color: Color.fromARGB(246, 214, 105, 17),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // actions: [],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0,),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0,left:5.0),
                      child:
                      cont.language == "English"
                          ? buildRichTextWidget("Demand Number: ",  cont.demandNoToShow.toString(),
                          title1Size: 18.0,title2Size: 18.0)
                          : buildRichTextWidget("मागणी क्र.: ",  cont.demandNoToShow.toString(),
                          title1Size: 18.0,title2Size: 18.0)
                    )  ),
                const SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(6),
                    },
                    children: [
                      cont.language == "English"
                      ? buildTableRow(context, "LATITUDE", "${cont.currentPosition?.latitude ?? ""}")
                      : buildTableRow(context, "अक्षांश", "${cont.currentPosition?.latitude ?? ""}"),
                      buildSpaceTableRow(),

                      cont.language == "English"
                      ? buildTableRow(context, "LONGITUDE", "${cont.currentPosition?.longitude ?? ""}")
                      : buildTableRow(context, "रेखांश", "${cont.currentPosition?.longitude ?? ""}"),
                      buildSpaceTableRow(),

                      cont.language == "English"
                      ? buildTableRow(context, "ADDRESS", cont.currentAddress ?? "")
                      : buildTableRow(context, "पत्ता", cont.currentAddress ?? ""),
                      buildSpaceTableRow(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Flexible(
                    //   child: Radio(
                    //       activeColor: Colors.red,
                    //       value: 0,
                    //       groupValue: cont.radioValue,
                    //       onChanged: (val){cont.handleRadioValueChanged(val!);}),
                    // ),
                    //
                    // cont.language == "English"
                    // ? buildTextBoldWidget("Before", Colors.black, context, 16.0,fontWeight: FontWeight.normal)
                    // : buildTextBoldWidget("आधी", Colors.black, context, 16.0,fontWeight: FontWeight.normal),
                    Flexible(
                      child: Radio<int>(
                          activeColor: Colors.red,
                          value: 1,
                          groupValue: cont.radioValue,
                          onChanged: (val){cont.handleRadioValueChanged(val!);}),
                    ),
                    cont.language == "English"
                    ? buildTextBoldWidget("Physics Progress", Colors.black, context, 16.0,fontWeight: FontWeight.normal)
                    : buildTextBoldWidget("नंतर", Colors.black, context, 16.0,fontWeight: FontWeight.normal),
                  ],
                ),

                cont.isLoading ? Center(child:buildCircularIndicator())
                    :
                cont.isSelected == false
                    ? Container(
                  height: 250,
                  width: 250,
                  color: Colors.white,
                  child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.upload,
                          color: Colors.orange,
                          size: 40,
                        ),
                        onPressed: () {
                          cont.pickImageFromCamera();
                        },
                      )),
                )
                    : SizedBox(
                  height: 250,
                  width: 250,
                  child: Stack(
                    children: [
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          image: DecorationImage(
                              image: FileImage(cont.imageFile!),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  cont.isSelected = false;
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                cont.isLoading ? const Opacity(opacity: 0.0,):
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.green, backgroundColor: Colors.deepOrange,
                          minimumSize: const Size(90, 40),
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                          // setState(() {
                          //   if(cont.imageFile==null){
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(content: Text('Please add photo')),
                          //     );
                          //   }
                          //   else if(cont.radioValue==-1){
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(content: Text('Please select before or after')),
                          //     );
                          //   }
                          //   else{
                          //     cont.isLoading = true;
                          //     cont.callPhotoUpload(cont.selectedBillIdForUploadPhoto.toString());
                          //   }
                          // });
                          cont.validateUploadPhoto();
                        },
                        child: const Text(
                          'Save Photo',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    // Flexible(
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       foregroundColor: Colors.green, backgroundColor: Colors.orange,
                    //       minimumSize: const Size(90, 40),
                    //       padding: const EdgeInsets.symmetric(horizontal: 35),
                    //       shape: const RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(20)),
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //      Get.toNamed(AppRoutes.billDetailsFromPhotoUpload);
                    //     },
                    //     child: const Text(
                    //       'Back',
                    //       style: TextStyle(color: Colors.white, fontSize: 20),
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
    });
  }

}
