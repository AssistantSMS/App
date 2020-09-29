import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../constants/Routes.dart';
import '../helpers/colourHelper.dart';
import '../helpers/navigationHelper.dart';

class NavBarItem {
  String route;
  FFNavigationBarItem child;
  NavBarItem(this.child, this.route);
}

class BottomNavbar extends StatefulWidget {
  final String currentRoute;
  final bool noRouteSelected;
  BottomNavbar({this.currentRoute, this.noRouteSelected = false});
  @override
  _BottomNavbarWidget createState() =>
      _BottomNavbarWidget(currentRoute, noRouteSelected);
}

class _BottomNavbarWidget extends State<BottomNavbar> {
  final String currentRoute;
  final bool noRouteSelected;
  static List<NavBarItem> navBarItems = [
    NavBarItem(
      FFNavigationBarItem(
        iconData: Icons.help_outline,
        label: 'About',
      ),
      Routes.about,
    ),
    NavBarItem(
      FFNavigationBarItem(
        iconData: Icons.home,
        label: 'Home',
      ),
      Routes.home,
    ),
    NavBarItem(
      FFNavigationBarItem(
        iconData: Icons.shopping_cart,
        label: 'Cart',
      ),
      Routes.cart,
    ),
  ];
  int selectedIndex = ((navBarItems.length - 1) / 2).floor();
  _BottomNavbarWidget(this.currentRoute, this.noRouteSelected) {
    if (noRouteSelected) {
      selectedIndex = null;
      return;
    }
    if (navBarItems.any((navItem) => navItem.route == this.currentRoute)) {
      selectedIndex = navBarItems
          .indexWhere((navItem) => navItem.route == this.currentRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    var secondaryColour = getSecondaryColour(context);
    var foregroundColour = getH1Colour(context);
    var backgroundColour = getBackgroundColour(context);
    var theme = FFNavigationBarTheme(
      barBackgroundColor: backgroundColour,
      selectedItemBorderColor: backgroundColour,
      selectedItemIconColor: foregroundColour,
      selectedItemBackgroundColor: secondaryColour,
      selectedItemLabelColor: foregroundColour,
      unselectedItemIconColor: foregroundColour,
      unselectedItemLabelColor: foregroundColour,
    );
    return FFNavigationBar(
      key: Key('NavBar' + getIsDark(context).toString()),
      theme: theme,
      selectedIndex: null,
      // selectedIndex: selectedIndex,
      onSelectTab: (index) {
        if (navBarItems[index] != null && navBarItems[index].route != null) {
          navigateHomeAsync(
            context,
            navigateToNamed: navBarItems[index].route,
          );
        }
        setState(() {
          selectedIndex = index;
        });
      },
      items: navBarItems.map((nb) => nb.child).toList(),
    );
  }
}
