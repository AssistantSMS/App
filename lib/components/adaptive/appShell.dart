import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:after_layout/after_layout.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:universal_html/html.dart' as html;

import '../../constants/AppImage.dart';
import '../../integration/router.dart';
import '../../theme/themes.dart';

class AdaptiveAppShell extends StatefulWidget {
  final TranslationsDelegate newLocaleDelegate;

  const AdaptiveAppShell({
    Key? key,
    required this.newLocaleDelegate,
  }) : super(key: key);

  @override
  _AppShellWidget createState() => _AppShellWidget();
}

class _AppShellWidget extends State<AdaptiveAppShell>
    with AfterLayoutMixin<AdaptiveAppShell> {
  //
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

    return AdaptiveTheme(
      initial: AdaptiveThemeMode.dark,
      light: getDynamicTheme(Brightness.dark),
      dark: getDynamicTheme(Brightness.dark),
      builder: appRenderer,
    );
  }

  Widget appRenderer(ThemeData theme, ThemeData darkTheme) {
    List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
      widget.newLocaleDelegate,
      GlobalMaterialLocalizations.delegate, //provides localised strings
      GlobalWidgetsLocalizations.delegate, //provides RTL support
    ];
    List<Locale> supportedLangs = getLanguage().supportedLocales();

    ScrollBehavior? scrollBehavior;
    if (isWindows) {
      scrollBehavior = const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      );
    }

    // Widget matApp = FeedbackWrapper(
    //   options: FeedbackOptions(
    //     buildNumber: appsBuildNum.toString(),
    //     buildVersion: appsBuildName,
    //     buildCommit: appsCommit,
    //     // TODO Supply these details
    //     currentLang: 'en', //introViewModel.currentLanguage,
    //     isPatron: false, //introViewModel.isPatron,
    //   ),
    //   child: MaterialApp(
    //     title: 'Assistant for Scrap Mechanic',
    //     scrollBehavior: scrollBehavior,
    //     darkTheme: getDynamicTheme(Brightness.dark),
    //     theme: theme,
    //     onGenerateRoute: CustomRouter.configureRoutes().generator,
    //     localizationsDelegates: localizationsDelegates,
    //     supportedLocales: supportedLangs,
    //   ),
    // );

    Widget matApp = MaterialApp(
      title: 'Assistant for Scrap Mechanic',
      scrollBehavior: scrollBehavior,
      darkTheme: getDynamicTheme(Brightness.dark),
      theme: theme,
      onGenerateRoute: CustomRouter.configureRoutes().generator,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLangs,
    );

    if (!isWindows) return matApp;

    return MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: WindowTitleBar(
          title: 'Assistant for Scrap Mechanic',
          iconPath: AppImage.assistantSMSWindowIcon,
        ),
        body: matApp,
      ),
    );
  }
}
