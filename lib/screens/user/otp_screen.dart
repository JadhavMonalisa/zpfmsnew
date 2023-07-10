import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/screens/user/login_controller.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({Key? key}) : super(key: key);

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  var data = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: ()async{ return await cont.backPressFromOtpToMobileNo(data);},
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
            controller: cont.otpScrollController,
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
                Column(
                  children: [
                    buildTextBoldWidget(
                        "Enter your OTP here", Colors.black, context, 16.0,
                        fontWeight: FontWeight.normal),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OTPTextField(
                        length: data == "forRegistration" ? 5 : 6,
                        width: 310,
                        controller: cont.otpController,
                        style: const TextStyle(fontSize: 20),
                        keyboardType: TextInputType.text,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.underline,
                        otpFieldStyle: OtpFieldStyle(
                            focusBorderColor: Colors.blue,
                            errorBorderColor: Colors.red),
                        onCompleted: (pin) {
                          setState(() {},);
                        },
                        onChanged: (value) {
                          cont.addOtpValue(value);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // cont.isAllowToResendOtp
                    // ? buildTextBoldWidget("Resend OTP", Colors.black, context, 16.0,decoration: TextDecoration.underline)
                    // : buildTextBoldWidget("Resend otp in ${_start.} minutes", Colors.black, context, 16.0,),

                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildTextBoldWidget(
                              "Didn’t receive code?", Colors.black, context, 15,
                              fontWeight: FontWeight.normal),
                          const SizedBox(width: 7.0,),
                          GestureDetector(
                            onTap: () {
                              cont.resendOtpClick();
                                  },
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 0.1),
                              decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(
                                  color: Colors.black, width: 1.5,),),
                              ),
                              child: buildTextBoldWidget(
                                  "Resend", Colors.black, context, 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                          cont.isAllowToResendOtp ?
                          buildTextBoldWidget(
                              " in ${cont.secondsRemainingForResend==120?0:cont.secondsRemainingForResend} seconds", Colors.black, context, 15,
                              fontWeight: FontWeight.normal) :
                          buildTextBoldWidget(

                              " in ${cont.secondsRemaining} seconds",
                              Colors.black, context, 15,
                              fontWeight: FontWeight.normal),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    cont.isLoading ? buildCircularIndicator() :
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (cont.otp == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter valid otp')),
                            );
                          }
                          else {
                            setState(() {
                              cont.isLoading = true;
                              if (data == "forRegistration") {
                                cont.verifyOtpForRegistration();
                              }
                              else {
                              cont.verifyOtpForForgotPassword();
                              }
                            });
                          }
                        });
                      },
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.pin,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Verify OTP',
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
