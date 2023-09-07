import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eat/constants/middleware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home/view/homepage.dart';
import '../subscription/subscription_page.dart';

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 2;
  MiddleWare middleWare = MiddleWare();
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _onItemTapped(2);
    final items = <Widget>[
      // Container(child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.category,size: 30,color: Colors.white,),Text("Menu",style: middleWare.customTextStyle(10, Colors.white, FontWeight.normal),)],),),
      // Container(child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.shopping_bag_outlined,size: 30,color: Colors.white,),Text("Menu",style: middleWare.customTextStyle(10, Colors.white, FontWeight.normal),)],),),
      // Icon(Icons.home,size: 30,color: Colors.white,),
      // Container(child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.person,size: 30,color: Colors.white,),Text("Menu",style: middleWare.customTextStyle(10, Colors.white, FontWeight.normal),)],),),
      // Container(child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.menu,size: 30,color: Colors.white,),Text("Menu",style: middleWare.customTextStyle(10, Colors.white, FontWeight.normal),)],),),

      Icon(Icons.category,size: 30,color: Colors.white,),
      Icon(Icons.shopping_bag_outlined,size: 30,color: Colors.white,),
      Icon(Icons.home,size: 30,color: Colors.white,),
      Icon(Icons.person,size: 30,color: Colors.white,),
      Icon(Icons.menu,size: 30,color: Colors.white,),
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.transparent,
        color: middleWare.uiThemeColor,
        items: items,
        index: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}