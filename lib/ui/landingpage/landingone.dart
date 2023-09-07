import 'package:eat/constants/middleware.dart';
import 'package:eat/constants/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingOnePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LandingOnePageState();
  }

}
class LandingOnePageState extends State<LandingOnePage>{
  MiddleWare middleWare = MiddleWare();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(width: MediaQuery.of(context).size.width,decoration: BoxDecoration(color: middleWare.uiBetaColor),child: Column(children: [
        Container(height: MediaQuery.of(context).size.height/3,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(color: middleWare.uiBetaColor),
        child: Container(margin: EdgeInsets.all(20),alignment: Alignment.center,
          child: Text(landing_one_text,style: middleWare.customTextStyle(19, Colors.black, FontWeight.bold),textAlign: TextAlign.center),)),
        Container(height: (MediaQuery.of(context).size.height/1.5)-30,width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft: Radius.circular(60))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Container(child: Image.asset("assets/images/landingone_image.png"),)],)),
      ],),),
    );
  }

}