
import 'package:eat/restaurant_details/view/restaurant_details_page.dart';
import 'package:eat/subscription/subscription_page.dart';
import 'package:eat/ui/landingpage/landing_page.dart';
import 'package:eat/ui/landingpage/register_success.dart';
import 'package:eat/ui/loginandregister/view/mobile_verification.dart';
import 'package:eat/ui/loginandregister/view/otppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'bottom_navigation/bottom_navigation_page.dart';
import 'cart/view/booking_success.dart';
import 'cart/view/cartpage.dart';
import 'cart/view/confirm_address.dart';
import 'constants/route_const.dart';

abstract class RouterViews {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
      switch (settings.name) {
        case RoutePaths.Landing:
          return PageTransition(child: LandingPage(),type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400));
        case RoutePaths.MobileVerification:
          return PageTransition(child: MobileNumberVerification(),type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400));
        case RoutePaths.OtpVerification:
          return PageTransition(child: OtpPage(),type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400));
        case RoutePaths.RegisterSuccess:
          return PageTransition(child: RegisterSuccessPage(),type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400));
        case RoutePaths.RestaurantDetailsPage:
          return PageTransition(child: RestaurantDetailsPage(),type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400));
        case RoutePaths.Cart:
          return PageTransition(child: CartPage(),type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400));
        case RoutePaths.ConfirmAddress:
          return PageTransition(child: ConfirmAddress(),type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400));
        case RoutePaths.BookingSuccessPage:
          return PageTransition(child: BookingSuccessPage(),type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400));
        case RoutePaths.BottomNavigationPage:
          return PageTransition(child: BottomNavigationBarExampleApp(),type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400));
        case RoutePaths.SubscriptionPage:
          return PageTransition(child: SubscriptionPage(),type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400));

        default:
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Center(
                      child: Text('No route defined for ${settings.name}'),
                    ),
                  ));
      }
  }
}
