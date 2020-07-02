import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/localization/localeKey.dart';

import '../components/adaptive/appScaffold.dart';
import '../components/adaptive/homePageAppBar.dart';
import '../components/drawer.dart';
import '../components/responsiveStaggeredGrid.dart';
import '../components/tilePresenters/responsiveStaggeredGridTilePresenter.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/AppImage.dart';
import '../constants/Routes.dart';
import '../constants/StaggeredGridItemType.dart';
import '../contracts/misc/staggeredGridItem.dart';
import '../helpers/analytics.dart';
import '../helpers/listPageHelper.dart';
import '../helpers/navigationHelper.dart';
import 'gameItem/gameItemListPage.dart';
import 'recipe/recipeListPage.dart';

class HomePage extends StatelessWidget {
  final void Function(Locale locale) onLocaleChange;
  final void Function(BuildContext context) changeBrightness;
  HomePage(this.changeBrightness, this.onLocaleChange) {
    trackEvent(AnalyticsEvent.homePage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: homePageAppBar(context, onLocaleChange),
      drawer: AppDrawer(),
      builder: (scaffoldContext) => getBody(scaffoldContext),
    );
  }

  Widget getBody(BuildContext context) {
    return responsiveStaggeredGrid(
      [
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.craftTile,
            text: LocaleKey.craftBot,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.craftBot,
                getCraftBotPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.medSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.traderTile,
            text: LocaleKey.hideout,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.hideout,
                getHideoutPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.smallRectLandscape,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.block,
            text: LocaleKey.blocksAndItems,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => GameItemListPage(
                LocaleKey.blocksAndItems,
                getBlocksAndItemsPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.medSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.workshopTile,
            text: LocaleKey.workbench,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.workbench,
                getWorkbenchPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.smallSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.refinerTile,
            text: LocaleKey.other,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.otherRecipes,
            ),
          ),
          gridItemType: StaggeredGridItemType.smallSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.dressTile,
            text: LocaleKey.dressBot,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => GameItemListPage(
                LocaleKey.dressBot,
                getDressBotPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.smallRectLandscape,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.raidTile,
            text: LocaleKey.raidCalculator,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.raidCalc,
            ),
          ),
          gridItemType: StaggeredGridItemType.smallRectLandscape,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridIconTilePresenter(
            context,
            Icons.shopping_cart,
            text: LocaleKey.cart,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.cart,
            ),
          ),
          gridItemType: StaggeredGridItemType.smallRectLandscape,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridIconTilePresenter(
            context,
            Icons.new_releases,
            text: LocaleKey.news,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.steamNews,
            ),
          ),
          gridItemType: StaggeredGridItemType.smallRectLandscape,
        ),
      ],
    );
  }
}
