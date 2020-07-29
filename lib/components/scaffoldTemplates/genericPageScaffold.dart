import 'package:flutter/material.dart';

import '../../contracts/misc/actionItem.dart';
import '../../helpers/navigationHelper.dart';
import '../adaptive/appBarForSubPage.dart';
import '../adaptive/appScaffold.dart';
import '../bottomNavbar.dart';

Widget genericPageScaffold<T>(
  context,
  String title,
  snapshot, {
  Widget Function(BuildContext context, AsyncSnapshot<T> snapshot) body,
  bool showShortcutLinks = false,
  List<ActionItem> shortcutActions,
  Widget floatingActionButton,
}) {
  List<ActionItem> actions = List<ActionItem>();
  actions.add(ActionItem(
    icon: Icons.home,
    onPressed: () async => await navigateHomeAsync(context),
  ));
  return appScaffold(
    context,
    appBar: appBarForSubPageHelper(
      context,
      title: Text(title),
      actions: actions,
      shortcutActions: shortcutActions,
    ),
    body: body(context, snapshot),
    bottomNavigationBar: BottomNavbar(noRouteSelected: true),
    floatingActionButton: floatingActionButton,
  );
}
