import 'package:flutter/material.dart';

class AppGlobal {
  GlobalKey _scaffoldKey;
  AppGlobal() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;
}
