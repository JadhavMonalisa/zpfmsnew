import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/screens/user/login_controller.dart';

class MobileNoScreen extends StatefulWidget {
  const MobileNoScreen({Key? key}) : super(key: key);

  @override
  State<MobileNoScreen> createState() => _MobileNoScreenState();
}

class _MobileNoScreenState extends State<MobileNoScreen> {

  var data = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: ()async{ return await cont.backPressFromMobileNoToLogin();},
      child:Scaffold(
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 1.0,
          height: MediaQuery
              .of(context)
              .size
              .height * 1.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              fit: BoxFit.cover,
            ),
            //color: Colors.blue,
          ),
          child: SingleChildScrollView(
            controller: cont.mobileNoScrollController,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    height: 180,
                  ),
                ),
                const Image(image: AssetImage("assets/tagline.png")),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: cont.mobNoFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: cont.mobileNoController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              border: OutlineInputBorder(),
                              labelText: 'Enter Mobile No',
                              counterText: ""
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Mobile No';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      cont.isLoading ? buildCircularIndicator() :
                      ElevatedButton(
                        onPressed: () {
                          cont.checkMobileNoValidation(data);
                        },
                        child: SizedBox(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.phone_android,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Send OTP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Image(
                  image: NetworkImage(
                      "http://api.demofms.com/api/Image/GetImage"),
                  width: 220,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Image(
                  image: AssetImage("assets/bom2.png"),
                  width: 220,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ));
    });
  }
}
