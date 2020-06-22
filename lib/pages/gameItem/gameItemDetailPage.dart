import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scrapmechanic_kurtlourens_com/components/tilePresenters/cartTilePresenter.dart';

import '../../components/adaptive/listWithScrollbar.dart';
import '../../components/common/cachedFutureBuilder.dart';
import '../../components/dialogs/quantityDialog.dart';
import '../../components/loading.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../components/tilePresenters/recipeIngredientTilePresenter.dart';
import '../../components/tilePresenters/recipeTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppDuration.dart';
import '../../constants/AppImage.dart';
import '../../constants/AppPadding.dart';
import '../../constants/Routes.dart';
import '../../contracts/craftingIngredient/craftedUsing.dart';
import '../../contracts/gameItem/gameItemPageItem.dart';
import '../../contracts/recipe/recipe.dart';
import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../contracts/usedInRecipe/usedInRecipe.dart';
import '../../helpers/analytics.dart';
import '../../helpers/colourHelper.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/snackbarHelper.dart';
import '../../helpers/snapshotHelper.dart';
import '../../helpers/textSpanHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/cart/cartItemState.dart';
import '../../state/modules/gameItem/gameItemViewModel.dart';
import '../recipe/recipeDetailPage.dart';
import 'gameItemComponents.dart';

class GameItemDetailPage extends StatelessWidget {
  final String itemId;
  final bool isInDetailPane;
  final void Function(Widget newDetailView) updateDetailView;

  GameItemDetailPage(
    this.itemId, {
    this.isInDetailPane = false,
    this.updateDetailView,
  }) {
    trackEvent('${AnalyticsEvent.itemDetailPage}: ${this.itemId}');
  }

  @override
  Widget build(BuildContext context) {
    String loading = Translations.get(context, LocaleKey.loading);
    var loadingWidget = fullPageLoading(context, loadingText: loading);
    return CachedFutureBuilder<ResultWithValue<GameItemPageItem>>(
      future: gameItemPageItemFuture(context, this.itemId),
      whileLoading: isInDetailPane
          ? loadingWidget
          : genericPageScaffold(context, loading, null,
              body: (_, __) => loadingWidget, showShortcutLinks: true),
      whenDoneLoading:
          (AsyncSnapshot<ResultWithValue<GameItemPageItem>> snapshot) {
        var bodyWidget = StoreConnector<AppState, GameItemViewModel>(
          converter: (store) => GameItemViewModel.fromStore(store),
          builder: (_, viewModel) => getBody(context, viewModel, snapshot),
        );
        if (isInDetailPane) return bodyWidget;
        return genericPageScaffold<ResultWithValue<GameItemPageItem>>(
          context,
          snapshot?.data?.value?.gameItem?.title ?? loading,
          snapshot,
          body: (_, __) => bodyWidget,
          showShortcutLinks: true,
        );
      },
    );
  }

