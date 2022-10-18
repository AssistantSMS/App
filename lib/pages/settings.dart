import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/bottomNavbar.dart';
import '../components/dialogs/prettyDialog.dart';
import '../components/tilePresenters/settingTilePresenter.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/AppImage.dart';
import '../state/modules/base/appState.dart';
import '../state/modules/setting/settingViewModel.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.settingsPage);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.settings)),
      ),
      body: StoreConnector<AppState, SettingViewModel>(
        converter: (store) => SettingViewModel.fromStore(store),
        builder: (_, viewModel) => getBody(context, viewModel),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }

  Widget getBody(BuildContext localCtx, SettingViewModel viewModel) {
    List<Widget> widgets = List.empty(growable: true);

    widgets.add(headingSettingTilePresenter(
        getTranslations().fromKey(LocaleKey.general)));

    widgets.add(languageSettingTilePresenter(
      localCtx,
      getTranslations().fromKey(LocaleKey.appLanguage),
      viewModel.selectedLanguage,
      onChange: (Locale locale) {
        LocalizationMap newLocal = getTranslations()
            .getCurrentLocalizationMap(localCtx, locale.languageCode);
        if (newLocal.code == 'it' || newLocal.code == 'zh-hans') {
          prettyDialog(
            localCtx,
            AppImage.translate,
            getTranslations().fromKey(LocaleKey.translation),
            getTranslations()
                .fromKey(LocaleKey.translationIssue)
                .replaceAll('{0}', getTranslations().fromKey(newLocal.name)),
            onlyCancelButton: true,
            onSuccess: () => viewModel.changeLanguage(locale),
          );
        } else {
          viewModel.changeLanguage(locale);
        }
      },
    ));

    widgets.add(
      headingSettingTilePresenter(getTranslations().fromKey(LocaleKey.other)),
    );

    widgets.add(logTilePresenter(localCtx));

    widgets.add(linkSettingTilePresenter(
      localCtx,
      getTranslations().fromKey(LocaleKey.privacyPolicy),
      icon: Icons.description,
      onTap: () => launchExternalURL(ExternalUrls.privacyPolicy),
    ));

    widgets.add(linkSettingTilePresenter(
      localCtx,
      getTranslations().fromKey(LocaleKey.termsAndConditions),
      icon: Icons.description,
      onTap: () => launchExternalURL(ExternalUrls.termsAndConditions),
    ));

    widgets.add(
      legalTilePresenter(description: LocaleKey.fairUseDisclaimer),
    );

    widgets.add(emptySpace3x());

    return listWithScrollbar(
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index]);
  }
}
