import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../base_model.dart';
import '../../common_providers/connectivity_service.dart';
import '../../constants/middleware.dart';
import '../../constants/shared_preference_const.dart';
import '../../constants/shared_preference_helper.dart';
import '../../services/api/eat_apis.dart';

class RestaurantDetailsViewModel extends BaseModel {
  late EatApis eatApis;
  MiddleWare middleWare = MiddleWare();
  late ConnectivityService connectivityService;

  RestaurantDetailsViewModel({required this.eatApis});
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

  getRestaurantDetails(BuildContext context,String cookId,
      {bool isShowProgress = true}) async {
    try {
      if (await InternetConnectionChecker().hasConnection == true) {
        if (isShowProgress) setState(ViewState.BUSY);

        var result = await eatApis.getRestaurantDetails(context,cookId);
        if (result!=null && result.status == "success") {
          setState(ViewState.IDLE);
          return result;
        } else{
          setState(ViewState.IDLE);
          middleWare.showToastMsg( "Failed", 13.00, Colors.red,
              Colors.yellow, Toast.LENGTH_SHORT);
          return result;
        }
      } else {
        middleWare.showToastMsg("You are Offline", 13.00, Colors.red,
            Colors.yellow, Toast.LENGTH_SHORT);
      }
    } catch (e) {
      print(e);
    }
  }

  addToCart(BuildContext context,String cookId, String foodId, String userId, String qty,
      {bool isShowProgress = true}) async {
    try {
      if (await InternetConnectionChecker().hasConnection == true) {
        // if (isShowProgress) setState(ViewState.BUSY);

        var result = await eatApis.addToCart(context,cookId,foodId,userId,qty);
        if (result!=null && result.status == "success") {
          setState(ViewState.IDLE);
          return true;
        } else{
          setState(ViewState.IDLE);
          middleWare.showToastMsg( "Failed", 13.00, Colors.red,
              Colors.yellow, Toast.LENGTH_SHORT);
          return false;
        }
      } else {
        middleWare.showToastMsg("You are Offline", 13.00, Colors.red,
            Colors.yellow, Toast.LENGTH_SHORT);
      }
    } catch (e) {
      print(e);
    }
  }
  getCartDetails(BuildContext context,String userId,
      {bool isShowProgress = true}) async {
    try {
      if (await InternetConnectionChecker().hasConnection == true) {
        // if (isShowProgress) setState(ViewState.BUSY);

        var result = await eatApis.getCartDetails(context,userId);
        if (result!=null ) {
          setState(ViewState.IDLE);
          return result;
        } else{
          setState(ViewState.IDLE);
          middleWare.showToastMsg( "Failed", 13.00, Colors.red,
              Colors.yellow, Toast.LENGTH_SHORT);
          return result;
        }
      } else {
        middleWare.showToastMsg("You are Offline", 13.00, Colors.red,
            Colors.yellow, Toast.LENGTH_SHORT);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> removeCart(BuildContext context, String foodId, String cartId) async {
    // setState(ViewState.BUSY);
    var result =
    await eatApis.removeCart(context, foodId, cartId);
    if (result != null && result.status == "success") {
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

  Future<bool> removeFullCart(BuildContext context, String cartId) async {
    // setState(ViewState.BUSY);
    var result =
    await eatApis.removeFullCart(context, cartId);
    if (result != null && result.status == "success") {
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


}
