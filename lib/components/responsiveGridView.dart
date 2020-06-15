import 'package:flutter/material.dart';

import '../helpers/colourHelper.dart';

Widget responsiveGrid<T>(BuildContext context, List<T> items,
    Widget Function(BuildContext context, T item) gridItemPresenter) {
  var deviceWidth = MediaQuery.of(context).size.width;
  var numberOfColumns = 4;
  if (deviceWidth < 600) numberOfColumns = 3;
  if (deviceWidth < 400) numberOfColumns = 2;

  return GridView.builder(
    primary: false,
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: numberOfColumns,
    ),
    itemCount: items.length,
    itemBuilder: (BuildContext context, int index) =>
        gridItemPresenter(context, items[index]),
  );
}

Widget responsiveSelectorGrid<T>(
    BuildContext context,
    List<T> items,
    int selectedIndex,
    Widget Function(BuildContext context, T item) gridItemPresenter) {
  var deviceWidth = MediaQuery.of(context).size.width;
  var numberOfColumns = 8;
  if (deviceWidth < 600) numberOfColumns = 6;
  if (deviceWidth < 400) numberOfColumns = 4;

  return GridView.builder(
    primary: false,
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: numberOfColumns,
    ),
    itemCount: items.length,
    itemBuilder: (BuildContext context, int index) => Container(
      child: gridItemPresenter(context, items[index]),
      color: index == selectedIndex ? getSecondaryColour(context) : null,
    ),
  );
}
