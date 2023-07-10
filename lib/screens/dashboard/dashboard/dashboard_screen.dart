import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/routes/app_pages.dart';
import 'package:zpfmsnew/screens/common/nav_drawer.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GlobalKey<ScaffoldState> dashboardSKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont){
      return WillPopScope(
        onWillPop: () async{
          return await warningDialog();
        },
        child: Scaffold(
          key: dashboardSKey,
          drawer: const NavDrawer(),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              color: const Color.fromARGB(246, 214, 105, 17),
              onPressed: () {
                dashboardSKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
            title: cont.language == "English"
                ? const Text(
              "Contractor Dashboard",
              style: TextStyle(
                  color: Color.fromARGB(246, 214, 105, 17),
                  fontWeight: FontWeight.bold),
            )
                : const Text(
              "कंत्राटदार डॅशबोर्ड",
              style: TextStyle(
                  color: Color.fromARGB(246, 214, 105, 17),
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            // actions: [],
          ),
          body:
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 1.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: cont.isLoading ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildCircularIndicator()
                ],
              ) :

              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  cont.contractorList.isEmpty ? const Opacity(opacity: 0.0):
                  buildTextBoldWidget("WELCOME ${cont.partyName}", Colors.black, context, 14.0,align: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.workOrder);
                            },
                            child: Container(
                              // width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height/4.9,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/4.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: const DecorationImage(
                                  image: AssetImage("assets/card.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    cont.language == "English"
                                        ? const Text(
                                      "Work Order",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(246, 214, 105, 17),
                                      ),
                                    )
                                        : const Text(
                                      "वर्क ऑर्डर",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(246, 214, 105, 17),
                                      ),
                                    ),
                                    const SizedBox(height: 10.0,),

                                    Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(5),
                                        1: FlexColumnWidth(4.5),
                                      },
                                      children: [
                                        cont.language == "English"
                                            ? buildTableRowForCount(context,"Total WO:", "${cont.contractorList.length}")
                                            : buildTableRowForCount(context, "एकूण वर्क ऑर्डर:", "${cont.contractorList.length}"),

                                        cont.language == "English"
                                            ? buildTableRowForCount(context,"Amount:", cont.amount.toString())
                                            : buildTableRowForCount(context,"रक्कम:", cont.amount.toString()),

                                        buildTableRowForCount(context,"", ""),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                            Get.toNamed(AppRoutes.paymentShortDataScreen);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/4.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: const DecorationImage(
                                  image: AssetImage("assets/card.png",),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    cont.language == "English"
                                        ? const Text(
                                      "Payment",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(246, 214, 105, 17),
                                      ),
                                    )
                                        : const Text(
                                      "पेमेंट",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(246, 214, 105, 17),
                                      ),
                                    ),
                                    const SizedBox(height: 10.0,),

                                    Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(5),
                                        1: FlexColumnWidth(4.5),
                                      },
                                      children: [
                                        cont.language == "English"
                                            ? buildTableRowForCount(context,"Billed Amt:",
                                            cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalBilledAmount.toString())
                                            :buildTableRowForCount(context, "बिल केलेली रक्कम:",
                                            cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalBilledAmount.toString()),

                                        cont.language == "English"
                                            ? buildTableRowForCount(context,"Paid Amt:",
                                            cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalPaidAmount.toString())
                                            : buildTableRowForCount(context,"देय रक्कम:",
                                            cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalPaidAmount.toString()),

                                        cont.language == "English"
                                            ? buildTableRowForCount(context,"Intransit Amt:",
                                            cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalPendingAmount.toString())
                                            : buildTableRowForCount(context,"अंतर्गमन रक्कम:",
                                            cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalPendingAmount.toString())
                                      ],
                                    ),
                                    // cont.language == "English"
                                    //     ? buildCountWidget(context,"Billed Amt:", cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalBilledAmount.toString())
                                    //     : buildCountWidget(context,"बिल केलेली रक्कम:", cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalBilledAmount.toString()),
                                  //: buildRichTextForCountWidget("बिल केलेली रक्कम:", cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalBilledAmount.toString(),

                                    // cont.language == "English"
                                    // ? buildCountWidget(context,"Paid Amt:", cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalPaidAmount.toString())
                                    // : buildCountWidget(context,"देय रक्कम:", cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalPaidAmount.toString()),

                          // cont.language == "English"
                          //     ? buildCountWidget(context,"Intransit Amt:", cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalPendingAmount.toString())
                          //     : buildCountWidget(context,"अंतर्गमन रक्कम:", cont.paymentList.isEmpty ? "0.0": cont.paymentList[0].totalPendingAmount.toString())
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.enterDataFromTrackBill);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/4.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: const DecorationImage(
                                  image: AssetImage("assets/card.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: cont.language == "English"
                                    ? const Text(
                                  "Track\nBill",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(246, 214, 105, 17),
                                  ),
                                  textAlign: TextAlign.center,
                                )
                                    : const Text(
                                  "ट्रॅक बिल",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(246, 214, 105, 17),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.enterDataScreenFromPhotoUpload);
                            },
                            child: Container(
                              // width: 150,
                              // height: 160,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/4.5,
                              // height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: const DecorationImage(
                                  image: AssetImage("assets/card.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: cont.language == "English"
                                    ? const Text(
                                  "Photo\nUpload",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(246, 214, 105, 17),
                                  ),
                                  textAlign: TextAlign.center,
                                )
                                    : const Text(
                                  "फोटो\nअपलोड ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(246, 214, 105, 17),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 2,
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 2.0,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            //setState(() {
                             // currentPos = index;
                           // });
                          },
                        ),
                        itemBuilder: (context, ind, realIdx) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              height: 250.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: NetworkImage("http://api.demofms.com/api/Image/GetBannerImage"),
                                    fit: BoxFit.fill,
                                  )
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                            ),
                          );},
                      ),
                    ],),
                  const Spacer(),
                  Center(
                      child:buildTextBoldWidget(cont.version??"",
                          Colors.black, context, 14.0,align: TextAlign.center)
                  )
                ],
              ),
            ),
          ),
        ));
    });
  }

  warningDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit"),
        content: const Text("Do you want to exit from an app?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () async {
              exit(0);
            },
            child: const Text("Yes"),
          )
        ],
      ),
    );
  }
}
