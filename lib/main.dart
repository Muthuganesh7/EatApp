import 'package:eat/constants/middleware.dart';
import 'package:eat/home/view/homepage.dart';
import 'package:eat/route_setup.dart';
import 'package:eat/services/api/api_helper.dart';
import 'package:eat/services/api/eat_apis.dart';
import 'package:eat/theme.dart';
import 'package:eat/ui/landingpage/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation/bottom_navigation_page.dart';
import 'common_providers/connectivity_service.dart';
import 'common_providers/theme_provider.dart';
import 'constants/route_const.dart';
import 'constants/shared_preference_const.dart';
import 'constants/shared_preference_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: ApiHandler()),
        // ChangeNotifierProvider(create: (context) => BottomBarVisibleModel()),
        ChangeNotifierProvider(
            create: (context) =>
                ConnectivityService(context: context, isCurrent: true)),
        // StreamProvider<DataConnectionStatus>(
        //     create: (_) => DataConnectionChecker().onStatusChange,
        //     initialData: dataConnectionStatus),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ProxyProvider<ApiHandler, EatApis>(
            update: (BuildContext context, ApiHandler apiHandler,
                EatApis eatApis) =>
                EatApis(apiHandler: apiHandler)),
      ],
      child: Consumer<ThemeProvider>(builder: (context, model, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Eat App',
          theme: CustomAppTheme.lightAppTheme,
          themeMode: model.themeMode,
          onGenerateRoute: RouterViews.generateRoute,
          home: SplashScreen(),
          //home: HomeView(),
        );
      }),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    return SplashScreenState();
  }
}
class SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver{
  MiddleWare middleWare = MiddleWare();
  bool userLogin = false;
  @override
  void initState() {
    try {
      super.initState();
      WidgetsBinding.instance.addObserver(this);
      Future.delayed(const Duration(milliseconds: 5000), () async {
        // middleWare.hideKeyBoard(context);
        try {
          /*Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              userLogin ? PatternView() : LoginView()));*/
          userLogin = await PreferenceHelper.getBool(PreferenceConst.isUserLogin);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
              userLogin == true ? BottomNavigationBarExample() : LandingPage()));
        } catch (e) {
          print(e);
        }

        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (BuildContext context) => LandingPage()));

      });
    } catch (e) {
      print(e);
    }
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        // Container(decoration: BoxDecoration(
        //   image: DecorationImage(image: AssetImage("assets/images/splash_screen.png"),fit: BoxFit.cover),
        // ),),
        Container(decoration: BoxDecoration(color: middleWare.uiBetaColor),child:Center(child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
            Image.asset("assets/images/splash_screen.png"),
          Container(child: Text("உணவே மருந்து",style: middleWare.customTextStyle(18, middleWare.uiThemeColor, FontWeight.bold),),)

        ],)),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,)
    );
  }

}
