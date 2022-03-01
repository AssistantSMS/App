import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/bottomNavbar.dart';
import '../../components/tilePresenters/gameItemTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/Routes.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/searchHelper.dart';
import 'gameItemDetailPage.dart';

class GameItemListPage extends StatelessWidget {
  final LocaleKey name;
  final List<LocaleKey> gameItemLocales;
  GameItemListPage(this.name, this.gameItemLocales, {Key key})
      : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.itemListPage);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        title: Text(getTranslations().fromKey(name)),
        showHomeAction: true,
      ),
      body: ResponsiveListDetailView<GameItem>(
        () => getAllGameItemFromLocaleKeys(context, gameItemLocales),
        gameItemTilePresenter,
        searchGameItem,
        listItemMobileOnTap: (BuildContext context, GameItem gameItem) =>
            getNavigation().navigateAwayFromHomeAsync(
          context,
          navigateToNamed: Routes.gameDetail,
          navigateToNamedParameters: {Routes.itemIdParam: gameItem.id},
        ),
        listItemDesktopOnTap: (BuildContext context, GameItem recipe,
            void Function(Widget) updateDetailView) {
          return GameItemDetailPage(
            recipe.id,
            isInDetailPane: true,
            updateDetailView: updateDetailView,
          );
        },
        key: Key(getTranslations().currentLanguage),
      ),
      bottomNavigationBar: const BottomNavbar(currentRoute: Routes.allItems),
    );
  }
}
