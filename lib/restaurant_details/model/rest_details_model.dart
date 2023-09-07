// To parse this JSON data, do
//
//     final restaurantDetailsModel = restaurantDetailsModelFromJson(jsonString);

import 'dart:convert';

RestaurantDetailsModel restaurantDetailsModelFromJson(str) => RestaurantDetailsModel.fromJson(json.decode(str));

String restaurantDetailsModelToJson(RestaurantDetailsModel data) => json.encode(data.toJson());

class RestaurantDetailsModel {
  String status;
  String message;
  Data data;

  RestaurantDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) => RestaurantDetailsModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  List<CookDetail> cookDetails;
  String prebooking;
  String foodCategory;
  List<FoodDetail> foodDetails;

  Data({
    required this.cookDetails,
    required this.prebooking,
    required this.foodCategory,
    required this.foodDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cookDetails: List<CookDetail>.from(json["Cook_Details"].map((x) => CookDetail.fromJson(x))),
    prebooking: json["Prebooking"],
    foodCategory: json["Food_Category"],
    foodDetails: List<FoodDetail>.from(json["Food_Details"].map((x) => FoodDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Cook_Details": List<dynamic>.from(cookDetails.map((x) => x.toJson())),
    "Prebooking": prebooking,
    "Food_Category": foodCategory,
    "Food_Details": List<dynamic>.from(foodDetails.map((x) => x.toJson())),
  };
}

class CookDetail {
  String kname;
  String ktype;
  String address;
  String kcuisines;
  String kitchenpic;
  String bannerpic;

  CookDetail({
    required this.kname,
    required this.ktype,
    required this.address,
    required this.kcuisines,
    required this.kitchenpic,
    required this.bannerpic
  });

  factory CookDetail.fromJson(Map<String, dynamic> json) => CookDetail(
    kname: json["kname"],
    ktype: json["ktype"],
    address: json["address"],
    kcuisines: json["kcuisines"],
    kitchenpic: json["kitchenpic"],
    bannerpic: json["bannerpic"],
  );

  Map<String, dynamic> toJson() => {
    "kname": kname,
    "ktype": ktype,
    "address": address,
    "kcuisines": kcuisines,
    "kitchenpic": kitchenpic,
    "bannerpic": bannerpic,
  };
}

class FoodDetail {
  String kname;
  String? ktype;
  String? address;
  String? kcuisines;
  String? id;
  String? kmobile;
  String? cookid;
  String? foodname;
  String? fooddes;
  String? availqty;
  int? qty;
  String? foodpic;
  String? foodtime;
  String? type;
  String? price;
  String? review;
  String? status;
  DateTime? created;
  String? modified;
  String? totalorders;

  FoodDetail({
    required this.kname,
    this.ktype,
    this.address,
    this.kcuisines,
    this.id,
    this.kmobile,
    this.cookid,
    this.foodname,
    this.fooddes,
    this.availqty,
    this.foodpic,
    this.foodtime,
    this.type,
    this.price,
    this.review,
    this.status,
    this.created,
    this.modified,
    this.totalorders,
    this.qty
  });

  factory FoodDetail.fromJson(Map<String, dynamic> json) => FoodDetail(
    kname: json["kname"],
    ktype: json["ktype"],
    address: json["address"],
    kcuisines: json["kcuisines"],
    id: json["id"],
    kmobile: json["kmobile"],
    cookid: json["cookid"],
    foodname: json["foodname"],
    fooddes: json["fooddes"],
    availqty: json["availqty"],
    foodpic: json["foodpic"],
    foodtime: json["foodtime"],
    type: json["type"],
    price: json["price"],
    review: json["review"],
    status: json["status"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    modified: json["modified"],
    totalorders: json["totalorders"],
    qty: 0
  );

  Map<String, dynamic> toJson() => {
    "kname": kname,
    "ktype": ktype,
    "address": address,
    "kcuisines": kcuisines,
    "id": id,
    "kmobile": kmobile,
    "cookid": cookid,
    "foodname": foodname,
    "fooddes": fooddes,
    "availqty": availqty,
    "foodpic": foodpic,
    "foodtime": foodtime,
    "type": type,
    "price": price,
    "review": review,
    "status": status,
    "created": created?.toIso8601String(),
    "modified": modified,
    "totalorders": totalorders,
    "qty": qty
  };
}
