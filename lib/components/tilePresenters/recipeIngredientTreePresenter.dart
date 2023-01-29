import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/recipeIngredient/recipeIngredientTreeDetails.dart';
import '../../pages/gameItem/gameItemDetailPage.dart';

Widget requiredItemTreeDetailsRowPresenter(
  BuildContext context,
  RecipeIngredientTreeDetails itemDetails,
  int cost,
) {
  var rowWidget = Row(
    children: [
      SizedBox(
        child: genericTileImage(itemDetails.icon),
        height: 50,
        width: 50,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(itemDetails.title, maxLines: 2),
            Container(height: 4),
            if (itemDetails.quantity > 0) ...[
              Text(
                "${getTranslations().fromKey(LocaleKey.quantity)}: ${itemDetails.quantity.toString()}",
                style: _subtitleTextStyle(getTheme().getTheme(context)),
                // style: getTheme(context).textTheme.bodyText2,
                // style: TextStyle(color: getTheme(context).textTheme.caption.color),
              ),
            ],
          ],
        ),
      ),
    ],
  );

  onTapFunc() async => await getNavigation().navigateAsync(
        context,
        navigateTo: (context) => GameItemDetailPage(itemDetails.id),
      );

  return GestureDetector(
    child: rowWidget,
    onTap: onTapFunc,
  );
}

TextStyle? _subtitleTextStyle(ThemeData theme) {
  final TextStyle? style = theme.textTheme.bodySmall;
  final Color? color = theme.textTheme.bodySmall?.color;
  return style?.copyWith(color: color);
}
