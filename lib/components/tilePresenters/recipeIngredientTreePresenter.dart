import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/recipeIngredient/recipeIngredientTreeDetails.dart';

import '../../helpers/navigationHelper.dart';
import '../../integration/themeManager.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../pages/gameItem/gameItemDetailPage.dart';
import 'genericTilePresenter.dart';

Widget requiredItemTreeDetailsRowPresenter(
    BuildContext context, RecipeIngredientTreeDetails itemDetails, int cost) {
  var rowWidget = Row(
    children: [
      if (itemDetails.icon != null) ...[
        SizedBox(
          child: genericTileImage(itemDetails.icon, null),
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
                "${Translations.get(context, LocaleKey.quantity)}: ${itemDetails.quantity.toString()}",
                style: _subtitleTextStyle(getTheme(context)),
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
  var onTapFunc = () async => await navigateAsync(
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
