import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/bottomNavbar.dart';
import '../../components/tilePresenters/responsiveStaggeredGridTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppImage.dart';
import '../../helpers/listPageHelper.dart';
import '../recipe/recipeListPage.dart';

class OtherRecipesPage extends StatelessWidget {
  OtherRecipesPage({Key? key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.homePage);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.other)),
      ),
      builder: (scaffoldContext) => getBody(scaffoldContext),
      bottomNavigationBar: const BottomNavbar(),
    );
  }

  Widget getBody(BuildContext bodyCtx) {
    return ResponsiveStaggeredGrid(
      items: [
        createStaggeredGridItem(
          child: responsiveStaggeredGridImageTilePresenter(
            bodyCtx,
            AppImage.workshopTile,
            text: LocaleKey.workbench,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.workbench,
                getWorkbenchPageLocales(),
              ),
            ),
          ),
          gridItemSize: StaggeredGridSize.medSquare,
        ),
        createStaggeredGridItem(
          child: responsiveStaggeredGridImageTilePresenter(
            bodyCtx,
            AppImage.refinerTile,
            text: LocaleKey.refiner,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.refiner,
                getRefinerPageLocales(),
              ),
            ),
          ),
          gridItemSize: StaggeredGridSize.medSquare,
        ),
        createStaggeredGridItem(
          child: responsiveStaggeredGridImageTilePresenter(
            bodyCtx,
            AppImage.resourceTile,
            text: LocaleKey.dispenser,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.dispenser,
                getDispensorPageLocales(),
              ),
            ),
          ),
          gridItemSize: StaggeredGridSize.medSquare,
        ),
        createStaggeredGridItem(
          child: responsiveStaggeredGridImageTilePresenter(
            bodyCtx,
            AppImage.cookingTile,
            text: LocaleKey.cookingBot,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              bodyCtx,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.cookingBot,
                getCookBotPageLocales(),
              ),
            ),
          ),
          gridItemSize: StaggeredGridSize.medSquare,
        ),
      ],
    );
  }
}
