import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zpfmsnew/common_widget/widget.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_screen.dart';

class WebviewScreen extends StatefulWidget {
  final String title;
  final String url;
  WebviewScreen({Key? key,required this.title,required this.url}) : super(key: key);

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  double progress = 0;
  double loadingContainerHeight = 5;
  bool isLoading = true;
  final key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
           widget.title,
            style: const TextStyle(
                color: Color.fromARGB(246, 214, 105, 17),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * progress,
                  height: loadingContainerHeight,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(4.0),bottomRight: Radius.circular(4.0),),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * (2 / 3),
                    child: WebView(
                      key: key,
                      //initialUrl: "https://www.zpfms.com/",
                      initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebResourceError: (error){
                      },
                      onPageFinished: (finish){
                        setState(() {
                          isLoading=false;
                        });
                      },
                      onProgress: (int progress) {
                        //cont.updateProgressInWebView(progress);
                        setState(() {
                          this.progress = progress/100;
                          if(progress == 100) {
                            loadingContainerHeight = 0;
                          }
                        });

                      },
                    ),
                  ),
                ),
              ],
            ),
            isLoading ? Center(child: buildCircularIndicator(),): Stack(),
          ],
        ),
      ),
    );
  }
}
