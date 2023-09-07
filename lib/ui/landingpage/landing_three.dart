import 'package:eat/constants/middleware.dart';
import 'package:eat/constants/string_constant.dart';
import 'package:flutter/material.dart';

import '../../constants/route_const.dart';

class LandingThreePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LandingThreePageState();
  }

}
class LandingThreePageState extends State<LandingThreePage>{
  MiddleWare middleWare = MiddleWare();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(width: MediaQuery.of(context).size.width,decoration: BoxDecoration(color: middleWare.uiBetaColor,),
        child: Stack(children: [
        Container(height: MediaQuery.of(context).size.height/2.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: middleWare.uiBetaColor,
                image: DecorationImage(
                    image: AssetImage('assets/images/landing_three_bg.png'),
                    fit: BoxFit.fill)),

            child: Container(margin: EdgeInsets.all(20),alignment: Alignment.center,
              child: Text(landing_three_text,style: middleWare.customTextStyle(19, Colors.black, FontWeight.bold),textAlign: TextAlign.center),)),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),height: (MediaQuery.of(context).size.height/1.5)-30,width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft: Radius.circular(60))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                Container(child: Image.asset("assets/images/landing_three.png",width: 250,height: 200,),),
                getStartedButton(),
              ],)

            ],)),
      ],),),
    );
  }
  Container getStartedButton() {
    return Container(
      margin: EdgeInsets.only(
        top: middleWare.minimumPadding * 4,
        // bottom: middleWare.minimumPadding * 5,
        left: middleWare.minimumPadding * 4,
        right: middleWare.minimumPadding * 4,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: middleWare.uiThemeColor,
          foregroundColor: middleWare.uiThemeColor,
          padding: EdgeInsets.only(
            top: middleWare.minimumPadding * 3,
            bottom: middleWare.minimumPadding * 3,
            left: middleWare.minimumPadding *
                7,
            right: middleWare.minimumPadding * 7,
          ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getStarted,
                style: middleWare.customTextStyle(
                    17.00, Colors.white, FontWeight.bold)),
            SizedBox(
              width: 8,
            ),
            // ViewState.BUSY == ViewState.BUSY
            //     ? Container(
            //   width: 25,
            //   height: 25,
            //   child: CircularProgressIndicator(
            //     valueColor:
            //     new AlwaysStoppedAnimation<Color>(Colors.white),
            //   ),
            // )
            //     : Container()
          ],
        ),
        onPressed: (){
          Navigator.pushNamed(context, RoutePaths.MobileVerification);
        },
      ),
    );
  }

}