import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../contracts/misc/staggeredGridItem.dart';
import '../helpers/columnHelper.dart';

Widget responsiveStaggeredGrid(List<StaggeredGridItem> items) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: BreakpointBuilder(
      builder: (BuildContext innerContext, Breakpoint breakpoint) {
        int numCols = getCustomColumnCount(breakpoint);
        return StaggeredGridView.countBuilder(
          key: Key("staggeredGrid-col-$numCols"),
          crossAxisCount: numCols,
          itemCount: items.length,
          itemBuilder: (BuildContext itemContext, int index) =>
              items[index].childBuilder(itemContext),
          staggeredTileBuilder: (int index) => items[index].gridItemType,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        );
      },
    ),
  );
}
