import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../../constant/provider/custom_exception.dart';
import '../../constant/repository/api_repository.dart';
import '../../routes/app_pages.dart';
import '../../utils/custom_response.dart';
import '../../utils/utils.dart';


class LoginController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  LoginController({required this.repository}) : assert(repository != null);

  ///login screen
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String loginEmail = ""; String loginPass = "";
  bool validateLoginEmail = false, validateLoginPassword = false;
  //show password
  bool showPass = true;

  ScrollController scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? deviceId;


  ///forget password
  TextEditingController forgotEmailController = TextEditingController();
  String forgotEmail ="";
  bool validateForgetEmail = false;

  ///Reset password
  TextEditingController resetPassController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String resetPass = ""; String confirmPass = "";
  //show password
  bool showResetPass = true; bool showResetConfirmPass = true;
  bool validateResetPass = false, validateResetConfirmPass = false, validateResetBothPass = false;

  bool noData = false; bool loader = false;
  updateLoader(bool val) { loader = val; update();}
  bool isLogin = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    initPlatformState();
  }

  getData(){
    isLogin = GetStorage().read("isLogin");
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    update();
  }


  ///Login Screen--------------------------------------------------
  //show/hide pass
  void onPassChange(){ showPass = !showPass; update();}
  //values for login controller
  void addEmailId(dynamic value){ loginEmail = value; update();}
  void addPassword(dynamic value){ loginPass = value; update();}
  //validation for each textFormField
  checkLoginEmailValidation(BuildContext context){
    if(usernameController.text.isEmpty){ validateLoginEmail = true; update(); }
    else{validateLoginEmail = false; update(); }
  }
  checkLoginPassValidation(BuildContext context){
    if(passwordController.text.isEmpty){ validateLoginPassword = true; update(); }
    else{ validateLoginPassword = false; update(); }
  }
  //main validation on submit button
  checkLoginValidation(BuildContext context){
    if(usernameController.text.isEmpty || passwordController.text.isEmpty){
      usernameController.text.isEmpty ? validateLoginEmail = true : validateLoginEmail = false;
      passwordController.text.isEmpty ? validateLoginPassword = true : validateLoginPassword = false;
      update();
    }else{
      isLoading = true; update();
      addLoginApi(context);
    }
    update();
  }

  ///Forget Password---------------------------------------------------------------
  //values for forgot controller
  void addForgotEmailId(dynamic value){ forgotEmail = value; update();}
  //validation for each textFormField
  checkForgetEmailValidation(BuildContext context){
    if(forgotEmailController.text.isEmpty){ validateForgetEmail = true; update(); }
    else{ validateForgetEmail = false; update(); }
  }
  //main validation on submit button
  checkForgetPasswordValidation(BuildContext context){
    if(forgotEmailController.text.isEmpty){
      forgotEmailController.text.isEmpty ? validateForgetEmail = true : validateForgetEmail = false;
      update();
    }else{
     //addForgetPasswordApi(context);
    }
    update();
  }

  ///add login api-----------------------------
  void addLoginApi(BuildContext context) async {
    try {
      Utils.dismissKeyboard();
      LoginResponse? response = (await repository.doLogin(
        usernameController.text, passwordController.text,deviceId
      ));

      if (response.statusCode==200) {
        GetStorage().write('username', usernameController.text);
        if(response.result!.contains("Token Already Genereated:")){
          GetStorage().write('token', response.result!.replaceAll("Token Already Genereated:", ""));
        }
        else{
          GetStorage().write('token', response.result);
        }
        GetStorage().write('language', "English");
        GetStorage().write('isLogin', true);
        Utils.showSuccessSnackBar("Login successfully!");
        isLoading = false;
        usernameController.clear();passwordController.clear();
        repository.getData();
        update();
        Get.toNamed(AppRoutes.dashboardScreen);
        update();
      }
      else if(response.statusCode==404){
        isLoading = false;
        Utils.showErrorSnackBar(response.result); update();
      }
      else {
        isLoading = false;
        Utils.showErrorSnackBar("Something went wrong. Please try again later!"); update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      Utils.showErrorSnackBar(e.getMsg().toString());update();
    } catch (error) {
      isLoading = false;
      Utils.showErrorSnackBar("Invalid username or password"); update();
    }
  }

  TextEditingController mobileNoController = TextEditingController();
  ScrollController mobileNoScrollController = ScrollController();
  final mobNoFormKey = GlobalKey<FormState>();
  final setPassFormKey = GlobalKey<FormState>();

  checkMobileNoValidation(String data){
    if (mobileNoController.text.isEmpty) {
      Utils.showErrorSnackBar('Please enter valid mobile no'); update();
    }
    else if (mobileNoController.text.length != 10) {
      Utils.showErrorSnackBar('Please enter valid mobile no'); update();
    }
    else {
      isLoading = true;
      if (data == "forRegistration") {
        verifyMobileNoRegistrationOperation();
      }
      else {
        verifyMobileNoForgotPasswordOperation();
      }
      update();
    }
  }

  addOtpValue(String val){
    otp = val; update();
  }

  verifyMobileNoForgotPasswordOperation() async {
      isLoading = true;
      //String token = GetStorage().read("token");
      try {
        Utils.dismissKeyboard();
        LoginResponse? response = (await repository.getMobileNoVerifyForForgotPassword(
            mobileNoController.text));


        if (response.statusCode==200) {
          isLoading = false;
          Utils.showErrorSnackBar(response.result);
          startTimer();
          Get.toNamed(AppRoutes.otpScreen,arguments: ["forForgotPassword"]);
          update();
        }
        else if(response.statusCode==404){
          isLoading = false;
          Utils.showErrorSnackBar(response.result); update();
        }
        else {
          isLoading = false;
          Utils.showErrorSnackBar("Something went wrong. Please try again later!"); update();
        }
        update();
      } on CustomException catch (e) {
        isLoading = false;
        Utils.showErrorSnackBar("Something went wrong. Please try again later!");update();
      } catch (error) {
        isLoading = false;
        Utils.showErrorSnackBar("Invalid username or password"); update();
      }
  }

  verifyMobileNoRegistrationOperation() async {
      isLoading = true;
      //String token = GetStorage().read("token");
      try {
        Utils.dismissKeyboard();
        LoginResponse? response = (await repository.getMobileNoVerifyForRegistration(
            mobileNoController.text));

        if (response.statusCode==200) {
          isLoading = false;
          Utils.showErrorSnackBar(response.result);
          startTimer();
          Get.toNamed(AppRoutes.otpScreen,arguments: ["forRegistration"]);
          update();
        }
        else if(response.statusCode==404){
          isLoading = false;
          Utils.showErrorSnackBar(response.result); update();
        }
        else {
          isLoading = false;
          Utils.showErrorSnackBar("Something went wrong. Please try again later!"); update();
        }
        update();
      } on CustomException catch (e) {
        isLoading = false;
        Utils.showErrorSnackBar("Something went wrong. Please try again later!");update();
      } catch (error) {
        isLoading = false;
        Utils.showErrorSnackBar("Invalid username or password"); update();
      }
  }

  resendOtpToMobileNoOperation() async {
      isLoading = true;
      //String token = GetStorage().read("token");
      try {
        Utils.dismissKeyboard();
        LoginResponse? response = (await repository.getResendPasswordForForgotPassword(
            mobileNoController.text));

        if (response.statusCode==200) {
          isLoading = false;
          Utils.showErrorSnackBar(response.result);

          secondsRemaining = 120;
          isAllowToResendOtp = false;
          startTimerForResend();
          update();
        } else {
          isLoading = false;
          Utils.showErrorSnackBar("Something went wrong. Please try again later!"); update();
        }
      } on CustomException catch (e) {
        isLoading = false;
        Utils.showErrorSnackBar("Something went wrong. Please try again later!");update();
      } catch (error) {
        isLoading = false;
        Utils.showErrorSnackBar("Invalid username or password"); update();
      }
  }

  int secondsRemaining = 120;
  bool isAllowToResendOtp = false;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining != 0) {
        secondsRemaining--; update();
      } else {
        isAllowToResendOtp = true; update();
      }
    });
    update();
  }


  int secondsRemainingForResend = 120;
  void startTimerForResend() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemainingForResend != 0) {
        secondsRemainingForResend--; update();
      } else {
        isAllowToResendOtp = true; update();
      }
    });
    update();
  }

  resendOtpClick(){
    if(secondsRemaining == 0){
      resendOtpToMobileNoOperation();
    }
    else{
      Utils.showAlertSnackBar("Please wait, after $secondsRemaining seconds you can resend OTP.");
      update();
    }
  }

  submitPasswordForgotPassword() async {
      isLoading = true;
      try {
        Utils.dismissKeyboard();
        LoginResponse? response = (await repository.getSetPasswordForForgotPassword(
            mobileNoController.text,setPassController.text));

        if (response.statusCode==200) {
          isLoading = false;
          Utils.showErrorSnackBar(response.result);
          Get.toNamed(AppRoutes.login);
          update();
        } else {
          isLoading = false;
          Utils.showErrorSnackBar("Something went wrong. Please try again later!"); update();
        }
        update();
      } on CustomException catch (e) {
        isLoading = false;
        Utils.showErrorSnackBar("Something went wrong. Please try again later!");update();
      } catch (error) {
        isLoading = false;
        Utils.showErrorSnackBar("Invalid username or password"); update();
      }
  }
  submitPasswordForRegistration() async {
      isLoading = true;
      try {
        Utils.dismissKeyboard();
        LoginResponse? response = (await repository.getSetPasswordForRegistration(
            mobileNoController.text,setPassController.text));

        if (response.statusCode==200) {
          isLoading = false;
          Utils.showErrorSnackBar(response.result);
          Get.toNamed(AppRoutes.login);
          update();
        } else {
          isLoading = false;
          Utils.showErrorSnackBar("Something went wrong. Please try again later!"); update();
        }
        update();
      } on CustomException catch (e) {
        isLoading = false;
        Utils.showErrorSnackBar("Something went wrong. Please try again later!");update();
      } catch (error) {
        isLoading = false;
        Utils.showErrorSnackBar("Invalid username or password"); update();
      }
  }

  ///otp screen
  String otp = "";

  verifyOtpForForgotPassword() async {
    isLoading = true;
    //String token = GetStorage().read("token");
    try {
      Utils.dismissKeyboard();
      LoginResponse? response = (await repository.getOtpVerifyForForgotPassword(mobileNoController.text,otp));

      if (response.statusCode==200) {
        isLoading = false;
        mobileNoController.clear();
        if(response.result == "Mobile Number And OTP Is Verify."){
          Utils.showErrorSnackBar(response.result);
          Get.toNamed(AppRoutes.setPasswordScreen,arguments: ["forForgotPassword"]);
          update();
        }
        else{
          Utils.showErrorSnackBar(response.result);
          update();
        }

      } else {
        isLoading = false;
        Utils.showErrorSnackBar("Something went wrong. Please try again later!"); update();
      }
      update();
    } on CustomException catch (e) {
      isLoading = false;
      Utils.showErrorSnackBar("Something went wrong. Please try again later!");update();
    } catch (error) {
      isLoading = false;
      Utils.showErrorSnackBar("Invalid username or password"); update();
    }
  }
  verifyOtpForRegistration() async {
    isLoading = true;
    String token = GetStorage().read("token");
    try {
      Utils.dismissKeyboard();
      LoginResponse? response = (await repository.getOtpVerifyForRegistration(mobileNoController.text,otp));

      if (response.statusCode==200) {
        isLoading = false;
        mobileNoController.clear();
        Utils.showErrorSnackBar(response.result);
        Get.toNamed(AppRoutes.setPasswordScreen,arguments: ["forRegistration"]);
        update();
      } else {
        isLoading = false;
        Utils.showErrorSnackBar("Something went wrong. Please try again later!"); update();
      }
      update();
    } on CustomException catch (e) {
      isLoading = false;
      Utils.showErrorSnackBar("Something went wrong. Please try again later!");update();
    } catch (error) {
      isLoading = false;
      Utils.showErrorSnackBar("Invalid username or password"); update();
    }
  }

  ScrollController otpScrollController = ScrollController();
  ScrollController setPassScrollController = ScrollController();
  OtpFieldController otpController = OtpFieldController();

  TextEditingController setPassController = TextEditingController();
  TextEditingController setPassConfController = TextEditingController();

  bool setShowPass = false;
  bool setShowConfPass = false;

  void onSetPassChange(){ setShowPass = !setShowPass; update();}
  void onSetConfPassChange(){ setShowConfPass = !setShowConfPass; update();}

  backPressFromMobileNoToLogin(){
    isLoading = false; update();
    Get.offAllNamed(AppRoutes.login);
  }

  backPressFromOtpToMobileNo(String data){
    isLoading = false; update();
    Get.offAllNamed(AppRoutes.mobileNoScreen,arguments: [data]);
  }

  backPressFromSetPasswordToLogin(){
    isLoading = false; update();
    Get.offAllNamed(AppRoutes.login);
  }
}
