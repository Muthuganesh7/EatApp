// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  String status;
  String message;
  Data data;

  HomeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
  List<AppSlider> appSlider;
  List<ListofFood> listofPrebookingFoods;
  List<ListofKitchen> listofKitchens;
  List<ListofFood> listofPopularfoods;
  List<ListofFood> listofRecentfoods;

  Data({
    required this.appSlider,
    required this.listofPrebookingFoods,
    required this.listofKitchens,
    required this.listofPopularfoods,
    required this.listofRecentfoods,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    appSlider: List<AppSlider>.from(json["App_slider"].map((x) => AppSlider.fromJson(x))),
    listofPrebookingFoods: List<ListofFood>.from(json["Listof_prebooking_foods"].map((x) => ListofFood.fromJson(x))),
    listofKitchens: List<ListofKitchen>.from(json["Listof_Kitchens"].map((x) => ListofKitchen.fromJson(x))),
    listofPopularfoods: List<ListofFood>.from(json["Listof_Popularfoods"].map((x) => ListofFood.fromJson(x))),
    listofRecentfoods: List<ListofFood>.from(json["Listof_Recentfoods"].map((x) => ListofFood.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "App_slider": List<dynamic>.from(appSlider.map((x) => x.toJson())),
    "Listof_prebooking_foods": List<dynamic>.from(listofPrebookingFoods.map((x) => x.toJson())),
    "Listof_Kitchens": List<dynamic>.from(listofKitchens.map((x) => x.toJson())),
    "Listof_Popularfoods": List<dynamic>.from(listofPopularfoods.map((x) => x.toJson())),
    "Listof_Recentfoods": List<dynamic>.from(listofRecentfoods.map((x) => x.toJson())),
  };
}

class AppSlider {
  String image;

  AppSlider({
    required this.image,
  });

  factory AppSlider.fromJson(Map<String, dynamic> json) => AppSlider(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}

class ListofKitchen {
  String kitchenpic;
  String kname;
  String cookid;
  String address;
  String city;
  String state;
  String country;
  String pincode;

  ListofKitchen({
    required this.kitchenpic,
    required this.kname,
    required this.cookid,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
  });

  factory ListofKitchen.fromJson(Map<String, dynamic> json) => ListofKitchen(
    kitchenpic: json["kitchenpic"],
    kname: json["kname"]!,
    cookid: json["cookid"]!,
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "kitchenpic": kitchenpic,
    "kname": kname,
    "cookid": cookid,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "pincode": pincode,
  };
}

class ListofFood {
  String id;
  String cookid;
  String kname;
  String foodname;
  String foodpic;
  String type;
  String availqty;
  String? review;
  String? fromdate;
  String? todate;

  ListofFood({
    required this.id,
    required this.cookid,
    required this.kname,
    required this.foodname,
    required this.foodpic,
    required this.type,
    required this.availqty,
    this.review,
    this.fromdate,
    this.todate,
  });

  factory ListofFood.fromJson(Map<String, dynamic> json) => ListofFood(
    id: json["id"],
    cookid: json["cookid"]!,
    kname: json["kname"]!,
    foodname: json["foodname"],
    foodpic: json["foodpic"],
    type: json["type"]!,
    availqty: json["availqty"],
    review: json["review"],
    fromdate: json["fromdate"],
    todate: json["todate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cookid": cookid,
    "kname": kname,
    "foodname": foodname,
    "foodpic": foodpic,
    "type": type,
    "availqty": availqty,
    "review": review,
    "fromdate": fromdate,
    "todate": todate,
  };
}


