import 'package:eat/constants/middleware.dart';
import 'package:eat/constants/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/route_const.dart';


class ConfirmAddress extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ConfirmAddressState();
  }

}
class ConfirmAddressState extends State<ConfirmAddress>{
  @override
  Widget build(BuildContext context) {
    MiddleWare middleWare = MiddleWare();
    // TODO: implement build
    return Scaffold(
      appBar: getAppBar(middleWare),
      body: SingleChildScrollView(
        child: Column(
          children: [
            middleWare.putSizedBoxHeight(20),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(location, style: middleWare.customTextStyle(20, middleWare.uiThemeColor, FontWeight.bold)),
                  middleWare.putSizedBoxHeight(10),
                  getLocation(middleWare),
                  SizedBox(height: 30),
                  getForm(middleWare),
                  SizedBox(height: 30),
                  getCategories(middleWare),
                  SizedBox(
                    height:20,
                  ),
                  Container(
                    width:MediaQuery.of(context).size.width,
                    height: 50,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  middleWare.uiThemeColor,
                        foregroundColor:  middleWare.uiThemeColor,
                      ),

                      onPressed: () {
                        Navigator.pushNamed(context, RoutePaths.BookingSuccessPage);
                      },
                      child: Text(confirmAddress, style: middleWare.customTextStyle(16, Colors.white, FontWeight.bold)),
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  getLocation(MiddleWare middleWare){
    return Container(
        child: Row(children: [
          Container(child: Image.asset("assets/images/pin.png",height: 25,width: 25,),),
          middleWare.putSizedBoxWidth(10),
          Container(width: MediaQuery.of(context).size.width/1.5,child: Text("Thirvalluvara Nagar, Padi Kuppam Annanagar West, Chennai -40",style: middleWare.customTextStyle(14, Colors.black, FontWeight.normal),maxLines: 2,overflow: TextOverflow.ellipsis,))
        ],)
    );
  }
  getForm(MiddleWare middleWare){
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child:Column (
        children :[TextField(
          decoration: InputDecoration(
            hintText: doorno,
            hintStyle: TextStyle(color: middleWare.uiThemeColor),
            border: OutlineInputBorder(),
          ),
        ),
          SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              hintText: streetAddress,
              hintStyle: TextStyle(color: middleWare.uiThemeColor),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              hintText: city,
              hintStyle: TextStyle(color: middleWare.uiThemeColor),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              hintText: zip,
              hintStyle: TextStyle(color: middleWare.uiThemeColor),
              border: OutlineInputBorder(),
            ),
          ),],
      ),
    );
  }
  getCategories(MiddleWare middleWare){
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child:Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:  middleWare.uiThemeColor,
              foregroundColor:  middleWare.uiThemeColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), side: BorderSide(width: 2.0,),
            ),
            onPressed: () {},
            child: Text(home, style:middleWare.customTextStyle(14, Colors.white, FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), side: BorderSide(width: 2.0,),
            ),
            onPressed: () {},
            child: Text(office, style:middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.w500)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), side: BorderSide(width: 2.0,),),
            onPressed: () {},
            child: Text('Office', style:middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.w500)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), side: BorderSide(width: 2.0,),),
            onPressed: () {},
            child: Text('city', style:middleWare.customTextStyle(14, middleWare.uiThemeColor, FontWeight.w500)),
          ),
        ],
      ),
    );
  }
getAppBar(MiddleWare middleWare){
    return AppBar(elevation: 0,automaticallyImplyLeading: false,actions: [
      GestureDetector(child: Container(alignment: Alignment.centerLeft,width: MediaQuery.of(context).size.width,
          child:Row(mainAxisAlignment: MainAxisAlignment.start,children: [
            middleWare.putSizedBoxWidth(20),
            Image.asset("assets/images/previous.png",height: 30,width: 30,fit: BoxFit.fill,),
            middleWare.putSizedBoxWidth(20),
            Text(confirmAddress,style: middleWare.customTextStyle(15, middleWare.uiThemeColor, FontWeight.bold),)
          ])),onTap: (){
        Navigator.pop(context);
      })
    ]);
}
}