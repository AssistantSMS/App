import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../constants/AppImage.dart';
import '../helpers/drawerHelper.dart';
import '../helpers/futureHelper.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: getDrawerItems(context, currentAppVersion()),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        List<Widget> widgets = List<Widget>();
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

        if (!snapshot.hasError && snapshot.hasData && snapshot.data != null) {
          widgets.addAll(snapshot.data);
        }

        return Drawer(
          child: listWithScrollbar(
            itemCount: widgets.length,
            itemBuilder: (BuildContext c, int index) => widgets[index],
            shrinkWrap: true,
          ),
        );
      },
    );
  }
}
