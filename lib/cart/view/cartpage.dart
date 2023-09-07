import 'package:eat/cart/model/cart_model.dart';
import 'package:eat/cart/view_model/cart_view_model.dart';
import 'package:eat/constants/middleware.dart';
import 'package:eat/constants/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../base_model.dart';
import '../../base_widget.dart';
import '../../bottom_navigation/bottom_navigation_page.dart';
import '../../constants/route_const.dart';
import '../../constants/shared_preference_const.dart';
import '../../constants/shared_preference_helper.dart';
import '../../home/view_model/home_view_model.dart';
import '../../restaurant_details/model/rest_details_model.dart';
import '../../services/api/eat_apis.dart';
import '../model/add_to_cart_model.dart';

class CartPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CartPageState();
  }

}
class CartPageState extends State<CartPage>{
  MiddleWare middleWare = MiddleWare();
  int cartCount = 1;
  bool checkedValue = false;
  String userId = "";
  List<Cartfooddetails> cartFooddetails = [];
  List<Carttotals> carttotal = [];
  List<dynamic> fullCartDetails = [];
  String restaurantID = "";
  String cartId = "";
  String itemCount = "",itemTotal = "", packageCharges = "",deliveryCharge = "",taxVal = "",grandTotalVal = "";
  TextEditingController instructionsController = TextEditingController();
  String restaurantName = "",address = "",kcuisines = "",prebooking = "",restImage = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(elevation: 0,automaticallyImplyLeading: false,actions: [
         GestureDetector(child: Container(alignment: Alignment.centerLeft,width: MediaQuery.of(context).size.width,
             child:Row(mainAxisAlignment: MainAxisAlignment.start,children: [
               middleWare.putSizedBoxWidth(20),
               Image.asset("assets/images/previous.png",height: 30,width: 30,fit: BoxFit.fill,),
               middleWare.putSizedBoxWidth(20),
               Text("Cart",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),)
             ])),onTap: (){
           Navigator.pop(context);
         })
      ]),
      body: Builder(
        builder: (BuildContext context1) => BaseWidgetWithNetworkConnectivity<CartViewModel>(
          key: Key('login'),
          model: CartViewModel(
              eatApis : Provider.of<EatApis>(context, listen: false)),
          onModelReady: (model) async {
            getCartDetails(model);

            return true;
          },
          builder: (context, model, child) => SafeArea(
            child: Stack(children: [getMainContainer(model),
              model.state == ViewState.BUSY ? Container(color: Colors.white,child: Center(
                  child:
                  Lottie.asset(
                    'assets/images/loader.json',
                    height: 150.0,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ))
                ,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,) : Container()],)
          ),
        ),
      ),
    );
  }

  getCartDetails(CartViewModel model) async {
    cartFooddetails = [];
    carttotal = [];
    userId = await PreferenceHelper.getString(PreferenceConst.userId);
    CartDetailsModel cartDetailsModel = await model.getCartDetails(context,userId);
    setState(() {
      cartFooddetails = cartDetailsModel.data.cartfooddetails;
      carttotal = cartDetailsModel.data.carttotal;
      restaurantID = cartDetailsModel.data.cartfooddetails[0].cookid;
      cartId = cartDetailsModel.data.cartbaseid;
      itemCount = cartDetailsModel.data.carttotal[0].cartitemtotal.toString();
      itemTotal = cartDetailsModel.data.carttotal[1].totalprice.toString();
      packageCharges = cartDetailsModel.data.carttotal[2].packingfee.toString();
      deliveryCharge = cartDetailsModel.data.carttotal[2].deliveryfee.toString();
      taxVal = cartDetailsModel.data.carttotal[2].tax.toString();
      grandTotalVal = cartDetailsModel.data.carttotal[3].grandtotal.toString();
      getRestaurantDetails(model);
    });
  }

  getMainContainer(CartViewModel model){
    return SingleChildScrollView(child: Column(mainAxisAlignment: MainAxisAlignment.start,children: [
      !restaurantName.isEmpty ? Stack(children: [
        Container(height:150,margin: EdgeInsets.only(top: 20,left: 25,right: 25),
          decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.grey,width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
            Text(restaurantName,style: middleWare.customTextStyle(17, middleWare.uiThemeColor, FontWeight.bold),),
            middleWare.putSizedBoxHeight(10),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Container(child: Image.asset("assets/images/pin.png",height: 20,width: 20,fit: BoxFit.fill,), ),
              middleWare.putSizedBoxWidth(10),
              Text(address,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis)
            ],),
            middleWare.putSizedBoxHeight(10),
            Text(kcuisines,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
          ],),
        ),
        restImage!=null && restImage.isEmpty == false ?
        Container(child:ClipRRect(borderRadius: BorderRadius.all(Radius.circular(50)),child:Image.network(restImage,height: 40,width: 40,fit: BoxFit.fill,)),width: MediaQuery.of(context).size.width,height: 40,alignment: Alignment.center,)
            :Container(child:Image.asset("assets/images/circle.png",height: 40,width: 40,fit: BoxFit.fill,),margin: EdgeInsets.only(top: 130),width: MediaQuery.of(context).size.width,height: 40,alignment: Alignment.center,),
      ],) : Container(),

      Container(child: Text("ITEMS",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
        alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 20,top: 20),),
      getProducts(model),
      middleWare.putSizedBoxHeight(10),
      getViewAddButton(),
      middleWare.putSizedBoxHeight(20),
      getInstructionsController(),
      middleWare.putSizedBoxHeight(20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Container(child: Text(deliveryAddress,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
          alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 20),),
        Row(children: [
          Icon(Icons.edit),
          Container(child: Text("Edit",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
            alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 5,right: 20),),
        ],)
      ],),
      middleWare.putSizedBoxHeight(10),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 10),child: Image.asset("assets/images/pin.png",height: 25,width: 25,),),
        middleWare.putSizedBoxWidth(10),
        Container(width: MediaQuery.of(context).size.width/1.5,child: Text("Thirvalluvara Nagar, Padi Kuppam Annanagar West, Chennai -40",style: middleWare.customTextStyle(14, Colors.black, FontWeight.normal),maxLines: 2,overflow: TextOverflow.ellipsis,))
      ],),

      Container(child: Text("Payment Method",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
        alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 20,top: 20),),
      middleWare.putSizedBoxHeight(10),
      Container(margin:EdgeInsets.only(left: 20,right: 20),padding: EdgeInsets.all(10),child:Row(children: [
        middleWare.putSizedBoxWidth(10),
        Image.asset("assets/images/card.png",width: 25,height: 25,),
        Container(child: Text(payusingcard,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
          alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 20),),
      ],),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),border: Border.all(color: middleWare.uiThemeColor,width: 1)),),

      middleWare.putSizedBoxHeight(10),
      Container(margin:EdgeInsets.only(left: 20,right: 20),padding: EdgeInsets.all(10),child:Row(children: [
        middleWare.putSizedBoxWidth(10),
        Image.asset("assets/images/wallet.png",width: 25,height: 25,),
        Container(child: Text(payusingcash,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
          alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 20),),
      ],),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),border: Border.all(color: middleWare.uiThemeColor,width: 1)),),


      Container(margin:EdgeInsets.only(left: 20,right: 20,top: 20),padding: EdgeInsets.all(10),child:
      Column(children: [

        Container(child: Text(recipt,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
            alignment: Alignment.centerLeft),
        middleWare.putSizedBoxHeight(10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Container(child: Text("$total_item ${itemCount}",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
              alignment: Alignment.centerLeft),

          Container(child: Text("Rs.${itemTotal}",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
            alignment: Alignment.centerLeft,)

        ],),
        middleWare.putSizedBoxHeight(10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Container(child: Text(packing_charges,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
              alignment: Alignment.centerLeft),

          Container(child: Text("${packageCharges}",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
            alignment: Alignment.centerLeft,)

        ],),
        middleWare.putSizedBoxHeight(10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Container(child: Text(deliveryFee,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
              alignment: Alignment.centerLeft),

          Container(child: Text("Rs.${deliveryCharge}",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
            alignment: Alignment.centerLeft,)

        ],),
        middleWare.putSizedBoxHeight(10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Container(child: Text(tax,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
              alignment: Alignment.centerLeft),

          Container(child: Text("Rs.${taxVal}",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
            alignment: Alignment.centerLeft,)

        ],),
        middleWare.putSizedBoxHeight(10),
        Divider(height: 1,color: middleWare.uiThemeColor,),
        middleWare.putSizedBoxHeight(10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Container(child: Text(grandTotal,style: middleWare.customTextStyle(17, middleWare.uiThemeColor, FontWeight.bold),),
              alignment: Alignment.centerLeft),

          Container(child: Text("Rs.${grandTotalVal}",style: middleWare.customTextStyle(17, middleWare.uiThemeColor, FontWeight.bold),),
            alignment: Alignment.centerLeft,)

        ],)


      ],), decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),border: Border.all(color: middleWare.uiThemeColor,width: 1)),),

      middleWare.putSizedBoxHeight(20),

      CheckboxListTile(
        title: Text(acceptTerms,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),),
        value: checkedValue,
        onChanged: (newValue) {
          setState(() {
            checkedValue = newValue!;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
      ),

      middleWare.putSizedBoxHeight(20),
      getplaceOrderButton(model)
    ],),);
  }
  getProducts(CartViewModel model){
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: cartFooddetails.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Column(children: [
                Container(width: 150,child: Text(cartFooddetails[index].foodname,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 2,),),
                middleWare.putSizedBoxHeight(10),
                Container(width: 150,child: Text(cartFooddetails[index].fooddes,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.normal),overflow: TextOverflow.ellipsis,maxLines: 2,),),
                middleWare.putSizedBoxHeight(10),
                Container(width: 150,child: Text("Rs.${cartFooddetails[index].price}",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 2,),),

              ],),
              Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [

          cartFooddetails[index].foodpic != null && !cartFooddetails[index].foodpic.toString().isEmpty ?
          ClipRRect(borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Image.network(cartFooddetails[index].foodpic.toString(),width: 150,height: 100,fit: BoxFit.cover,)) :
          ClipRRect(borderRadius: BorderRadius.all(Radius.circular(15)),
          child:Image.asset("assets/images/slider.png", fit: BoxFit.fill, width: MediaQuery.of(context).size.width),),

                // Container(
                //     margin: EdgeInsets.only(top: 20),
                //     width: 150,alignment: Alignment.center,child:Image.asset("assets/images/category_image.png",height: 80,width: 200,fit: BoxFit.fill,)),
                middleWare.putSizedBoxHeight(10),
                // getCartButton(index)
                int.parse(cartFooddetails[index].qty) > 0 ? getCartButton(index,model) : getAddButton(index,model)
              ],),
            ],),
          );
        }
    );
  }

  Container getCartButton(int index,CartViewModel model) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: middleWare.uiThemeColor,
          foregroundColor: middleWare.uiThemeColor,
          padding: EdgeInsets.only(
            // top: middleWare.minimumPadding * 3,
            // bottom: middleWare.minimumPadding * 3,
            left: middleWare.minimumPadding *
                5,
            right: middleWare.minimumPadding * 5,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: (){
              setState(() {
                if(int.parse(cartFooddetails[index].qty) >= 0){
                  if(int.parse(cartFooddetails[index].qty) == 1){
                    cartFooddetails[index].qty = "0";
                    removeCartApi(model,cartFooddetails[index]);
                  }else{
                    var quantity = int.parse(cartFooddetails[index].qty);
                    quantity = quantity - 1;
                    cartFooddetails[index].qty = quantity.toString();
                    print("cart Update ${cartFooddetails[index].qty}");
                    addToCartApi(model,cartFooddetails[index]);
                  }

                }
              });
            },child: Icon(Icons.remove,color: Colors.white,),),
            middleWare.putSizedBoxWidth(5),
            Container(width: 30,child: Text(cartFooddetails[index].qty.toString(),textAlign: TextAlign.center,
                style: middleWare.customTextStyle(
                    17.00, middleWare.uiThemeColor, FontWeight.bold)),color: Colors.white,),
            middleWare.putSizedBoxWidth(5),
            GestureDetector(onTap:(){
              setState(() {
                var quantity = int.parse(cartFooddetails[index].qty);
                quantity = quantity + 1;
                cartFooddetails[index].qty = quantity.toString();
                addToCartApi(model,cartFooddetails[index]);
              });
            },child: Icon(Icons.add,color: Colors.white,)),
          ],
        ),
        onPressed: () async {
          // Navigator.pushNamed(context, RoutePaths.RegisterSuccess);
        },
      ),
    );
  }

  Container getAddButton(int index,CartViewModel model) {
    return Container(
      margin: EdgeInsets.only(left: 25),
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: middleWare.uiThemeColor,
          foregroundColor: middleWare.uiThemeColor,
          padding: EdgeInsets.only(
            // top: middleWare.minimumPadding * 3,
            // bottom: middleWare.minimumPadding * 3,
            left: middleWare.minimumPadding *
                5,
            right: middleWare.minimumPadding * 5,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Add",
                style: middleWare.customTextStyle(
                    17.00, Colors.white, FontWeight.bold)),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        onPressed: () {
          setState(() {

            // selectedIndex = index;
            cartFooddetails[index].qty = "1";
            addToCartApi(model,cartFooddetails[index]);
          });
          // Navigator.pushNamed(context, RoutePaths.RegisterSuccess);
        },
      ),
    );
  }
  addToCartApi(CartViewModel model,Cartfooddetails item) async {
    AddToCartModel addToCartModel = await model.addToCart(context,restaurantID, item.id, userId, item.qty.toString(),);
    // if(addToCartModel.status == "success"){
      getCartDetails(model);
    // }
  }
  removeCartApi(CartViewModel model,Cartfooddetails item) async {
          bool isRemoveFromCart = await model.removeCart(context,item.id,cartId);
          if(isRemoveFromCart){
            getCartDetails(model);
          }

  }
  Container getInstructionsController() {
    return Container(
      margin: EdgeInsets.only(
        left: middleWare.minimumPadding * 4,
        right: middleWare.minimumPadding * 4,
      ),
      child: Opacity(
        opacity: 0.8,

        child: TextFormField(
          style: middleWare.customTextStyle(
              14.00, middleWare.uiTextColor, FontWeight.bold),
          controller: instructionsController,
          keyboardType: TextInputType.text,
          validator: (value) {
            value = value ?? "";
            if (value
                .trim()
                .isEmpty) {
              return "Please enter instruction";
            } else if (value
                .trim()
                .length != 10) {
              return "Please enter valid Instruction";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Instrustions, If Any",


            hintStyle: middleWare.customTextStyle(
                14.00, middleWare.uiFordGrayColor, FontWeight.normal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
              borderSide: BorderSide(color: middleWare.uiThemeColor,width: 1),
            ),
          ),
          /*onChanged: onSearchTextChanged,*/
        ),
        // ),
      ),
    );
  }
  Container getplaceOrderButton(CartViewModel model) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: middleWare.uiThemeColor,
          foregroundColor: middleWare.uiThemeColor,
          padding: EdgeInsets.only(
            top: middleWare.minimumPadding * 3,
            bottom: middleWare.minimumPadding * 3,
            left: middleWare.minimumPadding *
                7,
            right: middleWare.minimumPadding * 7,
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(placeOrder,
                style: middleWare.customTextStyle(
                    17.00, Colors.white, FontWeight.bold)),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        onPressed: () async {
          // setState(() {
          //   selectedIndex = index;
          // });
          bool isOrderPlaced = await model.placeOrder(context, userId,cartId,"1");
          if(isOrderPlaced == true){
            middleWare.showToastMsg(
                "Order Placed Successfully", 13.00,
                Colors.white, Colors.black, Toast.LENGTH_SHORT);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                BottomNavigationBarExample()));
          }
          // Navigator.pushNamed(context, RoutePaths.ConfirmAddress);
        },
      ),
    );
  }

  Container getViewAddButton() {
    return Container(
      width: 250,
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: middleWare.uiThemeColor,
          foregroundColor: middleWare.uiThemeColor,
          padding: EdgeInsets.only(
            // top: middleWare.minimumPadding * 3,
            // bottom: middleWare.minimumPadding * 3,
            left: middleWare.minimumPadding *
                7,
            right: middleWare.minimumPadding * 7,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(addmoreitems,
                style: middleWare.customTextStyle(
                    17.00, Colors.white, FontWeight.bold)),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        onPressed: () async {
          await PreferenceHelper.setString(PreferenceConst.selectedRestaurantId,restaurantID);

          Navigator.pushNamed(context, RoutePaths.RestaurantDetailsPage);
          // setState(() {
          //   selectedIndex = index;
          // });
          // Navigator.pushNamed(context, RoutePaths.RegisterSuccess);
        },
      ),
    );
  }
  getRestaurantDetails(CartViewModel model) async {

    RestaurantDetailsModel restModel = await model.getRestaurantDetails(context,restaurantID);
    restaurantName = restModel.data.cookDetails[0].kname;
    address = restModel.data.cookDetails[0].address;
    kcuisines = restModel.data.cookDetails[0].kcuisines;
    restImage = restModel.data.cookDetails[0].kitchenpic;
    // getCartDetails(model);
  }

  getListItem(){
    return Container(
        height: 300,
        width: 150,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
            Image.asset("assets/images/menu_image_three.png",height: 130,fit: BoxFit.fill,),
            Text("Mushroom Tikka",style: middleWare.customTextStyle(16, Colors.black, FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis),

            middleWare.putSizedBoxWidth(10),
            SizedBox(width: 120,child: Text("Delivery : Sun 9th (Lunch)",style: middleWare.customTextStyle(13, Colors.black, FontWeight.normal),maxLines: 2,overflow: TextOverflow.ellipsis),),
            SizedBox(width: 150,child:Text("KRISHNA's Hotel",style: middleWare.customTextStyle(15, Colors.black, FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis)),

          ],),
          Container(height: 110,width: 130,alignment: Alignment.centerRight,child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
            Container(decoration: BoxDecoration(color: middleWare.uiBlueColor,border: Border.all(color: Colors.grey,width: 1)),child:
            Text("Only 10 Left",style: middleWare.customTextStyle(15, Colors.white, FontWeight.normal),maxLines: 2,overflow: TextOverflow.ellipsis),
            ),]))
        ],)
    );
  }
}