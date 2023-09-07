import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

import '../constants/common_const.dart';

class ConnectivityService extends ChangeNotifier {
  bool isOnline = true;
  bool isShouldShowSnackBar = false;

  bool isCurrent = true;

  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController.broadcast();

  ConnectivityService({required BuildContext context, required this.isCurrent}) {
    try {
      Connectivity().checkConnectivity().then((value) {
        print("Connectivity Check $value");
        if (value == true) {
          isOnline = true;
        } else {
          isOnline = false;
        }
        notifyListeners();
      });
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
        print("Connectivity OnListen $result");
        if (result != ConnectivityResult.none) {
          isOnline = true;
          if (isShouldShowSnackBar) {
            isShouldShowSnackBar = false;
            if (isCurrent != null) {
              if (isCurrent && context != null) {
                /*  showSnackBar(context,
                  content: Text("Back Online"), backgroundColor: Colors.green);
              }*/
              }
            }
            if (isCurrent != null) {
              if (isCurrent)
                connectionStatusController.add(ConnectivityStatus.Online);
            }
          } else {
            isShouldShowSnackBar = true;
            isOnline = false;
            if (isCurrent != null) {
              if (isCurrent && context != null) {
                //showSnackBar(context, content: Text("You are Offline"));
              }
            }
            //connectionStatusController.add(ConnectivityStatus.Offline);
          }
          CommonConst.isOnline = isOnline;
          //  showLog("ConnectivityService :: isOnline -> $isOnline");
          notifyListeners();
        }});
    } catch (e) {
      print(e);
    }
  }
}

enum ConnectivityStatus { Online, Offline }

class DataConnectivityService {
  // StreamController<DataConnectionStatus> connectivityStreamController =
  //     StreamController<DataConnectionStatus>();
  //
  // DataConnectivityService() {
  //   try {
  //     DataConnectionChecker().onStatusChange.listen((dataConnectionStatus) {
  //       connectivityStreamController.add(dataConnectionStatus);
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
