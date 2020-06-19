import 'package:flutter/material.dart';

import '../pages/about.dart';
import '../pages/cart/cartPage.dart';
import '../pages/donation.dart';
import '../pages/home.dart';
import '../pages/news/steamNewsPage.dart';
import '../pages/settings.dart';

class Routes {
  static const String home = '/';
  static const String about = '/about';
  static const String settings = '/settings';
  static const String donation = '/donation';
  static const String cart = '/cart';
  static const String steamNews = '/steamNews';
}

Map<String, Widget Function(BuildContext)> initNamedRoutes(
  void Function(BuildContext context) changeBrightness,
  void Function(Locale locale) onLocaleChange,
) {
  Map<String, WidgetBuilder> routes = Map();
  routes.addAll({
    Routes.home: (context) => Home(changeBrightness, onLocaleChange),
    Routes.about: (context) => About(),
    Routes.settings: (context) =>
        SettingsPage(changeBrightness, onLocaleChange),
    Routes.donation: (context) => DonationPage(),
    Routes.cart: (context) => CartPage(),
    Routes.steamNews: (context) => SteamNewsPage(),
  });
  return routes;
}
