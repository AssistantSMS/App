import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/Routes.dart';

import '../components/adaptive/appScaffold.dart';
import '../components/adaptive/homePageAppBar.dart';
import '../components/drawer.dart';
import '../components/responsiveStaggeredGrid.dart';
import '../components/tilePresenters/responsiveStaggeredGridTilePresenter.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/AppImage.dart';
import '../constants/StaggeredGridItemType.dart';
import '../contracts/misc/staggeredGridItem.dart';
import '../helpers/analytics.dart';
import '../helpers/listPageHelper.dart';
import '../helpers/navigationHelper.dart';
import 'gameItem/gameItemListPage.dart';
import 'recipe/recipeListPage.dart';

class Home extends StatelessWidget {
  final void Function(Locale locale) onLocaleChange;
  final void Function(BuildContext context) changeBrightness;
  Home(this.changeBrightness, this.onLocaleChange) {
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
    const smallImage = 40.0;
    const largeImage = 65.0;

    return responsiveStaggeredGrid(
      [
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.craftBot,
            Colors.lightBlue,
            text: getCraftBotPageName(),
            height: largeImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                getCraftBotPageName(),
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
            AppImage.cookBot,
            Colors.purple,
            text: getWorkbenchPageName(),
            height: smallImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                getWorkbenchPageName(),
                getWorkbenchPageLocales(),
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
            Colors.blueGrey,
            text: getBlocksAndItemsPageName(),
            height: largeImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => GameItemListPage(
                getBlocksAndItemsPageName(),
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
            AppImage.refiner,
            Colors.redAccent,
            text: getDispensorPageName(),
            height: smallImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                getDispensorPageName(),
                getDispensorPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.smallRectLandscape,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.cookBot,
            Colors.green,
            text: getCookBotPageName(),
            height: smallImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                getCookBotPageName(),
                getCookBotPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.smallSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.refiner,
            Colors.indigo,
            text: getRefinerPageName(),
            height: smallImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                getRefinerPageName(),
                getRefinerPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.smallSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.dressBot,
            Colors.amber,
            text: getDressBotPageName(),
            height: smallImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                getDressBotPageName(),
                getDressBotPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.smallRectLandscape,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridIconTilePresenter(
            context,
            Icons.shopping_basket,
            Colors.cyan,
            text: getCartPageName(),
            height: smallImage,
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
            Colors.black,
            text: getSteamNewsPageName(),
            height: smallImage,
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
