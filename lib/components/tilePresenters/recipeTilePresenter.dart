import 'package:flutter/material.dart';

import '../../contracts/recipe/recipe.dart';
import 'genericTilePresenter.dart';

Widget recipeTilePresenter(BuildContext context, Recipe recipe, int index) =>
    genericListTile(
      context,
      leadingImage: recipe.icon,
      name: recipe.title,
    );
