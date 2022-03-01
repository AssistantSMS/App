import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart'
    hide BackupJsonService;
import 'package:flutter/material.dart';

import '../../components/bottomNavbar.dart';
import '../../components/tilePresenters/contributorTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/generated/contributorViewModel.dart';
import '../../integration/dependencyInjection.dart';
import '../../services/json/backupJsonService.dart';

class ContributorListPage extends StatefulWidget {
  const ContributorListPage({Key key}) : super(key: key);

  @override
  _ContributorsWidget createState() => _ContributorsWidget();
}

class _ContributorsWidget extends State<ContributorListPage> {
  int currentSelection = 0;

  _ContributorsWidget() {
    getAnalytics().trackEvent(AnalyticsEvent.contributorListPage);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [
      getSegmentedControlOption(
        getTranslations().fromKey(LocaleKey.contributors),
      ),
      getSegmentedControlOption(
        getTranslations().fromKey(LocaleKey.donation),
      )
    ];

    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.contributors)),
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
          customDivider(),
          Expanded(
            child: currentSelection == 0
                ? SearchableGrid<ContributorViewModel>(
                    () => getContributorApiRepo().getContributors(),
                    gridItemWithIndexDisplayer: contributorTilePresenter,
                    gridItemSearch: (_, __) => false,
                    backupListGetter: () =>
                        BackupJsonService().getContributors(context),
                    minListForSearch: 20000,
                    gridViewColumnCalculator: contributorsCustomColumnCount,
                  )
                : DonatorsPageComponent(smallLoadMorePageButton(context)),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
