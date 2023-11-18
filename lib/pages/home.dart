import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/adaptive/homePageAppBar.dart';
import '../components/bottomNavbar.dart';
import '../components/drawer.dart';
import '../components/tilePresenters/responsiveStaggeredGridTilePresenter.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/AppImage.dart';
import '../constants/Routes.dart';
import '../../constants/StaggeredGridItemType.dart';
import '../helpers/listPageHelper.dart';
import 'gameItem/gameItemListPage.dart';
import 'recipe/recipeListPage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key) {
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

  Widget getBody(BuildContext bodyCtx) {
    return ResponsiveStaggeredGrid(
      items: [
        createStaggeredGridItem(
          child: responsiveStaggeredGridImageTilePresenter(
            bodyCtx,
            AppImage.craftTile,
            text: LocaleKey.craftBot,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.craftBot,
                getCraftBotPageLocales(),
              ),
            ),
          ),
          gridItemSize: StaggeredGridSize.medSquare,
        ),
        createStaggeredGridItem(
          child: responsiveStaggeredGridImageTilePresenter(
            bodyCtx,
            AppImage.traderTile,
            text: LocaleKey.hideout,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.hideout,
                getHideoutPageLocales(),
              ),
            ),
          ),
          gridItemSize: StaggeredGridSize.smallRectLandscape,
        ),
        createStaggeredGridItem(
          child: responsiveStaggeredGridImageTilePresenter(
            bodyCtx,
            AppImage.block,
            text: LocaleKey.blocksAndItems,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateTo: (context) => GameItemListPage(
                LocaleKey.blocksAndItems,
                getBlocksAndItemsPageLocales(),
              ),
            ),
          ),
          gridItemSize: StaggeredGridSize.medSquare,
        ),
        createStaggeredGridItem(
          child: responsiveStaggeredGridImageTilePresenter(
            bodyCtx,
            AppImage.workshopTile,
            text: LocaleKey.other,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateToNamed: Routes.otherRecipes,
            ),
          ),
          gridItemSize: StaggeredGridSize.smallRectLandscape,
        ),
        createStaggeredGridItem(
          child: responsiveStaggeredGridImageTilePresenter(
            bodyCtx,
            AppImage.dressTile,
            text: LocaleKey.dressBot,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateToNamed: Routes.dressbot,
            ),
          ),
          gridItemSize: StaggeredGridSize.smallRectLandscape,
        ),
        createStaggeredGridItem(
          child: responsiveStaggeredGridImageTilePresenter(
            bodyCtx,
            AppImage.raidTile,
            text: LocaleKey.raidCalculator,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateToNamed: Routes.raidCalc,
            ),
          ),
          gridItemSize: StaggeredGridSize.smallRectLandscape,
        ),
        createStaggeredGridItem(
          child: responsiveStaggeredGridIconTilePresenter(
            bodyCtx,
            Icons.shopping_cart,
            text: LocaleKey.cart,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateToNamed: Routes.cart,
            ),
          ),
          gridItemSize: StaggeredGridSize.smallRectLandscape,
        ),
        createStaggeredGridItem(
          child: responsiveStaggeredGridIconTilePresenter(
            bodyCtx,
            Icons.new_releases,
            text: LocaleKey.news,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateToNamed: Routes.steamNews,
            ),
          ),
          gridItemSize: StaggeredGridSize.smallRectLandscape,
        ),
      ],
    );
  }
}
