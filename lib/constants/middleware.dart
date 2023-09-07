import 'dart:convert';
import 'dart:core';

import 'package:eat/constants/route_const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
class MiddleWare {
  static final MiddleWare _middleWare = MiddleWare._internal();

  factory MiddleWare() {
    return _middleWare;
  }

  MiddleWare._internal();

  static const String APP_VERSION = '1.0.0';

  static const String APP_NAME = 'Lc Pay';

  // ignore: non_constant_identifier_names
  static int CONNECT_TIMEOUT = 20;

  Color uiPacificBlueColor = Color(0xff1B8AD6);
  Color uiDarkCeruleanColor = Color(0xff0C5180);
  Color uiAliceBlueColor = Color(0xffF4F7FA);

  Color uiLightGreyColor = Color(0xffe1e1e1);
  Color uiNordicColor = Color(0xff002F34);
  Color uiRoyalBlueColor = Color(0xff2A65EA);
  Color uiTangerineYellowColor = Color(0xffFFCC00);
  Color uiFordGrayColor = Color(0xff979797);
  Color uiSailColor = Color(0xffA4D0EF);

  Color themeTransparent = Color(0xffFADEBB);
  Color uiThemeColor = Color(0xff0e360c);
  Color uiBetaColor = Color(0xffd5d5d5);
  Color uiBlueColor = Color(0xff360756);
  Color uiTextColor = Color(0xff000000);
  Color uiLightTextColor = Color(0xff205072);
  Color uiLightTextColor2 = Color(0xff20649f);
  Color uiRedColor = Color(0xffFF0000);
  Color uiGreenColor = Color(0xff10BE74);

  double margin5 = 5.0;
  double margin10 = 10.0;
  double margin15 = 15.0;
  double margin20 = 20.0;
  double margin25 = 25.0;
  double margin30 = 30.0;
  double margin40 = 40.0;
  double margin50 = 50.0;
  double margin60 = 60.0;
  double margin70 = 70.0;
  double margin80 = 80.0;
  double margin90 = 90.0;
  double margin100 = 100.0;
  double margin150 = 150.0;
  double margin200 = 200.0;
  double margin300 = 300.0;
  double margin400 = 400.0;
  double minimumPadding = 5.0;

  bool isApiLoading = false;

  String strRupeeCurrency = "\u20B9";

  String strDollarCurrency = "\$";

  var placeholder = AssetImage('assets/images/launcher_icon.png');
  var placeHolderPath = "assets/images/launcher_icon.png";

  bool isFirstToast = false;

  int compressImage = 30;

  String strOfflineMsg = "You are offline. Check your connection!!!";
  String strSorrySomethingWentWrong = "Sorry, something went wrong";
  String strLoadingPleaseWait = "Loading,Please Wait...";
  String aboutInfinityCXE = "InfinityCXE is A Cryptocurrency exchange build for traders, to win together. InfinityCXE offers innovative products and leverages tokens. We strive to develop a platform robust enough for professional training firms and intuitive enough for first-time users.";

//custom toast message visible to user
  void showToastMsg(String strMsg, double fontSize, Color bgColor,
      Color textColor, Toast toastLength) {
    try {
      if (isFirstToast) {
        Fluttertoast.cancel();
      }

      Fluttertoast.showToast(
          msg: "$strMsg",
          toastLength: toastLength,
          timeInSecForIosWeb: 1,
          backgroundColor: bgColor,
          textColor: textColor,
          fontSize: fontSize);

      isFirstToast = true;
    } catch (e) {
      print(e);
    }
  }
  //check string format
  String validString(String strText) {
    try {
      if (strText == null || strText.trim().isEmpty)
        return "";
      else
        return strText.trim();
    } catch (e) {
      print(e);
    }
    return "";
  }

  //custom textStyle
  TextStyle customTextStyle(
      double fontSize, Color textColor, FontWeight fontWeight) {

    return GoogleFonts.poppins(
        textStyle: TextStyle(
            fontSize: fontSize, color: textColor, fontWeight: fontWeight));
  }

  TextStyle customTextStyleLineThrough(
      double fontSize, Color textColor, FontWeight fontWeight) {

    return GoogleFonts.poppins(
        textStyle: TextStyle(decoration: TextDecoration.lineThrough,
            fontSize: fontSize, color: textColor, fontWeight: fontWeight));
  }

  // custom underlineTextStyle
  TextStyle customLinkTextStyle(
      double fontSize, Color textColor, FontWeight fontWeight) {

    return GoogleFonts.poppins(
        textStyle: TextStyle(decoration: TextDecoration.underline,
            fontSize: fontSize, color: textColor, fontWeight: fontWeight));
  }

  //custom divider with height
  SizedBox putSizedBoxHeight(double value) {
    return SizedBox(
      height: value,
    );
  }
  //divider with color
  Divider putDivider(double value, Color lineColor) {
    return Divider(height: value, color: lineColor);
  }

  //hideKeyBoard function
  void hideKeyBoard(BuildContext context) {
    try {
      FocusScope.of(context).unfocus();
    } catch (e) {
      print(e);
    }
  }
  showLog(message) {
      print("AEL: " + message);
  }

  bottomSheet(BuildContext context,int cartCount,String grandTotal){
    return GestureDetector(onTap: (){
      Navigator.pushNamed(context, RoutePaths.Cart);
    },
        child:Container(
          height: 60,
          margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
          decoration: BoxDecoration(color: uiThemeColor,borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // putSizedBoxWidth(20),
              // ClipRRect(
              //     borderRadius: BorderRadius.all(Radius.circular(20.0)),
              //     child: Stack(
              //       children: <Widget>[
              //         // Image.network(item, fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width),
              //         Image.asset("assets/images/category_image.png", fit: BoxFit.contain, width: 50),
              //       ],
              //     )),
              // putSizedBoxWidth(20),
              Container(margin: EdgeInsets.only(left: 20),child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                getSubText(cartCount),
                getTitleText("₹ $grandTotal"),
              ],)),
              Container(margin: EdgeInsets.only(right: 20),width: MediaQuery.of(context).size.width/1.7,child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    getTitleText("View Cart"),
                    Icon(Icons.arrow_right_alt,color: Colors.white,)]),)
            ],
          ),
        ));
  }
  getSubText(int itemCount){
    return Container(child:
      Text("$itemCount Items",style: customTextStyle(14, Colors.white, FontWeight.normal),),);
  }
  getTitleText(txt){
    return Container(child:
    Text(txt,style: customTextStyle(15, Colors.white, FontWeight.bold),),);
  }
  Column circularProgressIndicator(
      String strText, Color progressColor, Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        /*Padding(
            padding: EdgeInsets.all(minimumPadding * 2),
            child: Text(
              strText,
              style: TextStyle(
                  color: textColor, fontSize: 14.00, fontFamily: 'Roboto'),
            ),
          ),*/
      ],
    );
  }

  //format title
  String capitalizeFirstLetter(String strText) {
    try {
      if (strText == null || strText.trim().isEmpty)
        return "";
      else
        return strText[0].toUpperCase() + strText.substring(1);
    } catch (e) {
      print(e);
    }
    return "";
  }


  //custom divider with width
  SizedBox putSizedBoxWidth(double value) {
    return SizedBox(
      width: value,
    );
  }
//back button press functionality
  void moveToLastScreen(BuildContext context) {
    try {
      Navigator.pop(context, true);

    } catch (e) {
      print(e);
    }
  }
}
