import 'package:eat/constants/middleware.dart';
import 'package:eat/services/api/eat_apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../base_model.dart';
import '../../../common_providers/connectivity_service.dart';
import '../../../constants/shared_preference_const.dart';
import '../../../constants/shared_preference_helper.dart';

class LoginViewModel extends BaseModel {
  late EatApis eatApis;
  MiddleWare middleWare = MiddleWare();
  late ConnectivityService connectivityService;

  LoginViewModel({required this.eatApis});
  showNetworkStatus(BuildContext context1) {
    try {
      connectivityService =
          ConnectivityService(context: context1, isCurrent: true);
      connectivityService.connectionStatusController.stream
          .listen((event) async {});
    } catch (e)
    {

      print(e);
    }
  }

  Future<bool> register(BuildContext context, String mobile) async {
    setState(ViewState.BUSY);
    var result =
    await eatApis.callRegister(context, mobile.trim());
    if (result != null && result.status == "success") {
      await PreferenceHelper.setString(PreferenceConst.otpText, result.otp.toString().trim());

      // await PreferenceHelper.setBool(PreferenceConst.isUserLogin, true);
      // await PreferenceHelper.setString(
      //     PreferenceConst.userId, result?.userId ?? "");
      // await PreferenceHelper.setString(PreferenceConst.userEmail, email);
      // await PreferenceHelper.setString(
      //     PreferenceConst.token, result?.token ?? "");
      // await PreferenceHelper.setString(
      //     PreferenceConst.tfa_status, result.kycstatus.toString());
      setState(ViewState.IDLE);
      return true;
    } else {
      setState(ViewState.IDLE);
      middleWare.showToastMsg(
          middleWare.validString(result?.message ?? ""), 13.00,
          Colors.red, Colors.yellow, Toast.LENGTH_SHORT);
      return false;
    }
  }

  Future<bool> otpVerify(BuildContext context, String mobile, String otp) async {
    setState(ViewState.BUSY);
    var result = await eatApis.otpVerify(context, mobile.trim(),otp.trim());
    if (result != null && result.status == "success") {
      await PreferenceHelper.setBool(PreferenceConst.isUserLogin, true);
      await PreferenceHelper.setString(PreferenceConst.token, result.data[0].token);
      await PreferenceHelper.setString(PreferenceConst.userId, result.data[0].id);
      // await PreferenceHelper.setString(
      //     PreferenceConst.userId, result?.userId ?? "");
      // await PreferenceHelper.setString(PreferenceConst.userEmail, email);
      // await PreferenceHelper.setString(
      //     PreferenceConst.token, result?.token ?? "");
      // await PreferenceHelper.setString(
      //     PreferenceConst.tfa_status, result.kycstatus.toString());
      setState(ViewState.IDLE);
      return true;
    } else {
      setState(ViewState.IDLE);
      middleWare.showToastMsg(
          middleWare.validString(result?.message ?? ""), 13.00,
          Colors.red, Colors.yellow, Toast.LENGTH_SHORT);
      // middleWare.showToastMsg(
      //     middleWare.validString("failed"), 13.00,
      //     Colors.red, Colors.yellow, Toast.LENGTH_SHORT);
      return false;
    }
  }

}
