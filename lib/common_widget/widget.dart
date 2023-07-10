import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zpfmsnew/theme/app_colors.dart';
import 'package:zpfmsnew/theme/app_text_theme.dart';

///circular progress indicator widget
buildCircularIndicator(){
  return const Center(
    child: Padding(
      padding: EdgeInsets.only(top: 30.0,bottom: 30.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: CupertinoActivityIndicator(color: Colors.orange,),
        ),
      ),
    ),
  );
}

///no data found widget
buildNoDataFound(BuildContext context,{Color color = blackColor}){
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 30.0,bottom: 30.0),
      child: buildTextBoldWidget("Record Not Found", color, context, 14,),
    ),
  );
}

buildRichTextWidget(String title1,String title2, {FontWeight title1Weight = FontWeight.bold,
  FontWeight title2Weight = FontWeight.normal,Color title1Color = Colors.black, Color title2Color = Colors.black,
  double title1Size = 15.5, double title2Size = 15.5}){
  return RichText(
    text: TextSpan(
      text: title1,
      style: TextStyle(fontWeight: title1Weight,color: title1Color,fontSize: title1Size),
      children: <TextSpan>[
        TextSpan(
            text: title2,
            style: TextStyle(fontWeight: title2Weight,color: title2Color,fontSize: title2Size)),
      ],
    ),
  );
}

buildRichTextForCountWidget(String title1,String title2, {FontWeight title1Weight = FontWeight.normal,
  FontWeight title2Weight = FontWeight.normal,Color title1Color = const Color.fromARGB(246, 214, 105, 17),
  Color title2Color = const Color.fromARGB(246, 214, 105, 17),
  double title1Size = 12, double title2Size = 12}){
  return Padding(
    padding: const EdgeInsets.only(right: 10.0,left:10.0),
    child: RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: title1,
        style: TextStyle(fontWeight: title1Weight,color: title1Color,fontSize: title1Size),
        children: <TextSpan>[
          TextSpan(
              text: title2,
              style: TextStyle(fontWeight: title2Weight,color: title2Color,fontSize: title2Size,)),
        ],
      ),
    ),
  );
}

buildTableRow(BuildContext context,String title,String subTitle){
  return TableRow(
      children: [
        buildTextBoldWidget(title, Colors.black, context, 15.0,align: TextAlign.left),
        buildTextBoldWidget(":", Colors.black, context, 15.0),
        buildTextBoldWidget(subTitle, Colors.black, context, 15.0,align: TextAlign.left,fontWeight: FontWeight.normal),
      ]
  );
}
buildTableRowForCount(BuildContext context,String title,String subTitle,
    {double fontSize = 11.0,Color fontColor = const Color.fromARGB(246, 214, 105, 17)}){
  return
    TableRow(
        children: [
          Padding(
            padding:const EdgeInsets.only(left:5.0),
            child:buildTextRegularWidget(title, fontColor , context, fontSize,align: TextAlign.left),
          ),
          Padding(
          padding:const EdgeInsets.only(right:5.0),
          child:
          buildTextRegularWidget(subTitle, fontColor, context, fontSize,align: TextAlign.right,fontWeight: FontWeight.normal)),
        ]
    );
}

buildTableRowForPhoto(BuildContext context,String title,String subTitle,
    {double fontSize = 11.0,Color fontColor = const Color.fromARGB(246, 214, 105, 17)}){
  return
    TableRow(
        children: [
          Padding(
            padding:const EdgeInsets.only(left:5.0),
            child:buildTextBoldWidget(title, fontColor , context, fontSize,align: TextAlign.left),
          ),
          Padding(
              padding:const EdgeInsets.only(right:5.0),
              child:
              buildTextRegularWidget(subTitle, fontColor, context, fontSize,align: TextAlign.left,fontWeight: FontWeight.normal)),
        ]
    );
}

buildSpaceTableRow(){
  return const TableRow(
      children: [
        SizedBox(height: 3.0,),
        SizedBox(height: 3.0,),
        SizedBox(height: 3.0,),
      ]
  );
}

buildCountWidget(BuildContext context,String title, String count){
  return  Padding(
    padding: const EdgeInsets.only(right: 10.0,left:10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildTextRegularWidget(title, const Color.fromARGB(246, 214, 105, 17),context, 11.0),
        const Spacer(),
        buildTextRegularWidget(count, const Color.fromARGB(246, 214, 105, 17),context, 11.0)
      ],
    ),
  );
}

buildPaymentDetailsWidget(BuildContext context,String title, String count){
  return Column(
    children: [
      buildTextBoldWidget(title, blackColor, context, 15.0),
      const SizedBox(height: 5.0,),
      Container(
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: whiteColor
        ),
        child: Center(child:
        buildTextBoldWidget(count, blackColor, context, 16.0,align: TextAlign.center)),
      ),
      const SizedBox(height: 10.0,),
    ],
  );
}

buildPaymentBoxDesign(BuildContext context,String title, String count){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height/5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      image: const DecorationImage(
        image: AssetImage("assets/card.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTextBoldWidget(title, blackColor, context, 15.0,align: TextAlign.center),
        const SizedBox(height: 5.0,),
        buildTextRegularWidget(count, blackColor, context, 14.0,align: TextAlign.center),
      ],
    ),
  );
}