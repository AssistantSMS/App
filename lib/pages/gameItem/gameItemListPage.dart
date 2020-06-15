import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/searchableList.dart';
import '../../components/tilePresenters/gameItemTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/searchHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

class GameItemListPage extends StatelessWidget {
  final LocaleKey name;
  final List<LocaleKey> gameItemLocales;
  GameItemListPage(this.name, this.gameItemLocales) {
    trackEvent(AnalyticsEvent.itemListPage);
  }

  @override
  Widget build(BuildContext context) {
    var hintText = Translations.get(context, LocaleKey.searchItems);
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        title: Text(Translations.get(context, name)),
      ),
      body: SearchableList<GameItem>(
        () => getAllGameItemFromLocaleKeys(context, gameItemLocales),
        gameItemTilePresenter,
        searchGameItem,
        key: Key(Translations.of(context).currentLanguage),
        hintText: hintText,
      ),
    );
  }
}
