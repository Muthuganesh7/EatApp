import 'package:eat/constants/middleware.dart';
import 'package:eat/constants/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SubscriptionPageState();
  }
  
}
class SubscriptionPageState extends State<SubscriptionPage>{
  MiddleWare middleWare = MiddleWare();
  bool checkedValue = false;
  int selectedRadio = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  middleWare.putSizedBoxHeight(20),
                  getForm(),
                  getTitle(food),
                  getFoodLayout(),
                  getTitle(subscription),
                  getSubscriptionLayout(),
                  getTitle(time),
                  middleWare.putSizedBoxHeight(15),
                  getTimeItems(screenWidth),
                  getTitle(menu),
                  getMenuItems(screenWidth),
                  middleWare.putSizedBoxHeight(20),
                  getProceedBtn(screenWidth),
                  middleWare.putSizedBoxHeight(20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  getTitle(txt){
    return Container(margin: EdgeInsets.only(left: 20,top: 20),child: Text(txt,style: middleWare.customTextStyle(16, middleWare.uiThemeColor, FontWeight.bold),),);
  }
  getAppBar(){
    return AppBar(elevation: 0,automaticallyImplyLeading: false,actions: [
      GestureDetector(child: Container(alignment: Alignment.centerLeft,width: MediaQuery.of(context).size.width,
          child:Row(mainAxisAlignment: MainAxisAlignment.start,children: [
            middleWare.putSizedBoxWidth(20),
            Image.asset("assets/images/previous.png",height: 30,width: 30,fit: BoxFit.fill,),
            middleWare.putSizedBoxWidth(20),
            Text(subscription,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),)
          ])),onTap: (){
        Navigator.pop(context);
      },)
    ]);
  }
  getForm(){
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child:Column (
        children :[
          TextField(
            decoration: InputDecoration(
              hintText: name,
              hintStyle: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.normal),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: emailId,
              hintStyle: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.normal),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: address,
              hintStyle: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.normal),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: zip,
              hintStyle: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.normal),
              border: OutlineInputBorder(),
            ),
          ),],
      ),
    );
  }
  getFoodLayout(){
    return Container(child:Row(children: [
      // getProductLayout()
      middleWare.putSizedBoxWidth(10),
      Row(children: [Checkbox(value: checkedValue, onChanged: (newValue) {
        setState(() {
          checkedValue = newValue!;
        });
      },),
        Text("TIFFEN",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),

      middleWare.putSizedBoxWidth(10),
      Row(children: [Checkbox(value: checkedValue, onChanged: (newValue) {
        setState(() {
          checkedValue = newValue!;
        });
      },),
        Text("LUNCH",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),

      middleWare.putSizedBoxWidth(10),
      Row(children: [Checkbox(value: checkedValue, onChanged: (newValue) {
        setState(() {
          checkedValue = newValue!;
        });
      },),
        Text("DINNER",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),

      middleWare.putSizedBoxWidth(10),
    ]),
    );
  }
  getSubscriptionLayout(){
    return Container(child:Row(children: [
      // getProductLayout()
      middleWare.putSizedBoxWidth(10),
      Row(children: [
        Container(child: Radio(onChanged: (val){
          setState(() {
            selectedRadio = val!;
          });
        }, value: 1, groupValue: selectedRadio,activeColor: middleWare.uiThemeColor,)),

        Text("15 Days",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),

      middleWare.putSizedBoxWidth(10),
      Row(children: [
        Container(child: Radio(onChanged: (val){
          setState(() {
            selectedRadio = val!;
          });
        }, value: 1, groupValue: selectedRadio,activeColor: middleWare.uiThemeColor,)),

        Text("30 Days",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),

    ]),
    );
  }
  getTimeItems(screenWidth){
    return Column(children: [
      Row(children: [
        middleWare.putSizedBoxWidth(20),
        Container(child: TextField(

          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 20,left: 20),
            hintText: "Morning",
            hintStyle: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.normal),
            border: OutlineInputBorder(),
          ),
        ),width: screenWidth/3,),
        Container(width: 150,margin: EdgeInsets.only(left: 10),child: Text("(6.30 AM to 10.30AM)",overflow: TextOverflow.ellipsis,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),),),

      ],),
      middleWare.putSizedBoxHeight(15),
      Row(children: [
        middleWare.putSizedBoxWidth(20),
        Container(child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 20,left: 20),
            hintText: "Lunch",
            hintStyle: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.normal),
            border: OutlineInputBorder(),
          ),
        ),width: screenWidth/3,),
        Container(width: 150,margin: EdgeInsets.only(left: 10),child: Text("(12.30 PM to 4.30PM)",overflow: TextOverflow.ellipsis,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),),),

      ],),
      middleWare.putSizedBoxHeight(15),
      Row(children: [
        middleWare.putSizedBoxWidth(20),
        Container(child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 20,left: 20),
            hintText: "Dinner",
            hintStyle: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.normal),
            border: OutlineInputBorder(),
          ),
        ),width: screenWidth/3,),
        Container(width: 150,margin: EdgeInsets.only(left: 10),child: Text("(7.30 PM to 10.30PM)",overflow: TextOverflow.ellipsis,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),),),

      ],),
    ],);
  }
  getProceedBtn(screenWidth){
    return Container(
      width:screenWidth,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: middleWare.uiThemeColor,
          foregroundColor: middleWare.uiThemeColor,
        ),
        onPressed: () {},
        child: Text(proceedSubscription, style: middleWare.customTextStyle(15, Colors.white, FontWeight.bold)),
      ),

    );
  }
  getMenuItems(screenWidth){
    return  Column(children: [
    Container(child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      // getProductLayout()
      Container(margin: EdgeInsets.only(left: 20),child: Text("Breakfast",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),),
      Container(child:Row(children:[
        Row(children: [
          Container(child: Radio(onChanged: (val){
            setState(() {
              selectedRadio = val!;
            });
          }, value: 1, groupValue: selectedRadio,activeColor: middleWare.uiThemeColor,)),

          Text("VEG",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),

        middleWare.putSizedBoxWidth(10),
        Row(children: [
          Container(child: Radio(onChanged: (val){
            setState(() {
              selectedRadio = val!;
            });
          }, value: 1, groupValue: selectedRadio,activeColor: middleWare.uiThemeColor,)),

          Text("NVEG",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),]))

    ]),
    ),

    Container(child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    // getProductLayout()
    Container(margin: EdgeInsets.only(left: 20),child: Text("Lunch",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),),
    Container(child:Row(children:[
    Row(children: [
    Container(child: Radio(onChanged: (val){
    setState(() {
    selectedRadio = val!;
    });
    }, value: 1, groupValue: selectedRadio,activeColor: middleWare.uiThemeColor,)),

    Text("VEG",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),

    middleWare.putSizedBoxWidth(10),
    Row(children: [
    Container(child: Radio(onChanged: (val){
    setState(() {
    selectedRadio = val!;
    });
    }, value: 1, groupValue: selectedRadio,activeColor: middleWare.uiThemeColor,)),

    Text("NVEG",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),]))

    ]),
    ),

    Container(child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    // getProductLayout()
    Container(margin: EdgeInsets.only(left: 20),child: Text("Dinner",style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),),),
    Container(child:Row(children:[
    Row(children: [
    Container(child: Radio(onChanged: (val){
    setState(() {
    selectedRadio = val!;
    });
    }, value: 1, groupValue: selectedRadio,activeColor: middleWare.uiThemeColor,)),

    Text("VEG",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),

    middleWare.putSizedBoxWidth(10),
    Row(children: [
    Container(child: Radio(onChanged: (val){
    setState(() {
    selectedRadio = val!;
    });
    }, value: 1, groupValue: selectedRadio,activeColor: middleWare.uiThemeColor,)),

    Text("NVEG",style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),)],),]))

    ]),
    ),


    middleWare.putSizedBoxHeight(15),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    Container(margin: EdgeInsets.only(left: 20),
    child: Text("Morning",overflow: TextOverflow.ellipsis,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),),),
    Container(child: TextField(
    decoration: InputDecoration(
    contentPadding: EdgeInsets.only(top: 20,left: 20),
    hintText: "Home",
    hintStyle: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.normal),
    border: OutlineInputBorder(),
    ),
    ),width: screenWidth/2,),

    ],),
    middleWare.putSizedBoxHeight(15),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    Container(margin: EdgeInsets.only(left: 20),child: Text("Lunch",overflow: TextOverflow.ellipsis,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),),),
    middleWare.putSizedBoxWidth(20),
    Container(child: TextField(
    decoration: InputDecoration(
    contentPadding: EdgeInsets.only(top: 20,left: 20),
    hintText: "Office",
    hintStyle: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.normal),
    border: OutlineInputBorder(),
    ),
    ),width: screenWidth/2,),

    ],),
    middleWare.putSizedBoxHeight(15),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    Container(margin: EdgeInsets.only(left: 20),child: Text("Dinner",overflow: TextOverflow.ellipsis,style: middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.bold),),),
    middleWare.putSizedBoxWidth(20),
    Container(child: TextField(
    decoration: InputDecoration(
    contentPadding: EdgeInsets.only(top: 20,left: 20),
    hintText: "Home",
    hintStyle: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.normal),
    border: OutlineInputBorder(),
    ),
    ),width: screenWidth/2,),

    ],)
    ],);
  }
  
}