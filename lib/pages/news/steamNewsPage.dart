import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/bottomNavbar.dart';
import '../../components/searchableList.dart';
import '../../components/tilePresenters/steamNewsTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/generated/SteamNewsItem.dart';
import '../../helpers/analytics.dart';
import '../../helpers/columnHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../services/json/backupJsonService.dart';

class SteamNewsPage extends StatelessWidget {
  SteamNewsPage() {
    trackEvent(AnalyticsEvent.steamNewsPage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(Translations.get(context, LocaleKey.news)),
      ),
      body: SearchableList<SteamNewsItem>(
        () => getSteamApiRepo().getSteamNews(),
        steamNewsItemTilePresenter,
        (_, __) => false,
        backupListGetter: () => BackupJsonService().getSteamNews(context),
        backupListWarningMessage: LocaleKey.failedLatestDisplayingOld,
        minListForSearch: 20000,
        useGridView: true,
        gridViewColumnCalculator: steamNewsCustomColumnCount,
      ),
      bottomNavigationBar: BottomNavbar(noRouteSelected: true),
    );
  }
}
