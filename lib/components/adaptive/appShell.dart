import 'package:after_layout/after_layout.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:universal_html/html.dart' as html;

import '../../env/appRouter.dart';
import '../../integration/themeManager.dart';
import '../../theme/themes.dart';

class AdaptiveAppShell extends StatefulWidget {
  final newLocaleDelegate;

  AdaptiveAppShell({
    this.newLocaleDelegate,
  });

  @override
  _AppShellWidget createState() => _AppShellWidget();
}

class _AppShellWidget extends State<AdaptiveAppShell>
    with AfterLayoutMixin<AdaptiveAppShell> {
  @override
  void afterFirstLayout(BuildContext context) {
    if (!isWeb) return;
    var loadingElement = html.window.document.getElementById('initial-loader');
    if (loadingElement == null) return;
    loadingElement.remove();
  }

  @override
  Widget build(BuildContext context) {
    getLog().i("main rebuild");

    List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
      widget.newLocaleDelegate,
      GlobalMaterialLocalizations.delegate, //provides localised strings
      GlobalWidgetsLocalizations.delegate, //provides RTL support
    ];
    List<Locale> supportedLangs = getTranslations().supportedLocales().toList();

    return ThemeModeHandler(
      key: Key('ThemeModeHandler'),
      manager: ThemeManager(),
      builder: (ThemeMode themeMode) => MaterialApp(
        title: 'Assistant for Scrap Mechanic',
        themeMode: themeMode,
        darkTheme: getDynamicTheme(Brightness.dark),
        theme: getDynamicTheme(Brightness.light),
        onGenerateRoute: AppRouter.router.generator,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLangs,
      ),
    );
  }
}
