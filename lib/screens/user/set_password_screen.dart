import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/screens/user/login_controller.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  var data = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: ()async{ return await cont.backPressFromSetPasswordToLogin();},
        child: Scaffold(
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
              controller: cont.setPassScrollController,
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
                    key: cont.setPassFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 20.0),
                          child: TextFormField(
                            controller: cont.setPassController,
                            obscureText: cont.setShowPass,
                            maxLength: 8,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              border: const OutlineInputBorder(),
                              labelText: 'Enter Password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  cont.onSetPassChange();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: cont.setShowPass ? const Icon(
                                    Icons.visibility_off, color: Colors.black38,
                                    size: 30.0,) : const Icon(
                                    Icons.visibility, color: Colors.black38,
                                    size: 30.0,),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 20.0),
                          child: TextFormField(
                            controller: cont.setPassConfController,
                            obscureText: cont.setShowConfPass,
                            maxLength: 8,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              border: const OutlineInputBorder(),
                              labelText: 'Enter Confirm Password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  cont.onSetConfPassChange();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: cont.setShowConfPass ? const Icon(
                                    Icons.visibility_off, color: Colors.black38,
                                    size: 30.0,) : const Icon(
                                    Icons.visibility, color: Colors.black38,
                                    size: 30.0,),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
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
                            setState(() {
                              if (cont.setPassController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text(
                                      'Please enter valid password')),
                                );
                              }
                              else if (cont.setPassController.text !=
                                  cont.setPassConfController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text(
                                      'Password and Confirm password must be same')),
                                );
                              }
                              else if (cont.setPassController.text.length != 8) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text(
                                      'Password must contain 8 digits')),
                                );
                              }
                              else {
                                setState(() {
                                  cont.isLoading = true;
                                  if (data == "forRegistration") {
                                    cont.submitPasswordForRegistration();
                                  }
                                  else {
                                    cont.submitPasswordForgotPassword();
                                  }
                                });
                              }
                            });
                          },
                          child: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Submit',
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
        ),
      );
    });
  }
}
