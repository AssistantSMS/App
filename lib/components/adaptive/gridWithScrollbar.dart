import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/columnHelper.dart';

import '../../helpers/deviceHelper.dart';

Widget gridWithScrollbar(
        {int itemCount,
        Key key,
        Widget Function(BuildContext, int) itemBuilder,
        EdgeInsetsGeometry padding,
        int Function(Breakpoint) gridViewColumnCalculator,
        bool shrinkWrap = false}) =>
    BreakpointBuilder(
        builder: (BuildContext innerContext, Breakpoint breakpoint) {
      var columnCalc = gridViewColumnCalculator ?? getCustomColumnCount;
      var crossAxisCount = columnCalc(breakpoint);
      var listView = StaggeredGridView.countBuilder(
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        physics: isiOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        key: Key('grid-cross-axis$crossAxisCount'),
      );
      return isiOS
          ? appleGridWithScrollbar(itemCount: itemCount, listView: listView)
          : androidGridWithScrollbar(itemCount: itemCount, listView: listView);
    });

Widget androidGridWithScrollbar({int itemCount, Widget listView}) => Scrollbar(
      child: listView,
    );

Widget appleGridWithScrollbar({int itemCount, Widget listView}) =>
    CupertinoScrollbar(
      child: listView,
    );
