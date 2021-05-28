import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../constants/Routes.dart';

class NavBarItem {
  IconData icon;
  String title;
  String route;
  NavBarItem(this.icon, this.title, this.route);
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
  int currentRouteIndex = 1;
  final String currentRoute;
  final bool noRouteSelected;
  final List<NavBarItem> items = [
    NavBarItem(Icons.help_outline, 'About', Routes.about),
    NavBarItem(Icons.home, 'Home', Routes.home),
    NavBarItem(Icons.shopping_cart, 'Cart', Routes.cart),
  ];

  _BottomNavbarWidget(this.currentRoute, this.noRouteSelected) {
    int index = items.indexWhere((item) => item.route == this.currentRoute);
    if (index >= 0) {
      currentRouteIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color unSelectedColour = Colors.white70;
    Color selectedColour = getTheme().getSecondaryColour(context);
    Color backgroundColour = getTheme().getBackgroundColour(context);
    return CustomNavigationBar(
      items: items.map((nav) {
        Widget normalTitle = Text(nav.title);
        Widget highlightedTitle = Text(
          nav.title,
          style: TextStyle(color: selectedColour),
        );
        return CustomNavigationBarItem(
          icon: Icon(nav.icon),
          title: normalTitle,
          selectedTitle: this.noRouteSelected ? normalTitle : highlightedTitle,
        );
      }).toList(),
      currentIndex: currentRouteIndex,
      unSelectedColor: unSelectedColour,
      selectedColor: this.noRouteSelected ? unSelectedColour : selectedColour,
      backgroundColor: backgroundColour,
      onTap: (int i) {
        this.setState(() {
          currentRouteIndex = i;
        });
        String route = items[i].route;
        if (route == Routes.home) {
          getNavigation().navigateHomeAsync(context);
          return;
        }
        getNavigation().navigateAwayFromHomeAsync(
          context,
          navigateToNamed: items[i].route,
        );
      },
    );
  }
}
