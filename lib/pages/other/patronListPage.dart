import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/bottomNavbar.dart';
import '../../components/searchableList.dart';
import '../../components/tilePresenters/patreonTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/generated/PatreonViewModel.dart';
import '../../helpers/analytics.dart';
import '../../helpers/columnHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

class PatronListPage extends StatelessWidget {
  PatronListPage() {
    trackEvent(AnalyticsEvent.patronListPage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(Translations.get(context, LocaleKey.patrons)),
      ),
      body: SearchableList<PatreonViewModel>(
        () => getPatreonApiRepo().getPatrons(),
        patronTilePresenter,
        (_, __) => false,
        // backupListGetter: () =>
        //     new SteamNewsBackupJsonService().getAll(context),
        // backupListWarningMessage: LocaleKey.failedLatestDisplayingOld,
        minListForSearch: 20000,
        useGridView: true,
        gridViewColumnCalculator: steamNewsCustomColumnCount,
      ),
      bottomNavigationBar: BottomNavbar(noRouteSelected: true),
    );
  }
}
