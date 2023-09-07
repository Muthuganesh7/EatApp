import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eat/constants/middleware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../base_model.dart';
import '../../base_widget.dart';
import '../../cart/model/cart_model.dart';
import '../../constants/route_const.dart';
import '../../constants/shared_preference_const.dart';
import '../../constants/shared_preference_helper.dart';
import '../../constants/string_constant.dart';
import '../../services/api/eat_apis.dart';
import '../model/home_model.dart';
import '../view_model/home_view_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}
class HomePageState extends State<HomePage>{
  MiddleWare middleWare = MiddleWare();
  TextEditingController searchController = TextEditingController();
  int _current = 0;
  String token = "";
  List<AppSlider> appSliders = [];
  List<ListofFood> listofPrebookingFoods= [];
  List<ListofKitchen> listofKitchens= [];
  List<ListofFood> listofPopularfoods= [];
  List<ListofFood> listofRecentfoods= [];
  int selectedCategoryIndex  = 0;
  String userId = "";
  int cartCount = 0;
  String totalPrice = "";
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  List<String> listOfCategories = ['Under 30Mins','Ratings','Vegetarian','Weakly Deals'];
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getAppBar(),
      body:Builder(
        builder: (BuildContext context1) => BaseWidgetWithNetworkConnectivity<HomeViewModel>(
          key: Key('login'),
          model: HomeViewModel(
              eatApis : Provider.of<EatApis>(context, listen: false)),
          onModelReady: (model) async {
            token = await PreferenceHelper.getString(PreferenceConst.token);
            getHomeAndCartDetails(model);
            return true;
          },
          builder: (context, model, child) => SafeArea(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              color: middleWare.uiPacificBlueColor,
              onRefresh: () async {
                getHomeAndCartDetails(model);
              },
              child: getMainContainer(model),
            ),
          ),
        ),
      ),
      bottomSheet: cartCount > 0 ? middleWare.bottomSheet(context,cartCount,totalPrice) : null,
    );
  }
  getHomeAndCartDetails(HomeViewModel model) async {
    HomeModel homeModel = await model.getDashboardDetails(context);
    appSliders = homeModel.data.appSlider;
    listofPrebookingFoods = homeModel.data.listofPrebookingFoods;
    listofKitchens = homeModel.data.listofKitchens;
    listofPopularfoods = homeModel.data.listofPopularfoods;
    listofRecentfoods = homeModel.data.listofRecentfoods;
    getCartDetails(model);
  }
  getAppBar(){
    return AppBar(
      backgroundColor: middleWare.uiBetaColor,
      automaticallyImplyLeading: false,
      actions: [
        GestureDetector(child: Container(
          padding: EdgeInsets.only(left: 20),
          width: MediaQuery.of(context).size.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: MediaQuery.of(context).size.width/9.9,child:Image.asset(
                'assets/images/pin.png',
                color: middleWare.uiThemeColor,
                width: 25.00,
                height: 25.00,
              ),),
              Container(width: MediaQuery.of(context).size.width/1.5,margin: EdgeInsets.only(left: 10,top: 5),alignment: Alignment.topLeft,child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text("Home",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),
                  Icon(Icons.keyboard_arrow_down)
                ],),
                SizedBox(
                  width: MediaQuery.of(context).size.width/1.5,
                  child: Text(
                    "24, Maruthu Pandiyar Street, Maduraieeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeesssssssssssssssss",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,

                    style: middleWare.customTextStyle(
                        10.00, Colors.grey, FontWeight.w500),
                  ),
                )

              ],)),
              GestureDetector(child: Container(width: MediaQuery.of(context).size.width/9.9,alignment: Alignment.centerRight,child:
              Icon(Icons.account_circle_outlined,size: 25,)),onTap: (){
                Navigator.pushNamed(context, RoutePaths.SubscriptionPage);
              })
            ],
          ),),onTap: (){
          // Navigator.pushNamed(context, RoutePaths.ChooseDeliveryLocations);
        })


      ],
    );
  }
  getMainContainer(HomeViewModel model){
    var size = MediaQuery.of(context).size;
    final double itemHeight = 290;
    final double itemWidth = size.width / 2;
    // TODO: implement build
    final List<Widget> imageSliders = appSliders
        .map((item) => Container(
      child: GestureDetector(child: Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: 20),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: Stack(
              children: <Widget>[
                Card(elevation: 10,shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),child: item.image != null && !item.image.toString().isEmpty ?
                ClipRRect(borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.network(item.image.toString(),width: MediaQuery.of(context).size.width,fit: BoxFit.cover,)) :
                ClipRRect(borderRadius: BorderRadius.all(Radius.circular(15)),
                  child:Image.asset("assets/images/slider.png", fit: BoxFit.fill, width: MediaQuery.of(context).size.width),))

              ],
            )),
      ),onTap: ()  {
        // Navigator.pushNamed(context, RoutePaths.RestaurantDetailsPage);
      }),
    )).toList();
    return WillPopScope(
        onWillPop: () async {
      onBackPressed(); // Action to perform on back pressed
      return false;
    },
    child:Stack(children: [
      Container(color: middleWare.uiBetaColor,child: SingleChildScrollView(child:
      Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
        Container(margin: EdgeInsets.only(top: 20),child:
        Row(children: [
          Container(width: MediaQuery.of(context).size.width/1.2,child:getSearchText()),
          Image.asset("assets/images/setting.png",width: 30,height: 30,)
        ],),),
        getSlider(imageSliders),
        middleWare.putSizedBoxHeight(20),
        Container(height: 45,margin: EdgeInsets.only(left: 10),child:
        ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listOfCategories.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Row(children: [
                middleWare.putSizedBoxWidth(5),
                GestureDetector(child: Container(width: 150,
                    child: Text(listOfCategories[index], style: middleWare.customTextStyle(14, selectedCategoryIndex == index ? Colors.white : middleWare.uiThemeColor, FontWeight.normal),),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: selectedCategoryIndex == index ? middleWare.uiThemeColor : Colors.white,
                        border: Border.all(
                            color: selectedCategoryIndex == index ? Colors.white : middleWare.uiThemeColor, width: 1))),onTap: (){
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },),
                middleWare.putSizedBoxWidth(5),
              ],);

            }),
        ),
        middleWare.putSizedBoxHeight(20),
        getSubTitle(nearyoutext),
        middleWare.putSizedBoxHeight(20),
        getGridLayout(itemWidth,itemHeight),
        getSubTitle(prebooking),
        getSimilarProducts(),
        getCategories(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Container(margin: EdgeInsets.only(left: 20),child: Text(mostpopular,style: middleWare.customTextStyle(16, middleWare.uiThemeColor, FontWeight.bold),)),
          Container(margin: EdgeInsets.only(right: 20),child: Text(viewAll,style: middleWare.customTextStyle(15, Colors.orange, FontWeight.normal),)),
        ],),
        middleWare.putSizedBoxHeight(20),
        getPopularItems(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Container(margin: EdgeInsets.only(left: 20),child: Text(recentItems,style: middleWare.customTextStyle(16, middleWare.uiThemeColor, FontWeight.bold),)),
          Container(margin: EdgeInsets.only(right: 20),child: Text(viewAll,style: middleWare.customTextStyle(15, Colors.orange, FontWeight.normal),)),
        ],),
        middleWare.putSizedBoxHeight(20),
        getRecentItems()

      ],)),),
      model.state == ViewState.BUSY ? Container(color: Colors.white.withOpacity(0.5),child: Center(
      child:
      Lottie.asset(
        'assets/images/loader.json',
        height: 150.0,
        repeat: true,
        reverse: true,
        animate: true,
      ))
        ,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,) : Container()

    ],));
  }
  getSubTitle(txt){
    return Container(margin: EdgeInsets.only(left: 20,top: 20),child: Text(txt,style: middleWare.customTextStyle(16, middleWare.uiThemeColor, FontWeight.bold),));
  }
  onBackPressed(){
    showAlertDialog(context);
  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Exit"),
      onPressed:  () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Eat"),
      content: Text("Would you like to want to exit?"),
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
  getSimilarProducts(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 250,
      child: ListView.builder(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        itemCount: listofPrebookingFoods.length,
        shrinkWrap: true,

        itemBuilder: (BuildContext context, int index) { return GestureDetector(child: getListItem(listofPrebookingFoods[index]),onTap: () async {
          await PreferenceHelper.setString(PreferenceConst.selectedRestaurantId,listofPrebookingFoods[index].cookid);

          Navigator.pushNamed(context, RoutePaths.RestaurantDetailsPage);
        });
          },

      ),
    );
  }
  getPopularItems(){
    return Container(
      height: 250,
      child:
        ListView.builder(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        itemCount: listofPopularfoods.length,
        shrinkWrap: true,

        itemBuilder: (BuildContext context, int index) { return GestureDetector(child: getPopularListItem(listofPopularfoods[index]),onTap: () async {
          await PreferenceHelper.setString(PreferenceConst.selectedRestaurantId,listofPopularfoods[index].cookid);
      Navigator.pushNamed(context, RoutePaths.RestaurantDetailsPage);
    });
          }));
  }

  getRecentItems(){
    return Container(
        height: 250,
        child:
        ListView.builder(
          // This next line does the trick.
            scrollDirection: Axis.horizontal,
            itemCount: listofRecentfoods.length,
            shrinkWrap: true,

            itemBuilder: (BuildContext context, int index) { return GestureDetector(child: getPopularListItem(listofRecentfoods[index]),onTap: () async {
              await PreferenceHelper.setString(PreferenceConst.selectedRestaurantId,listofRecentfoods[index].cookid);
              Navigator.pushNamed(context, RoutePaths.RestaurantDetailsPage);
            });
            }));
  }


  getCategories(){
    return Container(
      height: 170,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          middleWare.putSizedBoxWidth(10),
          GestureDetector(child: getCategoryListItem(),onTap: (){
            // Navigator.pushNamed(context, RoutePaths.RestaurantDetailsPage);
          }),
          middleWare.putSizedBoxWidth(10),
          GestureDetector(child: getCategoryListItem(),onTap: (){
            // Navigator.pushNamed(context, RoutePaths.RestaurantDetailsPage);
          }),
          middleWare.putSizedBoxWidth(10),
          GestureDetector(child: getCategoryListItem(),onTap: (){
            // Navigator.pushNamed(context, RoutePaths.RestaurantDetailsPage);
          })
        ],
      ),
    );
  }


  getGridLayout(itemWidth,itemHeight){

    final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    return GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        childAspectRatio: (itemWidth / 260),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: listofKitchens.map((value) {
      return Container(
        // alignment: Alignment.center,

        child: getProductLayout(value,itemWidth),
      );
    }).toList());
  }
  getPopularListItem(ListofFood item){
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(5),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
        Container(margin: EdgeInsets.only(left: 10),alignment: Alignment.center,
            child: item.foodpic != null && !item.foodpic.toString().isEmpty ? ClipRRect(borderRadius: BorderRadius.all(Radius.circular(15)),child: Image.network(item.foodpic.toString(),height: 150,width: 250,fit: BoxFit.fill,),) : Image.asset("assets/images/menu_image_four.png",height: 150,width: 250,fit: BoxFit.fill,),
            ),
        middleWare.putSizedBoxHeight(10),
        Container(margin: EdgeInsets.only(left: 10),width: 200,child:Text(item.foodname,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis)),

        Row(children: [
          middleWare.putSizedBoxWidth(10),
          SizedBox(width: 60,child:Text(item.kname,style: middleWare.customTextStyle(14, Colors.grey, FontWeight.normal),maxLines: 1,overflow: TextOverflow.ellipsis)),
          Text(".",textAlign: TextAlign.start,style: middleWare.customTextStyle(14, Colors.orange, FontWeight.bold),),
          middleWare.putSizedBoxWidth(5),
          SizedBox(width: 60,child:Text(item.type,style: middleWare.customTextStyle(14, Colors.grey, FontWeight.normal),maxLines: 1,overflow: TextOverflow.ellipsis)),
          SizedBox(width: 50,child:Text("",style: middleWare.customTextStyle(14, Colors.grey, FontWeight.normal),maxLines: 2,overflow: TextOverflow.ellipsis)),
          Row(mainAxisAlignment: MainAxisAlignment.end,children: [
            Icon(Icons.star,color: Colors.orange,),
            Text(item.review.toString(),style: middleWare.customTextStyle(15, Colors.orange, FontWeight.normal),maxLines: 2,overflow: TextOverflow.ellipsis),
            ])
        ],),
      ],),

    );
  }
  getCategoryListItem(){
    return Container(
        height: 200,
        width: 110,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(5),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
          Container(
          width: 150,alignment: Alignment.center,child:Image.asset("assets/images/category_image.png",height: 100,width: 100,fit: BoxFit.fill,)),
            middleWare.putSizedBoxHeight(10),
            SizedBox(width: 150,child:Text("Offers",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.normal),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis)),
          ],),

    );
  }
  getCartDetails(HomeViewModel model) async {
    userId = await PreferenceHelper.getString(PreferenceConst.userId);
    CartDetailsModel cartDetailsModel = await model.getCartDetails(context,userId);
    setState(() {
        cartCount = int.parse(cartDetailsModel.data.carttotal[0].cartitemtotal.toString());
        if(cartCount > 0){
              totalPrice = cartDetailsModel.data.carttotal[3].grandtotal.toString();
            }
    });

  }

  getListItem(ListofFood item){
    return Container(
          width: 180,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(5),
          child: Card( shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),child: Stack(children: [
            Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
              item.foodpic != null && !item.foodpic.toString().isEmpty ? ClipRRect(borderRadius: BorderRadius.all(Radius.circular(15)),child: Image.network(item.foodpic.toString(),height: 125,width: 180,fit: BoxFit.cover,),) : Image.asset("assets/images/menu_image_three.png",height: 130,fit: BoxFit.fill,),
                Container(margin: EdgeInsets.only(left: 10,top: 10),child: Text(item.foodname,style: middleWare.customTextStyle(16, middleWare.uiThemeColor, FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis),),

                middleWare.putSizedBoxHeight(10),
              Container(width: 180,margin: EdgeInsets.only(left: 10),child: Text("Delivery : ${item.todate != null ? item.todate.toString() : ""}",style: middleWare.customTextStyle(13, middleWare.uiThemeColor, FontWeight.normal),maxLines: 1,overflow: TextOverflow.ellipsis),),
              Container(width: 180,margin: EdgeInsets.only(left: 10),child:Text(item.kname.toString(),style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis)),

            ],),
            Container(height: 125,width: 180,alignment: Alignment.centerRight,child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
              Container(decoration: BoxDecoration(color: middleWare.uiBlueColor,border: Border.all(color: Colors.grey,width: 1)),child:
                Text("Only ${item.availqty} Left",style: middleWare.customTextStyle(15, Colors.white, FontWeight.normal),maxLines: 2,overflow: TextOverflow.ellipsis),
           ),]))
          ],) ,)
      );
  }

  getProductLayout(ListofKitchen item,double itemWidth){
    return GestureDetector(child: Container(height: 260,child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
            item.kitchenpic != null && !item.kitchenpic.toString().isEmpty ? ClipRRect(child: Image.network(item.kitchenpic.toString(),height: 150,width: MediaQuery.of(context).size.width/2,fit: BoxFit.fill,),borderRadius: BorderRadius.all(Radius.circular(15)),) : Image.asset("assets/images/menu_image_one.png",height: 150,width: MediaQuery.of(context).size.width/2,fit: BoxFit.fill,),
            Container(margin: EdgeInsets.only(left: 10,top: 10),width: itemWidth - 10,child:Text(item.kname.toString(),style: middleWare.customTextStyle(17, middleWare.uiThemeColor, FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis)),
            Row(children: [
              middleWare.putSizedBoxWidth(10),
              Container(child: Image.asset("assets/images/pin.png",height: 20,width: 20,fit: BoxFit.fill,), margin: EdgeInsets.only(top: 10),),
              middleWare.putSizedBoxWidth(10),
              Container(width: 120,margin: EdgeInsets.only(top: 10),child: Text(item.city,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.w500),maxLines: 2,overflow: TextOverflow.ellipsis),)
            ],)
          ],),
          Container(width: itemWidth,height: 150,padding: EdgeInsets.only(bottom: 10,right: 10),alignment: Alignment.bottomRight,child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
          Container(decoration: BoxDecoration(color: Colors.red),child:Row(children:[
            middleWare.putSizedBoxWidth(5),
            Text("4",style: middleWare.customTextStyle(15, Colors.white, FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis),
            Icon(Icons.star,color: Colors.yellow,)
          ],)),]))
        ],)
      ),
    ),),onTap: () async {
      await PreferenceHelper.setString(PreferenceConst.selectedRestaurantId,item.cookid);
      Navigator.pushNamed(context, RoutePaths.RestaurantDetailsPage);
    },);
  }


  getSlider(List<Widget> imageSliders){
    return Container(child:Column(children: [
      CarouselSlider(
        items: imageSliders,
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            aspectRatio: 2.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });

            }),
      ),
      middleWare.putSizedBoxHeight(10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: appSliders.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : middleWare.uiThemeColor)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        )
    ]),);
  }

  Container getSearchText() {
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
          controller: searchController,
          keyboardType: TextInputType.text,
          validator: (value) {
            value = value ?? "";
            if (value
                .trim()
                .isEmpty) {
              return "Search favorite Item";
            } else if (value
                .trim()
                .length != 10) {
              return "Please enter valid mobile number";
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(top: 20,left: 20),
            hintText: "Search favorite Item",
            hintStyle: middleWare.customTextStyle(
                14.00, middleWare.uiFordGrayColor, FontWeight.normal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: middleWare.uiLightTextColor),
            ),
          ),
          /*onChanged: onSearchTextChanged,*/
        ),
        // ),
      ),
    );
  }

}