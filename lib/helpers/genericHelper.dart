import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

const int maxNumberOfRowsForRecipeCategory = 3;

Widget genericItemImage(BuildContext context, String imagePath,
        {bool disableZoom = false,
        double height = 100,
        String name = 'Zoom',
        bool hdAvailable = false,
        Function onTap}) =>
    Center(
      child: GestureDetector(
        child: Container(
          child: localImage(imagePath, height: height),
          margin: const EdgeInsets.all(4.0),
        ),
        onTap: onTap ??
            genericItemImageOnTap(
                context, imagePath, disableZoom, name, hdAvailable),
      ),
    );

Function genericItemImageOnTap(BuildContext context, String imagePath,
        bool disableZoom, String name, bool hdAvailable) =>
    () async {
      if (disableZoom) return;
    };

Widget genericItemNameWithQuantity(context, String name, String quantity) =>
    Container(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              name + '   ',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20),
            ),
            Chip(
                label: Text('x $quantity'),
                backgroundColor: getTheme().getSecondaryColour(context))
          ]),
      margin: const EdgeInsets.all(4.0),
    );

Widget genericItemIntCurrency(String currency, String imageUrl,
        {Color colour}) =>
    genericItemWithListWidgets(
        Text(
          currency,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: colour),
        ),
        localImage(imageUrl, height: 20));

Widget genericItemTextWithIcon(String text, IconData icon,
        {Color colour, bool addSpace = true}) =>
    genericItemWithListWidgets(
      Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: colour),
      ),
      Icon(icon, size: 20, color: colour),
      addSpace: addSpace,
    );

Widget genericItemWithListWidgets(Widget first, Widget second,
        {bool addSpace = true}) =>
    Container(
      child: Wrap(alignment: WrapAlignment.center, children: [
        first,
        addSpace
            ? Padding(padding: const EdgeInsets.only(left: 5), child: second)
            : second,
      ]),
      margin: const EdgeInsets.all(4.0),
    );

Widget genericIconWithText(IconData icon, String text, {Function onTap}) => Row(
      children: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(icon),
          ),
          onTap: () {
            if (onTap != null) onTap();
          },
        ),
        Text(text),
      ],
    );

List<Widget> genericItemWithOverflowButton<T>(context, List<T> itemArray,
    Widget Function(BuildContext context, T item) presenter,
    {Function viewMoreOnPress}) {
  int numRecords = itemArray.length > maxNumberOfRowsForRecipeCategory
      ? maxNumberOfRowsForRecipeCategory
      : itemArray.length;
  List<Widget> widgets = List.empty(growable: true);
  for (var itemIndex = 0; itemIndex < numRecords; itemIndex++) {
    widgets.add(Card(
      child: presenter(context, itemArray[itemIndex]),
      margin: const EdgeInsets.all(0.0),
    ));
  }
  if (itemArray.length > maxNumberOfRowsForRecipeCategory &&
      viewMoreOnPress != null) {
    widgets.add(viewMoreButton(
        context, (itemArray.length - numRecords), viewMoreOnPress));
  }
  return widgets;
}

Widget viewMoreButton(context, int numLeftOver, viewMoreOnPress) {
  String viewMore = getTranslations().fromKey(LocaleKey.viewXMore);
  return Container(
    child: positiveButton(
      context,
      title: viewMore.replaceAll("{0}", numLeftOver.toString()),
      onPress: () {
        if (viewMoreOnPress == null) return;
        viewMoreOnPress();
      },
    ),
  );
}

Widget genericChip(context, String title, {Color color, Function onTap}) =>
    genericChipWidget(context, Text(title), color: color, onTap: onTap);

Widget genericChipWidget(context, Widget content,
    {Color color, Function onTap}) {
  var child = Padding(
    child: Chip(
      label: content,
      backgroundColor: color ?? getTheme().getSecondaryColour(context),
    ),
    padding: const EdgeInsets.only(left: 4),
  );
  return (onTap == null) ? child : GestureDetector(child: child, onTap: onTap);
}

Widget gridIconTilePresenter(BuildContext innerContext, String imageprefix,
        String imageAddress, Function(String icon) onTap) =>
    genericItemImage(
      innerContext,
      '$imageprefix$imageAddress',
      disableZoom: true,
      onTap: () => onTap(imageAddress),
    );

String padString(String input, int numChars) {
  String padding = '';
  for (var paddingIndex = 0;
      paddingIndex < numChars - input.length;
      paddingIndex++) {
    padding += '0';
  }
  return padding + input;
}
