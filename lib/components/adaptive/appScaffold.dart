import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

Widget adaptiveAppScaffold(
  BuildContext context, {
  @required Widget appBar,
  Widget body,
  Widget Function(BuildContext scaffoldContext) builder,
  Widget drawer,
  Widget bottomNavigationBar,
  Widget floatingActionButton,
  FloatingActionButtonLocation floatingActionButtonLocation,
}) {
  const _kTabletBreakpoint = 720.0;
  const _kDesktopBreakpoint = 1440.0;
  var customBody =
      builder != null ? Builder(builder: (inner) => builder(inner)) : body;

  return WillPopScope(
    onWillPop: () => getNavigation().navigateBackOrHomeAsync(context),
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
                      appBar: appBar,
                      body: customBody,
                      floatingActionButton: floatingActionButton,
                      floatingActionButtonLocation:
                          floatingActionButtonLocation,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        if (constraints.maxWidth >= _kTabletBreakpoint) {
          return Scaffold(
            drawer: (drawer != null) ? SafeArea(child: drawer) : null,
            appBar: appBar,
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
          appBar: appBar,
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