  Widget getBody(
    BuildContext context,
    GameItemViewModel viewModel,
    AsyncSnapshot<ResultWithValue<GameItemPageItem>> snapshot,
  ) {
    TextEditingController controller = TextEditingController();
    Widget errorWidget = asyncSnapshotHandler(context, snapshot,
        isValidFunction: (ResultWithValue<GameItemPageItem> gameItemResult) {
      if (!gameItemResult.isSuccess) return false;
      if (gameItemResult.value == null) return false;
      return true;
    });
    if (errorWidget != null) return errorWidget;

    var gameItem = snapshot?.data?.value?.gameItem;

    List<Widget> widgets = List<Widget>();

    if (gameItem.icon != null) {
      widgets.add(genericItemImage(
        context,
        '${AppImage.base}${gameItem.icon}',
        name: gameItem.title,
      ));
    }
    widgets.add(emptySpace1x());
    widgets.add(genericItemName(gameItem.title));

    widgets.add(emptySpace1x());

    List<Widget> rowWidgets = List<Widget>();

    if (gameItem.rating != null) {
      ResultWithValue<Widget> tableResult =
          getRatingTableRows(context, gameItem);
      if (tableResult.isSuccess) {
        // widgets.add(tableResult.value);
        rowWidgets.add(Card(
          child: Container(
            constraints: BoxConstraints(maxWidth: 450),
            padding: EdgeInsets.all(10),
            child: tableResult.value,
          ),
        ));
      }
    }

    if (gameItem.box != null) {
      var cudeWidget = Center(
        child: SizedBox(
          child: cubeDimension(context, gameItem.box),
          height: 120,
          // width: 120,
        ),
      );

      rowWidgets.add(Card(
        child: Padding(
            padding: EdgeInsets.only(bottom: 18),
            child: Container(
              constraints: BoxConstraints(maxWidth: 450),
              padding: EdgeInsets.all(10),
              child: cudeWidget,
            )),
      ));
    }

    widgets.add(
      Wrap(
        alignment: WrapAlignment.center,
        children: rowWidgets,
      ),
    );

    List<CraftedUsing> craftingRecipes =
        snapshot?.data?.value?.craftingRecipes ?? [];

    for (CraftedUsing craftingRecipe in craftingRecipes) {
      var stationName = Translations.get(context, craftingRecipe.name);
      widgets.add(emptySpace1x());
      widgets.add(Divider());
      widgets.add(emptySpace1x());
      widgets.add(getTextSpanFromTemplateAndArray(
        context,
        LocaleKey.createXUsingY,
        [gameItem.title, stationName],
      ));
      for (var ingDetailsIndex = 0;
          ingDetailsIndex < craftingRecipe.ingredientDetails.length;
          ingDetailsIndex++) {
        RecipeIngredientDetails ingDetails =
            craftingRecipe.ingredientDetails[ingDetailsIndex];
        widgets.add(Card(
          child: recipeIngredientDetailCustomOnTapTilePresenter(
            context,
            ingDetails,
            ingDetailsIndex,
            onTap: () async {
              if (isInDetailPane && updateDetailView != null) {
                updateDetailView(GameItemDetailPage(
                  ingDetails.id,
                  isInDetailPane: isInDetailPane,
                  updateDetailView: updateDetailView,
                ));
              } else {
                await navigateAwayFromHomeAsync(
                  context,
                  navigateTo: (context) => GameItemDetailPage(
                    ingDetails.id,
                    isInDetailPane: isInDetailPane,
                    updateDetailView: updateDetailView,
                  ),
                );
              }
            },
          ),
        ));
      }
    }

    List<UsedInRecipe> usedInRecipes =
        snapshot?.data?.value?.usedInRecipes ?? [];

    for (UsedInRecipe usedInRecipe in usedInRecipes) {
      widgets.add(emptySpace1x());
      widgets.add(Divider());
      widgets.add(emptySpace1x());
      var name = Translations.get(context, usedInRecipe.name);
      widgets.add(getTextSpanFromTemplateAndArray(
          context, LocaleKey.usedInXToCreate, [name]));
      for (var recipeIndex = 0;
          recipeIndex < usedInRecipe.recipes.length;
          recipeIndex++) {
        Recipe recipe = usedInRecipe.recipes[recipeIndex];
        widgets.add(
          GestureDetector(
            child: Card(
              child: recipeTilePresenter(context, recipe, recipeIndex,
                  showOutputQuantity: true),
            ),
            onTap: () async {
              if (isInDetailPane && updateDetailView != null) {
                updateDetailView(RecipeDetailPage(
                  recipe.id,
                  isInDetailPane: isInDetailPane,
                  updateDetailView: updateDetailView,
                ));
              } else {
                await navigateAwayFromHomeAsync(
                  context,
                  navigateTo: (context) => RecipeDetailPage(
                    recipe.id,
                    isInDetailPane: isInDetailPane,
                    updateDetailView: updateDetailView,
                  ),
                );
              }
            },
          ),
        );
      }
    }

    var navigateToCart = () async =>
        await navigateHomeAsync(context, navigateToNamed: Routes.cart);

    List<CartItemState> cartItems = viewModel.cartItems
        .where((CartItemState ci) => ci.itemId == gameItem.id)
        .toList();
    if (cartItems != null && cartItems.length > 0) {
      widgets.add(emptySpace3x());
      widgets.add(genericItemText(Translations.get(context, LocaleKey.cart)));
      widgets.add(Card(
        child: cartTilePresenter(
          context,
          RecipeIngredientDetails(
            id: gameItem.id,
            icon: gameItem.icon,
            title: gameItem.title,
            quantity: cartItems[0].quantity,
          ),
          0,
          onTap: navigateToCart,
          onEdit: () {
            var controller =
                TextEditingController(text: cartItems[0].quantity.toString());
            showQuantityDialog(context, controller, onSuccess: (quantity) {
              int intQuantity = int.tryParse(quantity);
              if (intQuantity == null) return;
              viewModel.editCartItem(gameItem.id, intQuantity);
            });
          },
          onDelete: () {
            viewModel.removeFromCart(gameItem.id);
          },
        ),
        margin: const EdgeInsets.all(0.0),
      ));
    }

    widgets.add(emptySpace10x());

    var fabColour = getSecondaryColour(context);
    return Stack(
      children: [
        listWithScrollbar(
          padding: AppPadding.listSidePadding,
          itemCount: widgets.length,
          itemBuilder: (context, index) => widgets[index],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            child: Icon(Icons.shopping_basket),
            backgroundColor: fabColour,
            foregroundColor: getForegroundTextColour(fabColour),
            onPressed: () {
              showQuantityDialog(context, controller,
                  title: Translations.get(context, LocaleKey.quantity),
                  onSuccess: (String quantityString) {
                int quantity = int.tryParse(quantityString);
                if (quantity == null) return;
                viewModel.addToCart(gameItem.id, quantity);
                showSnackbar(
                  context,
                  LocaleKey.addedToCart,
                  duration: AppDuration.snackBarAddToCart,
                  onTap: () async => await navigateHomeAsync(context,
                      navigateToNamed: Routes.cart),
                );
              });
            },
          ),
        )
      ],
    );
  }
}
