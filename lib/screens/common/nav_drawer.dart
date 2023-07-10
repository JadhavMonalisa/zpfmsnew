import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpfmsnew/screens/common/webview_screen.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key,}) : super(key: key);
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  // String language = "";
  // String username = "";
  // String token = "";

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   reload();
  //   super.initState();
  // }
  //
  // reload() async {
  //   username = GetStorage().read("username")??"";
  //   language = GetStorage().read("language")??"";
  //   token = GetStorage().read("token")??"";
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont)
    {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Image.asset(
                  "assets/logo.png",
                  height: 100,
                ),
              ),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('assets/bg.jpg'))),
            ),
            ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text('Dashboard'),
                onTap: () {
                  Navigator.pop(context);
                  cont.navigateToDashboardFromDrawer();
                }
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                cont.navigateToProfileFromDrawer();
              }
            ),
            ListTile(
              leading: cont.language == "English"
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank_sharp),
              title: const Text('Choose Language English'),
              onTap: () async {
                // setState(() {
                //   Navigator.pop(context);
                //   GetStorage().write("language", "English");
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Language Change Please Wait')),
                //   );
                //   Get.toNamed(AppRoutes.dashboardScreen);
                // });
                cont.changeLangToEnglish(context,"English");
              },
            ),
            ListTile(
              leading: cont.language == "Marathi"
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank_sharp),
              title: const Text('Choose Language Marathi'),
              onTap: () async {
                cont.changeLangToEnglish(context,"Marathi");
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_mark),
              title: const Text('FAQ'),
              onTap: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WebviewScreen(title: "FAQ", url: "http://bems.prmgroup.in/zp_api/FaqQuestion.html"),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.call),
              title: const Text('Contact Us'),
              onTap: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WebviewScreen(title: "Contact Us",
                            url: "http://bems.prmgroup.in/zp_api/ContactUs.html"),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('About Us'),
              onTap: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WebviewScreen(title: "About Us",
                            url: "http://bems.prmgroup.in/zp_api/AboutUs.html"),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () =>
              {
                showDialog(
                  context: context,
                  builder: (context) =>
                      AlertDialog(
                        title: const Text("Exit"),
                        content: const Text("Do you want to Logout..."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              cont.goToLogout();
                             //  GetStorage().remove("username");
                             //  GetStorage().remove("token");
                             //  GetStorage().remove("language");
                             //  GetStorage().write("isLogin", false);
                             //  GetStorage().erase();
                             //  Get.toNamed(AppRoutes.login);
                            },
                            child: const Text("Yes"),
                          )
                        ],
                      ),
                ),
              },
            ),
          ],
        ),
      );
    });
  }
}
