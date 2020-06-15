import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridItemType {
  static StaggeredTile smallSquare = StaggeredTile.count(1, 1);
  static StaggeredTile smallRectLandscape = StaggeredTile.count(2, 1);
  static StaggeredTile smallRectPortrait = StaggeredTile.count(1, 2);
  static StaggeredTile smallRectLandscapeLong = StaggeredTile.count(3, 1);
  static StaggeredTile smallRectLandscapeXLong = StaggeredTile.count(4, 1);

  static StaggeredTile medSquare = StaggeredTile.count(2, 2);
  static StaggeredTile medRectLandscape = StaggeredTile.count(3, 2);
  static StaggeredTile medRectPortrait = StaggeredTile.count(2, 3);

  static StaggeredTile largeSquare = StaggeredTile.count(3, 3);
  static StaggeredTile largeRectLandscape = StaggeredTile.count(4, 3);
  static StaggeredTile largeRectPortrait = StaggeredTile.count(3, 4);
}
