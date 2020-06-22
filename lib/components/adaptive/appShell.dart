import 'package:universal_html/html.dart';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../constants/Routes.dart';
import '../../integration/logging.dart';
import '../../integration/themeManager.dart';
import '../../localization/localization.dart';
import '../../theme/themes.dart';

class AppShell extends StatefulWidget {
  final newLocaleDelegate;
  final changeBrightness;
  final onLocaleChange;

  AppShell({
    this.changeBrightness,
    this.onLocaleChange,
    this.newLocaleDelegate,
  });

  @override
  _AppShellWidget createState() => _AppShellWidget();
}

class _AppShellWidget extends State<AppShell> with AfterLayoutMixin<AppShell> {
  @override
  void afterFirstLayout(BuildContext context) {
    if (kIsWeb) {
      document.querySelector('#initial-loader').remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.i("main rebuild");
    Map<String, Widget Function(BuildContext)> routes = initNamedRoutes(
      widget.changeBrightness,
      widget.onLocaleChange,
    );
    List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
      widget.newLocaleDelegate,
      GlobalMaterialLocalizations.delegate, //provides localised strings
      GlobalWidgetsLocalizations.delegate, //provides RTL support
    ];
    List<Locale> supportedLocales = localization.supportedLocales().toList();

    String initialRoute = Routes.home;
    return ThemeModeHandler(
      manager: ThemeManager(),
      builder: (ThemeMode themeMode) => MaterialApp(
        title: 'Assistant for Scrap Mechanic',
        themeMode: themeMode,
        darkTheme: getDynamicTheme(Brightness.dark),
        theme: getDynamicTheme(Brightness.light),
        initialRoute: initialRoute,
        routes: routes,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
      ),
    );
  }
}
