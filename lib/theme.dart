import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';


class CustomAppTheme {
  const CustomAppTheme();

  static ThemeData lightAppTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    accentColor: primaryColor,
    brightness: Brightness.light,

    appBarTheme: AppBarTheme(
        elevation: 2,
        color: Colors.white,
        textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.black),
            caption: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black)),
    primaryTextTheme: TextTheme(subtitle1: TextStyle(color: Colors.black)),
    backgroundColor: lightBackgroundColor,
    hoverColor: lightIconBackgroundColor,
    dividerColor: lightIconBackgroundColor,
    sliderTheme: SliderThemeData(trackShape: CustomTrackShape()),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.white),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: lightBackgroundColor,
        modalBackgroundColor: lightBackgroundColor),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        color: Colors.black,
      ),
    ),
  );

  static ThemeData darkAppTheme = ThemeData.dark().copyWith(
    //primarySwatch: Colors.red,
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    accentColor: primaryColor,
    //cursorColor: primaryColor,
    appBarTheme: AppBarTheme(
        elevation: 4,
        //color: Color(0xff212121),
        color: darkBackgroundColor,
        textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white)),
    backgroundColor: darkBackgroundColor,
    hoverColor: darkIconBackgroundColor,
    dividerColor: Colors.black.withOpacity(0.5),
    sliderTheme: SliderThemeData(trackShape: CustomTrackShape()),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: darkBackgroundColor),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: darkBackgroundColor,
        modalBackgroundColor: darkBackgroundColor),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        color: Colors.white,
      ),
    ),
  );

  static Brightness brightness(BuildContext context) {
    return Theme.of(context).brightness;
  }

  static TextStyle titleStyle =
      const TextStyle(color: Colors.black54, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: Colors.grey, fontSize: 12);

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static var circleBorder = (double size) =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(size));

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static var textFieldDecoration1 = (String label) => InputDecoration(
        //floatingLabelBehavior: FloatingLabelBehavior.auto,

        //hoverColor: Colors.grey,
        contentPadding: EdgeInsets.only(bottom: 6, top: 0),
        labelText: label,
        labelStyle: TextStyle(fontSize: 16.6, fontWeight: FontWeight.w500),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: blue, width: 1),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.6)),
      );

  static var textFieldDecoration =
      (BuildContext context, String label) => InputDecoration(
            //floatingLabelBehavior: FloatingLabelBehavior.auto,
            fillColor: Theme.of(context).brightness == Brightness.light
                ? Color(0xffF5F5F5)
                : Theme.of(context).hoverColor.withOpacity(0.6),
            filled: true,
            //hoverColor: Colors.grey,
            //contentPadding: EdgeInsets.only(bottom: 6, top: 10, left: 10.0,),
            labelText: label,
            //border: InputBorder,
            labelStyle: TextStyle(fontSize: 15.6, fontWeight: FontWeight.w400),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[700]!, width: 1.3),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[100]!
                        : Colors.grey.withOpacity(0.4),
                    width: 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
          );

  static var boxTextFieldDecoration = (String label) => InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 18, bottom: 18, left: 14, right: 14),
        labelText: label,
        //labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          /*borderSide: BorderSide(
            color: Colors.red.withOpacity(0.7),
          ),*/
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide:
              BorderSide(color: Colors.grey.withOpacity(0.8), width: 0.7),
        ),
      );
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    //final double trackHeight = sliderTheme.trackHeight;
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, 3);
    //return Rect.fromLTRB(trackLeft, trackTop, trackTop, trackHeight);
  }
}
