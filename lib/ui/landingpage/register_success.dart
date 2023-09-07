import 'package:eat/bottom_navigation/bottom_navigation_page.dart';
import 'package:eat/constants/middleware.dart';
import 'package:eat/constants/string_constant.dart';
import 'package:eat/home/view/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterSuccessPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterSuccessPageState();
  }

}
class RegisterSuccessPageState extends State<RegisterSuccessPage>{
  MiddleWare middleWare = MiddleWare();
  @override
  void initState() {
    try {
      super.initState();
      Future.delayed(const Duration(milliseconds: 500), () {
        // middleWare.hideKeyBoard(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => BottomNavigationBarExample()));

      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(width: MediaQuery.of(context).size.width,decoration: BoxDecoration(color: middleWare.uiBetaColor),child: Column(children: [
        Container(height: MediaQuery.of(context).size.height/3,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(color: middleWare.uiBetaColor),
            child: Container(margin: EdgeInsets.all(20),alignment: Alignment.center,
              child: Text(register_success_text,style: middleWare.customTextStyle(19, Colors.black, FontWeight.bold),textAlign: TextAlign.center),)),
        Container(height: (MediaQuery.of(context).size.height/1.5),width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft: Radius.circular(60))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Container(child: Image.asset("assets/images/reg_complete.png"),height: 300,)],)),
      ],),),
    );
  }

}