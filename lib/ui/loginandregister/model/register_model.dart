// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String status;
  String message;
  String mobile;
  int otp;
  String userid;

  RegisterModel({
    required this.status,
    required this.message,
    required this.mobile,
    required this.otp,
    required this.userid,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"],
    message: json["message"],
    mobile: json["mobile"],
    otp: json["otp"],
    userid: json["userid"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "mobile": mobile,
    "otp": otp,
    "userid": userid,
  };
}
