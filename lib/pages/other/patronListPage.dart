import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/ExternalUrls.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/results/resultWithValue.dart';
import 'package:scrapmechanic_kurtlourens_com/services/json/patronsListBackupJsonService.dart';

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

  Future<ResultWithValue<List<PatreonViewModel>>> wrapPatronsListCall(
    BuildContext context,
    Future<ResultWithValue<List<PatreonViewModel>>> getPatrons,
  ) async {
    ResultWithValue<List<PatreonViewModel>> patronsResult = await getPatrons;
    if (!patronsResult.isSuccess) return patronsResult;

    List<PatreonViewModel> list = patronsResult.value;
    // List<PatreonViewModel> list = List<PatreonViewModel>();
    list.add(PatreonViewModel(
      name: Translations.get(context, LocaleKey.joinPatreon),
      imageUrl:
          'https://scrapassistant.com/assets/assets/img/drawer/patreon.png',
      url: ExternalUrls.patreon,
    ));
    // list.addAll(patronsResult.value);

    return ResultWithValue<List<PatreonViewModel>>(true, list, '');
  }

  @override
  Widget build(BuildContext context) {
    var apiFunc = getPatreonApiRepo().getPatrons();
    var backupFunc = PatronsListBackupJsonService().getAll(context);
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(Translations.get(context, LocaleKey.patrons)),
      ),
      body: SearchableList<PatreonViewModel>(
        () => wrapPatronsListCall(context, apiFunc),
        patronTilePresenter,
        (_, __) => false,
        backupListGetter: () => wrapPatronsListCall(context, backupFunc),
        backupListWarningMessage: LocaleKey.failedLatestDisplayingOld,
        minListForSearch: 20000,
        useGridView: true,
        gridViewColumnCalculator: steamNewsCustomColumnCount,
      ),
      bottomNavigationBar: BottomNavbar(noRouteSelected: true),
    );
  }
}
