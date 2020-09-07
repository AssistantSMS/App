import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:package_info/package_info.dart';
import 'package:scrapmechanic_kurtlourens_com/components/bottomNavbar.dart';
import 'package:scrapmechanic_kurtlourens_com/integration/themeManager.dart';

import '../components/adaptive/appBarForSubPage.dart';
import '../components/adaptive/appScaffold.dart';
import '../components/adaptive/listWithScrollbar.dart';
import '../components/dialogs/prettyDialog.dart';
import '../components/tilePresenters/settingTilePresenter.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/AppImage.dart';
import '../constants/ExternalUrls.dart';
import '../constants/SupportedLanguages.dart';
import '../contracts/results/resultWithValue.dart';
import '../helpers/analytics.dart';
import '../helpers/colourHelper.dart';
import '../helpers/external.dart';
import '../helpers/futureHelper.dart';
import '../helpers/genericHelper.dart';
import '../helpers/snapshotHelper.dart';
import '../localization/localeKey.dart';
import '../localization/localizationMap.dart';
import '../localization/translations.dart';
import '../state/modules/base/appState.dart';
import '../state/modules/setting/settingViewModel.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage() {
    trackEvent(AnalyticsEvent.settingsPage);
  }

  void _changeBrightness(BuildContext context) {
    bool isDark = getIsDark(context);
    setBrightness(context, isDark);
    trackEvent(isDark ? AnalyticsEvent.lightMode : AnalyticsEvent.darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(Translations.get(context, LocaleKey.settings)),
      ),
      body: StoreConnector<AppState, SettingViewModel>(
        converter: (store) => SettingViewModel.fromStore(store),
        builder: (_, viewModel) => getBody(context, viewModel),
      ),
      bottomNavigationBar: BottomNavbar(noRouteSelected: true),
    );
  }

  Widget getBody(BuildContext context, SettingViewModel viewModel) {
    List<Widget> widgets = List<Widget>();

    widgets.add(headingSettingTilePresenter(
        Translations.get(context, LocaleKey.general)));

    widgets.add(languageSettingTilePresenter(
      context,
      Translations.get(context, LocaleKey.appLanguage),
      viewModel.selectedLanguage,
      onChange: (Locale locale) {
        viewModel.changeLanguage(locale);
        LocalizationMap newLocal = supportedLanguageMaps.firstWhere(
          (LocalizationMap localizationMap) =>
              localizationMap.code == locale.languageCode,
          orElse: () => supportedLanguageMaps[0],
        );
        if (newLocal.code == 'it' || newLocal.code == 'zh-hans') {
          prettyDialog(
            context,
            AppImage.translate,
            Translations.get(context, LocaleKey.translation),
            Translations.get(context, LocaleKey.translationIssue)
                .replaceAll('{0}', Translations.get(context, newLocal.name)),
            onlyCancelButton: true,
          );
        }
      },
    ));

    widgets.add(boolSettingTilePresenter(
      context,
      Translations.get(context, LocaleKey.darkModeEnabled),
      getIsDark(context),
      onChange: () => _changeBrightness(context),
    ));

    widgets.add(
      headingSettingTilePresenter(Translations.get(context, LocaleKey.other)),
    );

    widgets.add(linkSettingTilePresenter(
      context,
      Translations.get(context, LocaleKey.privacyPolicy),
      icon: Icons.description,
      onTap: () => launchExternalURL(ExternalUrls.privacyPolicy),
    ));

    widgets.add(linkSettingTilePresenter(
      context,
      Translations.get(context, LocaleKey.termsAndConditions),
      icon: Icons.description,
      onTap: () => launchExternalURL(ExternalUrls.termsAndConditions),
    ));

    widgets.add(
      FutureBuilder<ResultWithValue<PackageInfo>>(
          future: currentAppVersion(),
          builder: (BuildContext context,
              AsyncSnapshot<ResultWithValue<PackageInfo>> snapshot) {
            Widget errorWidget = asyncSnapshotHandler(context, snapshot);
            if (errorWidget != null) return errorWidget;
            return linkSettingTilePresenter(
              context,
              Translations.get(context, LocaleKey.legal),
              icon: Icons.description,
              onTap: () => showAboutDialog(
                context: context,
                applicationLegalese:
                    Translations.get(context, LocaleKey.fairUseDisclaimer),
                applicationVersion: snapshot?.data?.value?.version ?? 'v1.0',
              ),
            );
          }),
    );

    widgets.add(emptySpace3x());

    return listWithScrollbar(
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index]);
  }
}
