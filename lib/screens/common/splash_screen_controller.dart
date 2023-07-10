
import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zpfmsnew/constant/repository/api_repository.dart';
import 'package:zpfmsnew/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  SplashScreenController({required this.repository}) : assert(repository != null);

  bool isLogin=false;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData(){
    isLogin = GetStorage().read("isLogin")??false;

    if(isLogin==false || isLogin == null) {
      Timer(
          const Duration(seconds: 3),
              () => Get.toNamed(AppRoutes.login));
      update();
    }
    else{
      Timer(
          const Duration(seconds: 3),
              () => Get.toNamed(AppRoutes.dashboardScreen));
      update();
    }
  }

  // startTime() async {
  //   var duration = const Duration(seconds: 3);
  //
  //
  //   return Timer(duration, navigationPage);
  //
  // }
  //
  // Future<void> navigationPage() async {
  //   if(isLogin==false || isLogin == null){
  //     Get.toNamed(AppRoutes.login);
  //   }
  //   else{
  //     Get.toNamed(AppRoutes.dashboardScreen);
  //   }
  //
  //   update();
  // }
}