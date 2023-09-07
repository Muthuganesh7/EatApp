import 'dart:async';
import 'dart:io';
import 'package:eat/cart/model/remove_cart_model.dart';
import 'package:eat/home/model/home_model.dart';
import 'package:eat/restaurant_details/model/rest_details_model.dart';
import 'package:eat/ui/loginandregister/model/otp_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../../cart/model/add_to_cart_model.dart';
import '../../cart/model/cart_model.dart';
import '../../constants/api_param_const.dart';
import '../../constants/api_url_const.dart';
import '../../constants/middleware.dart';
import '../../constants/shared_preference_const.dart';
import '../../constants/shared_preference_helper.dart';
import '../../ui/loginandregister/model/register_model.dart';
import 'package:http/http.dart' as http;
import 'api_helper.dart';

class EatApis {
  late ApiHandler apiHandler;
  MiddleWare middleWare = MiddleWare();

  EatApis({required this.apiHandler});

  Future<String> get userId async =>
      await PreferenceHelper.getString(PreferenceConst.userId);


  Future<RegisterModel> callRegister(BuildContext context, String mobile) async {
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl + methodSignup));
    request.fields[MOBILE_KEY] = mobile;
    var result = await apiHandler.requestRestApi(context,request);
    return compute(registerModelFromJson, result);
  }

  Future<OtpVerifyModel> otpVerify(BuildContext context, String mobile, String otp) async {
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl + methodOtpVerify));
    request.fields[MOBILE_KEY] = mobile;
    request.fields[OTP_KEY] = otp;
    var result = await apiHandler.requestRestApi(context,request);
    return compute(otpVerifyModelFromJson, result);
  }

  Future<HomeModel> getDashboardDetails(BuildContext context) async {
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl + methodGetDashboardDetails));
    String token = await PreferenceHelper.getString(PreferenceConst.token);
    request.fields[TOKEN_KEY] = token;
    print("Request Fields ${request.fields}");
    var result = await apiHandler.requestRestApi(context,request);
    return compute(homeModelFromJson, result);
  }

  Future<RestaurantDetailsModel> getRestaurantDetails(BuildContext context,String cookId) async {
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl + methodGetRestaurantDetails));
    String token = await PreferenceHelper.getString(PreferenceConst.token);
    request.fields[TOKEN_KEY] = token;
    request.fields[COOKID_KEY] = cookId;
    request.fields[CURRENT_TIME_KEY] = DateTime.now().toString();
    print("Request Fields ${request.fields}");
    var result = await apiHandler.requestRestApi(context,request);
    return compute(restaurantDetailsModelFromJson, result);
  }

  Future<AddToCartModel> addToCart(BuildContext context,String cookId,String foodId,String userId,String qty) async {
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl + methodAddToCart));
    String token = await PreferenceHelper.getString(PreferenceConst.token);
    request.fields[TOKEN_KEY] = token;
    request.fields[COOKID_KEY] = cookId;
    request.fields[FOOD_ID] = foodId;
    request.fields[USER_ID] = userId;
    request.fields[QTY] = qty;
    print("Request Fields ${request.fields}");
    var result = await apiHandler.requestRestApi(context,request);
    return compute(addToCartModelFromJson, result);
  }

  Future<RemoveCartModel> removeCart(BuildContext context,String foodId,String cartId) async {
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl + methodRemoveCart));
    String token = await PreferenceHelper.getString(PreferenceConst.token);
    request.fields[TOKEN_KEY] = token;
    request.fields[FOOD_ID] = foodId;
    request.fields[CART_ID] = cartId;
    print("Request Fields ${request.fields}");
    var result = await apiHandler.requestRestApi(context,request);
    return compute(removeCartModelFromJson, result);
  }

  Future<RemoveCartModel> removeFullCart(BuildContext context,String cartId) async {
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl + methodRemoveCart));
    String token = await PreferenceHelper.getString(PreferenceConst.token);
    request.fields[TOKEN_KEY] = token;
    request.fields[CART_ID] = cartId;
    print("Request Fields ${request.fields}");
    var result = await apiHandler.requestRestApi(context,request);
    return compute(removeCartModelFromJson, result);
  }


  Future<RemoveCartModel> placeOrder(BuildContext context,String userId,String cartId,String paymentMood) async {
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl + methodPlaceOrder));
    String token = await PreferenceHelper.getString(PreferenceConst.token);
    request.fields[TOKEN_KEY] = token;
    request.fields[USER_ID] = userId;
    request.fields[CART_ID] = cartId;
    request.fields[PAYMENT_MOOD] = paymentMood;
    print("Request Fields ${request.fields}");
    var result = await apiHandler.requestRestApi(context,request);
    return compute(removeCartModelFromJson, result);
  }

  Future<CartDetailsModel> getCartDetails(BuildContext context,String userId) async {
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl + methodGetCartDetails));
    String token = await PreferenceHelper.getString(PreferenceConst.token);
    request.fields[TOKEN_KEY] = token;
    request.fields[USER_ID] = userId;
    print("Request Fields ${request.fields}");
    var result = await apiHandler.requestRestApi(context,request);
    return compute(cartDetailsModelFromJson, result);
  }


}
