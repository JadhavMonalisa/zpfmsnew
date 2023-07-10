import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/common_widget/error_text.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/routes/app_pages.dart';
import 'package:zpfmsnew/screens/user/login_controller.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (cont){
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body:
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 1.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.cover,
              ),
              //color: Colors.blue,
            ),
            child: SingleChildScrollView(
              controller: cont.scrollController,
              child:
              Column(
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
                  const Padding(
                    padding:EdgeInsets.only(right:20.0,left:20.0),
                    child:Image(image: AssetImage("assets/tagline.png")),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: cont.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: cont.usernameController,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                            ),
                            onChanged: (val){
                              cont.checkForgetEmailValidation(context);
                            },
                          ),
                        ),
                        cont.validateLoginEmail == true
                            ? ErrorText(errorMessage: "Please enter valid username",)
                            : const Opacity(opacity: 0.0),

                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: TextFormField(
                            controller: cont.passwordController,
                            obscureText: cont.showPass,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  cont.onPassChange();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: cont.showPass ? const Icon(
                                    Icons.visibility_off,color: Colors.black38,size: 30.0,) : const Icon(
                                    Icons.visibility, color: Colors.black38,size: 30.0,),
                                ),
                              ),
                            ),
                            onChanged: (val){
                              cont.checkLoginPassValidation(context);
                            },
                          ),
                        ),
                        cont.validateLoginPassword == true
                            ? ErrorText(errorMessage: "Please enter valid password",)
                            : const Opacity(opacity: 0.0),

                        const SizedBox(
                          height: 20,
                        ),
                        cont.isLoading ? buildCircularIndicator() :
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: ElevatedButton(
                                onPressed: () {
                                  cont.checkLoginValidation(context);
                                },
                                child: SizedBox(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        'Login',
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
                            ),
                            const SizedBox(width: 10,),
                            Flexible(
                              child: GestureDetector(
                                  onTap:(){
                                    Get.toNamed(AppRoutes.mobileNoScreen,arguments: ["forForgotPassword"]);
                                  },
                                  child:Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                          padding: const EdgeInsets.only(right: 15.0),
                                          child: buildTextBoldWidget("FORGOT PASSWORD ?", Colors.black, context, 15.0,fontWeight: FontWeight.normal)
                                      )    )   ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap:(){
                              Get.toNamed(AppRoutes.mobileNoScreen,arguments: ["forRegistration"]);
                            },
                            child:buildRichTextWidget("New user? ","Click to register.",title1Size: 18.0,title2Size: 18.0,)
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Image(
                    image: NetworkImage("http://api.demofms.com/api/Image/GetImage"),
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
