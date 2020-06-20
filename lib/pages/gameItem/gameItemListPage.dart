import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/responsiveSearchableList.dart';
import '../../components/tilePresenters/gameItemTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/searchHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import 'gameItemDetailPage.dart';

class GameItemListPage extends StatelessWidget {
  final LocaleKey name;
  final List<LocaleKey> gameItemLocales;
  GameItemListPage(this.name, this.gameItemLocales) {
    trackEvent(AnalyticsEvent.itemListPage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        title: Text(Translations.get(context, name)),
        showHomeAction: true,
      ),
      body: ResponsiveListDetailView<GameItem>(
        () => getAllGameItemFromLocaleKeys(context, gameItemLocales),
        gameItemTilePresenter,
        searchGameItem,
        listItemMobileOnTap: (BuildContext context, GameItem recipe) async =>
            await navigateAwayFromHomeAsync(context,
                navigateTo: (context) => GameItemDetailPage(recipe.id)),
        listItemDesktopOnTap: (BuildContext context, GameItem recipe,
                void Function(Widget) updateDetailView) =>
            GameItemDetailPage(
          recipe.id,
          isInDetailPane: true,
          updateDetailView: updateDetailView,
        ),
        key: Key(Translations.of(context).currentLanguage),
      ),
    );
  }
}
