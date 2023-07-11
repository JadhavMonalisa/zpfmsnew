import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/routes/app_pages.dart';
import 'package:zpfmsnew/screens/common/nav_drawer.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';

class WorkOrderListScreen extends StatefulWidget {
  const WorkOrderListScreen({Key? key}) : super(key: key);

  @override
  State<WorkOrderListScreen> createState() => _WorkOrderListScreenState();
}

class _WorkOrderListScreenState extends State<WorkOrderListScreen> {
  GlobalKey<ScaffoldState> woSKey1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont){
    return WillPopScope(onWillPop: () async {return await Get.toNamed(AppRoutes.dashboardScreen);},
     child:Scaffold(
        key: woSKey1,
        drawer: const NavDrawer(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            color: const Color.fromARGB(246, 214, 105, 17),
            onPressed: () {
              woSKey1.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: cont.language == "English"
              ? const Text(
            "Work Order Details",
            style: TextStyle(
                color: Color.fromARGB(246, 214, 105, 17),
                fontWeight: FontWeight.bold),
          )
              : const Text( "वर्क ऑर्डर",
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
            child:ListView(
              children: [
                SingleChildScrollView(
                  child:

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 20.0),
                    child:
                    // isLoading ? buildCircularIndicator():
                    cont.contractorList.isEmpty ? buildNoDataFound(context) :
                    Align(
                      alignment: Alignment.center,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cont.contractorList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            final item = cont.contractorList[index];
                            return GestureDetector(
                              onTap: (){
                                cont.navigateToBillDataFromWorkOrder(item.workDetailsID!,item.workOrderNo!);
                              },
                              child: Padding(
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
                                                ? buildTableRow(context, "Sr. No.", "${index+1}")
                                                : buildTableRow(context, "अनु. क्र.", "${index+1}"),
                                            buildSpaceTableRow(),

                                            cont.language == "English"
                                                ? buildTableRow(context, "District", "${item.districtName}")
                                                : buildTableRow(context, "जिल्हा", "${item.districtName}"),
                                            buildSpaceTableRow(),

                                            cont.language == "English"
                                                ? buildTableRow(context, "Work Order Number", "${item.workOrderNo}")
                                                : buildTableRow(context, "वर्क ऑर्डर क्र.", "${item.workOrderNo}"),
                                            buildSpaceTableRow(),

                                            cont.language == "English"
                                                ? buildTableRow(context, "Work Order Date", "${item.workOrderDate}")
                                                : buildTableRow(context, "वर्क ऑर्डरची तारीख", "${item.workOrderDate}"),
                                            buildSpaceTableRow(),

                                            cont.language == "English"
                                                ? buildTableRow(context, "Work Order Amount", "${item.payableAmount}")
                                                : buildTableRow(context, "वर्क ऑर्डरचे रक्कम", "${item.payableAmount}"),
                                            buildSpaceTableRow(),

                                            cont.language == "English"
                                                ? buildTableRow(context, "Work Order Name", "${item.workName}")
                                                : buildTableRow(context, "वर्क ऑर्डरचे नाव", "${item.workName}"),
                                            buildSpaceTableRow(),
                                          ],
                                        )
                                      ],
                                    ),

                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                )
              ],
            )
        )
    )
     );
    });
  }
}
