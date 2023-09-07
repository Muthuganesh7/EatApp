import 'dart:math';

import 'package:eat/constants/middleware.dart';
import 'package:eat/constants/shared_preference_const.dart';
import 'package:eat/constants/shared_preference_helper.dart';
import 'package:eat/ui/loginandregister/view_model/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../../base_model.dart';
import '../../../base_widget.dart';
import '../../../constants/route_const.dart';
import '../../../constants/string_constant.dart';
import '../../../services/api/eat_apis.dart';

class OtpPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OtpPageState();
  }

}
class OtpPageState extends State<OtpPage>{
  MiddleWare middleWare = MiddleWare();
  String otpText = "";
  String mobileNo = "";
  OtpFieldController otpController = OtpFieldController();

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }
  getSharedPreferences() async {
    mobileNo = await PreferenceHelper.getString(PreferenceConst.mobileNo);
    otpText = await PreferenceHelper.getString(PreferenceConst.otpText);
    otpController.setValue(otpText[0], 0);
    otpController.setValue(otpText[1], 1);
    otpController.setValue(otpText[2], 2);
    otpController.setValue(otpText[3], 3);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Builder(
          builder: (BuildContext context1) => BaseWidgetWithNetworkConnectivity<LoginViewModel>(
            key: Key('login'),

            model: LoginViewModel(
                eatApis : Provider.of<EatApis>(context, listen: false)),
            onModelReady: (model) => model.showNetworkStatus(context1),
            builder: (context, model, child) => SafeArea(
              child: getMainContainer(model),
            ),
          ),
        )
    );
  }
  getMainContainer(LoginViewModel model) {
    return  Stack(children: [SingleChildScrollView(child: Container(width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: middleWare.uiBetaColor,),
      child: Stack(children: [
        Container(height: MediaQuery.of(context).size.height/2.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: middleWare.uiBetaColor,
                image: DecorationImage(
                    image: AssetImage('assets/images/otp_bg.png',),
                    fit: BoxFit.fill)),
            child: Container(margin: EdgeInsets.all(20),alignment: Alignment.center,
              child: Text(verification,style: middleWare.customTextStyle(19, Colors.black, FontWeight.bold),textAlign: TextAlign.center),)),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3,),
            height: (MediaQuery.of(context).size.height/1.5)-30,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft: Radius.circular(60))),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
              Container(child: getOtpTextField()),
              getStartedButton(model),
            ],)),
      ],),),),
    model.state == ViewState.BUSY ? Container(color: Colors.white.withOpacity(0.5),child: Center(
    child:
    Lottie.asset(
    'assets/images/loader.json',
    height: 150.0,
    repeat: true,
    reverse: true,
    animate: true,
    ))
    ,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,) : Container()],);
  }
  Container getStartedButton(LoginViewModel model) {
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
            left: middleWare.minimumPadding * 7,
            right: middleWare.minimumPadding * 7,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(submitText, style: middleWare.customTextStyle(17.00, Colors.white, FontWeight.bold)),
            SizedBox(width: 8,),
          ],
        ),
        onPressed: () async {
          if(otpText.length < 4){
            middleWare.showToastMsg(
                middleWare.validString("Plase Enter Valid OTP"), 13.00,
                Colors.red, Colors.yellow, Toast.LENGTH_SHORT);
          }else{
            bool isOtpVerify = await model.otpVerify(context, mobileNo,otpText);
            if(isOtpVerify){
              Navigator.pushNamed(context, RoutePaths.RegisterSuccess);
            }
          }
        },
      ),
    );
  }
  getOtpTextField(){
    return Container(padding: EdgeInsets.all(5),child: OTPTextField(
      length: 4,
      width: MediaQuery.of(context).size.width,
      controller: otpController,
      fieldWidth: 55,
      style: TextStyle(
          fontSize: 14
      ),
      textFieldAlignment: MainAxisAlignment.spaceEvenly,
      fieldStyle: FieldStyle.box,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          otpText = pin;
        });
      },
    ));
  }

}
