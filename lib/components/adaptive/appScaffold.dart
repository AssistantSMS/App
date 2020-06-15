import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/navigationHelper.dart';

Widget appScaffold(
  BuildContext context, {
  @required Widget appBar,
  Widget body,
  Widget Function(BuildContext scaffoldContext) builder,
  Widget drawer,
  Widget floatingActionButton,
  FloatingActionButtonLocation floatingActionButtonLocation,
}) {
  var deviceAppBar = appBar != null ? appBar : null;
  var customBody =
      builder != null ? Builder(builder: (inner) => builder(inner)) : body;
  return WillPopScope(
      onWillPop: () => navigateBackOrHomeAsync(context),
      child: Scaffold(
        appBar: deviceAppBar,
        body: customBody,
        drawer: drawer,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ));
}
