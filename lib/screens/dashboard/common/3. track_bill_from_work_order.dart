import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/screens/common/nav_drawer.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class TrackBillFromWorkOrder extends StatefulWidget {
  const TrackBillFromWorkOrder({Key? key}) : super(key: key);

  @override
  State<TrackBillFromWorkOrder> createState() => _TrackBillFromWorkOrderState();
}

class _TrackBillFromWorkOrderState extends State<TrackBillFromWorkOrder> {
  GlobalKey<ScaffoldState> woSKey3 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont){
      return Scaffold(
        key: woSKey3,
        drawer: const NavDrawer(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            color: const Color.fromARGB(246, 214, 105, 17),
            onPressed: () {
              woSKey3.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: cont.language == "English"
              ? const Text(
            "Track Bill Result",
            style: TextStyle(
                color: Color.fromARGB(246, 214, 105, 17),
                fontWeight: FontWeight.bold),
          )
              : const Text(
            "ट्रॅक बिल तपशील",
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
            child: ListView(
              children: [
                cont.isLoading ? buildCircularIndicator() :
                SingleChildScrollView(
                  child:
                  cont.isLoading ? Center(child:buildCircularIndicator()):
                  Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0),
                      child:
                      cont.trackBillFromWorkOrderList.isEmpty ? buildNoDataFound(context) :
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cont.trackBillFromWorkOrderList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              final item = cont.trackBillFromWorkOrderList[index];
                              return GestureDetector(
                                onTap: (){

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
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
                                              0: FlexColumnWidth(4),
                                              1: FlexColumnWidth(1),
                                              2: FlexColumnWidth(5),
                                            },
                                            children: [
                                              cont.language == "English"
                                              ? buildTableRow(context, "Bill Date", "${item.billDate}")
                                              : buildTableRow(context, "बिल तारीख", "${item.billDate}"),
                                              buildSpaceTableRow(),
                                            ],
                                          ),
                                          Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(4),
                                              1: FlexColumnWidth(1),
                                              2: FlexColumnWidth(5),
                                            },
                                            children: [
                                              cont.language == "English"
                                              ? TableRow(
                                                  children: [
                                                    buildTextBoldWidget("Bill No.", Colors.black, context, 15.0,align: TextAlign.left),
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
                                              0: FlexColumnWidth(4),
                                              1: FlexColumnWidth(1),
                                              2: FlexColumnWidth(5),
                                            },
                                            children: [
                                              buildTableRow(context, "Bill Amount", "${item.billAmount}"),
                                              buildSpaceTableRow(),
                                              buildTableRow(context, "Contractor Name", "${item.partyName}"),
                                              buildSpaceTableRow(),
                                              buildTableRow(context, "District", "${item.districtName}"),
                                              buildSpaceTableRow(),
                                              buildTableRow(context, "UTR No.", "${item.utrno}"),
                                              buildSpaceTableRow(),
                                            ],
                                          )
                                          : Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(4),
                                              1: FlexColumnWidth(1),
                                              2: FlexColumnWidth(5),
                                            },
                                            children: [
                                              buildTableRow(context, "बिलाची रक्कम", "${item.billAmount}"),
                                              buildSpaceTableRow(),
                                              buildTableRow(context, "कंत्राटदाराचे नाव", "${item.partyName}"),
                                              buildSpaceTableRow(),
                                              buildTableRow(context, "जिल्हा", "${item.districtName}"),
                                              buildSpaceTableRow(),
                                              buildTableRow(context, "यूटीआर क्र.", "${item.utrno}"),
                                              buildSpaceTableRow(),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              );
                            }),
                      )
                  ),
                ),
              ],
            )),
      );
    });
  }
}
