import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/Routes.dart';

class HomePageAppBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  @override
  final Size preferredSize;
  final dynamic bottom;
  final Color? backgroundColor;
  static const double kMinInteractiveDimensionCupertino = 44.0;

  HomePageAppBar({
    Key? key,
    this.bottom,
    this.backgroundColor,
  })  : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ActionItem> actions = List.empty(growable: true);
    actions.add(ActionItem(
      icon: Icons.settings,
      onPressed: () async => await getNavigation().navigateAsync(
        context,
        navigateToNamed: Routes.settings,
      ),
    ));

    List<Widget> widgets = List.empty(growable: true);
    widgets.addAll(actionItemToAndroidAction(context, actions));

    return AdaptiveAppBar(
      title: Text(getTranslations().fromKey(LocaleKey.title)),
      actions: widgets,
      bottom: bottom,
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
