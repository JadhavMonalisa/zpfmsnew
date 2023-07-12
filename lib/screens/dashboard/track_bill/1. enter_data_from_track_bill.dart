import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/screens/common/nav_drawer.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class EnterManuallyForTrackBill extends StatefulWidget {
  const EnterManuallyForTrackBill({Key? key}) : super(key: key);

  @override
  State<EnterManuallyForTrackBill> createState() => _EnterManuallyForTrackBillState();
}

class _EnterManuallyForTrackBillState extends State<EnterManuallyForTrackBill> {
  GlobalKey<ScaffoldState> tbSKey1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont){
    return WillPopScope(
      onWillPop: () async {return await cont.navigateToDashboardFromTrackBill();},
      child: Scaffold(
        key: tbSKey1,
        drawer: const NavDrawer(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            color: const Color.fromARGB(246, 214, 105, 17),
            onPressed: () {
              tbSKey1.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title:cont.language == "English"
              ? const Text(
            "Track Bill",
            style: TextStyle(
                color: Color.fromARGB(246, 214, 105, 17),
                fontWeight: FontWeight.bold),
          )
              : const Text(
            "ट्रॅक बिल",
            style: TextStyle(
                color: Color.fromARGB(246, 214, 105, 17),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
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
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // buildTextBoldWidget("Track Bill", Colors.black, context, 22.0),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.green, backgroundColor: Colors.deepOrange,
                            minimumSize: const Size(100, 40),
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          onPressed: () {
                           cont.setVariable();
                          },
                          child: const Text(
                            'Scan QR Code',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        cont.isScanQrSelected
                            ?  Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 2,
                              child: cont.buildQr(context)
                          ),
                        )
                            : const Opacity(opacity: 0.0,),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.green, backgroundColor: Colors.yellow.shade400,
                            minimumSize: const Size(100, 40),
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          onPressed: () {
                           cont.setVariableForManually();
                          },
                          child: const Text(
                            'Enter Manually',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),

                        const SizedBox(height: 10.0,),
                        cont.isEnterManuallySelected ?
                        buildTextBoldWidget("Enter Demand Number", Colors.black, context, 20.0,align: TextAlign.center) : const Opacity(opacity: 0.0),

                        cont.isEnterManuallySelected
                            ? Padding(
                          padding: const EdgeInsets.only(top: 20.0,right: 25.0,left: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                    height: 40.0,
                                    //width:230.0,
                                    color: Colors.white,
                                    child: TextFormField(
                                      controller: cont.enterManuallyController,
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical.center,
                                      textInputAction: TextInputAction.done,
                                      onTap: () {
                                      },
                                      style:const TextStyle(fontSize: 16.0),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        border: InputBorder.none,
                                        hintText: "1234",
                                      ),
                                      onChanged: (value) {
                                      },
                                    )
                                ),
                              ),
                              const SizedBox(width: 10.0,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.green, backgroundColor: Colors.yellow.shade400,
                                  minimumSize: const Size(60, 40),
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(25)),
                                  ),
                                ),
                                onPressed: () {
                                  if(cont.enterManuallyController.text.isEmpty){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please enter bill id')),
                                    );
                                  }
                                  else{
                                    ///same used in work order
                                    //cont.navigateToBillFromTrackBill(int.parse(cont.enterManuallyController.text));
                                    cont.demandNoToShow = cont.enterManuallyController.text;
                                    cont.navigateToBillFromTrackBill(cont.enterManuallyController.text);
                                  }
                                },
                                child: const Text(
                                  'Search',
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        )
                            : const Opacity(opacity: 0.0),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    });
  }
}
