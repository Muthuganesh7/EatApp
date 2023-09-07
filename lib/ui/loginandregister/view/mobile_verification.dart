import 'package:eat/constants/middleware.dart';
import 'package:eat/constants/shared_preference_const.dart';
import 'package:eat/constants/string_constant.dart';
import 'package:eat/services/api/eat_apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../base_model.dart';
import '../../../base_widget.dart';
import '../../../constants/route_const.dart';
import '../../../constants/shared_preference_helper.dart';
import '../view_model/register_view_model.dart';

class MobileNumberVerification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MobileNumberVerificationState();
  }

}
class MobileNumberVerificationState extends State<MobileNumberVerification>{
  MiddleWare middleWare = MiddleWare();
  TextEditingController phoneNumberController = TextEditingController();
  var _mobileKey = GlobalKey<FormState>();
  late EatApis eatApis;
  @override
  void initState() {
    super.initState();
    try {
      Future.delayed(Duration.zero, () {
        middleWare.hideKeyBoard(context);
        eatApis = Provider.of<EatApis>(context, listen: false);
      });
    } catch (e) {
      print(e);
    }
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
    ));
  }
  getMainContainer(LoginViewModel model){
    return WillPopScope(child: SingleChildScrollView(child: Stack(children: [ Container(width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: middleWare.uiBetaColor,),child: Stack(children: [
        Container(height: MediaQuery.of(context).size.height/2.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: middleWare.uiBetaColor,
                image: DecorationImage(
                    image: AssetImage('assets/images/mobile_verify_bg.png',),
                    fit: BoxFit.fill)),

            child: Container(margin: EdgeInsets.all(20),alignment: Alignment.center,
              child: Text(loginDescription,style: middleWare.customTextStyle(19, Colors.black, FontWeight.bold),textAlign: TextAlign.center),)),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3,),height: (MediaQuery.of(context).size.height/1.5)-30,width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft: Radius.circular(60))),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center,children: [
              Form(key: _mobileKey, child:Container(child: getMobileController())),
              getStartedButton(model),
            ],)),
      ],),),
      model.state == ViewState.BUSY ? Container(color: Colors.white.withOpacity(0.5),child: Center(
          child:
          Lottie.asset(
            'assets/images/loader.json',
            height: 150.0,
            repeat: true,
            reverse: true,
            animate: true,
          ))
        ,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,) : Container()

    ],)), onWillPop: () async{
      onBackPressed();
      return false;
    },) ;
  }
  Container getMobileController() {
    return Container(
      margin: EdgeInsets.only(
        left: middleWare.minimumPadding * 4,
        right: middleWare.minimumPadding * 4,
      ),
      child: Opacity(
        opacity: 0.8,

        child: TextFormField(
          style: middleWare.customTextStyle(
              14.00, middleWare.uiTextColor, FontWeight.bold),
          controller: phoneNumberController,
          keyboardType: TextInputType.number,
          validator: (value) {
            value = value ?? "";
            if (value
                .trim()
                .isEmpty) {
              return "Please enter mobile number";
            } else if (value
                .trim()
                .length != 10) {
              return "Please enter valid mobile number";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Mobile number",
            hintStyle: middleWare.customTextStyle(
                14.00, middleWare.uiFordGrayColor, FontWeight.normal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: middleWare.uiLightTextColor),
            ),
          ),
          /*onChanged: onSearchTextChanged,*/
        ),
        // ),
      ),
    );
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
            left: middleWare.minimumPadding *
                7,
            right: middleWare.minimumPadding * 7,
          ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getOtp,
                style: middleWare.customTextStyle(
                    17.00, Colors.white, FontWeight.bold)),
            SizedBox(
              width: 8,
            ),
            middleWare.isApiLoading == true
                ? Container(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Container()
          ],
        ),
        onPressed: () async {
    if (_mobileKey.currentState != null &&
    _mobileKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      bool isRegister = await model.register(context, phoneNumberController.text.trim());
      if(isRegister){
        PreferenceHelper.setString(PreferenceConst.mobileNo, phoneNumberController.text.trim());

        Navigator.pushNamed(context, RoutePaths.OtpVerification);
      }
    }else{

    }
          // Navigator.pushNamed(context, RoutePaths.OtpVerification);
        },
      ),
    );
  }
  onBackPressed(){
    showAlertDialog(context);
  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Exit"),
      onPressed:  () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Eat"),
      content: Text("Would you like to want to exit?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
