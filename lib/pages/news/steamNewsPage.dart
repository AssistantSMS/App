import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart'
    hide BackupJsonService;
import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/bottomNavbar.dart';
import '../../components/tilePresenters/steamNewsTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/generated/SteamNewsItem.dart';
import '../../helpers/analytics.dart';
import '../../integration/dependencyInjection.dart';
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
        title: Text(getTranslations().fromKey(LocaleKey.news)),
      ),
      body: SearchableGrid<SteamNewsItem>(
        () => getSteamApiRepo().getSteamNews(),
        gridItemWithIndexDisplayer: steamNewsItemTilePresenter,
        gridItemSearch: (_, __) => false,
        backupListGetter: () => BackupJsonService().getSteamNews(context),
        backupListWarningMessage: LocaleKey.failedLatestDisplayingOld,
        gridViewColumnCalculator: steamNewsCustomColumnCount,
        //
        // useGridView: true,
        // gridItemWithIndexDisplayer: steamNewsItemTilePresenter,
        //
        minListForSearch: 20000,
      ),
      bottomNavigationBar: BottomNavbar(noRouteSelected: true),
    );
  }
}
