import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../pages/about.dart';
import '../pages/settings.dart';

class Routes {
  static const String home = '/';
  static const String about = '/about';
  static const String settings = '/settings';
}

Map<String, Widget Function(BuildContext)> initNamedRoutes(
  void Function(BuildContext context) changeBrightness,
  void Function(Locale locale) onLocaleChange,
) {
  Map<String, WidgetBuilder> routes = Map();
  routes.addAll({
    Routes.home: (context) => Home(changeBrightness, onLocaleChange),
    Routes.about: (context) => About(),
    Routes.settings: (context) => Settings(changeBrightness, onLocaleChange),
  });
  return routes;
}
