import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/ExternalUrls.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/results/resultWithValue.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/external.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/futureHelper.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/snapshotHelper.dart';
import 'package:package_info/package_info.dart';

import '../components/adaptive/appBarForSubPage.dart';
import '../components/adaptive/appScaffold.dart';
import '../components/adaptive/listWithScrollbar.dart';
import '../components/tilePresenters/settingTilePresenter.dart';
import '../constants/AnalyticsEvent.dart';
import '../helpers/analytics.dart';
import '../helpers/colourHelper.dart';
import '../helpers/genericHelper.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';
import '../state/modules/base/appState.dart';
import '../state/modules/setting/settingViewModel.dart';

class SettingsPage extends StatelessWidget {
  final void Function(Locale locale) onLocaleChange;
  final void Function(BuildContext context) changeBrightness;
  SettingsPage(this.changeBrightness, this.onLocaleChange) {
    trackEvent(AnalyticsEvent.settingsPage);
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
      onChange: (Locale locale) => this.onLocaleChange(locale),
    ));

    widgets.add(boolSettingTilePresenter(
      context,
      Translations.get(context, LocaleKey.darkModeEnabled),
      getIsDark(context),
      onChange: () => changeBrightness(context),
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
