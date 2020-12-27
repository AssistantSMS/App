import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/adaptive/paginationControl.dart';
import '../../components/adaptive/segmentedControl.dart';
import '../../components/bottomNavbar.dart';
import '../../components/lazyLoadedSearchableList.dart';
import '../../components/searchableList.dart';
import '../../components/tilePresenters/contributorTilePresenter.dart';
import '../../components/tilePresenters/donationTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/generated/AssistantApps/donationViewModel.dart';
import '../../contracts/generated/AssistantApps/contributorViewModel.dart';
import '../../helpers/analytics.dart';
import '../../helpers/columnHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../services/json/backupJsonService.dart';

class ContributorListPage extends StatefulWidget {
  const ContributorListPage({Key key}) : super(key: key);

  @override
  _ContributorsWidget createState() => _ContributorsWidget();
}

class _ContributorsWidget extends State<ContributorListPage> {
  int currentSelection = 0;

  _ContributorsWidget() {
    trackEvent(AnalyticsEvent.contributorListPage);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [
      getSegmentedControlOption(
        Translations.get(context, LocaleKey.contributors),
      ),
      getSegmentedControlOption(
        Translations.get(context, LocaleKey.donation),
      )
    ];

    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(Translations.get(context, LocaleKey.contributors)),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: adaptiveSegmentedControl(context,
                controlItems: options,
                currentSelection: currentSelection, onSegmentChosen: (index) {
              setState(() {
                currentSelection = index;
              });
            }),
          ),
          Divider(),
          Expanded(
            child: currentSelection == 0
                ? SearchableList<ContributorViewModel>(
                    () => getContributorApiRepo().getContributors(),
                    contributorTilePresenter,
                    (_, __) => false,
                    // backupListGetter: () => PatronsListBackupJsonService().getAll(context),
                    // backupListWarningMessage: LocaleKey.failedLatestDisplayingOld,
                    backupListGetter: () =>
                        BackupJsonService().getContributors(context),
                    minListForSearch: 20000,
                    useGridView: true,
                    gridViewColumnCalculator: steamNewsCustomColumnCount,
                  )
                : LazyLoadSearchableList<DonationViewModel>(
                    (int page) => getDonatorApiRepo().getDonators(page: page),
                    UIConstants.DonationsPageSize,
                    donationTilePresenter,
                    backupListGetter: (int page) =>
                        BackupJsonService().getDonations(
                      context,
                      page: page,
                      pageSize: UIConstants.DonationsPageSize,
                    ),
                    loadMoreItemWidget: smallLoadMorePageButton(context),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(noRouteSelected: true),
    );
  }
}
