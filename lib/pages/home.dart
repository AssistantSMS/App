import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/adaptive/homePageAppBar.dart';
import '../components/bottomNavbar.dart';
import '../components/drawer.dart';
import '../components/tilePresenters/responsiveStaggeredGridTilePresenter.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/AppImage.dart';
import '../constants/Routes.dart';
import '../helpers/listPageHelper.dart';
import 'gameItem/gameItemListPage.dart';
import 'recipe/recipeListPage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.homePage);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: HomePageAppBar(),
      drawer: const AppDrawer(),
      builder: (scaffoldContext) => getBody(scaffoldContext),
      bottomNavigationBar: const BottomNavbar(currentRoute: Routes.home),
    );
  }

  Widget getBody(BuildContext context) {
    return responsiveStaggeredGrid(
      items: [
        StaggeredGridTileItem(
          2,
          2,
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
        ),
        StaggeredGridTileItem(
          2,
          1,
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
        ),
        StaggeredGridTileItem(
          2,
          2,
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
        ),
        StaggeredGridTileItem(
          2,
          1,
          responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.workshopTile,
            text: LocaleKey.other,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.otherRecipes,
            ),
          ),
        ),
        StaggeredGridTileItem(
          2,
          1,
          responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.dressTile,
            text: LocaleKey.dressBot,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.dressbot,
            ),
          ),
        ),
        StaggeredGridTileItem(
          2,
          1,
          responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.raidTile,
            text: LocaleKey.raidCalculator,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.raidCalc,
            ),
          ),
        ),
        StaggeredGridTileItem(
          2,
          1,
          responsiveStaggeredGridIconTilePresenter(
            context,
            Icons.shopping_cart,
            text: LocaleKey.cart,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.cart,
            ),
          ),
        ),
        StaggeredGridTileItem(
          2,
          1,
          responsiveStaggeredGridIconTilePresenter(
            context,
            Icons.new_releases,
            text: LocaleKey.news,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateToNamed: Routes.steamNews,
            ),
          ),
        ),
      ],
    );
  }
}
