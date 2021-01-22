import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/adaptive/appScaffold.dart';
import '../components/adaptive/homePageAppBar.dart';
import '../components/bottomNavbar.dart';
import '../components/drawer.dart';
import '../components/tilePresenters/responsiveStaggeredGridTilePresenter.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/AppImage.dart';
import '../constants/Routes.dart';
import '../constants/StaggeredGridItemType.dart';
import '../helpers/analytics.dart';
import '../helpers/listPageHelper.dart';
import 'gameItem/gameItemListPage.dart';
import 'recipe/recipeListPage.dart';

class HomePage extends StatelessWidget {
  HomePage() {
    trackEvent(AnalyticsEvent.homePage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: HomePageAppBar(),
      drawer: AppDrawer(),
      builder: (scaffoldContext) => getBody(scaffoldContext),
      bottomNavigationBar: BottomNavbar(currentRoute: Routes.home),
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
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
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
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
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
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
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
            text: LocaleKey.other,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.otherRecipes,
            ),
          ),
          gridItemType: StaggeredGridItemType.smallRectLandscape,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.dressTile,
            text: LocaleKey.dressBot,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.dressbot,
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
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
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
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
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
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
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
