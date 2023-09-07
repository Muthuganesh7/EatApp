import 'package:eat/cart/model/add_to_cart_model.dart';
import 'package:eat/constants/middleware.dart';
import 'package:eat/restaurant_details/model/rest_details_model.dart';
import 'package:eat/restaurant_details/view_model/restaurant_details_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../base_model.dart';
import '../../base_widget.dart';
import '../../cart/model/cart_model.dart';
import '../../constants/route_const.dart';
import 'package:intl/intl.dart';
import 'package:eat/cart/model/cart_model.dart';
import '../../constants/shared_preference_const.dart';
import '../../constants/shared_preference_helper.dart';
import '../../services/api/eat_apis.dart';

class RestaurantDetailsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RestaurantDetailsPageState();
  }
}
class RestaurantDetailsPageState extends State<RestaurantDetailsPage>{
  MiddleWare middleWare = MiddleWare();
  String selectedDateTime = DateTime.now().toString();
  int selectedIndex = -1;
  int cartCount = 0;
  String cartId = "";
  String cookId = "";
  String totalPrice = "0.0";
  int selectedCategoryIndex = 0;
  List<String> listOfCategories = ['Breakfast','Lunch','Snacks','Dinner'];
  String restaurantID = "";
  String restaurantName = "",address = "",kcuisines = "",prebooking = "",restImage = "",bannerImage = "";
  List<FoodDetail> listOfFoods = [];
  String userId = "";
  late DateTime nextWeek;
  // List<CartDetail> cartDetails = [];
  List<Cartfooddetails> cartFooddetails = [];
  List<Carttotals> carttotal = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextWeek = findLastDateOfTheWeek(DateTime.now());
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Builder(
        builder: (BuildContext context1) => BaseWidgetWithNetworkConnectivity<RestaurantDetailsViewModel>(
          key: Key('login'),
          model: RestaurantDetailsViewModel(
              eatApis : Provider.of<EatApis>(context, listen: false)),
          onModelReady: (model) async {
            restaurantID = await PreferenceHelper.getString(PreferenceConst.selectedRestaurantId);
            userId = await PreferenceHelper.getString(PreferenceConst.userId);
            getRestaurantDetails(model);

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
                ,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,) : Container()],),
          ),
        ),
      ),
        bottomSheet: cartCount > 0 ? middleWare.bottomSheet(context,cartCount,totalPrice) : null,
      // bottomSheet: middleWare.bottomSheet(context, cartCount, "100"),
    );
  }
  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }
  getCartDetails(RestaurantDetailsViewModel model) async {
    // cartDetails = [];
    cartFooddetails = [];
    carttotal = [];
    userId = await PreferenceHelper.getString(PreferenceConst.userId);
    CartDetailsModel cartDetailsModel = await model.getCartDetails(context,userId);
    setState(() {
      if(cartDetailsModel.data != null){
        print("Cart Details Api Response ${cartDetailsModel.data}");
        cartCount = int.parse(cartDetailsModel.data.carttotal[0].cartitemtotal.toString());
        if(cartCount > 0){
          cookId = cartDetailsModel.data.cartfooddetails[0].cookid.toString();
          // cartDetails = cartDetailsModel.data.cartDetails;
          cartFooddetails = cartDetailsModel.data.cartfooddetails;
          carttotal = cartDetailsModel.data.carttotal;
          cartId = cartDetailsModel.data.cartbaseid;
          cartFooddetails.forEach((cartelement) {
            // if(cartelement.cookid == restaurantID){
              totalPrice = cartDetailsModel.data.carttotal[3].grandtotal.toString();
              listOfFoods.forEach((element) {
                if(element.id == cartelement.id){
                  element.qty = int.parse(cartelement.qty);
                }
              });
            // }
          });
        }
        print("Cart Details ${cartCount}");
      }

    });

  }
  getMainContainer(RestaurantDetailsViewModel model){
    return SingleChildScrollView(child: Column(children: [
      stackDetails(),
      middleWare.putSizedBoxHeight(20),
      Container(child: Text("Pre Order $prebooking",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),),
      middleWare.putSizedBoxHeight(20),
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        Container(child: Text("Select Date & time",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),),
        middleWare.putSizedBoxWidth(10),
        GestureDetector(onTap: (){
          DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              minTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,DateTime.now().hour,DateTime.now().minute),
              // maxTime: DateTime(nextWeek.year,nextWeek.month,nextWeek.day),
              onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                setState(() {
                  print('confirm $date');
                  selectedDateTime = date.toString();
                  getRestaurantDetails(model);
                });
              }, currentTime: DateTime.now(), locale: LocaleType.en);
        },child: Container(decoration: BoxDecoration(border: Border.all(width: 1,color: middleWare.uiThemeColor),color: Colors.white),padding: EdgeInsets.all(7),child: Row(children: [
          Text(DateFormat('MMM dd yyyy hh:mm a').format(DateTime.parse(selectedDateTime).toLocal()).toString() ,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
          Icon(Icons.calendar_month)
        ],)),)

      ],),
      middleWare.putSizedBoxHeight(20),
      Container(height: 45,child:
      ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listOfCategories.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Row(children: [
              middleWare.putSizedBoxWidth(5),
              GestureDetector(child: Container(width: 120,
                  child: Text(listOfCategories[index], style: middleWare.customTextStyle(14, selectedCategoryIndex == index ? Colors.white : middleWare.uiThemeColor, FontWeight.normal),),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: selectedCategoryIndex == index ? middleWare.uiThemeColor : Colors.white,
                      border: Border.all(color: selectedCategoryIndex == index ? Colors.white : middleWare.uiThemeColor, width: 1))),
                onTap: (){
                setState(() {
                  selectedCategoryIndex = index;
                });
              },),
              middleWare.putSizedBoxWidth(5),
            ],);

          })
      ),
      getProducts(model),
      middleWare.putSizedBoxHeight(100)
    ],),
    );
  }
  getRestaurantDetails(RestaurantDetailsViewModel model) async {
    listOfFoods = [];
    RestaurantDetailsModel restModel = await model.getRestaurantDetails(context,restaurantID);
    setState(() {
      restaurantName = restModel.data.cookDetails[0].kname;
      address = restModel.data.cookDetails[0].address;
      kcuisines = restModel.data.cookDetails[0].kcuisines;
      prebooking = restModel.data.prebooking;
      listOfFoods = restModel.data.foodDetails;
      restImage = restModel.data.cookDetails[0].kitchenpic;
      bannerImage = restModel.data.cookDetails[0].bannerpic;
      print("Categories ${restImage}");
      listOfCategories.asMap().forEach((key, value) {
        print("forwaach ${key} , ${value}");
      });
      for(int i=0;i<listOfCategories.length;i++){
        if(listOfCategories[i].toString().toLowerCase() == restModel.data.foodCategory.toString().toLowerCase()){
          selectedCategoryIndex = i;
        }
      }

      getCartDetails(model);
    });

  }
  getProducts(RestaurantDetailsViewModel model){
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listOfFoods.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Column(children: [
                Container(width: 200,child: Text(listOfFoods[index].foodname.toString(),style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 2,),),
                middleWare.putSizedBoxHeight(10),
                Container(width: 200,child: Text(listOfFoods[index].fooddes.toString(),style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.normal),overflow: TextOverflow.ellipsis,maxLines: 2,),),
                middleWare.putSizedBoxHeight(10),
                Container(width: 200,child: Text("Rs.${listOfFoods[index].price}",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 2,),),

              ],),
              Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                    width: 150,alignment: Alignment.center,
                    child:listOfFoods[index].foodpic != null && !listOfFoods[index].foodpic.toString().isEmpty ?
          ClipRRect(borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Image.network(listOfFoods[index].foodpic.toString(),width: MediaQuery.of(context).size.width,fit: BoxFit.cover,)) :
          ClipRRect(borderRadius: BorderRadius.all(Radius.circular(15)),
          child:Image.asset("assets/images/slider.png", fit: BoxFit.fill, width: MediaQuery.of(context).size.width),)),

                    // Image.asset("assets/images/category_image.png",height: 80,width: 200,fit: BoxFit.fill,)),
                middleWare.putSizedBoxHeight(10),
                listOfFoods[index].qty! > 0 ? getCartButton(index,model) : getAddButton(index,model)
              ],),
            ],),
          );
        }
          );
        }
  Container getCartButton(int index,RestaurantDetailsViewModel model) {
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
                if(listOfFoods[index].qty! >= 0){
                  if(listOfFoods[index].qty == 1){
                    listOfFoods[index].qty = 0;
                    removeCartApi(model,listOfFoods[index]);
                  }else{
                    listOfFoods[index].qty = listOfFoods[index].qty! - 1;
                    addToCartApi(model,listOfFoods[index]);
                  }

                }
              });
            },child: Icon(Icons.remove,color: Colors.white,),),
            middleWare.putSizedBoxWidth(5),
            Container(width: 30,child: Text(listOfFoods[index].qty.toString(),textAlign: TextAlign.center,
                style: middleWare.customTextStyle(
                    17.00, middleWare.uiThemeColor, FontWeight.bold)),color: Colors.white,),
            middleWare.putSizedBoxWidth(5),
        GestureDetector(onTap:(){
          setState(() {
            listOfFoods[index].qty = listOfFoods[index].qty! + 1;
            addToCartApi(model,listOfFoods[index]);

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

  Container getAddButton(int index,RestaurantDetailsViewModel model) {
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
            listOfFoods[index].qty = 1;
            addToCartApi(model,listOfFoods[index]);
          });
          // Navigator.pushNamed(context, RoutePaths.RegisterSuccess);
        },
      ),
    );
  }
  addToCartApi(RestaurantDetailsViewModel model,FoodDetail item) async {
    print("AddToCart Api Call $cartCount");
    if(cartCount > 0){
      if(cookId != restaurantID){
        addToCartApiCall(item,model);
      }else{
        showAlertDialog(context,item,model);
      }
    }else{
      addToCartApiCall(item,model);
    }


  }
  addToCartApiCall(FoodDetail item,RestaurantDetailsViewModel model) async {
    AddToCartModel addToCartModel = await model.addToCart(context,restaurantID, item.id!, userId, item.qty.toString(),);
    // if(addToCartModel.status == "success"){
    getCartDetails(model);
    // }
  }
  removeCartApi(RestaurantDetailsViewModel model,FoodDetail item) async {
    if(cartCount > 0){
      cartFooddetails.forEach((element) async {
        if(item.id == element.id){
          bool isRemoveFromCart = await model.removeCart(context,element.id,cartId);
          if(isRemoveFromCart){
            getCartDetails(model);
          }
        }
      });
    }

  }
  removeFullCartApi(RestaurantDetailsViewModel model, FoodDetail item) async {
          bool isRemoveFromCart = await model.removeFullCart(context,cartId);
          if(isRemoveFromCart){
            addToCartApiCall(item, model);
          }
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

  showAlertDialog(BuildContext context,FoodDetail item,RestaurantDetailsViewModel model) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("CANCEL"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("CLEAR CART AND ADD"),
      onPressed:  () {
        removeFullCartApi(model,item);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Eat"),
      content: Text("You can only order items from one restaurant at a time, Clear your cart if you'd still like to order this item"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  // Container(child:Image.asset("assets/images/circle.png",height: 30,width: 30,)),
stackDetails(){
    return Stack(children: [
      Container(height: 250,decoration: BoxDecoration(image: bannerImage!=null && bannerImage.isEmpty == false ? DecorationImage(
          image: NetworkImage(bannerImage),
          fit: BoxFit.cover) : DecorationImage(
          image:  AssetImage('assets/images/rest_bg.png'),
          fit: BoxFit.cover))),
      GestureDetector(child: Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      Image.asset("assets/images/previous.png",height: 30,width: 30,fit: BoxFit.fill,),
        Container(child:Image.asset("assets/images/circle.png",height: 30,width: 30,),
      margin: EdgeInsets.only(right: 20),padding: EdgeInsets.all(2),
      decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.grey,width: 1)),)
  ],),margin: EdgeInsets.only(top: 40,left: 20),),onTap: (){
        Navigator.pop(context);
      }),

      Stack(children: [
        Container(height:150,margin: EdgeInsets.only(top: 150,left: 25,right: 25),
          decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.grey,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
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
          Container(child:ClipRRect(borderRadius: BorderRadius.all(Radius.circular(50)),child:Image.network(restImage,height: 40,width: 40,fit: BoxFit.fill,)),margin: EdgeInsets.only(top: 130),width: MediaQuery.of(context).size.width,height: 40,alignment: Alignment.center,)
            :Container(child:Image.asset("assets/images/circle.png",height: 40,width: 40,fit: BoxFit.fill,),margin: EdgeInsets.only(top: 130),width: MediaQuery.of(context).size.width,height: 40,alignment: Alignment.center,),

      ],),
    ],);
}

}