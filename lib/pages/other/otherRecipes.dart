import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/bottomNavbar.dart';
import '../../components/tilePresenters/responsiveStaggeredGridTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppImage.dart';
import '../../constants/StaggeredGridItemType.dart';
import '../../helpers/listPageHelper.dart';
import '../recipe/recipeListPage.dart';

class OtherRecipesPage extends StatelessWidget {
  OtherRecipesPage() {
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

  Widget getBody(BuildContext context) {
    return responsiveStaggeredGrid(
      [
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.workshopTile,
            text: LocaleKey.workbench,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.workbench,
                getWorkbenchPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.medSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.refinerTile,
            text: LocaleKey.refiner,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.refiner,
                getRefinerPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.medSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.resourceTile,
            text: LocaleKey.dispenser,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.dispenser,
                getDispensorPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.medSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.cookingTile,
            text: LocaleKey.cookingBot,
            onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage(
                LocaleKey.cookingBot,
                getCookBotPageLocales(),
              ),
            ),
          ),
          gridItemType: StaggeredGridItemType.medSquare,
        ),
      ],
    );
  }
}
