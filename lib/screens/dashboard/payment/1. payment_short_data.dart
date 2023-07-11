import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/routes/app_pages.dart';
import 'package:zpfmsnew/screens/common/nav_drawer.dart';

import '../dashboard/dashboard_controller.dart';

class PaymentShortDataScreen extends StatefulWidget {
  const PaymentShortDataScreen({Key? key}) : super(key: key);

  @override
  State<PaymentShortDataScreen> createState() => _PaymentShortDataScreenState();
}

class _PaymentShortDataScreenState extends State<PaymentShortDataScreen> {
  GlobalKey<ScaffoldState> pSKey1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont){
      return WillPopScope(
          onWillPop: () async {return await Get.toNamed(AppRoutes.dashboardScreen);},
      child:Scaffold(
        key: pSKey1,
        drawer: const NavDrawer(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            color: const Color.fromARGB(246, 214, 105, 17),
            onPressed: () {
              pSKey1.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: cont.language == "English"
              ? const Text(
            "Payment Details",
            style: TextStyle(
                color: Color.fromARGB(246, 214, 105, 17),
                fontWeight: FontWeight.bold),
          )
              : const Text(
            "देयक तपशील",
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
                const SizedBox(height: 50,),
                cont.isLoading ? buildCircularIndicator() :
                SingleChildScrollView(
                  child:
                  Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                      child:
                      cont.paymentList.isEmpty ? buildNoDataFound(context) :
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cont.paymentList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              final item = cont.paymentList[index];
                              return Padding(
                                padding: const EdgeInsets.only(left:30.0,right: 30.0,top:10.0,bottom: 2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: (){
                                          cont.callPaymentBilledApi();
                                        },
                                        onDoubleTap: (){
                                          cont.callPaymentBilledApi();
                                        },
                                        child:cont.language == "English"
                                            ? buildPaymentDetailsWidget(context,"Billed Count","${item.billedBillCount}")
                                            : buildPaymentDetailsWidget(context,"बिल केलेली संख्या","${item.billedBillCount}")
                                    ),
                                    const SizedBox(height: 10.0,),

                                    GestureDetector(
                                        onTap: (){
                                          cont.callPaymentBilledApi();
                                        },
                                        onDoubleTap: (){
                                          cont.callPaymentBilledApi();
                                        },
                                        child: cont.language == "English"
                                            ? buildPaymentDetailsWidget(context,"Billed Amount","${item.totalBilledAmount}")
                                            : buildPaymentDetailsWidget(context,"बिल केलेली रक्कम","${item.totalBilledAmount}")),
                                    const SizedBox(height: 20.0,),

                                    GestureDetector(
                                        onTap: (){
                                          cont.callPaymentPaidApi();
                                        },
                                        onDoubleTap: (){
                                          cont.callPaymentPaidApi();
                                        },
                                        child: cont.language == "English"
                                            ? buildPaymentDetailsWidget(context,"Paid Bill Count","${item.paidBillCount}")
                                            : buildPaymentDetailsWidget(context,"देय बिल गणना","${item.paidBillCount}")),
                                    const SizedBox(height: 10.0,),

                                    GestureDetector(
                                        onTap: (){
                                          cont.callPaymentPaidApi();
                                        },
                                        child: cont.language == "English"
                                            ? buildPaymentDetailsWidget(context,"Paid Bill Amount","${item.totalPaidAmount}")
                                            : buildPaymentDetailsWidget(context,"बिलाची रक्कम भरली","${item.totalPaidAmount}")),
                                    const SizedBox(height: 20.0,),

                                    GestureDetector(
                                        onTap: (){
                                          cont.callPaymentIntransitApi();
                                        },
                                        child: cont.language == "English"
                                            ? buildPaymentDetailsWidget(context,"Intransit Count","${item.pendingBillCount}")
                                            : buildPaymentDetailsWidget(context,"अंतर्गमन गणना","${item.pendingBillCount}")),
                                    const SizedBox(height: 10.0,),

                                    GestureDetector(
                                        onTap: (){
                                          cont.callPaymentIntransitApi();
                                        },
                                        child: cont.language == "English"
                                            ? buildPaymentDetailsWidget(context,"Intransit Amount","${item.totalPendingAmount}")
                                            : buildPaymentDetailsWidget(context,"अंतर्गमन रक्कम","${item.totalPendingAmount}")),
                                  ],
                                ),
                              );
                            }),
                      )
                  ),
                ),
              ],
            )),
      )
      );
    });
  }
}
