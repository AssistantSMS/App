import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/AppImage.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/genericHelper.dart';

import '../constants/Routes.dart';
import '../helpers/listPageHelper.dart';
import '../pages/gameItem/gameItemListPage.dart';

class NavBarItem {
  Widget Function() icon;
  LocaleKey title;
  String route;
  Function onTap;
  NavBarItem(this.icon, this.title, {this.route, this.onTap});
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

  _BottomNavbarWidget(this.currentRoute, this.noRouteSelected) {
    List<NavBarItem> items = getItems(null);
    int index = items.indexWhere((item) => item.route == this.currentRoute);
    if (index >= 0) {
      currentRouteIndex = index;
    }
  }

  List<NavBarItem> getItems(BuildContext itemContext) {
    return [
      NavBarItem(
        () => Icon(Icons.list),
        LocaleKey.allItems,
        onTap: (BuildContext navContext) =>
            getNavigation().navigateAwayFromHomeAsync(
          navContext,
          navigateTo: (context) => GameItemListPage(
            LocaleKey.blocksAndItems,
            getBlocksAndItemsPageLocales(),
          ),
        ),
      ),
      NavBarItem(
        () => Icon(Icons.home),
        LocaleKey.home,
        route: Routes.home,
      ),
      NavBarItem(
        () => Icon(Icons.shopping_cart),
        LocaleKey.cart,
        route: Routes.cart,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Color unSelectedColour = Colors.white70;
    // Color selectedColour = getTheme().getSecondaryColour(context);
    Color selectedColour = Colors.white70;
    Color backgroundColour = getTheme().getBackgroundColour(context);
    List<NavBarItem> items = getItems(context);
    return CustomNavigationBar(
      items: items.map((nav) {
        Widget normalTitle = Text(getTranslations().fromKey(nav.title));
        Widget highlightedTitle = Text(
          getTranslations().fromKey(nav.title),
          style: TextStyle(color: selectedColour),
        );
        return CustomNavigationBarItem(
          icon: nav.icon(),
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
        NavBarItem selectedItem = items[i];
        if (selectedItem.onTap != null) {
          selectedItem.onTap(context);
          return;
        }
        String route = selectedItem.route;
        if (route == Routes.home) {
          getNavigation().navigateHomeAsync(context);
          return;
        }
        getNavigation().navigateAwayFromHomeAsync(
          context,
          navigateToNamed: route,
        );
      },
    );
  }
}
