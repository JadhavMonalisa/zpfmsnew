import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/screens/common/nav_drawer.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import 'package:zpfmsnew/theme/app_colors.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final GlobalKey<ScaffoldState> profileKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont){
    return Scaffold(
      key: profileKey,
      drawer: const NavDrawer(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          color: const Color.fromARGB(246, 214, 105, 17),
          onPressed: () {
            profileKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: cont.language == "English"
            ? const Text(
                "Contractor Profile",
                style: TextStyle(
                    color: Color.fromARGB(246, 214, 105, 17),
                    fontWeight: FontWeight.bold),
              )
            : const Text(
                "कंत्राटदार माहिती",
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
        child:
        cont.isLoading ? buildCircularIndicator() :
        SingleChildScrollView(
          child: Form(
            key: cont.formKey,
            child:
            cont.contractorList.isEmpty ? buildNoDataFound(context) :
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                  padding: const EdgeInsets.only(left:16.0,top: 10.0),
                  child: buildTextBoldWidget("Contractor Name", Colors.black, context, 15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,bottom: 16.0,top: 10.0),
                    // child: TextFormField(
                    //   controller: cont.firstNameController,
                    //   keyboardType: TextInputType.text,
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //     isDense: true,
                    //     filled: true,
                    //     border: InputBorder.none,
                    //     labelText: cont.contractorList[0].partyName,
                    //     labelStyle: const TextStyle(color: Colors.black),
                    //     // disabledBorder: const OutlineInputBorder(
                    //     //   borderRadius: BorderRadius.all(Radius.circular(4)),
                    //     //   borderSide: BorderSide(width: 1,color: Colors.black),
                    //     // ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter First Name';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    child:buildTextRegularWidget(cont.contractorList[0].partyName!, blackColor, context, 14.0)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,top: 5.0),
                    child: buildTextBoldWidget("Contractor Mobile No", Colors.black, context, 15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,bottom: 16.0,top: 10.0),
                    // child: TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   enabled: false,
                    //   controller: cont.mobileNoController,
                    //   decoration: InputDecoration(
                    //     isDense: true,
                    //     filled: true,
                    //     border: InputBorder.none,
                    //     labelText: cont.contractorList[0].mobile,
                    //     labelStyle: const TextStyle(color: Colors.black),
                    //     // disabledBorder: const OutlineInputBorder(
                    //     //   borderRadius: BorderRadius.all(Radius.circular(4)),
                    //     //   borderSide: BorderSide(width: 1,color: Colors.black),
                    //     // ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter Mobile No';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    child:buildTextRegularWidget(cont.contractorList[0].mobile!, blackColor, context, 14.0)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,top: 5.0),
                    child: buildTextBoldWidget("Bank Name", Colors.black, context, 15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,bottom: 16.0,top: 10.0),
                    // child: TextFormField(
                    //   controller: cont.mobileNoController,
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //     isDense: true,
                    //     filled: true,
                    //     border: InputBorder.none,
                    //     labelText: cont.contractorList[0].bankName,
                    //     labelStyle: const TextStyle(color: Colors.black),
                    //     // disabledBorder: const OutlineInputBorder(
                    //     //   borderRadius: BorderRadius.all(Radius.circular(4)),
                    //     //   borderSide: BorderSide(width: 1,color: Colors.black),
                    //     // ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter Mobile No';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    child:  buildTextRegularWidget(cont.contractorList[0].bankName!, blackColor, context, 14.0)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,top: 5.0),
                    child: buildTextBoldWidget("MICR Code", Colors.black, context, 15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,bottom: 16.0,top: 10.0),
                    // child: TextFormField(
                    //   controller: cont.mobileNoController,
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //     isDense: true,
                    //     filled: true,
                    //     border:InputBorder.none,
                    //     labelText: cont.contractorList[0].micrCode,
                    //     labelStyle: const TextStyle(color: Colors.black),
                    //     // disabledBorder: const OutlineInputBorder(
                    //     //   borderRadius: BorderRadius.all(Radius.circular(4)),
                    //     //   borderSide: BorderSide(width: 1,color: Colors.black),
                    //     // ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter Mobile No';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    child:buildTextRegularWidget(cont.contractorList[0].micrCode!, blackColor, context, 14.0)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,top: 5.0),
                    child: buildTextBoldWidget("IFSC Code", Colors.black, context, 15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,bottom: 16.0,top: 10.0),
                    // child: TextFormField(
                    //   controller: cont.mobileNoController,
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //     isDense: true,
                    //     filled: true,
                    //     border: InputBorder.none,
                    //     labelText: cont.contractorList[0].ifsCCode,
                    //     labelStyle: const TextStyle(color: Colors.black),
                    //     // disabledBorder: const OutlineInputBorder(
                    //     //   borderRadius: BorderRadius.all(Radius.circular(4)),
                    //     //   borderSide: BorderSide(width: 1,color: Colors.black),
                    //     // ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter Mobile No';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    child:buildTextRegularWidget(cont.contractorList[0].ifsCCode!, blackColor, context, 14.0)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,top: 5.0),
                    child: buildTextBoldWidget("Account Number", Colors.black, context, 15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,bottom: 16.0,top: 10.0),
                    // child: TextFormField(
                    //   controller: cont.mobileNoController,
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //     isDense: true,
                    //     filled: true,
                    //     border: InputBorder.none,
                    //     labelText: cont.contractorList[0].bankAccountNumber,
                    //     labelStyle: const TextStyle(color: Colors.black),
                    //     // disabledBorder: const OutlineInputBorder(
                    //     //   borderRadius: BorderRadius.all(Radius.circular(4)),
                    //     //   borderSide: BorderSide(width: 1,color: Colors.black),
                    //     // ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter Mobile No';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    child:buildTextRegularWidget(cont.contractorList[0].bankAccountNumber!, blackColor, context, 14.0)
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.orange,
                  //     ),
                  //     child: SizedBox(
                  //       width: 150,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: const [
                  //           Icon(
                  //             Icons.cloud_upload_outlined,
                  //             color: Colors.white,
                  //           ),
                  //           SizedBox(
                  //             width: 5,
                  //           ),
                  //           Text(
                  //             'Update Profile',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    });
  }
}
