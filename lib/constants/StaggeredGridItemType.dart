import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridItemType {
  static StaggeredTile smallSquare = const StaggeredTile.count(1, 1);
  static StaggeredTile smallRectLandscape = const StaggeredTile.count(2, 1);
  static StaggeredTile smallRectPortrait = const StaggeredTile.count(1, 2);
  static StaggeredTile smallRectLandscapeLong = const StaggeredTile.count(3, 1);
  static StaggeredTile smallRectLandscapeXLong =
      const StaggeredTile.count(4, 1);

  static StaggeredTile medSquare = const StaggeredTile.count(2, 2);
  static StaggeredTile medRectLandscape = const StaggeredTile.count(3, 2);
  static StaggeredTile medRectPortrait = const StaggeredTile.count(2, 3);

  static StaggeredTile largeSquare = const StaggeredTile.count(3, 3);
  static StaggeredTile largeRectLandscape = const StaggeredTile.count(4, 3);
  static StaggeredTile largeRectPortrait = const StaggeredTile.count(3, 4);
}
