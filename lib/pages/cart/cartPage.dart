import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../components/bottomNavbar.dart';
import '../../components/tilePresenters/cartTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppPadding.dart';
import '../../constants/Routes.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../helpers/itemsHelper.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/cart/cartItemState.dart';
import '../../state/modules/cart/cartViewModel.dart';
import '../gameItem/gameItemDetailPage.dart';
import '../generic/genericPageAllRequired.dart';

class CartPage extends StatelessWidget {
  CartPage({Key key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.cartPage);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.cart)),
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
      bottomNavigationBar: const BottomNavbar(currentRoute: Routes.cart),
    );
  }

  Future<List<RecipeIngredientDetails>> cartItemsFuture(
      context, CartViewModel viewModel) async {
    List<RecipeIngredientDetails> reqItems = List.empty(growable: true);
    for (CartItemState cartItem in viewModel.craftingItems) {
      var genRepo = getGameItemRepoFromId(context, cartItem.itemId);
      if (genRepo.hasFailed) continue;

      ResultWithValue<GameItem> itemResult =
          await genRepo.value.getById(context, cartItem.itemId);
      if (itemResult.isSuccess) {
        reqItems.add(RecipeIngredientDetails(
          id: itemResult.value.id,
          icon: itemResult.value.icon,
          title: itemResult.value.title,
          quantity: cartItem.quantity,
        ));
      }
    }
    return reqItems;
  }

  Widget getBody(BuildContext context, CartViewModel viewModel,
      AsyncSnapshot<List<RecipeIngredientDetails>> snapshot) {
    Widget errorWidget = asyncSnapshotHandler(context, snapshot);
    if (errorWidget != null) return errorWidget;

    List<Widget> widgets = List.empty(growable: true);
    List<RecipeIngredient> requiredItems = List.empty(growable: true);
    for (var ingDetailsIndex = 0;
        ingDetailsIndex < snapshot.data.length;
        ingDetailsIndex++) {
      RecipeIngredientDetails cartDetail = snapshot.data[ingDetailsIndex];
      widgets.add(cartTilePresenter(
        context,
        cartDetail,
        ingDetailsIndex,
        onTap: () async => await getNavigation().navigateAsync(context,
            navigateTo: (context) => GameItemDetailPage(cartDetail.id)),
        onEdit: () {
          var controller =
              TextEditingController(text: cartDetail.quantity.toString());
          getDialog().showQuantityDialog(context, controller,
              onSuccess: (quantity) {
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

    if (widgets.isNotEmpty) {
      widgets.add(Container(
        child: positiveButton(
          title: getTranslations().fromKey(LocaleKey.viewAllRequiredItems),
          onPress: () async => await getNavigation().navigateAsync(
            context,
            navigateTo: (context) => GenericAllRequiredPage(requiredItems),
          ),
        ),
      ));
      widgets.add(Container(
        child: negativeButton(
            title: getTranslations().fromKey(LocaleKey.deleteAll),
            onPress: () {
              getDialog().showSimpleDialog(
                  context,
                  getTranslations().fromKey(LocaleKey.deleteAll),
                  Text(getTranslations().fromKey(LocaleKey.areYouSure)),
                  buttons: [
                    getDialog().simpleDialogCloseButton(context),
                    getDialog().simpleDialogPositiveButton(context,
                        title: LocaleKey.yes,
                        onTap: () => viewModel.removeAllFromCart()),
                  ]);
            }),
      ));
    } else {
      widgets.add(
        Container(
          child: Text(
            getTranslations().fromKey(LocaleKey.noItems),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20),
          ),
          margin: const EdgeInsets.only(top: 30),
        ),
      );
    }

    return listWithScrollbar(
        padding: AppPadding.listSidePadding,
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index]);
  }
}
