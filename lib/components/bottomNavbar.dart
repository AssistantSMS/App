// ignore_for_file: no_logic_in_create_state

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../constants/Routes.dart';
import '../helpers/listPageHelper.dart';
import '../pages/gameItem/gameItemListPage.dart';

class NavBarItem {
  IconData icon;
  LocaleKey title;
  String route;
  void Function(BuildContext)? onTap;

  NavBarItem(
    this.icon,
    this.title, {
    required this.route,
    this.onTap,
  });
}

class BottomNavbar extends StatefulWidget {
  final String? currentRoute;

  const BottomNavbar({
    Key? key,
    this.currentRoute,
  }) : super(key: key);

  @override
  createState() => _BottomNavbarWidget(currentRoute);
}

class _BottomNavbarWidget extends State<BottomNavbar>
    with SingleTickerProviderStateMixin {
  int currentRouteIndex = -1;

  _BottomNavbarWidget(String? initialRoute) {
    List<NavBarItem> items = getItems(null);
    int index = items.indexWhere(
      (item) => item.route == initialRoute,
    );
    if (index >= 0) {
      currentRouteIndex = index;
    }
  }

  List<NavBarItem> getItems(BuildContext? itemContext) {
    return [
      NavBarItem(
        Icons.list,
        LocaleKey.allItems,
        route: Routes.allItems,
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
        Icons.home,
        LocaleKey.home,
        route: Routes.home,
      ),
      NavBarItem(
        Icons.shopping_cart,
        LocaleKey.cart,
        route: Routes.cart,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Color unSelectedColour = Colors.white38;
    Color selectedColour = Colors.white;
    Color selectedBgColour = getTheme().getSecondaryColour(context);
    Color backgroundColour = Colors.white10;
    List<NavBarItem> items = getItems(context);
    return FloatingNavbar(
      items: items
          .map(
            (item) => FloatingNavbarItem(
              icon: item.icon,
              title: getTranslations().fromKey(item.title),
            ),
          )
          .toList(),
      backgroundColor: backgroundColour,
      selectedItemColor: selectedColour,
      unselectedItemColor: unSelectedColour,
      selectedBackgroundColor: selectedBgColour,
      currentIndex: currentRouteIndex,
      // onTap: (index) => setState(() => _bottomNavIndex = index),
      onTap: (int i) {
        if (currentRouteIndex == i) return;
        // setState(() {
        //   currentRouteIndex = i;
        // });
        NavBarItem selectedItem = items[i];
        if (selectedItem.onTap != null) {
          selectedItem.onTap!(context);
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
