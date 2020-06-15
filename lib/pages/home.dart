import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/components/drawer.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/AppImage.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/navigationHelper.dart';
import 'package:scrapmechanic_kurtlourens_com/localization/localeKey.dart';
import 'package:scrapmechanic_kurtlourens_com/pages/recipe/recipeListPage.dart';

import '../components/adaptive/appScaffold.dart';
import '../components/adaptive/homePageAppBar.dart';
import '../components/responsiveStaggeredGrid.dart';
import '../components/tilePresenters/responsiveStaggeredGridTilePresenter.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/StaggeredGridItemType.dart';
import '../contracts/misc/staggeredGridItem.dart';
import '../helpers/analytics.dart';
import 'gameItem/gameItemListPage.dart';

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
    const smallImage = 50.0;
    const largeImage = 96.0;

    var all = [
      LocaleKey.blocksJson,
      LocaleKey.buildingJson,
      LocaleKey.constructionJson,
      LocaleKey.consumableJson,
      LocaleKey.containersJson,
      LocaleKey.craftbotJson,
      LocaleKey.decorJson,
      LocaleKey.gittingJson,
      LocaleKey.harvestJson,
      LocaleKey.industrialJson,
      LocaleKey.interactiveJson,
      LocaleKey.interactiveUpgradableJson,
      LocaleKey.interactiveContainerJson,
      LocaleKey.lightJson,
      LocaleKey.manMadeJson,
      LocaleKey.outfitJson,
      LocaleKey.packingCrateJson,
      LocaleKey.plantJson,
      LocaleKey.powerJson,
      LocaleKey.resourcesJson,
      LocaleKey.robotJson,
      LocaleKey.survivalJson,
      LocaleKey.toolJson,
      LocaleKey.vehicleJson,
      LocaleKey.warehouseJson,
    ];

    return responsiveStaggeredGrid(
      [
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.craftBot,
            Colors.lightBlue,
            height: largeImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage([LocaleKey.craftBotJson]),
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
            height: smallImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage([LocaleKey.cookBotJson]),
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
            height: largeImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => GameItemListPage(all),
            ),
          ),
          gridItemType: StaggeredGridItemType.medSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.refiner,
            Colors.lightGreen,
            height: largeImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage([LocaleKey.refineryJson]),
            ),
          ),
          gridItemType: StaggeredGridItemType.medSquare,
        ),
        StaggeredGridItem(
          childBuilder: (BuildContext childContext) =>
              responsiveStaggeredGridImageTilePresenter(
            context,
            AppImage.dressBot,
            Colors.amber,
            height: smallImage,
            onTap: () async => await navigateAwayFromHomeAsync(
              context,
              navigateTo: (context) => RecipeListPage([LocaleKey.dressBotJson]),
            ),
          ),
          gridItemType: StaggeredGridItemType.smallRectLandscape,
        ),
      ],
    );
  }
}
