
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/screens/common/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<SplashScreenController>(builder: (cont)
    {
      return SafeArea(
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
            ),
            child: Center(
              child: Image.asset(
                "assets/logo.png",
                height: 100,
              ),
            ),
          ),
        ),
      );
    });
  }
}
