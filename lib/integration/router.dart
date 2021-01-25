import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:scrapmechanic_kurtlourens_com/pages/whatIsNew/whatIsNewPage.dart';

import '../constants/Routes.dart';
import '../pages/about.dart';
import '../pages/cart/cartPage.dart';
import '../pages/donation.dart';
import '../pages/dressbot/dressbotDetailPage.dart';
import '../pages/dressbot/dressbotPage.dart';
import '../pages/gameItem/gameItemDetailPage.dart';
import '../pages/home.dart';
import '../pages/news/steamNewsPage.dart';
import '../pages/notFound.dart';
import '../pages/other/contributorListPage.dart';
import '../pages/other/otherRecipes.dart';
import '../pages/other/patronListPage.dart';
import '../pages/raid/raidCalculatorPage.dart';
import '../pages/recipe/recipeDetailPage.dart';
import '../pages/settings.dart';

class CustomRouter {
  static FluroRouter configureRoutes() {
    final router = FluroRouter();

    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
          NotFoundPage(),
    );

    TransitionType transition = TransitionType.material;
    router.define(
      Routes.home,
      handler: _basicHandlerFunc(() => HomePage()),
      transitionType: transition,
    );
    router.define(
      Routes.about,
      handler: _basicHandlerFunc(() => AboutPage()),
      transitionType: transition,
    );
    router.define(
      Routes.settings,
      handler: _basicHandlerFunc(() => SettingsPage()),
      transitionType: transition,
    );
    router.define(
      Routes.donation,
      handler: _basicHandlerFunc(() => DonationPage()),
      transitionType: transition,
    );
    router.define(
      Routes.cart,
      handler: _basicHandlerFunc(() => CartPage()),
      transitionType: transition,
    );
    router.define(
      Routes.steamNews,
      handler: _basicHandlerFunc(() => SteamNewsPage()),
      transitionType: transition,
    );
    router.define(
      Routes.otherRecipes,
      handler: _basicHandlerFunc(() => OtherRecipesPage()),
      transitionType: transition,
    );
    router.define(
      Routes.raidCalc,
      handler: _basicHandlerFunc(() => RaidCalcPage()),
      transitionType: transition,
    );
    router.define(
      Routes.dressbot,
      handler: _basicHandlerFunc(() => DressBotPage()),
      transitionType: transition,
    );
    router.define(
      Routes.patronList,
      handler: _basicHandlerFunc(() => PatronListPage()),
      transitionType: transition,
    );
    router.define(
      Routes.contributors,
      handler: _basicHandlerFunc(() => ContributorListPage()),
      transitionType: transition,
    );
    router.define(
      Routes.whatIsNew,
      handler: _basicHandlerFunc(() => WhatIsNewPage()),
      transitionType: transition,
    );
    router.define(
      Routes.gameDetail,
      handler: _itemListPageHandler(
        (String id) => GameItemDetailPage(id, isInDetailPane: false),
      ),
      transitionType: transition,
    );
    router.define(
      Routes.cosmeticDetail,
      handler: _itemListPageHandler(
        (String id) => DressBotDetailPage(id, isInDetailPane: false),
      ),
      transitionType: transition,
    );
    router.define(
      Routes.recipeDetail,
      handler: _itemListPageHandler(
        (String id) => RecipeDetailPage(id, isInDetailPane: false),
      ),
      transitionType: transition,
    );

    return router;
  }

  static Handler _basicHandlerFunc(Widget Function() generateRoute) => Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
            generateRoute(),
      );

  static Handler _itemListPageHandler(
      Widget Function(String itemId) generateRoute) {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        String id = params[Routes.itemIdParam][0];
        return generateRoute(id);
      },
    );
  }
}
