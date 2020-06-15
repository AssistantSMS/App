import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridItem {
  final Widget Function(BuildContext childContext) childBuilder;
  final StaggeredTile gridItemType;
  StaggeredGridItem({this.childBuilder, this.gridItemType});
}
