import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../constants/AppImage.dart';
import '../helpers/drawerHelper.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);
    widgets.add(DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            getTheme().getPrimaryColour(context),
            getTheme().getSecondaryColour(context),
          ],
        ),
      ),
      child: Padding(
        child: Image(image: AssetImage(AppImage.drawer)),
        padding: EdgeInsets.all(8),
      ),
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
    ));

    widgets.addAll(getDrawerItems(context));

    return Drawer(
      child: listWithScrollbar(
        itemCount: widgets.length,
        itemBuilder: (BuildContext c, int index) => widgets[index],
        shrinkWrap: true,
      ),
    );
  }
}
