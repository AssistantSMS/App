import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/components/common/image.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/AppImage.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/gameItem/box.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../contracts/gameItem/gameItem.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/colourHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

ResultWithValue<Widget> getTableRows(BuildContext context, GameItem gameItem) {
  List<TableRow> rows = List<TableRow>();
  if (gameItem.rating == null)
    return ResultWithValue<Table>(false, null, 'rating is null');

  if (gameItem.rating.density != null) {
    rows.add(TableRow(children: [
      headingText(context, LocaleKey.density),
      rowValue(context, gameItem.rating.density)
    ]));
  }
  if (gameItem.rating.durability != null) {
    rows.add(TableRow(children: [
      headingText(context, LocaleKey.durability),
      rowValue(context, gameItem.rating.durability)
    ]));
  }
  if (gameItem.rating.friction != null) {
    rows.add(TableRow(children: [
      headingText(context, LocaleKey.friction),
      rowValue(context, gameItem.rating.friction)
    ]));
  }
  if (gameItem.rating.buoyancy != null) {
    rows.add(TableRow(children: [
      headingText(context, LocaleKey.buoyancy),
      rowValue(context, gameItem.rating.buoyancy)
    ]));
  }
  if (gameItem.flammable != null) {
    rows.add(TableRow(children: [
      headingText(context, LocaleKey.flammable),
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
      columnWidths: {0: FractionColumnWidth(.4), 1: FractionColumnWidth(.6)},
    ),
  );
  return ResultWithValue<Widget>(true, child, '');
}

Widget headingText(BuildContext context, LocaleKey key) => Padding(
      child:
          Text(Translations.get(context, key), style: TextStyle(fontSize: 16)),
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
        padding: EdgeInsets.all(16),
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
