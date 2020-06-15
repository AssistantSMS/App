import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/Routes.dart';

import '../../contracts/misc/actionItem.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import 'appBar.dart';

class HomePageAppBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  final changeBrightness;
  final onLocaleChange;
  final preferredSize;
  final bottom;
  final backgroundColor;
  static final kMinInteractiveDimensionCupertino = 44.0;

  HomePageAppBar(this.changeBrightness, this.onLocaleChange,
      {this.bottom, this.backgroundColor})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super();

  @override
  Widget build(BuildContext context) {
    var title = Text(Translations.get(context, LocaleKey.title));
    var actions = List<ActionItem>();
    actions.add(ActionItem(
      icon: Icons.settings,
      onPressed: () async => await navigateAsync(
        context,
        navigateToNamed: Routes.settings,
      ),
    ));
    return _androidAppBarActions(context, title, actions);
  }

  Widget _androidAppBarActions(
      context, Widget title, List<ActionItem> actions) {
    List<Widget> widgets = List<Widget>();
    widgets.addAll(actionItemToAndroidAction(actions));
    return adaptiveAppBar(
      context,
      Text(Translations.get(context, LocaleKey.title)),
      widgets,
      bottom: this.bottom,
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}

Widget homePageAppBar(changeBrightness, onLocaleChange) =>
    HomePageAppBar(changeBrightness, onLocaleChange);
