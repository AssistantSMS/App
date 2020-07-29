import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/adaptive/button.dart';
import '../../components/adaptive/listWithScrollbar.dart';
import '../../components/bottomNavbar.dart';
import '../../components/dialogs/quantityDialog.dart';
import '../../components/tilePresenters/cartTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppPadding.dart';
import '../../constants/Routes.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/analytics.dart';
import '../../helpers/dialogHelper.dart';
import '../../helpers/itemsHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/snapshotHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/cart/cartItemState.dart';
import '../../state/modules/cart/cartViewModel.dart';
import '../gameItem/gameItemDetailPage.dart';
import '../generic/genericPageAllRequired.dart';

class CartPage extends StatelessWidget {
  CartPage() {
    trackEvent(AnalyticsEvent.cartPage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(Translations.get(context, LocaleKey.cart)),
      ),
      body: StoreConnector<AppState, CartViewModel>(
        converter: (store) => CartViewModel.fromStore(store),
        builder: (_, viewModel) => FutureBuilder<List<RecipeIngredientDetails>>(
          future: cartItemsFuture(context, viewModel),
          builder: (BuildContext context,
                  AsyncSnapshot<List<RecipeIngredientDetails>> snapshot) =>
              getBody(context, viewModel, snapshot),
        ),
      ),
      bottomNavigationBar: BottomNavbar(currentRoute: Routes.cart),
    );
  }

  Future<List<RecipeIngredientDetails>> cartItemsFuture(
      context, CartViewModel viewModel) async {
    List<RecipeIngredientDetails> reqItems = List<RecipeIngredientDetails>();
    for (CartItemState cartItem in viewModel.craftingItems) {
      var genRepo = getGameItemRepoFromId(context, cartItem.itemId);
      if (genRepo.hasFailed) continue;

      ResultWithValue<GameItem> itemResult =
          await genRepo.value.getById(context, cartItem.itemId);
      if (itemResult.isSuccess)
        reqItems.add(RecipeIngredientDetails(
          id: itemResult.value.id,
          icon: itemResult.value.icon,
          title: itemResult.value.title,
          quantity: cartItem.quantity,
        ));
    }
    return reqItems;
  }

  Widget getBody(BuildContext context, CartViewModel viewModel,
      AsyncSnapshot<List<RecipeIngredientDetails>> snapshot) {
    Widget errorWidget = asyncSnapshotHandler(context, snapshot);
    if (errorWidget != null) return errorWidget;

    List<Widget> widgets = List<Widget>();
    List<RecipeIngredient> requiredItems = List<RecipeIngredient>();
    for (var ingDetailsIndex = 0;
        ingDetailsIndex < snapshot.data.length;
        ingDetailsIndex++) {
      RecipeIngredientDetails cartDetail = snapshot.data[ingDetailsIndex];
      widgets.add(cartTilePresenter(
        context,
        cartDetail,
        ingDetailsIndex,
        onTap: () async => await navigateAsync(context,
            navigateTo: (context) => GameItemDetailPage(cartDetail.id)),
        onEdit: () {
          var controller =
              TextEditingController(text: cartDetail.quantity.toString());
          showQuantityDialog(context, controller, onSuccess: (quantity) {
            int intQuantity = int.tryParse(quantity);
            if (intQuantity == null) return;
            viewModel.editCartItem(cartDetail.id, intQuantity);
          });
        },
        onDelete: () {
          viewModel.removeFromCart(cartDetail.id);
        },
      ));

      requiredItems.add(RecipeIngredient(
        id: cartDetail.id,
        quantity: cartDetail.quantity,
      ));
    }

    if (widgets.length > 0) {
      widgets.add(Container(
        child: positiveButton(
          title: Translations.get(context, LocaleKey.viewAllRequiredItems),
          onPress: () async => await navigateAsync(
            context,
            navigateTo: (context) => GenericAllRequiredPage(requiredItems),
          ),
        ),
      ));
      widgets.add(Container(
        child: negativeButton(
            title: Translations.get(context, LocaleKey.deleteAll),
            onPress: () {
              showSimpleDialog(
                  context,
                  Translations.get(context, LocaleKey.deleteAll),
                  Text(Translations.get(context, LocaleKey.areYouSure)),
                  buttons: [
                    simpleDialogCloseButton(context),
                    simpleDialogPositiveButton(context,
                        title: LocaleKey.yes,
                        onTap: () => viewModel.removeAllFromCart()),
                  ]);
            }),
      ));
    } else {
      widgets.add(
        Container(
          child: Text(
            Translations.get(context, LocaleKey.noItems),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20),
          ),
          margin: EdgeInsets.only(top: 30),
        ),
      );
    }

    return listWithScrollbar(
        padding: AppPadding.listSidePadding,
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index]);
  }
}
