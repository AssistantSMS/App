import 'package:flutter/material.dart';

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
import '../helpers/colourHelper.dart';
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

    var tileColour =
        getIsDark(context) ? Colors.blueGrey[600] : Colors.blueGrey[300];
    return responsiveStaggeredGrid(
      [
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.craftBot,
            tileColour, // Colors.blue[500],
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
            tileColour, // Colors.green[900],
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
            tileColour, // Colors.blueGrey,
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
            tileColour, // Colors.orange[900],
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
            tileColour, // Colors.green[300],
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
            tileColour, // Colors.brown,
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
            tileColour, // Colors.amber,
            text: getDressBotPageName(),
            height: smallImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => GameItemListPage(
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
            tileColour, // Colors.purple[300],
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
            tileColour, // Colors.black,
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
