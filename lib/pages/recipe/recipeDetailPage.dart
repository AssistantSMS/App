import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../components/common/positioned.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../components/tilePresenters/recipeIngredientTilePresenter.dart';
import '../../components/webSpecific/mousePointer.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppImage.dart';
import '../../constants/AppPadding.dart';
import '../../constants/IdPrefix.dart';
import '../../constants/Routes.dart';
import '../../contracts/recipe/recipe.dart';
import '../../contracts/recipe/recipePageItem.dart';
import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/cart/cartItemState.dart';
import '../../state/modules/gameItem/gameItemViewModel.dart';
import '../gameItem/gameItemDetailPage.dart';

class RecipeDetailPage extends StatelessWidget {
  final String itemId;
  final bool isInDetailPane;
  final void Function(Widget newDetailView)? updateDetailView;

  RecipeDetailPage(
    this.itemId, {
    Key? key,
    this.isInDetailPane = false,
    this.updateDetailView,
  }) : super(key: key) {
    getAnalytics().trackEvent('${AnalyticsEvent.recipeDetailPage}: $itemId');
  }

  @override
  Widget build(BuildContext context) {
    String loading = getTranslations().fromKey(LocaleKey.loading);
    var loadingWidget = getLoading().fullPageLoading(
      context,
      loadingText: loading,
    );
    return CachedFutureBuilder<ResultWithValue<RecipePageItem>>(
      future: recipePageItemFuture(context, itemId),
      whileLoading: () => isInDetailPane
          ? loadingWidget
          : genericPageScaffold(context, loading, null,
              body: (_, __) => loadingWidget, showShortcutLinks: true),
      whenDoneLoading: (ResultWithValue<RecipePageItem> result) {
        var bodyWidget = StoreConnector<AppState, GameItemViewModel>(
          converter: (store) => GameItemViewModel.fromStore(store),
          builder: (_, viewModel) => getBody(context, viewModel, result),
        );
        if (isInDetailPane) return bodyWidget;
        return genericPageScaffold<ResultWithValue<RecipePageItem>>(
          context,
          (result.value.recipe.title) + ' recipe',
          result,
          body: (_, __) => bodyWidget,
          showShortcutLinks: true,
        );
      },
    );
  }

  Widget getBody(
    BuildContext context,
    GameItemViewModel viewModel,
    ResultWithValue<RecipePageItem> result,
  ) {
    TextEditingController controller = TextEditingController();
    Recipe recipeItem = result.value.recipe;
    bool isTrade = recipeItem.id.contains(IdPrefix.recipeHideOut);

    List<Widget> widgets = List.empty(growable: true);

    List<Widget> stackWidgets = List.empty(growable: true);
    stackWidgets.add(genericItemImage(
      context,
      '${AppImage.base}${recipeItem.icon}',
      name: recipeItem.title,
    ));

    Future Function(String id) navigateToGameItem;
    navigateToGameItem = (String id) async {
      if (isInDetailPane && updateDetailView != null) {
        updateDetailView!(GameItemDetailPage(
          id,
          isInDetailPane: isInDetailPane,
          updateDetailView: updateDetailView,
        ));
      } else {
        await getNavigation().navigateAwayFromHomeAsync(
          context,
          navigateToNamed: Routes.gameDetail,
          navigateToNamedParameters: {Routes.itemIdParam: id},
        );
      }
    };

    stackWidgets.add(Positioned(
      child: AvatarGlow(
        glowColor: getTheme().getSecondaryColour(context),
        endRadius: 30.0,
        child: GestureDetector(
          child: const Icon(Icons.info, size: 40),
          onTap: () => navigateToGameItem(recipeItem.output.id),
        ).showPointerOnHover,
      ),
      top: 4,
      right: 0,
    ));

    widgets.add(Stack(children: stackWidgets));
    widgets.add(const EmptySpace1x());
    var quantitySuffix = ' x${recipeItem.output.quantity}';
    widgets.add(GenericItemName(recipeItem.title + quantitySuffix));
    if (recipeItem.description.isNotEmpty) {
      widgets.add(GenericItemDescription(recipeItem.description));
    }

    if (!isTrade) {
      var timeToCraft = getTranslations().fromKey(LocaleKey.timeToCraft) +
          ' ' +
          recipeItem.craftingTime.toString() +
          's';
      widgets.add(GenericItemDescription(timeToCraft));
    }

    widgets.add(customDivider());
    widgets.add(const EmptySpace1x());

    LocaleKey localeKey = LocaleKey.craftedUsing;
    if (isTrade) {
      localeKey = LocaleKey.tradedFor;
    }
    widgets.add(Text(
      getTranslations().fromKey(localeKey),
      textAlign: TextAlign.center,
    ));
    for (var recipeIngIndex = 0;
        recipeIngIndex < recipeItem.inputs.length;
        recipeIngIndex++) {
      RecipeIngredientDetails recipeIng =
          result.value.ingredientDetails[recipeIngIndex];
      widgets.add(Card(
        child: recipeIngredientDetailCustomOnTapTilePresenter(
          context,
          recipeIng,
          recipeIngIndex,
          onTap: navigateToGameItem,
        ),
      ));
    }

    navigateToCart() async => await getNavigation()
        .navigateHomeAsync(context, navigateToNamed: Routes.cart);

    List<CartItemState> cartItems = viewModel.cartItems
        .where((CartItemState ci) => ci.itemId == recipeItem.output.id)
        .toList();
    if (cartItems.isNotEmpty) {
      widgets.add(const EmptySpace3x());
      widgets.add(GenericItemText(getTranslations().fromKey(LocaleKey.cart)));
      widgets.add(Card(
        child: GestureDetector(
          child: recipeIngredientTilePresenter(
            context,
            RecipeIngredient(
              id: recipeItem.output.id,
              quantity: cartItems[0].quantity,
            ),
            0,
          ),
          onTap: navigateToCart,
        ),
        margin: const EdgeInsets.all(0.0),
      ));
    }

    widgets.add(const EmptySpace10x());

    Color fabColour = getTheme().getSecondaryColour(context);
    return Stack(
      children: [
        listWithScrollbar(
          padding: AppPadding.listSidePadding,
          itemCount: widgets.length,
          itemBuilder: (context, index) => widgets[index],
        ),
        fabPositioned(
          FloatingActionButton(
            child: const Icon(Icons.shopping_cart),
            backgroundColor: fabColour,
            foregroundColor: getTheme().getForegroundTextColour(fabColour),
            onPressed: () {
              getDialog().showQuantityDialog(context, controller,
                  title: getTranslations().fromKey(LocaleKey.quantity),
                  onSuccess: (BuildContext dialogCtx, String quantityString) {
                int? quantity = int.tryParse(quantityString);
                if (quantity == null) return;
                viewModel.addToCart(recipeItem.output.id, quantity);
                // getSnackbar().showSnackbar(
                //   context,
                //   LocaleKey.addedToCart,
                //   onPositiveText: getTranslations().fromKey(LocaleKey.cart),
                //   onPositive: () => getNavigation().navigateAwayFromHomeAsync(
                //     context,
                //     navigateToNamed: Routes.cart,
                //   ),
                // );
              });
            },
          ),
        ),
      ],
    );
  }
}
