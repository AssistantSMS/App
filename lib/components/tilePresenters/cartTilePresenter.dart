import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/cupertino.dart';

import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../pages/gameItem/gameItemDetailPage.dart';

Widget cartTilePresenter(
  BuildContext context,
  RecipeIngredientDetails recipeIngredient,
  int index, {
  void Function()? onTap,
  void Function()? onEdit,
  void Function()? onDelete,
}) =>
    genericListTile(
      context,
      leadingImage: recipeIngredient.icon,
      name: recipeIngredient.title,
      quantity: recipeIngredient.quantity,
      onTap: onTap ??
          () async => await getNavigation().navigateAwayFromHomeAsync(
                context,
                navigateTo: (context) =>
                    GameItemDetailPage(recipeIngredient.id),
              ),
      trailing: popupMenu(context, onEdit: onEdit, onDelete: onDelete),
    );
