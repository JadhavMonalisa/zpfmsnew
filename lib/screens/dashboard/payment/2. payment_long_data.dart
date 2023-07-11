import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/routes/app_pages.dart';
import 'package:zpfmsnew/screens/common/nav_drawer.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class PaymentLongDataScreen extends StatefulWidget {
  const PaymentLongDataScreen({Key? key}) : super(key: key);

  @override
  State<PaymentLongDataScreen> createState() => _PaymentLongDataScreenState();
}

class _PaymentLongDataScreenState extends State<PaymentLongDataScreen> {
  GlobalKey<ScaffoldState> pSKey2 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont){
      return WillPopScope(
          onWillPop: () async {return await Get.toNamed(AppRoutes.paymentShortDataScreen);},
      child:Scaffold(
        key: pSKey2,
        drawer: const NavDrawer(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            color: const Color.fromARGB(246, 214, 105, 17),
            onPressed: () {
              pSKey2.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: cont.language == "English"
              ? const Text(
            "All Bill Details",
            style: TextStyle(
                color: Color.fromARGB(246, 214, 105, 17),
                fontWeight: FontWeight.bold),
          )
              : const Text( "सर्व बिल तपशील",
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
                SingleChildScrollView(
                    child:
                    cont.isLoading ? buildCircularIndicator():
                    cont.paymentTypeList.isEmpty ? buildNoDataFound(context) :
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0,top: 20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cont.paymentTypeList.length,
                            itemBuilder: (context,index){
                              cont.demandNoToShow =cont.paymentTypeList.isEmpty?"":cont.paymentTypeList[index].demandNo!;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.transparent,),
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(5),
                                              1: FlexColumnWidth(1),
                                              2: FlexColumnWidth(4),
                                            },
                                            children: [
                                              cont.language == "English"
                                                  ? buildTableRow(context, "Sr. No.", "${index+1}")
                                                  : buildTableRow(context, "अनु. क्र.", "${index+1}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "District", "${cont.paymentTypeList[index].districtName}")
                                                  : buildTableRow(context, "जिल्हा", "${cont.paymentTypeList[index].districtName}"),
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
                                                    buildTextBoldWidget("Demand Number", Colors.black, context, 15.0,align: TextAlign.left),
                                                    buildTextBoldWidget(":", Colors.black, context, 15.0),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: "${cont.paymentTypeList[index].demandNo.toString()}  ",
                                                        style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 17.5),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: "Copy",
                                                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo,fontSize: 16,
                                                                decoration: TextDecoration.underline),
                                                            recognizer: TapGestureRecognizer()..onTap = () {
                                                              setState(() {
                                                                cont.isLoading=true;
                                                                Clipboard.setData(ClipboardData(text:cont.paymentTypeList[index].demandNo.toString()));
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
                                                    buildTextBoldWidget("मागणी क्र.", Colors.black, context, 15.0,align: TextAlign.left),
                                                    buildTextBoldWidget(":", Colors.black, context, 15.0),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: "${cont.paymentTypeList[index].demandNo.toString()}  ",
                                                        style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 17.5),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: "कॉपी करा",
                                                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo,fontSize: 16,
                                                                decoration: TextDecoration.underline),
                                                            recognizer: TapGestureRecognizer()..onTap = () {
                                                              setState(() {
                                                                cont.isLoading=true;
                                                                Clipboard.setData(ClipboardData(text:cont.paymentTypeList[index].demandNo.toString()));
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
                                          Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(5),
                                              1: FlexColumnWidth(1),
                                              2: FlexColumnWidth(4),
                                            },
                                            children: [
                                              cont.language == "English"
                                                  ? buildTableRow(context, "Bill Date", "${cont.paymentTypeList[index].billDate}")
                                                  : buildTableRow(context, "बिल तारीख", "${cont.paymentTypeList[index].billDate}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "Bill Amount", "${cont.paymentTypeList[index].billAmount}")
                                                  : buildTableRow(context, "बिलाची रक्कम", "${cont.paymentTypeList[index].billAmount}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "Net Amount", "${cont.paymentTypeList[index].netAmount}")
                                                  : buildTableRow(context, "निव्वळ रक्कम", "${cont.paymentTypeList[index].netAmount}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "Deduction Amount", "${cont.paymentTypeList[index].deductionAmount}")
                                                  : buildTableRow(context, "कपातीची रक्कम", "${cont.paymentTypeList[index].deductionAmount}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "Cashbook Name", "${cont.paymentTypeList[index].cashBookNameMarathi}")
                                                  : buildTableRow(context, "कॅशबुकचे नाव", "${cont.paymentTypeList[index].cashBookNameMarathi}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "Head Name", "${cont.paymentTypeList[index].headNameMarathi}")
                                                  : buildTableRow(context, "प्रमुखाचे नाव", "${cont.paymentTypeList[index].headNameMarathi}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "Work Order No.", "${cont.paymentTypeList[index].workOrderNo}")
                                                  : buildTableRow(context, "वर्क ऑर्डर क्र.", "${cont.paymentTypeList[index].workOrderNo}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "Work Order Name", "${cont.paymentTypeList[index].workName}")
                                                  : buildTableRow(context, "वर्क ऑर्डरचे नाव", "${cont.paymentTypeList[index].workName}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "Approval Status", "${cont.paymentTypeList[index].approvalStatus}")
                                                  : buildTableRow(context, "मंजुरीची स्थिती", "${cont.paymentTypeList[index].approvalStatus}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "Payment Status", "${cont.paymentTypeList[index].paymentStatus}")
                                                  : buildTableRow(context, "पैसे भरल्याची स्थिती", "${cont.paymentTypeList[index].paymentStatus}"),
                                              buildSpaceTableRow(),

                                              cont.language == "English"
                                                  ? buildTableRow(context, "UTR No.", "${cont.paymentTypeList[index].utrno}")
                                                  : buildTableRow(context, "यूटीआर क्र.", "${cont.paymentTypeList[index].utrno}"),
                                              buildSpaceTableRow(),
                                            ],
                                          ),
                                          GestureDetector(
                                              onTap: (){
                                                cont.navigateToUploadedPhotos(int.parse(cont.paymentTypeList[index].billID!),
                                                    cont.paymentTypeList[index].workOrderNo!,AppRoutes.paymentLongDataScreen);
                                              },
                                              child: Table(
                                                columnWidths: const {
                                                  0: FlexColumnWidth(5),
                                                  1: FlexColumnWidth(1),
                                                  2: FlexColumnWidth(4),
                                                },
                                                children: [
                                                  TableRow(
                                                      children: [
                                                        cont.language == "English"
                                                            ? buildTextBoldWidget("Previous Photos", Colors.black, context, 15.0)
                                                            : buildTextBoldWidget("मागील फोटो", Colors.black, context, 15.0),
                                                        buildTextBoldWidget(":", Colors.black, context, 15.0),
                                                        Transform(
                                                          transform: Matrix4.translationValues(-60.0, 0.0, 0.0),
                                                          child:const Icon(Icons.photo),
                                                        ),
                                                      ]
                                                  )
                                                ],
                                              )
                                          ),
                                          Align(
                                            alignment:Alignment.topRight,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.green, backgroundColor: Colors.yellow.shade400,
                                                minimumSize: Size(MediaQuery.of(context).size.width, 25),
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                                ),
                                              ),
                                              onPressed: () {
                                                cont.goToUploadPhotoScreen(int.parse(cont.paymentTypeList[index].billID!),AppRoutes.paymentLongDataScreen);
                                              },
                                              child:
                                              cont.language == "English"
                                                  ? const Text(
                                                'Upload Photo',
                                                style: TextStyle(color: Colors.black, fontSize: 15),
                                              )
                                                  : const Text(
                                                'फोटो अपलोड करा',
                                                style: TextStyle(color: Colors.black, fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                ),
              ],
            )),
      )
      );
    });
  }
}
