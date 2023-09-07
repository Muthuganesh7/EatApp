// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../services/api/api_helper.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  BaseWidget({
    required Key key,
    required this.builder,
    required this.model,
    required this.child,
    required this.onModelReady,
  }) : super(key: key);

  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

bool isFirstTimeShow = false;

class BaseWidgetWithNetworkConnectivity<T extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Future<bool> Function(T) onModelReady;
  final bool isOffline;

  BaseWidgetWithNetworkConnectivity({
    required Key key,
    required this.builder,
    required this.model,
    required this.onModelReady,
    this.isOffline = false,
  }) : super(key: key);

  _BaseWidgetState1<T> createState() => _BaseWidgetState1<T>();
}

class _BaseWidgetState1<T extends ChangeNotifier>
    extends State<BaseWidgetWithNetworkConnectivity<T>> {
  late T model;

  //ConnectivityService connectivityService;
  // late DataConnectionStatus dataConnectionStatus;
  ValueNotifier<bool> isInitiallyLoaded = ValueNotifier(false);
  late BuildContext buildContext;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.dependOnInheritedWidgetOfExactType();
  }

  @override
  void initState() {
    try {
      super.initState();
      model = widget.model;
      if (widget.isOffline) isInitiallyLoaded.value = true;
      Future.delayed(Duration.zero, () async {
        if (await InternetConnectionChecker().hasConnection == true) {
          widget.onModelReady(model).then((value) {
            isInitiallyLoaded.value = value;
          });
        }
        // DataConnectionChecker().onStatusChange.listen((event) {
        //   if (event == DataConnectionStatus.connected &&
        //       !isInitiallyLoaded.value) {
        //     widget.onModelReady(model).then((value) {
        //       isInitiallyLoaded.value = value;
        //     });
        //   }
          if (await InternetConnectionChecker().hasConnection == true) {
            if (isFirstTimeShow) {
              // showSnackBar(buildContext,
              //     content: Text("Back Online"), backgroundColor: Colors.green);
            }
            isFirstTimeShow = true;
          } else {
            //showOfflineSnackBar(buildContext);
           /* Scaffold.of(buildContext)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                duration: Duration(milliseconds: 2000),
                content: Text("You are Offline"),
              ));*/
          }
        });
      // });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // dataConnectionStatus = Provider.of<DataConnectionStatus>(context);
    buildContext = context;
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
      //  child: widget.child,
        builder: (context, model, child) {
          return ValueListenableBuilder(
            valueListenable: isInitiallyLoaded,
            builder: (context, value, child) {
              return InternetConnectionChecker().hasConnection == true
                  ? widget.builder(context, model, child ?? Container(child:Text("null")))
                  : value != null
                      ? widget.builder(context, model, child?? Container(child:Text("null")))
                      : NoInternetView(
                          onTap: () async {
                            if (await InternetConnectionChecker().hasConnection == true) {
                              widget.onModelReady(model).then((value) {
                                isInitiallyLoaded.value = value;
                              });
                            } else {
                              // showSnackBar(context,
                              //     content: Text("You are Offline"));
                            }
                          },
                        );
            },
          );
        },
      ),
    );
  }
}

class BaseWidgetWithNetworkConnectivity1<T extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(
      BuildContext context, T model, Widget child, bool isReady) builder;
  final T model;
  final Widget child;
  final Future<bool> Function(T) onModelReady;
  final bool isOffline;

  BaseWidgetWithNetworkConnectivity1({
    required Key key,
    required this.builder,
    required this.model,
    required this.child,
    required this.onModelReady,
    this.isOffline = false,
  }) : super(key: key);

  BaseWidgetWithNetworkConnectivityState1<T> createState() =>
      BaseWidgetWithNetworkConnectivityState1<T>();
}

class BaseWidgetWithNetworkConnectivityState1<T extends ChangeNotifier>
    extends State<BaseWidgetWithNetworkConnectivity1<T>> {
  late T model;

  //ConnectivityService connectivityService;
  // late DataConnectionStatus dataConnectionStatus;
  ValueNotifier<bool> isInitiallyLoaded = ValueNotifier(false);
  late BuildContext buildContext;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.dependOnInheritedWidgetOfExactType();
  }

  @override
  Future<void> initState() async {
    try {
      super.initState();
      model = widget.model;
      widget.builder(context, model, SizedBox(), false);
      if (widget.isOffline) isInitiallyLoaded.value = true;
      if (widget.onModelReady != null &&
          (await InternetConnectionChecker().hasConnection == true)) {
        widget.onModelReady(model).then((value) {
          isInitiallyLoaded.value = value;
        });
      }

      // Future.delayed(Duration.zero, () {
      //   DataConnectionChecker().onStatusChange.listen((event) {
      //     if (event == DataConnectionStatus.connected &&
      //         !isInitiallyLoaded.value) {
      //       widget.onModelReady(model).then((value) {
      //         isInitiallyLoaded.value = value;
      //       });
      //     }
      //     if (event == DataConnectionStatus.connected) {
      //       if (isFirstTimeShow) {
      //         // showSnackBar(buildContext,
      //         //     content: Text("Back Online"), backgroundColor: Colors.green);
      //       }
      //       isFirstTimeShow = true;
      //     } else {
      //      // showOfflineSnackBar(buildContext);
      //     }
      //   });
      // });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // dataConnectionStatus = Provider.of<DataConnectionStatus>(context);
    buildContext = context;
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        child: widget.child,
        builder: (context, model, child) {
          return ValueListenableBuilder(
            valueListenable: isInitiallyLoaded,
            builder: (context, value, child) {
              return InternetConnectionChecker().hasConnection == true
                  ? widget.builder(context, model, child!, true)
                  : value != null
                      ? widget.builder(context, model, child!, true)
                      : NoInternetView(
                          onTap: () async {
                            if (await InternetConnectionChecker().hasConnection == true) {
                              widget.onModelReady(model).then((value) {
                                isInitiallyLoaded.value = value;
                              });
                            } else {
                              // showSnackBar(context,
                              //     content: Text("You are Offline"));
                            }
                          },
                        );
            },
          );
        },
      ),
    );
  }
}

class RouteObserverUtil extends RouteObserver<PageRoute<dynamic>> {
  RouteObserverUtil({required this.onChange});

  final Function onChange;

  void _sendScreenView(PageRoute<dynamic> route) {
    //showLog("RouteObserverUtil :: _sendScreenView()");
    String? screenName = route.settings.name;
    if (onChange != null) {
      onChange(screenName);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: implement didPush
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }


  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    // TODO: implement didReplace
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }


}
