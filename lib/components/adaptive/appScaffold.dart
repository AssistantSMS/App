import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/navigationHelper.dart';

Widget appScaffold(
  BuildContext context, {
  @required Widget appBar,
  Widget body,
  Widget Function(BuildContext scaffoldContext) builder,
  Widget drawer,
  Widget bottomNavigationBar,
  Widget floatingActionButton,
  FloatingActionButtonLocation floatingActionButtonLocation,
}) {
  final _kTabletBreakpoint = 720.0;
  final _kDesktopBreakpoint = 1440.0;
  final _drawerWidth = 304.0;
  var deviceAppBar = appBar != null ? appBar : null;
  var customBody =
      builder != null ? Builder(builder: (inner) => builder(inner)) : body;

  return WillPopScope(
    onWillPop: () => navigateBackOrHomeAsync(context),
    child: LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth >= _kDesktopBreakpoint) {
          return Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (drawer != null) ...[SafeArea(child: drawer)],
                  Expanded(
                    child: Scaffold(
                      appBar: deviceAppBar,
                      body: customBody,
                      floatingActionButton: floatingActionButton,
                      floatingActionButtonLocation:
                          floatingActionButtonLocation,
                    ),
                  ),
                ],
              ),
              if (floatingActionButton != null) ...[
                Positioned(
                  top: 100.0,
                  left: _drawerWidth - 30,
                  child: floatingActionButton,
                )
              ],
            ],
          );
        }
        if (constraints.maxWidth >= _kTabletBreakpoint) {
          return Scaffold(
            drawer: (drawer != null) ? SafeArea(child: drawer) : null,
            appBar: deviceAppBar,
            body: SafeArea(
              right: false,
              bottom: false,
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(child: customBody ?? Container()),
                    ],
                  ),
                  if (floatingActionButton != null) ...[
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: floatingActionButton,
                    )
                  ],
                ],
              ),
            ),
          );
        }
        return Scaffold(
          key: Key('homeScaffold-${constraints.maxWidth}'),
          appBar: deviceAppBar,
          body: customBody,
          drawer: drawer,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
        );
      },
    ),
  );
}
