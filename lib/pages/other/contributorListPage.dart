import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/bottomNavbar.dart';
import '../../components/searchableList.dart';
import '../../components/tilePresenters/contributorTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/generated/ContributorViewModel.dart';
import '../../helpers/analytics.dart';
import '../../helpers/columnHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

class ContributorListPage extends StatelessWidget {
  ContributorListPage() {
    trackEvent(AnalyticsEvent.contributorListPage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(Translations.get(context, LocaleKey.contributors)),
      ),
      body: SearchableList<ContributorViewModel>(
        () => getContributorApiRepo().getContributors(),
        contributorTilePresenter,
        (_, __) => false,
        // backupListGetter: () => PatronsListBackupJsonService().getAll(context),
        // backupListWarningMessage: LocaleKey.failedLatestDisplayingOld,
        minListForSearch: 20000,
        useGridView: true,
        gridViewColumnCalculator: steamNewsCustomColumnCount,
      ),
      bottomNavigationBar: BottomNavbar(noRouteSelected: true),
    );
  }
}
