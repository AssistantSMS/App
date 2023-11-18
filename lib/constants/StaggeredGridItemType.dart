import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class StaggeredGridSize {
  static Size smallSquare = const Size(1, 1);
  static Size smallRectLandscape = const Size(2, 1);
  static Size smallRectPortrait = const Size(1, 2);
  static Size smallRectLandscapeLong = const Size(3, 1);
  static Size smallRectLandscapeXLong = const Size(4, 1);

  static Size medSquare = const Size(2, 2);
  static Size medRectLandscape = const Size(3, 2);
  static Size medRectPortrait = const Size(2, 3);

  static Size largeSquare = const Size(3, 3);
  static Size largeRectLandscape = const Size(4, 3);
  static Size largeRectPortrait = const Size(3, 4);
}

StaggeredGridTileItem createStaggeredGridItem({
  required Widget child,
  required Size gridItemSize,
}) =>
    StaggeredGridTileItem(
      gridItemSize.width.toInt(),
      gridItemSize.height.toInt(),
      child,
    );
