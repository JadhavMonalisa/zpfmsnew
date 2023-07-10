import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/screens/common/nav_drawer.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class TrackBillList extends StatefulWidget {
  const TrackBillList({Key? key}) : super(key: key);

  @override
  State<TrackBillList> createState() => _TrackBillListState();
}

class _TrackBillListState extends State<TrackBillList> {

  GlobalKey<ScaffoldState> billFromTrackKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont){
      return WillPopScope(
          onWillPop: () async {return await cont.navigateToEnterTrackBill();},
      child: Scaffold(
        key: billFromTrackKey,
        drawer: const NavDrawer(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            color: const Color.fromARGB(246, 214, 105, 17),
            onPressed: () {
              billFromTrackKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: cont.language == "English"
              ? const Text(
            "Bill Details",
            style: TextStyle(
                color: Color.fromARGB(246, 214, 105, 17),
                fontWeight: FontWeight.bold),
          )
              : const Text(
            "बिल तपशील",
            style: TextStyle(
                color: Color.fromARGB(246, 214, 105, 17),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
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
            child: cont.isLoading ? buildCircularIndicator() :
            cont.isLoading ? Center(child:buildCircularIndicator()):
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0),
                  child:
                  cont.trackBillDetailsList.isEmpty ? buildNoDataFound(context) :
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: cont.language == "English"
                            ? buildRichTextWidget("Work Order Number: ", cont.trackBillDetailsList.isEmpty?"":cont.trackBillDetailsList[0].workOrderNo!)
                            : buildRichTextWidget("वर्क ऑर्डर क्र.: ",cont.trackBillDetailsList.isEmpty?"": cont.trackBillDetailsList[0].workOrderNo!)
                          )),
                      const SizedBox(height: 10,),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: cont.trackBillDetailsList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            final item = cont.trackBillDetailsList[index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
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
                                      Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(5),
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(4),
                                        },
                                        children: [
                                          cont.language == "English"
                                              ? buildTableRow(context, "Sr. No", "${index+1}")
                                              : buildTableRow(context, "अनु. क्र.", "${index+1}"),
                                          buildSpaceTableRow(),

                                          cont.language == "English"
                                              ? buildTableRow(context, "District", "${item.districtName}")
                                              : buildTableRow(context, "जिल्हा", "${item.districtName}"),
                                          buildSpaceTableRow(),
                                        ],
                                      ),
                                      Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(5),
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(4),
                                        },
                                        children: [
                                          cont.language == "English"
                                              ? TableRow(
                                              children: [
                                                buildTextBoldWidget("Bill Number", Colors.black, context, 15.0,align: TextAlign.left),
                                                buildTextBoldWidget(":", Colors.black, context, 15.0),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "${item.billID.toString()}  ",
                                                    style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 17.5),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: "Copy",
                                                        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo,fontSize: 16,
                                                            decoration: TextDecoration.underline),
                                                        recognizer: TapGestureRecognizer()..onTap = () {
                                                          setState(() {
                                                            cont.isLoading=true;
                                                            Clipboard.setData(ClipboardData(text:item.billID.toString()));
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text("Copied!")),
                                                            );
                                                            cont.isLoading=false;
                                                          });
                                                        },
                                                      ),

                                                    ],
                                                  ),
                                                )
                                              ]
                                          )
                                              : TableRow(
                                              children: [
                                                buildTextBoldWidget("बिल क्र.", Colors.black, context, 15.0,align: TextAlign.left),
                                                buildTextBoldWidget(":", Colors.black, context, 15.0),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "${item.billID.toString()}  ",
                                                    style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 17.5),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: "कॉपी करा",
                                                        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo,fontSize: 16,
                                                            decoration: TextDecoration.underline),
                                                        recognizer: TapGestureRecognizer()..onTap = () {
                                                          setState(() {
                                                            cont.isLoading=true;
                                                            Clipboard.setData(ClipboardData(text:item.billID.toString()));
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text("कॉपी केले!")),
                                                            );
                                                            cont.isLoading=false;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ]
                                          ),
                                          buildSpaceTableRow(),
                                        ],
                                      ),
                                      cont.language == "English"
                                          ? Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(5),
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(4),
                                        },
                                        children: [
                                          buildTableRow(context, "Bill Date", "${item.billDate}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "Bill Amount", "${item.billAmount}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "Net Amount", "${item.netAmount}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "Deduction Amount", "${item.deductionAmount}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "Cashbook Name", "${item.cashBookNameMarathi}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "Head Name", "${item.headNameMarathi}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "Work Order Number", "${item.workOrderNo}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "Work Order Name", "${item.workName}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "Approval Status", "${item.approvalStatus}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "Payment Status", "${item.paymentStatus}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "UTR No", "${item.utrno}"),
                                          buildSpaceTableRow(),
                                        ],
                                      )
                                          : Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(5),
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(4),
                                        },
                                        children: [
                                          buildTableRow(context, "बिल तारीख", "${item.billDate}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "बिलाची रक्कम", "${item.billAmount}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "निव्वळ रक्कम", "${item.netAmount}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "कपातीची रक्कम", "${item.deductionAmount}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "कॅशबुकचे नाव", "${item.cashBookNameMarathi}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "प्रमुखाचे नाव", "${item.headNameMarathi}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "वर्क ऑर्डर क्र.", "${item.workOrderNo}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "वर्क ऑर्डरचे नाव", "${item.workName}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "मंजुरीची स्थिती", "${item.approvalStatus}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "पैसे भरल्याची स्थिती", "${item.paymentStatus}"),
                                          buildSpaceTableRow(),
                                          buildTableRow(context, "यूटीआर क्र.", "${item.utrno}"),
                                          buildSpaceTableRow(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  )
              ),
            )),
      )
      );
    });
  }
}
