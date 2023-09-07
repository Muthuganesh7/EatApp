// To parse this JSON data, do
//
//     final otpVerifyModel = otpVerifyModelFromJson(jsonString);

import 'dart:convert';

OtpVerifyModel otpVerifyModelFromJson(str) => OtpVerifyModel.fromJson(json.decode(str));

String otpVerifyModelToJson(OtpVerifyModel data) => json.encode(data.toJson());

class OtpVerifyModel {
  String status;
  String message;
  List<Datum> data;

  OtpVerifyModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OtpVerifyModel.fromJson(Map<String, dynamic> json) => OtpVerifyModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String userid;
  String mobile;
  String token;

  Datum({
    required this.id,
    required this.userid,
    required this.mobile,
    required this.token,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userid: json["userid"],
    mobile: json["mobile"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "mobile": mobile,
    "token": token,
  };
}
