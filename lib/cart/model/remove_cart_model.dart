import 'dart:convert';

RemoveCartModel removeCartModelFromJson(str) => RemoveCartModel.fromJson(json.decode(str));

String removeCartModelToJson(RemoveCartModel data) => json.encode(data.toJson());

class RemoveCartModel {
  String status;
  String message;

  RemoveCartModel({
    required this.status,
    required this.message,
  });

  factory RemoveCartModel.fromJson(Map<String, dynamic> json) => RemoveCartModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
