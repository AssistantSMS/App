import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

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
  List<ActionItem> actions = List.empty(growable: true);
  actions.add(ActionItem(
    icon: Icons.home,
    onPressed: () async => await getNavigation().navigateHomeAsync(context),
  ));
  return getBaseWidget().appScaffold(
    context,
    appBar: getBaseWidget().appBarForSubPage(
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
