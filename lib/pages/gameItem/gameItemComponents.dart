import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/gameItem/cylinder.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../components/common/image.dart';
import '../../components/customPaint/ratingOval.dart';
import '../../constants/AppImage.dart';
import '../../contracts/gameItem/box.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/colourHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

ResultWithValue<Widget> getRatingTableRows(
    BuildContext context, GameItem gameItem) {
  List<TableRow> rows = List<TableRow>();
  if (gameItem.rating == null)
    return ResultWithValue<Table>(false, null, 'rating is null');

  var isDark = getIsDark(context);
  if (gameItem.rating.density != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.weight(isDark), LocaleKey.density),
      rowValue(context, gameItem.rating.density)
    ]));
  }
  if (gameItem.rating.durability != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.durability(isDark), LocaleKey.durability),
      rowValue(context, gameItem.rating.durability)
    ]));
  }
  if (gameItem.rating.friction != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.friction(isDark), LocaleKey.friction),
      rowValue(context, gameItem.rating.friction)
    ]));
  }
  if (gameItem.rating.buoyancy != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.buoyancy(isDark), LocaleKey.buoyancy),
      rowValue(context, gameItem.rating.buoyancy)
    ]));
  }
  if (gameItem.flammable != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.flammable(isDark), LocaleKey.flammable),
      Text(
        Translations.get(
            context, gameItem.flammable ? LocaleKey.yes : LocaleKey.no),
        textAlign: TextAlign.center,
        style: TextStyle(color: getPrimaryColour(context), fontSize: 16),
      ),
    ]));
  }

  var child = Padding(
    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
    child: Table(
      children: rows,
      // border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {0: FractionColumnWidth(.5), 1: FractionColumnWidth(.5)},
    ),
  );
  return ResultWithValue<Widget>(true, child, '');
}

Widget headingLocaleKeyWithImage(
        BuildContext context, String imagePath, LocaleKey key,
        {TextAlign textAlign}) =>
    Row(children: [
      Padding(
        padding: EdgeInsets.only(right: 4),
        child: localImage(
          imagePath,
          height: 16,
          // imageInvertColor: true, //getIsDark(context) == false,
        ),
      ),
      headingText(context, Translations.get(context, key),
          textAlign: textAlign),
    ]);

Widget headingLocaleKey(BuildContext context, LocaleKey key,
        {TextAlign textAlign}) =>
    headingText(context, Translations.get(context, key), textAlign: textAlign);

Widget headingText(BuildContext context, String text, {TextAlign textAlign}) =>
    Padding(
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
        textAlign: textAlign,
      ),
      padding: EdgeInsets.only(top: 2, bottom: 4),
    );

Widget rowValue(BuildContext context, int value) {
  return Center(
    child: StepProgressIndicator(
      size: 16,
      totalSteps: 10,
      currentStep: value,
      selectedColor: getPrimaryColour(context),
      unselectedColor: Colors.black,
      customStep: (index, color, size) {
        return ratingOval(index < value, getPrimaryColour(context));
      },
    ),
  );
}

Widget rowText(BuildContext context, String text) {
  return Padding(
    child: Text(text),
    padding: EdgeInsets.only(top: 2, bottom: 4),
  );
}

Widget rowInt(
    BuildContext context, int quantity, String suffix, String suffixPural) {
  return Padding(
    child: Text(quantity.toString() + (quantity == 1 ? suffix : suffixPural)),
    padding: EdgeInsets.only(top: 2, bottom: 4),
  );
}

Widget cubeDimensionGrid(BuildContext context, Box box) {
  String suffix = "";
  String suffixPural = "";
  return Padding(
    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
    child: Table(
      children: [
        TableRow(children: [
          headingText(context, "X: ", textAlign: TextAlign.end),
          rowInt(context, box.x, suffix, suffixPural),
        ]),
        TableRow(children: [
          headingText(context, "Y: ", textAlign: TextAlign.end),
          rowInt(context, box.y, suffix, suffixPural),
        ]),
        TableRow(children: [
          headingText(context, "Z: ", textAlign: TextAlign.end),
          rowInt(context, box.z, suffix, suffixPural),
        ]),
        TableRow(children: [
          headingText(context, "Area: ", textAlign: TextAlign.end),
          rowInt(context, (box.x * box.y * box.z), suffix, suffixPural),
        ])
      ],
      // border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {0: FractionColumnWidth(.5), 1: FractionColumnWidth(.5)},
    ),
  );
}

Widget cubeDimension(BuildContext context, Box box) {
  var textStyleDim = TextStyle(
    fontSize: 20,
    color: getSecondaryColour(context),
  );
  return Stack(
    children: [
      Padding(
        child: localImage(AppImage.dimensionsCube),
        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      ),
      Positioned(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(box.z.toString(), style: textStyleDim),
            Text(box.x.toString(), style: textStyleDim),
          ],
        ),
        left: 8,
        right: 8,
        bottom: 0,
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(box.y.toString(), style: textStyleDim),
        ),
      ),
    ],
  );
}

Widget cylinderDimension(BuildContext context, Cylinder cylinder) {
  var textStyleDim = TextStyle(
    fontSize: 20,
    color: getSecondaryColour(context),
  );
  return Stack(
    children: [
      Padding(
        child: localImage(AppImage.dimensionsCylinder),
        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      ),
      Positioned(
        child: Text(
          cylinder.diameter.toString(),
          style: textStyleDim,
          textAlign: TextAlign.center,
        ),
        left: 8,
        right: 8,
        bottom: 0,
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(cylinder.depth.toString(), style: textStyleDim),
        ),
      ),
    ],
  );
}

Widget paddedCardWithMaxSize(Widget child,
    {double maxWidth = 450, EdgeInsetsGeometry padding}) {
  var container = Container(
    constraints: BoxConstraints(maxWidth: maxWidth),
    padding: EdgeInsets.all(10),
    child: child,
  );
  return (padding == null)
      ? Card(child: container)
      : Card(
          child: Padding(
            padding: padding,
            child: container,
          ),
        );
}
