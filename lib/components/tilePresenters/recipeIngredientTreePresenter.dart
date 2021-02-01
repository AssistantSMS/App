import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/AppImage.dart';

import '../../contracts/recipeIngredient/recipeIngredientTreeDetails.dart';
import '../../pages/gameItem/gameItemDetailPage.dart';

Widget requiredItemTreeDetailsRowPresenter(
    BuildContext context, RecipeIngredientTreeDetails itemDetails, int cost) {
  var rowWidget = Row(
    children: [
      if (itemDetails.icon != null) ...[
        SizedBox(
          child: genericTileImage(itemDetails.icon),
          height: 50,
          width: 50,
        ),
      ],
      Padding(
        padding: EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(itemDetails.title, maxLines: 2),
            Container(height: 4),
            if (itemDetails.quantity != null && itemDetails.quantity > 0) ...[
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
  if (itemDetails.id == null) return rowWidget;
  var onTapFunc = () async => await getNavigation().navigateAsync(
        context,
        navigateTo: (context) => GameItemDetailPage(itemDetails.id),
      );

  return GestureDetector(
    child: rowWidget,
    onTap: onTapFunc,
  );
}

TextStyle _subtitleTextStyle(ThemeData theme) {
  final TextStyle style = theme.textTheme.bodyText2;
  final Color color = theme.textTheme.caption.color;
  return style.copyWith(color: color);
}
