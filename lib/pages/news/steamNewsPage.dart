import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/components/tilePresenters/steamNewsTilePresenter.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/generated/SteamNewsItem.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/columnHelper.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/searchableList.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../helpers/analytics.dart';
import '../../integration/dependencyInjection.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

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
        title: Text(Translations.get(context, LocaleKey.cookingBot)),
      ),
      body: SearchableList<SteamNewsItem>(
        () => getApiRepo().getSteamNews(),
        steamNewsItemTilePresenter,
        (SteamNewsItem, String) => false,
        minListForSearch: 20000,
        useGridView: true,
        gridViewColumnCalculator: steamNewsCustomColumnCount,
      ),
    );
  }
}
