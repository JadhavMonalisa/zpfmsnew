import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/routes/app_pages.dart';
import 'package:zpfmsnew/screens/common/nav_drawer.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class SearchWorkOrderList extends StatefulWidget {
  const SearchWorkOrderList({Key? key}) : super(key: key);

  @override
  State<SearchWorkOrderList> createState() => _SearchWorkOrderListState();
}

class _SearchWorkOrderListState extends State<SearchWorkOrderList> {

  GlobalKey<ScaffoldState> scaffoldKeyDemo = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont){
      return  WillPopScope(
          onWillPop: () async {  return await cont.navigateToEnterPhoto();},
      child: Scaffold(
          key: scaffoldKeyDemo,
          drawer: const NavDrawer(),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: cont.language == "English"
                ? const Text(
              "Work Order Search Details",
              style: TextStyle(
                  color: Color.fromARGB(246, 214, 105, 17),
                  fontWeight: FontWeight.bold),
            )
                : const Text(
              "वर्क ऑर्डर शोध तपशील",
              style: TextStyle(
                  color: Color.fromARGB(246, 214, 105, 17),
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: IconButton(
              color: const Color.fromARGB(246, 214, 105, 17),
              onPressed: () {
                scaffoldKeyDemo.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ),
          body: Stack(
            children: [
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
                  children: [
                    const SizedBox(height: 20.0,),
                    cont.isLoading ? Center(child: buildCircularIndicator(),):
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                        child:
                        cont.searchWorkOrderList.isEmpty ? buildNoDataFound(context) :
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cont.searchWorkOrderList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index){
                                final item = cont.searchWorkOrderList[index];
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
                                          Align(
                                            alignment:Alignment.topRight,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.green, backgroundColor: Colors.yellow.shade400,
                                                minimumSize: const Size(70, 25),
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                                ),
                                              ),
                                              onPressed: () {
                                                cont.navigateToBillDataFromPhotoUpload(item.workID!,item.workOrderNo!);
                                              },
                                              child:
                                              cont.language == "English"
                                              ? const Text('View Bills',
                                                style: TextStyle(color: Colors.black, fontSize: 15),
                                              )
                                                  : const Text('बिले पहा',
                                                style: TextStyle(color: Colors.black, fontSize: 15),
                                              ),
                                            ),
                                          ),
                                          Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(5),
                                              1: FlexColumnWidth(1),
                                              2: FlexColumnWidth(4),
                                            },
                                            children: [
                                              cont.language == "English"
                                                  ? buildTableRow(context, "Sr. No.", "${item.srNo}")
                                                  : buildTableRow(context, "अनु. क्र.", "${item.srNo}"),
                                              buildSpaceTableRow(),
                                            ],
                                          ),
                                          Column(
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
                                                   ? buildTableRow(context, "District", "${item.district}")
                                                  : buildTableRow(context, "जिल्हा", "${item.district}"),
                                                  buildSpaceTableRow(),

                                                  cont.language == "English"
                                                  ? buildTableRow(context, "Work Order Name", "${item.workOrderName}")
                                                  : buildTableRow(context, "वर्क ऑर्डरचे नाव", "${item.workOrderName}"),
                                                  buildSpaceTableRow(),

                                                  cont.language == "English"
                                                  ? buildTableRow(context, "Work Order Date", "${item.workOrderDate}")
                                                  : buildTableRow(context, "वर्क ऑर्डरची तारीख", "${item.workOrderDate}"),
                                                  buildSpaceTableRow(),

                                                  cont.language == "English"
                                                  ? buildTableRow(context, "Work Order Amount", "${item.workOrderAmount}")
                                                  : buildTableRow(context, "वर्क ऑर्डरची रक्कम", "${item.workOrderAmount}"),
                                                  buildSpaceTableRow(),
                                                ],
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                              onTap: (){
                                                cont.navigateToUploadedPhotos(item.billID!,item.workOrderNo!,AppRoutes.searchWorkOrderList);
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
                                          // Align(
                                          //   alignment:Alignment.topRight,
                                          //   child: ElevatedButton(
                                          //     style: ElevatedButton.styleFrom(
                                          //       onPrimary: Colors.green,
                                          //       primary: Colors.yellow.shade400,
                                          //       minimumSize: const Size(70, 25),
                                          //       shape: const RoundedRectangleBorder(
                                          //         borderRadius: BorderRadius.all(Radius.circular(7)),
                                          //       ),
                                          //     ),
                                          //     onPressed: () {
                                          //       cont.navigateToUploadedPhotos(item.billID!,item.workOrderNo!);
                                          //     },
                                          //     child:
                                          //     cont.language == "English"
                                          //         ? const Text('Previous Photo',
                                          //       style: TextStyle(color: Colors.black, fontSize: 15),
                                          //     )
                                          //         : const Text('मागील फोटो पहा',
                                          //       style: TextStyle(color: Colors.black, fontSize: 15),
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                    ),
                  ],
                ),
              )
            ],
          )
      )
      );
    });
  }
}
