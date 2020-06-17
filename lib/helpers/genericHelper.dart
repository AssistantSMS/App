import 'package:flutter/material.dart';

import '../components/adaptive/button.dart';
import '../components/common/image.dart';
import '../constants/AppImage.dart';
import '../integration/logging.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';
import 'colourHelper.dart';

final int maxNumberOfRowsForRecipeCategory = 3;

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

      // String url = 'assets/images/$icon';
      // String helpContent;
      // if (hdAvailable) {
      //   url = "${ExternalUrls.assistantNMSCDN}/$icon";
      //   helpContent =
      //       'Yakuza did all the hard work'; // TODO HDImages - Translations
      // }
      // await navigateAsync(
      //   context,
      //   navigateTo: (context) => ImageViewerPage(
      //     name,
      //     url, // 'https://github.com/NMSCD/No-Mans-Sky-Enhanced-Images/blob/master/AssistantNMS/cooking/1.png?raw=true',
      //     helpContent: helpContent,
      //   ),
      // );
    };

Widget genericItemName(String name, {maxLines = 3}) => Container(
      child: Text(
        name,
        textAlign: TextAlign.center,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 20),
      ),
      margin: const EdgeInsets.all(4.0),
    );

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
              style: TextStyle(fontSize: 20),
            ),
            Chip(
                label: Text('x $quantity'),
                backgroundColor: getSecondaryColour(context))
          ]),
      margin: const EdgeInsets.all(4.0),
    );

Widget genericItemGroup(String group) => Container(
      child: Text(
        group,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 20),
      ),
      margin: const EdgeInsets.all(4.0),
    );

Widget genericItemDescription(String description, {TextStyle textStyle}) =>
    Container(
      child: Text(
        description,
        textAlign: TextAlign.center,
        maxLines: 10,
        style: textStyle,
      ),
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
            ? Padding(padding: EdgeInsets.only(left: 5), child: second)
            : second,
      ]),
      margin: const EdgeInsets.all(4.0),
    );

Widget genericIconWithText(IconData icon, String text, {Function onTap}) => Row(
      children: [
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(right: 4),
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
  List<Widget> widgets = List<Widget>();
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
  String viewMore = Translations.get(context, LocaleKey.viewXMore);
  return Container(
    child: positiveButton(
      title: viewMore.replaceAll("{0}", numLeftOver.toString()),
      onPress: () {
        if (viewMoreOnPress == null) return;
        viewMoreOnPress();
      },
    ),
  );
}

Widget genericItemText(String text) => Container(
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      margin: const EdgeInsets.all(4.0),
    );

Widget genericEllipsesText(String text) => Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

Widget getListTileImage(context, String partialPath) => ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 35,
        maxHeight: 35,
      ),
      child: localImage('${AppImage.base}$partialPath'),
    );
Widget getCorrectlySizedImageFromIcon(context, IconData icon, {Color colour}) =>
    ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 35,
        maxHeight: 35,
      ),
      child: Center(
        child: Icon(
          icon,
          color: colour ?? getSecondaryColour(context),
          size: 35,
        ),
      ),
    );

Widget genericChip(context, String title, {Color color, Function onTap}) =>
    genericChipWidget(context, Text(title), color: color, onTap: onTap);

Widget genericChipWidget(context, Widget content,
    {Color color, Function onTap}) {
  var child = Padding(
    child: Chip(
      label: content,
      backgroundColor: color ?? getSecondaryColour(context),
    ),
    padding: EdgeInsets.only(left: 4),
  );
  return (onTap == null) ? child : GestureDetector(child: child, onTap: onTap);
}

Widget emptySpace(double multiplier) =>
    Container(margin: EdgeInsets.all(multiplier * 4));
Widget emptySpace1x() => emptySpace(1.0);
Widget emptySpace2x() => emptySpace(2.0);
Widget emptySpace3x() => emptySpace(3.0);
Widget emptySpace8x() => emptySpace(8.0);
Widget emptySpace10x() => emptySpace(10.0);

List<T> getListFromJson<T>(dynamic obj, T Function(dynamic json) func) {
  if (obj == null) return List<T>();
  try {
    return List<T>.from(obj.map((t) => func(t)));
  } catch (exception) {
    logger.e("getListFromJson - $exception");
    return List<T>();
  }
}

String simpleDate(DateTime dateTime) =>
    "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

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
