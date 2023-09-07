import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.IDLE;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    try {
      _state = viewState;
     // showLog("state: $viewState");
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

enum ViewState { BUSY, IDLE }
