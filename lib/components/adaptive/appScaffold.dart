import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class AdaptiveAppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget Function(BuildContext scaffoldContext)? builder;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AdaptiveAppScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.builder,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _kTabletBreakpoint = 720.0;
    const _kDesktopBreakpoint = 1440.0;
    var customBody = builder != null //
        ? Builder(builder: (inner) => builder!(inner))
        : (body ?? const Center(child: Text('error')));

    return WillPopScope(
      onWillPop: () => getNavigation().navigateBackOrHomeAsync(context),
      child: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= _kDesktopBreakpoint) {
            return Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (drawer != null) ...[SafeArea(child: drawer!)],
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
              drawer: (drawer != null) ? SafeArea(child: drawer!) : null,
              appBar: appBar,
              body: SafeArea(
                right: false,
                bottom: false,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(child: customBody),
                      ],
                    ),
                    if (floatingActionButton != null) ...[
                      Positioned(
                        top: 10.0,
                        left: 10.0,
                        child: floatingActionButton!,
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
}
