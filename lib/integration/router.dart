import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart'
    hide BackupJsonService;
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scrapmechanic_kurtlourens_com/services/json/backupJsonService.dart';

import '../components/bottomNavbar.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/Routes.dart';
// import '../pages/about.dart';
import '../pages/cart/cartPage.dart';
import '../pages/donation.dart';
import '../pages/dressbot/dressbotDetailPage.dart';
import '../pages/dressbot/dressbotPage.dart';
import '../pages/gameItem/gameItemDetailPage.dart';
import '../pages/home.dart';
import '../pages/notFound.dart';
import '../pages/other/contributorListPage.dart';
import '../pages/other/otherRecipes.dart';
import '../pages/raid/raidCalculatorPage.dart';
import '../pages/recipe/recipeDetailPage.dart';
import '../pages/settings.dart';
import '../state/modules/base/appState.dart';
import '../state/modules/setting/whatIsNewSettingsViewModel.dart';

class CustomRouter {
  static FluroRouter configureRoutes() {
    final router = FluroRouter();

    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
          const NotFoundPage(),
    );

    TransitionType transition = TransitionType.material;
    router.define(
      Routes.home,
      handler: _basicHandlerFunc(() => HomePage()),
      transitionType: transition,
    );
    router.define(
      Routes.about,
      handler: _basicHandlerFunc(() => AboutPage(
            key: const Key('about'),
          )),
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
      handler: _basicHandlerFunc(
        () => SteamNewsPage(
          AnalyticsEvent.steamNewsPage,
          AssistantAppType.SMS,
          bottomNavigationBar: const BottomNavbar(),
          backupFunc: (backupFuncContext) =>
              BackupJsonService().getSteamNews(backupFuncContext),
        ),
      ),
      transitionType: transition,
    );
    router.define(
      Routes.otherRecipes,
      handler: _basicHandlerFunc(() => OtherRecipesPage()),
      transitionType: transition,
    );
    router.define(
      Routes.raidCalc,
      handler: _basicHandlerFunc(() => const RaidCalcPage()),
      transitionType: transition,
    );
    router.define(
      Routes.dressbot,
      handler: _basicHandlerFunc(() => const DressBotPage()),
      transitionType: transition,
    );
    router.define(
      Routes.patronList,
      handler: _basicHandlerFunc(
        () => PatronListPage(
          AnalyticsEvent.patronListPage,
          bottomNavigationBar: const BottomNavbar(currentRoute: Routes.home),
        ),
      ),
      transitionType: transition,
    );
    router.define(
      Routes.contributors,
      handler: _basicHandlerFunc(() => const ContributorListPage()),
      transitionType: transition,
    );
    router.define(
      Routes.whatIsNew,
      handler: _basicHandlerFunc(
        () => StoreConnector<AppState, WhatIsNewSettingsViewModel>(
          converter: (store) => WhatIsNewSettingsViewModel.fromStore(store),
          builder: (_, viewModel) => WhatIsNewPage(
            AnalyticsEvent.whatIsNewPage,
            selectedLanguage: viewModel.selectedLanguage,
          ),
        ),
      ),
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
