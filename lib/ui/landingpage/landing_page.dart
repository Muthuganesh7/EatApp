import 'package:carousel_slider/carousel_slider.dart';
import 'package:eat/constants/middleware.dart';
import 'package:eat/constants/string_constant.dart';
import 'package:eat/ui/landingpage/landing_three.dart';
import 'package:eat/ui/landingpage/landing_two.dart';
import 'package:eat/ui/landingpage/landingone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LandingPageState();
  }

}
class LandingPageState extends State<LandingPage>{
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> sliderList = [
    landing_one_text,
    landing_second_text,
    landing_three_text
  ];
  MiddleWare middleWare = MiddleWare();
  @override
  Widget build(BuildContext context) {
    final List<Widget> sliders = sliderList
        .map((item) => LandingOnePage())
        .toList();
    // TODO: implement build
  return Scaffold(
    body: Container(height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(color: Colors.white),
    child: Column(children: [
      getSlider(sliders),
    ]),)
  );
  }
  getSlider(List<Widget> sliders) {
    return WillPopScope(
        onWillPop: () async {
      onBackPressed(); // Action to perform on back pressed
      return false;
    },
    child:SingleChildScrollView(child: Container( child: Column(children: [
      Container(height: MediaQuery.of(context).size.height-30,
          child: CarouselSlider(
        items: [LandingOnePage(),LandingTwoPage(),LandingThreePage()],
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: false,
            viewportFraction: 1,
            height: MediaQuery.of(context).size.height-30,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      )),
      Container(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: sliderList
            .asMap()
            .entries
            .map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),height: 30,)

    ]),),));
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
}