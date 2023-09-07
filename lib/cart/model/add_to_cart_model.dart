// To parse this JSON data, do
//
//     final addToCartModel = addToCartModelFromJson(jsonString);

import 'dart:convert';

AddToCartModel addToCartModelFromJson(str) => AddToCartModel.fromJson(json.decode(str));

String addToCartModelToJson(AddToCartModel data) => json.encode(data.toJson());

class AddToCartModel {
  String status;
  String message;
  Data data;

  AddToCartModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
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
  List<Cartfooddetail> cartfooddetails;
  List<CartDetail> cartDetails;
  List<CartUserdetail> cartUserdetails;
  List<Carttotal> carttotal;

  Data({
    required this.cartfooddetails,
    required this.cartDetails,
    required this.cartUserdetails,
    required this.carttotal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cartfooddetails: List<Cartfooddetail>.from(json["Cartfooddetails"].map((x) => Cartfooddetail.fromJson(x))),
    cartDetails: List<CartDetail>.from(json["Cart_Details"].map((x) => CartDetail.fromJson(x))),
    cartUserdetails: List<CartUserdetail>.from(json["Cart_Userdetails"].map((x) => CartUserdetail.fromJson(x))),
    carttotal: List<Carttotal>.from(json["Carttotal"].map((x) => Carttotal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Cartfooddetails": List<dynamic>.from(cartfooddetails.map((x) => x.toJson())),
    "Cart_Details": List<dynamic>.from(cartDetails.map((x) => x.toJson())),
    "Cart_Userdetails": List<dynamic>.from(cartUserdetails.map((x) => x.toJson())),
    "Carttotal": List<dynamic>.from(carttotal.map((x) => x.toJson())),
  };
}

class CartDetail {
  String id;
  String fooddetails;
  String userid;
  String cookid;
  String total;
  String status;

  CartDetail({
    required this.id,
    required this.fooddetails,
    required this.userid,
    required this.cookid,
    required this.total,
    required this.status,
  });

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
    id: json["id"],
    fooddetails: json["fooddetails"],
    userid: json["userid"],
    cookid: json["cookid"],
    total: json["total"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fooddetails": fooddetails,
    "userid": userid,
    "cookid": cookid,
    "total": total,
    "status": status,
  };
}

class CartUserdetail {
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

  CartUserdetail({
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

  factory CartUserdetail.fromJson(Map<String, dynamic> json) => CartUserdetail(
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

class Cartfooddetail {
  String id;
  String foodname;
  String fooddes;
  String foodpic;
  String type;
  String price;
  String review;
  String qty;

  Cartfooddetail({
    required this.id,
    required this.foodname,
    required this.fooddes,
    required this.foodpic,
    required this.type,
    required this.price,
    required this.review,
    required this.qty,
  });

  factory Cartfooddetail.fromJson(Map<String, dynamic> json) => Cartfooddetail(
    id: json["id"],
    foodname: json["foodname"],
    fooddes: json["fooddes"],
    foodpic: json["foodpic"],
    type: json["type"],
    price: json["price"],
    review: json["review"],
    qty: json["qty"],
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
  };
}

class Carttotal {
  String? cartitemtotal;
  String? totalprice;
  String? packingfee;
  String? deliveryfee;
  String? tax;
  int? grandtotal;

  Carttotal({
    this.cartitemtotal,
    this.totalprice,
    this.packingfee,
    this.deliveryfee,
    this.tax,
    this.grandtotal,
  });

  factory Carttotal.fromJson(Map<String, dynamic> json) => Carttotal(
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
