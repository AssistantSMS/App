import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../../helpers/colourHelper.dart';
import '../../helpers/deviceHelper.dart';

Widget adaptiveSegmentedControl(BuildContext context,
        {@required List<Widget> controlItems,
        @required int currentSelection,
        @required void Function(int) onSegmentChosen}) =>
    isiOS
        ? _androidSegmentedControl(
            context, controlItems, currentSelection, onSegmentChosen)
        : _androidSegmentedControl(
            context, controlItems, currentSelection, onSegmentChosen);

Widget _androidSegmentedControl(BuildContext context, List<Widget> controlItems,
    int currentSelection, void Function(int) onSegmentChosen) {
  Map<int, Widget> map = Map<int, Widget>();
  for (int childIndex = 0; childIndex < controlItems.length; childIndex++) {
    map.putIfAbsent(childIndex, () => controlItems[childIndex]);
  }

  return MaterialSegmentedControl(
    children: map,
    selectionIndex: currentSelection,
    borderColor: getSecondaryColour(context),
    selectedColor: getSecondaryColour(context),
    unselectedColor:
        getIsDark(context) ? Color.fromRGBO(47, 47, 47, 1) : Colors.white,
    borderRadius: 4.0,
    horizontalPadding: EdgeInsets.only(top: 12, bottom: 6),
    onSegmentChosen: onSegmentChosen,
  );
}

// Widget _iosSegmentedControl(BuildContext context, List<Widget> controlItems,
//     int currentSelection, void Function(int) onSegmentChosen) {}

Widget getSegmentedControlOption(String text) {
  return Padding(
    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
    child: Text(text),
  );
}

Widget getSegmentedControlWithIconOption(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(icon),
        ),
        Text(text)
      ],
    ),
  );
}
