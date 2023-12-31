import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:after_layout/after_layout.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:universal_html/html.dart' as html;

import '../../constants/AppImage.dart';
import '../../env/app_version_num.dart';
import '../../integration/router.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/base/intro_view_model.dart';
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

    List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
      widget.newLocaleDelegate,
      GlobalMaterialLocalizations.delegate, //provides localised strings
      GlobalWidgetsLocalizations.delegate, //provides RTL support
    ];

    return StoreConnector<AppState, IntroViewModel>(
      converter: (store) => IntroViewModel.fromStore(store),
      builder: (_, introViewModel) {
        return AdaptiveTheme(
          initial: AdaptiveThemeMode.dark,
          light: getDynamicTheme(Brightness.dark),
          dark: getDynamicTheme(Brightness.dark),
          builder: (ThemeData theme, ThemeData darkTheme) {
            return _androidApp(
              context,
              Key('android-${introViewModel.currentLanguage}'),
              theme,
              darkTheme,
              introViewModel,
              localizationsDelegates,
              getLanguage().supportedLocales(),
            );
          },
        );
      },
    );
  }

  Widget _androidApp(
    BuildContext context,
    Key? key,
    ThemeData theme,
    ThemeData darkTheme,
    IntroViewModel introViewModel,
    List<LocalizationsDelegate<dynamic>> localizationsDelegates,
    List<Locale> supportedLocales,
  ) {
    List<Locale> supportedLangs = getLanguage().supportedLocales();

    ScrollBehavior? scrollBehavior;
    if (isDesktop || isWeb) {
      scrollBehavior = const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      );
    }

    Widget matApp = FeedbackWrapper(
      options: FeedbackOptions(
        buildNumber: appsBuildNum.toString(),
        buildVersion: appsBuildName,
        buildCommit: appsCommit,
        currentLang: introViewModel.currentLanguage,
        isPatron: introViewModel.isPatron,
      ),
      child: MaterialApp(
        title: 'Assistant for Scrap Mechanic',
        scrollBehavior: scrollBehavior,
        darkTheme: getDynamicTheme(Brightness.dark),
        theme: theme,
        onGenerateRoute: CustomRouter.configureRoutes().generator,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLangs,
      ),
    );

    if (isDesktop) {
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

    return MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: matApp),
    );
  }
}
