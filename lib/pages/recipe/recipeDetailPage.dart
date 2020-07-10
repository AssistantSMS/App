import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../components/adaptive/listWithScrollbar.dart';
import '../../components/common/cachedFutureBuilder.dart';
import '../../components/dialogs/quantityDialog.dart';
import '../../components/loading.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../components/tilePresenters/recipeIngredientTilePresenter.dart';
import '../../components/webSpecific/mousePointer.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppDuration.dart';
import '../../constants/AppImage.dart';
import '../../constants/AppPadding.dart';
import '../../constants/IdPrefix.dart';
import '../../constants/Routes.dart';
import '../../contracts/recipe/recipePageItem.dart';
import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/analytics.dart';
import '../../helpers/colourHelper.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/snackbarHelper.dart';
import '../../helpers/snapshotHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/cart/cartItemState.dart';
import '../../state/modules/gameItem/gameItemViewModel.dart';
import '../gameItem/gameItemDetailPage.dart';

class RecipeDetailPage extends StatelessWidget {
  final String itemId;
  final bool isInDetailPane;
  final void Function(Widget newDetailView) updateDetailView;

  RecipeDetailPage(
    this.itemId, {
    this.isInDetailPane = false,
    this.updateDetailView,
  }) {
    trackEvent('${AnalyticsEvent.recipeDetailPage}: ${this.itemId}');
  }

  @override
  Widget build(BuildContext context) {
    String loading = Translations.get(context, LocaleKey.loading);
    var loadingWidget = fullPageLoading(context, loadingText: loading);
    return CachedFutureBuilder<ResultWithValue<RecipePageItem>>(
      future: recipePageItemFuture(context, this.itemId),
      whileLoading: isInDetailPane
          ? loadingWidget
          : genericPageScaffold(context, loading, null,
              body: (_, __) => loadingWidget, showShortcutLinks: true),
      whenDoneLoading:
          (AsyncSnapshot<ResultWithValue<RecipePageItem>> snapshot) {
        var bodyWidget = StoreConnector<AppState, GameItemViewModel>(
          converter: (store) => GameItemViewModel.fromStore(store),
          builder: (_, viewModel) => getBody(context, viewModel, snapshot),
        );
        if (isInDetailPane) return bodyWidget;
        return genericPageScaffold<ResultWithValue<RecipePageItem>>(
          context,
          (snapshot?.data?.value?.recipe?.title ?? loading) + ' recipe',
          snapshot,
          body: (_, __) => bodyWidget,
          showShortcutLinks: true,
        );
      },
    );
  }

  Widget getBody(BuildContext context, GameItemViewModel viewModel,
      AsyncSnapshot<ResultWithValue<RecipePageItem>> snapshot) {
    TextEditingController controller = TextEditingController();
    Widget errorWidget = asyncSnapshotHandler(context, snapshot,
        isValidFunction: (ResultWithValue<RecipePageItem> itemResult) {
      if (!itemResult.isSuccess) return false;
      if (itemResult.value == null) return false;
      if (itemResult.value.recipe == null) return false;
      if (itemResult.value.recipe.icon == null) return false;

      return true;
    });
    if (errorWidget != null) return errorWidget;

    var recipeItem = snapshot?.data?.value?.recipe;
    var isTrade = recipeItem.id.contains(IdPrefix.recipeHideOut);

    List<Widget> widgets = List<Widget>();

    List<Widget> stackWidgets = List<Widget>();
    stackWidgets.add(genericItemImage(
      context,
      '${AppImage.base}${recipeItem.icon}',
      name: recipeItem.title,
    ));
    if (recipeItem?.output?.id != null) {
      stackWidgets.add(Positioned(
        child: GestureDetector(
          child: Icon(Icons.info_outline, size: 40),
          onTap: () async {
            if (isInDetailPane && updateDetailView != null) {
              updateDetailView(GameItemDetailPage(
                recipeItem.output.id,
                isInDetailPane: isInDetailPane,
                updateDetailView: updateDetailView,
              ));
            } else {
              await navigateAwayFromHomeAsync(
                context,
                navigateToNamed: Routes.gameDetail,
                navigateToNamedParameters: {
                  Routes.itemIdParam: recipeItem.output.id
                },
              );
            }
          },
        ).showPointerOnHover,
        top: 12,
        right: 4,
      ));
    }
    widgets.add(Stack(children: stackWidgets));
    widgets.add(emptySpace1x());
    var quantitySuffix = recipeItem?.output?.quantity?.toString() != null
        ? ' x${recipeItem.output.quantity}'
        : '';
    widgets.add(genericItemName(recipeItem.title + quantitySuffix));
    if (recipeItem.description != null && recipeItem.description.length > 0) {
      widgets.add(genericItemDescription(recipeItem.description));
    }

    if (!isTrade) {
      var timeToCraft = Translations.get(context, LocaleKey.timeToCraft) +
          ' ' +
          recipeItem.craftingTime.toString() +
          's';
      widgets.add(genericItemDescription(timeToCraft));
    }

    widgets.add(customDivider());
    widgets.add(emptySpace1x());

    LocaleKey localeKey = LocaleKey.craftedUsing;
    if (isTrade) {
      localeKey = LocaleKey.tradedFor;
    }
    widgets.add(Text(
      Translations.get(context, localeKey),
      textAlign: TextAlign.center,
    ));
    for (var recipeIngIndex = 0;
        recipeIngIndex < recipeItem.inputs.length;
        recipeIngIndex++) {
      RecipeIngredientDetails recipeIng =
          snapshot?.data?.value?.ingredientDetails[recipeIngIndex];
      widgets.add(Card(
        child: recipeIngredientDetailCustomOnTapTilePresenter(
          context,
          recipeIng,
          recipeIngIndex,
          onTap: () async {
            if (isInDetailPane && updateDetailView != null) {
              updateDetailView(GameItemDetailPage(
                recipeIng.id,
                isInDetailPane: isInDetailPane,
                updateDetailView: updateDetailView,
              ));
            } else {
              await navigateAwayFromHomeAsync(
                context,
                navigateToNamed: Routes.gameDetail,
                navigateToNamedParameters: {Routes.itemIdParam: recipeIng.id},
              );
            }
          },
        ),
      ));
    }

    var navigateToCart = () async =>
        await navigateHomeAsync(context, navigateToNamed: Routes.cart);

    List<CartItemState> cartItems = viewModel.cartItems
        .where((CartItemState ci) => ci.itemId == recipeItem.output.id)
        .toList();
    if (cartItems != null && cartItems.length > 0) {
      widgets.add(emptySpace3x());
      widgets.add(genericItemText(Translations.get(context, LocaleKey.cart)));
      print(recipeItem.output.id);
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
            child: Icon(Icons.shopping_cart),
            backgroundColor: fabColour,
            foregroundColor: getForegroundTextColour(fabColour),
            onPressed: () {
              showQuantityDialog(context, controller,
                  title: Translations.get(context, LocaleKey.quantity),
                  onSuccess: (String quantityString) {
                int quantity = int.tryParse(quantityString);
                if (quantity == null) return;
                viewModel.addToCart(recipeItem.output.id, quantity);
                showSnackbar(
                  context,
                  LocaleKey.addedToCart,
                  duration: AppDuration.snackBarAddToCart,
                  onTap: navigateToCart,
                );
              });
            },
          ),
        )
      ],
    );
  }
}
