// To parse this JSON data, do
//
//     final cartDetailsModel = cartDetailsModelFromJson(jsonString);

import 'dart:convert';

CartDetailsModel cartDetailsModelFromJson(str) => CartDetailsModel.fromJson(json.decode(str));

String cartDetailsModelToJson(CartDetailsModel data) => json.encode(data.toJson());

class CartDetailsModel {
  String status;
  String message;
  Data data;

  CartDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CartDetailsModel.fromJson(Map<String, dynamic> json) => CartDetailsModel(
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
  List<Cartfooddetails> cartfooddetails;
  String cartbaseid;
  List<CartUserdetails> cartUserdetails;
  List<Carttotals> carttotal;

  Data({
    required this.cartfooddetails,
    required this.cartbaseid,
    required this.cartUserdetails,
    required this.carttotal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cartfooddetails: List<Cartfooddetails>.from(json["Cartfooddetails"].map((x) => Cartfooddetails.fromJson(x))),
    cartbaseid: json["Cartbaseid"],
    cartUserdetails: List<CartUserdetails>.from(json["Cart_Userdetails"].map((x) => CartUserdetails.fromJson(x))),
    carttotal: List<Carttotals>.from(json["Carttotal"].map((x) => Carttotals.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Cartfooddetails": List<dynamic>.from(cartfooddetails.map((x) => x.toJson())),
    "Cartbaseid": cartbaseid,
    "Cart_Userdetails": List<dynamic>.from(cartUserdetails.map((x) => x.toJson())),
    "Carttotal": List<dynamic>.from(carttotal.map((x) => x.toJson())),
  };
}

class CartUserdetails {
  String id;
  String userid;
  String mobile;
  String token;
  DateTime tokenexp;
  String plot;
  String address;
  String city;
  String state;
  String pincode;

  CartUserdetails({
    required this.id,
    required this.userid,
    required this.mobile,
    required this.token,
    required this.tokenexp,
    required this.plot,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
  });

  factory CartUserdetails.fromJson(Map<String, dynamic> json) => CartUserdetails(
    id: json["id"],
    userid: json["userid"],
    mobile: json["mobile"],
    token: json["token"],
    tokenexp: DateTime.parse(json["tokenexp"]),
    plot: json["plot"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "mobile": mobile,
    "token": token,
    "tokenexp": tokenexp.toIso8601String(),
    "plot": plot,
    "address": address,
    "city": city,
    "state": state,
    "pincode": pincode,
  };
}

class Cartfooddetails {
  String id;
  String foodname;
  String fooddes;
  String foodpic;
  String type;
  String price;
  String review;
  String qty;
  String cookid;

  Cartfooddetails({
    required this.id,
    required this.foodname,
    required this.fooddes,
    required this.foodpic,
    required this.type,
    required this.price,
    required this.review,
    required this.qty,
    required this.cookid,
  });

  factory Cartfooddetails.fromJson(Map<String, dynamic> json) => Cartfooddetails(
    id: json["id"],
    foodname: json["foodname"],
    fooddes: json["fooddes"],
    foodpic: json["foodpic"],
    type: json["type"],
    price: json["price"],
    review: json["review"],
    qty: json["qty"],
    cookid: json["cookid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "foodname": foodname,
    "fooddes": fooddes,
    "foodpic": foodpic,
    "type": type,
    "price": price,
    "review": review,
    "qty": qty,
    "cookid": cookid,
  };
}

class Carttotals {
  String? cartitemtotal;
  String? totalprice;
  String? packingfee;
  String? deliveryfee;
  String? tax;
  int? grandtotal;

  Carttotals({
    this.cartitemtotal,
    this.totalprice,
    this.packingfee,
    this.deliveryfee,
    this.tax,
    this.grandtotal,
  });

  factory Carttotals.fromJson(Map<String, dynamic> json) => Carttotals(
    cartitemtotal: json["cartitemtotal"],
    totalprice: json["totalprice"],
    packingfee: json["packingfee"],
    deliveryfee: json["deliveryfee"],
    tax: json["tax"],
    grandtotal: json["grandtotal"],
  );

  Map<String, dynamic> toJson() => {
    "cartitemtotal": cartitemtotal,
    "totalprice": totalprice,
    "packingfee": packingfee,
    "deliveryfee": deliveryfee,
    "tax": tax,
    "grandtotal": grandtotal,
  };
}
