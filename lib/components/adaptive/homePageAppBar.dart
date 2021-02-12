import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/Routes.dart';
import 'appBar.dart';

class HomePageAppBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  final preferredSize;
  final bottom;
  final backgroundColor;
  static final kMinInteractiveDimensionCupertino = 44.0;

  HomePageAppBar({this.bottom, this.backgroundColor})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super();

  @override
  Widget build(BuildContext context) {
    Widget title = Text(getTranslations().fromKey(LocaleKey.title));
    List<ActionItem> actions = List.empty(growable: true);
    actions.add(ActionItem(
      icon: Icons.settings,
      onPressed: () async => await getNavigation().navigateAsync(
        context,
        navigateToNamed: Routes.settings,
      ),
    ));
    return _androidAppBarActions(context, title, actions);
  }

  Widget _androidAppBarActions(
      context, Widget title, List<ActionItem> actions) {
    List<Widget> widgets = List.empty(growable: true);
    widgets.addAll(actionItemToAndroidAction(actions));
    return adaptiveAppBar(
      context,
      Text(getTranslations().fromKey(LocaleKey.title)),
      widgets,
      bottom: this.bottom,
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
